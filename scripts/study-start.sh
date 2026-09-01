#!/usr/bin/env bash
# Start of Session — 오늘 예산, checkpoint 이후의 변경(튜터/학습자 구분), INBOX, 중단 여부, 복습 만기,
# 준비된 unit, 속도와 남은 분량, 예산에 맞는 오늘 구성과 next steps를 안내한다.
#
# 사용법: scripts/study-start.sh [minutes] [--diff]
#   minutes  오늘 예산(분). 없으면 .ai/INBOX.md의 "오늘 N분" → LEARNER.md의 default_budget
#   --diff   학습자 커밋의 변경 파일 목록까지 표시
# 요구:   git 2.22+, bash 3.2+, POSIX awk (macOS 기본 도구 호환). 항상 종료 코드 0 (정보 제공용).

set -eo pipefail
# 템플릿 루트 = 이 스크립트의 상위 디렉터리. 더 큰 저장소(예: ~/study vault) 안의 하위 폴더여도 동작한다.
cd "$(cd "$(dirname "$0")/.." && pwd)"
have_git=1; prefix=""
if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then prefix=$(git rev-parse --show-prefix); else have_git=0; fi

CURRENT=".ai/CURRENT.md"; HANDOFF=".ai/HANDOFF.md"; INBOX=".ai/INBOX.md"; LOG=".ai/LOG.md"
LEARNER="LEARNER.md"; ROADMAP="curriculum/ROADMAP.md"; MISC="concepts/MISCONCEPTIONS.md"
SEP=$'\x1f'
today=$(date +%F)
show_diff=0; budget_arg=""
for a in "$@"; do
  case "$a" in
    --diff) show_diff=1 ;;
    *[!0-9]*|"") ;;
    *) budget_arg="$a" ;;
  esac
done

# --- helpers ---
# section <file> <header>: 해당 "## 헤더" 섹션의 본문 (헤더·주석·빈 줄 제외)
section() { sed -n "/^## $2/,/^## /p" "$1" | grep -vE '^(## |<!--|-->|$)' || true; }
# param <key>: LEARNER.md Parameters의 값
param() { grep -E "^- $1:" "$LEARNER" 2>/dev/null | head -n1 | sed -E "s/^- $1:[[:space:]]*//" | tr -d '\r' || true; }
# fm <file> <key>: frontmatter 값 (한 줄 리스트는 대괄호 제거)
fm() {
  awk -v k="$2" '
    NR == 1 { if ($0 != "---") exit; next }
    $0 == "---" { exit }
    index($0, k ":") == 1 { v = $0; sub("^" k ":[ \t]*", "", v); gsub(/^\[[ \t]*|[ \t]*\]$/, "", v); print v; exit }
  ' "$1"
}
# daynum YYYY-MM-DD: 1970-01-01 기준 일수 (date 명령 비의존)
daynum() {
  awk -v d="$1" 'BEGIN {
    y = substr(d, 1, 4) + 0; m = substr(d, 6, 2) + 0; dd = substr(d, 9, 2) + 0
    if (m <= 2) { y--; m += 12 }
    era = int(y / 400); yoe = y - era * 400
    doy = int((153 * (m - 3) + 2) / 5) + dd - 1
    doe = yoe * 365 + int(yoe / 4) - int(yoe / 100) + doy
    print era * 146097 + doe - 719468 }'
}
is_date() { case "$1" in [0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]) return 0 ;; *) return 1 ;; esac; }

p_default=$(param default_budget);     : "${p_default:=30}"
p_min=$(param min_session);            : "${p_min:=5}"
p_review_only=$(param review_only_below); : "${p_review_only:=15}"
p_review_est=$(param review_est);      : "${p_review_est:=5}"
p_record_est=$(param record_est);      : "${p_record_est:=5}"
p_passes=$(param verified_passes);     : "${p_passes:=2}"
p_warn_kb=$(param context_warn_kb);    : "${p_warn_kb:=25}"
today_n=$(daynum "$today")

# --- 0. 오늘 예산 ---
budget="$budget_arg"; budget_src="인자"
if [ -z "$budget" ] && [ -f "$INBOX" ]; then
  budget=$(grep -E '^- \[ \]' "$INBOX" | grep -oE '[0-9]+ ?(분|min|m)' | head -n1 | grep -oE '^[0-9]+' || true)
  budget_src="INBOX"
fi
if [ -z "$budget" ]; then budget="$p_default"; budget_src="LEARNER.md default_budget"; fi
echo "budget: ${budget}m (${budget_src}) — 세션은 이 안에서 끝낸다 (Rule 11)"
[ "$budget" -lt "$p_min" ] && echo "  → 최소 세션 ${p_min}m 미만. 회상 질문 1개만 하고 기록한다."

# --- 1. checkpoint ---
echo
checkpoint=$(section "$CURRENT" "Last Checkpoint" | grep -oE '^`[0-9a-f]{7,40}`$' | head -n1 | tr -d '`' || true)
limit=""; range="HEAD"
if [ "$have_git" -eq 0 ]; then
  echo "checkpoint: (git 저장소가 아니다) — 변경 추적·checkpoint 절차를 쓰려면 git init 후 첫 커밋을 남긴다."
elif [ -z "$checkpoint" ]; then
  echo "checkpoint: (없음) — 첫 세션이거나 CURRENT.md의 Last Checkpoint가 비어 있다. 최근 30개 커밋을 표시한다."
  range="HEAD"; limit="-n 30"
elif ! git cat-file -e "${checkpoint}^{commit}" 2>/dev/null; then
  echo "checkpoint: $checkpoint — 이 저장소에 없는 커밋이다 (history rewrite 또는 다른 clone?). 최근 30개 커밋을 표시한다."
  range="HEAD"; limit="-n 30"
else
  echo "checkpoint: $checkpoint  $(git log -1 --format='%as %s' "$checkpoint")"
  range="${checkpoint}..HEAD"
fi

# --- 2. checkpoint 이후 커밋 (Agent trailer 유무로 구분) ---
echo
echo "commits since checkpoint (oldest first):"
count=0; dev_count=0; dev_shas=""
if [ "$have_git" -eq 1 ] && git rev-parse --verify HEAD >/dev/null 2>&1; then
  while IFS="$SEP" read -r sha date subject agent unit; do
    [ -z "$sha" ] && continue
    count=$((count + 1))
    if [ -n "$agent" ]; then
      printf '  [agent:%s] %s %s %s%s\n' "$agent" "$sha" "$date" "$subject" "${unit:+  (Unit: $unit)}"
    else
      printf '  [LEARNER] %s %s %s\n' "$sha" "$date" "$subject"
      dev_count=$((dev_count + 1)); dev_shas="$dev_shas $sha"
    fi
  done < <(git log --reverse $limit \
    --format="%h${SEP}%as${SEP}%s${SEP}%(trailers:key=Agent,valueonly,separator=%x2C)${SEP}%(trailers:key=Unit,valueonly,separator=%x2C)" \
    "$range" -- .)
fi
[ "$count" -eq 0 ] && echo "  (없음)"
if [ "$dev_count" -gt 0 ]; then
  echo
  echo "learner commits: ${dev_count}개 — 되돌리지 말 것 (Rule 4). 학습자가 쓴 정의·주장은 exercise로 확인한다."
  if [ "$show_diff" -eq 1 ]; then
    for sha in $dev_shas; do
      echo "  --- $sha  $(git log -1 --format='%an: %s' "$sha")"
      git show --stat --format= "$sha" -- . | sed 's/^/    /'
    done
  else
    echo "  변경 파일 목록: scripts/study-start.sh --diff"
  fi
fi

# --- 3. uncommitted 변경 (학습자 변경 또는 중단된 튜터 작업) ---
echo
echo "uncommitted changes:"
status_out=""
[ "$have_git" -eq 1 ] && status_out=$(git status --porcelain -- . | sed "s|^\(...\)${prefix}|\1|; s| -> ${prefix}| -> |")
if [ -z "$status_out" ]; then echo "  (없음)"; else printf '%s\n' "$status_out" | sed 's/^/  /'; fi

# --- 4. INBOX ---
echo
open_items=0
if [ -f "$INBOX" ]; then
  open_items=$(grep -c '^- \[ \]' "$INBOX" || true); open_items=${open_items:-0}
  if [ "$open_items" -gt 0 ]; then
    echo "INBOX: 처리할 항목 ${open_items}개 — 학습자의 직접 지시 (Rule 5)"
    grep '^- \[ \]' "$INBOX" | sed 's/^/  /'
  else
    echo "INBOX: 비어 있음"
  fi
else
  echo "INBOX: 파일 없음 ($INBOX)"
fi

# --- 5. CURRENT 상태와 중단 여부 ---
echo
phase=$(section "$CURRENT" "Current Phase" | head -n1)
plan=$(printf '%s' "$phase" | grep -oE '`[^`]+`' | head -n1 | tr -d '`' || true)
phase_no=$(printf '%s' "$phase" | grep -oE '^[0-9]{2}' || true)
unit_line=$(section "$CURRENT" "Current Unit" | head -n1)
unit_id=$(printf '%s' "$unit_line" | grep -oE '^U[0-9]+' || true)
status=$(section "$CURRENT" "Status" | head -n1 | tr -d '[:space:]')
next=$(section "$CURRENT" "Next Action" | head -n1)
progress=$(section "$CURRENT" "Progress")
echo "CURRENT: phase  = ${phase:-?}"
echo "         unit   = ${unit_line:-?}"
echo "         status = ${status:-?}"
echo "         next   = ${next:-?}"
if [ "$status" = "IN_PROGRESS" ]; then
  echo "  → 직전 세션이 정상 종료되지 않았다(중단 가능성). progress:"
  printf '%s\n' "$progress" | sed 's/^/      /'
fi

# --- 6. 개념 상태 · 복습 만기 · 오개념 ---
echo
n_unseen=0; n_intro=0; n_prac=0; n_ver=0; n_stale=0; n_due=0; due_lines=""
for f in concepts/*.md; do
  [ -f "$f" ] || continue
  case "$(basename "$f")" in _template.md|CONCEPT_MAP.md|MISCONCEPTIONS.md) continue ;; esac
  st=$(fm "$f" state); name=$(fm "$f" name); [ -z "$name" ] && name=$(basename "$f" .md)
  case "$st" in
    unseen)     n_unseen=$((n_unseen + 1)) ;;
    introduced) n_intro=$((n_intro + 1)) ;;
    practiced)  n_prac=$((n_prac + 1)) ;;
    verified)
      n_ver=$((n_ver + 1))
      due=$(fm "$f" review_due)
      if is_date "$due"; then
        over=$(( today_n - $(daynum "$due") ))
        if [ "$over" -ge 0 ]; then
          n_due=$((n_due + 1)); due_lines="${due_lines}  [D+${over}]  ${name} (${f})"$'\n'
        fi
      else
        due_lines="${due_lines}  [no due] ${name} (${f}) — verified인데 review_due가 없다 (Rule 14)"$'\n'
      fi ;;
    stale)
      n_stale=$((n_stale + 1)); n_due=$((n_due + 1))
      due_lines="${due_lines}  [stale]  ${name} (${f}) — 복습 pass 1회로 verified 복귀"$'\n' ;;
  esac
done
echo "concepts: unseen ${n_unseen} · introduced ${n_intro} · practiced ${n_prac} · verified ${n_ver} · stale ${n_stale}"
echo "review due (Rule 14 — 새 unit보다 먼저):"
if [ -n "$due_lines" ]; then printf '%s' "$due_lines"; else echo "  (없음)"; fi
active_misc=$(grep -E '^\| *[0-9]{4}-[0-9]{2}-[0-9]{2}' "$MISC" 2>/dev/null | grep -c '| *active *|' || true)
echo "misconceptions active: ${active_misc:-0} — 새 exercise의 Rubric(흔한 오답)에 반영 ($MISC)"

# --- 7. 현재 PLAN의 unit: 완료 · 진행 중 · 준비된 것 ---
echo
units=""
if [ -n "$plan" ] && [ -f "$plan" ]; then
  # id|done|kind|est|requires|title
  units=$(awk '
    /^- \[[ x]\] U[0-9]+\./ {
      dn = (substr($0, 4, 1) == "x") ? 1 : 0
      id = $0; sub(/^- \[[ x]\] /, "", id); sub(/\..*$/, "", id)
      title = $0; sub(/^- \[[ x]\] U[0-9]+\. */, "", title)
      kind = ""; est = 0; req = ""
      # 메타데이터는 " — <kind> · " 부터. 제목 안의 " — "와 구분하기 위해 kind 이름으로 찾는다
      if (match(title, / — (setup|learn|practice|review|capstone) · /)) {
        meta = substr(title, RSTART); title = substr(title, 1, RSTART - 1); sub(/^ — /, "", meta)
        m = split(meta, fld, / · /)
        kind = fld[1]; gsub(/^[ \t]+|[ \t]+$/, "", kind)
        for (i = 2; i <= m; i++) {
          x = fld[i]; gsub(/^[ \t]+|[ \t]+$/, "", x)
          if (x ~ /^est [0-9]+m/) { sub(/^est /, "", x); sub(/m.*$/, "", x); est = x + 0 }
          else if (x ~ /^requires /) { sub(/^requires /, "", x); req = x; if (req == "—" || req == "-") req = "" }
        }
      }
      gsub(/[ \t]+$/, "", title)
      print id "|" dn "|" kind "|" est "|" req "|" title
    }' "$plan")
fi
done_ids=" "; remaining_cur=0; wip_line=""; ready_lines=""; blocked_n=0; ready_ids=""
if [ -n "$units" ]; then
  while IFS='|' read -r id dn kind est req title; do
    [ "$dn" = "1" ] && done_ids="${done_ids}${id} "
  done <<EOF
$units
EOF
  while IFS='|' read -r id dn kind est req title; do
    [ "$dn" = "1" ] && continue
    remaining_cur=$((remaining_cur + est))
    ready=1
    for r in $(printf '%s' "$req" | tr ',' ' '); do
      case "$done_ids" in *" $r "*) ;; *) ready=0 ;; esac
    done
    if [ "$id" = "$unit_id" ] && printf '%s' "$progress" | grep -q '←'; then
      wip_line="${id} ${title} — ${kind} · est ${est}m (진행 중, HANDOFF의 Work In Progress)"
    elif [ "$ready" -eq 1 ]; then
      ready_lines="${ready_lines}    ${id} ${title} — ${kind} · est ${est}m"$'\n'; ready_ids="${ready_ids}${id}|${est}|${title}"$'\n'
    else
      blocked_n=$((blocked_n + 1))
    fi
  done <<EOF
$units
EOF
fi
echo "units (${plan:-PLAN 없음}):"
if [ -z "$units" ]; then
  echo "  (unit을 읽을 수 없다 — PLAN의 Units 줄 형식 확인: '- [ ] U1. <unit> — <kind> · est 20m · requires — · Done when: ...')"
else
  echo "  done: $(printf '%s' "$done_ids" | wc -w | tr -d ' ')개 · remaining ${remaining_cur}m · blocked(선행 미완) ${blocked_n}개"
  [ -n "$wip_line" ] && echo "  in progress: $wip_line"
  echo "  ready (선행 완료, PLAN 순서):"
  if [ -n "$ready_lines" ]; then printf '%s' "$ready_lines"; else echo "    (없음)"; fi
fi

# --- 8. 속도 (LOG) 와 남은 분량 ---
echo
vel=$(awk -v today_n="$today_n" '
  function daynum(d,   y, m, dd, era, yoe, doy, doe) {
    y = substr(d, 1, 4) + 0; m = substr(d, 6, 2) + 0; dd = substr(d, 9, 2) + 0
    if (m <= 2) { y--; m += 12 }
    era = int(y / 400); yoe = y - era * 400
    doy = int((153 * (m - 3) + 2) / 5) + dd - 1
    doe = yoe * 365 + int(yoe / 4) - int(yoe / 100) + doy
    return era * 146097 + doe - 719468 }
  /^## [0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]/ {
    p = 0; a = 0
    if (match($0, /planned [0-9]+m/)) { p = substr($0, RSTART + 8, RLENGTH - 9) + 0 }
    if (match($0, /actual [0-9]+m/))  { a = substr($0, RSTART + 7, RLENGTH - 8) + 0 }
    if (p == 0 && a == 0) next
    n++
    if (n <= 10) { sp += p; sa += a }
    if (today_n - daynum(substr($0, 4, 10)) <= 14) recent++
    next }
  /^- Units:/ {
    s = $0
    while (match(s, /est [0-9]+m · actual [0-9]+m/)) {
      pair = substr(s, RSTART, RLENGTH); s = substr(s, RSTART + RLENGTH)
      e = pair; sub(/^est /, "", e); sub(/m.*$/, "", e)
      t = pair; sub(/^.*actual /, "", t); sub(/m$/, "", t)
      ue += e + 0; ua += t + 0 } }
  END {
    ratio = (sp > 0) ? sa / sp : 1; uratio = (ue > 0) ? ua / ue : ratio
    avg = (n > 0) ? sa / ((n < 10) ? n : 10) : 0
    printf "%d %d %.2f %.2f %.1f\n", n + 0, avg, ratio, uratio, recent / 2 }
' "$LOG" 2>/dev/null || echo "0 0 1.00 1.00 0.0")
set -- $vel; v_n=$1; v_avg=$2; v_ratio=$3; v_uratio=$4; v_perweek=$5
planned_est=0; planned_unknown=0
if [ -f "$ROADMAP" ]; then
  eval "$(awk -F'|' -v cur="$phase_no" '
    $2 ~ /^ *[0-9][0-9] *$/ {
      no = $2; gsub(/ /, "", no); est = $6; gsub(/ /, "", est); st = $7; gsub(/ /, "", st)
      if (no == cur) next
      if (st == "PLANNED" || st == "IN_PROGRESS") { if (est ~ /^[0-9]+$/) sum += est; else unk++ } }
    END { printf "planned_est=%d; planned_unknown=%d\n", sum + 0, unk + 0 }' "$ROADMAP")"
fi
if [ "$v_n" -eq 0 ]; then
  echo "velocity: 데이터 없음 — LOG 헤더의 'planned Nm · actual Mm'이 있는 세션이 아직 없다"
else
  echo "velocity (LOG 최근 10세션): sessions ${v_n} · avg actual ${v_avg}m · actual/planned ${v_ratio} · unit actual/est ${v_uratio} · 최근 2주 ${v_perweek}회/주"
fi
remaining_total=$((remaining_cur + planned_est))
adj=$(awk -v r="$remaining_total" -v k="$v_uratio" 'BEGIN { printf "%d", r * k + 0.5 }')
line="remaining: 현재 Phase ${remaining_cur}m + PLANNED Phase ${planned_est}m = ${remaining_total}m"
[ "$planned_unknown" -gt 0 ] && line="$line (Est 미정 Phase ${planned_unknown}개 제외)"
if [ "$v_n" -gt 0 ] && [ "$v_avg" -gt 0 ]; then
  sessions_needed=$(awk -v a="$adj" -v s="$v_avg" 'BEGIN { printf "%d", a / s + 0.999 }')
  if awk -v w="$v_perweek" 'BEGIN { exit !(w > 0) }'; then
    weeks=$(awk -v n="$sessions_needed" -v w="$v_perweek" 'BEGIN { printf "%.1f", n / w }')
    line="$line × ${v_uratio} ≈ ${adj}m → ≈ ${sessions_needed}세션 ≈ ${weeks}주"
  else
    line="$line × ${v_uratio} ≈ ${adj}m → ≈ ${sessions_needed}세션 (최근 2주 세션 없음)"
  fi
fi
echo "$line"

# --- 9. 시작 컨텍스트 크기 (Rule 13) ---
echo
files="AGENTS.md $CURRENT $HANDOFF $LEARNER"
[ -n "$plan" ] && [ -f "$plan" ] && files="$files $plan"
total=0
for f in $files; do size=$(wc -c < "$f" | tr -d ' '); total=$((total + size)); done
echo "startup context: $(( (total + 512) / 1024 ))KB — $files"
[ "$total" -gt $((p_warn_kb * 1024)) ] && echo "  → ${p_warn_kb}KB 초과. CURRENT/HANDOFF/PLAN을 줄인다 (Rule 13)."
cur_lines=$(wc -l < "$CURRENT" | tr -d ' '); ho_lines=$(wc -l < "$HANDOFF" | tr -d ' ')
[ "$cur_lines" -gt 40 ] && echo "  → CURRENT.md ${cur_lines}줄 (상한 40)"
[ "$ho_lines" -gt 50 ] && echo "  → HANDOFF.md ${ho_lines}줄 (상한 50)"

# --- 10. 오늘 구성 제안 (Rule 11) ---
echo
echo "today (budget ${budget}m):"
avail=$((budget - p_record_est)); used=0; k=1
if [ "$n_due" -gt 0 ]; then
  max_rev=$(( avail / p_review_est )); [ "$max_rev" -lt 1 ] && max_rev=1
  shown=0
  printf '%s' "$due_lines" | while IFS= read -r l; do
    [ -z "$l" ] && continue
    case "$l" in *"[no due]"*) continue ;; esac
    shown=$((shown + 1)); [ "$shown" -gt "$max_rev" ] && break
    echo "  ${shown}. review ${p_review_est}m — ${l#  }"
  done
  rev_n=$(( n_due < max_rev ? n_due : max_rev )); used=$((rev_n * p_review_est)); k=$((rev_n + 1))
  [ "$n_due" -gt "$max_rev" ] && echo "     (복습 만기 ${n_due}개 중 ${max_rev}개만 — 나머지는 다음 세션)"
fi
if [ "$budget" -lt "$p_review_only" ]; then
  echo "  ${k}. record ${p_record_est}m — 예산 ${budget}m < review_only_below ${p_review_only}m: 복습만 (Rule 11)"
  [ "$n_due" -eq 0 ] && echo "     복습 만기가 없으면 practiced 개념 중 하나를 recall로 확인한다"
else
  left=$((avail - used))
  if [ -n "$wip_line" ]; then
    wip_est=$(printf '%s' "$wip_line" | grep -oE 'est [0-9]+' | grep -oE '[0-9]+' || echo 0)
    echo "  ${k}. continue ${wip_line}"; k=$((k + 1)); used=$((used + wip_est)); left=$((left - wip_est))
    [ "$left" -lt 0 ] && echo "     (남은 예산 밖 — 예산이 끝나는 step에서 멈추고 Progress·HANDOFF에 남긴다)"
  fi
  picked=""; need=0
  if [ -n "$ready_ids" ] && [ "$left" -gt 0 ]; then
    while IFS='|' read -r id est title; do
      [ -z "$id" ] && continue
      need=$(awk -v e="$est" -v k="$v_uratio" 'BEGIN { printf "%d", e * k + 0.5 }')
      if [ "$need" -le "$left" ]; then picked="${id} ${title} — est ${est}m (×${v_uratio} ≈ ${need}m)"; break; fi
    done <<EOF
$ready_ids
EOF
  fi
  if [ -n "$picked" ]; then
    echo "  ${k}. unit ${picked}"; k=$((k + 1)); used=$((used + need))
  elif [ -n "$ready_ids" ] && [ "$left" -gt 0 ]; then
    first=$(printf '%s' "$ready_ids" | head -n1)
    echo "  ${k}. unit 없음 — 남은 ${left}m에 맞는 준비된 unit이 없다. 첫 unit(${first%%|*})을 step 단위로 시작하고 HANDOFF에 Work In Progress를 남기거나, 복습·recall로 채운다"; k=$((k + 1))
  elif [ -z "$ready_ids" ] && [ -z "$wip_line" ]; then
    echo "  ${k}. unit 없음 — 준비된 unit이 없다 (Phase 완료 또는 PLAN 미작성). PLAN·ROADMAP을 확인한다"; k=$((k + 1))
  fi
  echo "  ${k}. record ${p_record_est}m — exercise result 확정, concept state·review_due, LOG(planned ${budget}m · actual ?m), HANDOFF, study-end.sh"
  echo "  total ≈ $((used + p_record_est))m / ${budget}m"
fi

# --- 11. next steps (상황에 따라 달라짐) ---
echo
echo "next steps:"
n=1
if [ "$status" = "IN_PROGRESS" ]; then
  echo "  $n. Resume (Rule 12) — uncommitted diff를 HANDOFF의 Work In Progress·위 progress와 대조: 일치하면 그 step부터 잇고, 아니면 학습자 변경으로 취급."
  n=$((n + 1))
fi
if [ "$dev_count" -gt 0 ] || [ "$open_items" -gt 0 ] || [ -n "$status_out" ]; then
  echo "  $n. 학습자 변경·INBOX 반영 (Rule 4·5) — 되돌리지 말고 concept·PLAN·HANDOFF에 반영, LOG의 Learner changes에 기록. 학습자가 쓴 정의는 exercise로 확인."
  n=$((n + 1))
fi
pending=$(grep -l '^result: pending' exercises/*.md 2>/dev/null | grep -v '_template' || true)
if [ -n "$pending" ]; then
  echo "  $n. 채점 대기 exercise 먼저 (Rule 9): $(printf '%s' "$pending" | tr '\n' ' ')"
  n=$((n + 1))
fi
echo "  $n. 위 today 구성대로 — 복습 만기 → 진행 중 unit → 새 unit 하나. ${plan:-현재 Phase PLAN.md}의 Units·Acceptance Criteria와 오늘 unit의 concept·evidence만 읽는다 (Rule 3)."
n=$((n + 1))
echo "  $n. CURRENT.md: Status=IN_PROGRESS, Current Unit, Progress에 step 목록(≤10). HANDOFF.md: Goal·Work In Progress 초안 (handoff-first, Rule 12)."
n=$((n + 1))
echo "  $n. 진행 — exercise는 Problem+Rubric 먼저, 답은 사진·ASCII·코드로 받아 전사·확인 후 항목별 판정 (Rule 9·10). 끝나면 scripts/study-end.sh."
exit 0
