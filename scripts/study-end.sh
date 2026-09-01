#!/usr/bin/env bash
# End of Session — close commit 전에 종료 절차, state–근거 일치(Rule 8), 크기 상한(Rule 13)이 지켜졌는지 확인한다.
#
# 사용법: scripts/study-end.sh                   점검만
#         scripts/study-end.sh --set-checkpoint  CURRENT.md의 Last Checkpoint를 현재 HEAD로 기록한 뒤 점검
# 종료 코드: 0 = 통과, 1 = FAIL 항목 있음 (warn은 통과)
# 요구:   git 2.22+, bash 3.2+, POSIX awk (macOS 기본 도구 호환)

set -eo pipefail
# 템플릿 루트 = 이 스크립트의 상위 디렉터리. 더 큰 저장소(예: ~/study vault) 안의 하위 폴더여도 동작한다.
cd "$(cd "$(dirname "$0")/.." && pwd)"
have_git=1; prefix=""
if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then prefix=$(git rev-parse --show-prefix); else have_git=0; fi

CURRENT=".ai/CURRENT.md"; HANDOFF=".ai/HANDOFF.md"; LOG=".ai/LOG.md"; INBOX=".ai/INBOX.md"; LEARNER="LEARNER.md"
SEP=$'\x1f'
today=$(date +%F)
head_short=""; head_full=""
if [ "$have_git" -eq 1 ]; then
  head_short=$(git rev-parse --short HEAD 2>/dev/null || echo "")
  head_full=$(git rev-parse HEAD 2>/dev/null || echo "")
fi
fail=0

ok()   { printf '  [ok]   %s\n' "$1"; }
bad()  { printf '  [FAIL] %s\n' "$1"; fail=1; }
warn() { printf '  [warn] %s\n' "$1"; }
section() { sed -n "/^## $2/,/^## /p" "$1" | grep -vE '^(## |<!--|-->|$)' || true; }
strip_comments() { awk '/<!--/ { c = 1 } !c { print } /-->/ { c = 0 }' "$1"; }
lines() { wc -l < "$1" | tr -d ' '; }
count_bullets() { section "$1" "$2" | grep -c '^- ' || true; }
param() { grep -E "^- $1:" "$LEARNER" 2>/dev/null | head -n1 | sed -E "s/^- $1:[[:space:]]*//" | tr -d '\r' || true; }
fm() {
  awk -v k="$2" '
    NR == 1 { if ($0 != "---") exit; next }
    $0 == "---" { exit }
    index($0, k ":") == 1 { v = $0; sub("^" k ":[ \t]*", "", v); gsub(/^\[[ \t]*|[ \t]*\]$/, "", v); print v; exit }
  ' "$1"
}
is_date() { case "$1" in [0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]) return 0 ;; *) return 1 ;; esac; }
# cap <label> <value> <max>
cap() { if [ "${2:-0}" -le "$3" ]; then ok "$1 = $2 (≤ $3)"; else warn "$1 = $2 — 상한 $3 (Rule 13)"; fi; }

p_passes=$(param verified_passes); : "${p_passes:=2}"

if [ "${1:-}" = "--set-checkpoint" ]; then
  if [ -z "$head_short" ]; then
    echo "  [FAIL] 커밋이 없다 — checkpoint를 기록할 수 없다"; exit 1
  fi
  old=$(section "$CURRENT" "Last Checkpoint" | grep -oE '^`[0-9a-f]{7,40}`$' | head -n1 | tr -d '`' || true)
  if [ -n "$old" ] && git cat-file -e "${old}^{commit}" 2>/dev/null; then
    dev_in_range=$(git log --format="%h${SEP}%(trailers:key=Agent,valueonly,separator=%x2C)" "${old}..HEAD" -- . | awk -v FS="$SEP" '$2 == "" { n++ } END { print n + 0 }')
    [ "$dev_in_range" -gt 0 ] && echo "  [warn] 이전 checkpoint($old) 이후 학습자 커밋 ${dev_in_range}개 — LOG의 Learner changes에 반영했는지 확인 (Rule 4)"
  fi
  awk -v sha="$head_short" '
    /^## Last Checkpoint/            { insec = 1; print; next }
    insec && /^## /                  { insec = 0 }
    insec && !done && /^`[^`]*`$/    { print "`" sha "`"; done = 1; next }
    { print }
  ' "$CURRENT" > "$CURRENT.tmp" && mv "$CURRENT.tmp" "$CURRENT"
  echo "Last Checkpoint → $head_short"
fi

echo "end-of-session check (HEAD ${head_short:-없음}, $today)"

# 1. 작업 커밋: close commit에 들어갈 수 있는 것은 .ai/ 와 curriculum/ 뿐이다
if [ "$have_git" -eq 0 ]; then
  warn "git 저장소가 아니다 — 커밋·checkpoint 점검을 건너뛴다 (git init 후 첫 커밋을 남기면 Rule 4·12의 변경 추적이 동작한다)"
else
  other=$(git status --porcelain -- . | cut -c4- | sed 's/.* -> //' | sed "s|^${prefix}||" | grep -vE '^(\.ai/|curriculum/)' || true)
  if [ -z "$other" ]; then
    ok "학습 산출물(concepts·evidence·exercises·sandbox) 변경이 모두 커밋되어 있다"
  else
    bad "작업 커밋이 안 된 변경이 있다 (close commit 전에 Commit Format대로 커밋):"
    printf '%s\n' "$other" | sed 's/^/           /'
  fi
fi

# 2. Status
status=$(section "$CURRENT" "Status" | head -n1 | tr -d '[:space:]')
case "$status" in
  IN_PROGRESS)              bad "CURRENT.md Status가 IN_PROGRESS다 → TODO / REVIEW / BLOCKED / DONE 중 하나로 바꾼다 (Rule 12)" ;;
  TODO|REVIEW|BLOCKED|DONE) ok  "CURRENT.md Status = $status" ;;
  *)                        bad "CURRENT.md Status를 읽을 수 없다: '${status:-}'" ;;
esac

# 3. Last Checkpoint == HEAD
checkpoint=$(section "$CURRENT" "Last Checkpoint" | grep -oE '^`[0-9a-f]{7,40}`$' | head -n1 | tr -d '`' || true)
if [ "$have_git" -eq 0 ]; then
  :
elif [ -n "$checkpoint" ] && [ -n "$head_full" ] && [ "${head_full#$checkpoint}" != "$head_full" ]; then
  ok "Last Checkpoint = HEAD ($checkpoint)"
else
  bad "Last Checkpoint(${checkpoint:-없음})가 HEAD(${head_short:-없음})와 다르다 → scripts/study-end.sh --set-checkpoint"
fi

# 4. HANDOFF: 오늘 날짜, placeholder 없음
if grep -q "^- Date: $today" "$HANDOFF"; then ok "HANDOFF.md Date = $today"; else warn "HANDOFF.md의 Date가 오늘($today)이 아니다 — 갱신했는지 확인"; fi
if strip_comments "$HANDOFF" | grep -qE '<[^>]+>'; then warn "HANDOFF.md에 placeholder(<...>)가 남아 있다"; else ok "HANDOFF.md에 placeholder 없음"; fi

# 5. LOG: 맨 위 항목이 오늘 세션이고 planned·actual이 있다 (속도 데이터, DR-0004)
top=$(grep -m1 '^## ' "$LOG" || true)
case "$top" in
  "## $today"*)
    ok "LOG.md 맨 위 항목 = 오늘 세션"
    if printf '%s' "$top" | grep -qE 'planned [0-9]+m · actual [0-9]+m'; then
      ok "LOG 헤더에 planned·actual 있음"
    else
      warn "LOG 헤더에 'planned Nm · actual Mm'이 없다 — 속도 계산에서 빠진다 (Rule 11)"
    fi ;;
  *) warn "LOG.md 맨 위 항목이 오늘($today)이 아니다 — 세션 기록을 추가했는지 확인 (${top:-항목 없음})" ;;
esac

# 6. HEAD 커밋 trailer
if [ "$have_git" -eq 0 ]; then
  :
elif [ -n "$head_full" ] && git log -1 --format='%(trailers:key=Agent,valueonly)' | grep -q .; then
  ok "HEAD 커밋에 Agent trailer 있음"
else
  warn "HEAD 커밋(${head_short:-없음})에 Agent trailer가 없다 — 학습자 커밋이거나 trailer 누락"
fi

# 7. INBOX 미처리 항목
open_items=$(grep -c '^- \[ \]' "$INBOX" 2>/dev/null || true)
if [ "${open_items:-0}" -gt 0 ]; then warn "INBOX에 미처리 항목 ${open_items}개 — 처리하지 못했다면 LOG에 이유를 적는다"; else ok "INBOX 비어 있음"; fi

# 8. exercises: pending, grader·result 값
pending=$(grep -l '^result: pending' exercises/*.md 2>/dev/null | grep -v '_template' || true)
if [ -n "$pending" ]; then warn "채점 대기 exercise: $(printf '%s' "$pending" | tr '\n' ' ')— 다음 세션 시작에 먼저 채점한다"; else ok "채점 대기 exercise 없음"; fi
bad_ex=""
for f in exercises/*.md; do
  [ -f "$f" ] || continue
  case "$(basename "$f")" in _template.md|README.md) continue ;; esac
  r=$(fm "$f" result); g=$(fm "$f" grader); d=$(fm "$f" date)
  case "$r" in pending|pass|partial|fail) ;; *) bad_ex="${bad_ex}${f}(result '${r}') " ;; esac
  case "$r" in pass|partial|fail)
    case "$g" in ""|"<"*) bad_ex="${bad_ex}${f}(grader 없음) " ;; esac ;;
  esac
  is_date "$d" || bad_ex="${bad_ex}${f}(date '${d}') "
done
if [ -n "$bad_ex" ]; then bad "exercise frontmatter 오류: $bad_ex"; else ok "exercise frontmatter(result·grader·date) 정상"; fi

# 9. concepts: state가 exercise 기록으로 정당화되는가 (Rule 8), review_due (Rule 14)
c_bad=0; c_checked=0
for f in concepts/*.md; do
  [ -f "$f" ] || continue
  case "$(basename "$f")" in _template.md|CONCEPT_MAP.md|MISCONCEPTIONS.md) continue ;; esac
  c_checked=$((c_checked + 1))
  st=$(fm "$f" state); vb=$(fm "$f" verified_by)
  case "$st" in
    unseen|introduced) continue ;;
    practiced|verified|stale) ;;
    *) bad "$f: state '${st:-없음}' — unseen|introduced|practiced|verified|stale 중 하나여야 한다"; c_bad=$((c_bad + 1)); continue ;;
  esac
  passes=0; any=0; high=0; dates=" "; missing=""; wrong=""
  cname=$(fm "$f" name); [ -z "$cname" ] && cname=$(basename "$f" .md)
  for ex in $(printf '%s' "$vb" | tr ',' ' '); do
    ex=$(printf '%s' "$ex" | tr -d '`"'"'"' ')
    [ -z "$ex" ] && continue
    if [ ! -f "$ex" ]; then missing="$missing $ex"; continue; fi
    r=$(fm "$ex" result); t=$(fm "$ex" type); d=$(fm "$ex" date); c=$(fm "$ex" concept)
    if [ "$c" != "$cname" ]; then wrong="$wrong $ex(concept: ${c:-없음})"; continue; fi
    case "$r" in
      pass) any=1
            case "$dates" in *" $d "*) ;; *) passes=$((passes + 1)); dates="${dates}${d} " ;; esac
            case "$t" in transfer|derivation|proof|coding) high=1 ;; esac ;;
      partial) any=1 ;;
    esac
  done
  if [ -n "$missing" ]; then bad "$f: verified_by가 가리키는 파일이 없다:$missing"; c_bad=$((c_bad + 1)); continue; fi
  if [ -n "$wrong" ]; then bad "$f: verified_by의 exercise가 다른 개념의 기록이다:$wrong"; c_bad=$((c_bad + 1)); continue; fi
  case "$st" in
    practiced)
      if [ "$any" -eq 1 ]; then ok "$f: practiced — 근거 있음"; else bad "$f: practiced인데 verified_by에 pass/partial 기록이 없다 (Rule 8)"; c_bad=$((c_bad + 1)); fi ;;
    verified|stale)
      if [ "$passes" -ge "$p_passes" ] && [ "$high" -eq 1 ]; then
        ok "$f: $st — 서로 다른 날 pass ${passes}회, high 유형 포함"
      else
        bad "$f: ${st}인데 근거 부족 — 서로 다른 날 pass ${passes}/${p_passes}, transfer·derivation·proof·coding $([ "$high" -eq 1 ] && echo 있음 || echo 없음) (Rule 8)"; c_bad=$((c_bad + 1))
      fi
      if [ "$st" = "verified" ]; then
        due=$(fm "$f" review_due); von=$(fm "$f" verified_on)
        is_date "$due" || { bad "$f: verified인데 review_due가 없다 (Rule 14)"; c_bad=$((c_bad + 1)); }
        is_date "$von" || warn "$f: verified_on이 비어 있다"
      fi ;;
  esac
done
[ "$c_checked" -eq 0 ] && ok "concepts 없음 (초기화 전)"
[ "$c_checked" -gt 0 ] && [ "$c_bad" -eq 0 ] && ok "concepts ${c_checked}개 state–근거 일치"

# 10. 크기 상한 (Rule 13)
cap "CURRENT.md 줄 수" "$(lines "$CURRENT")" 40
cap "HANDOFF.md 줄 수" "$(lines "$HANDOFF")" 50
top_lines=$(awk '/^## /{ n++ } n == 1 && NF' "$LOG" | grep -vc '^## ' || true)
cap "LOG 맨 위 항목 줄 수" "${top_lines:-0}" 8
cap "Progress step 수" "$(count_bullets "$CURRENT" Progress)" 10
cap "Recent Important Changes 수" "$(count_bullets "$CURRENT" 'Recent Important Changes')" 5
big=""
for f in concepts/*.md; do [ -f "$f" ] && [ "$(lines "$f")" -gt 150 ] && big="$big $f($(lines "$f"))"; done
for f in exercises/*.md; do [ -f "$f" ] && [ "$(lines "$f")" -gt 100 ] && big="$big $f($(lines "$f"))"; done
if [ -n "$big" ]; then warn "상한 초과 파일 (concept 150줄, exercise 100줄):$big"; else ok "concept·exercise 파일 크기 상한 이내"; fi

echo
if [ "$fail" -eq 0 ]; then
  echo "통과. 남은 단계: close commit"
  echo "  git add .ai curriculum && git commit -m 'docs(ai): close session — <요약>' --trailer 'Agent: <이름>' --trailer 'Unit: <phase>/<unit>'"
else
  echo "FAIL 항목을 해결한 뒤 다시 실행한다."
  exit 1
fi
