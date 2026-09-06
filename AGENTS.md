# AGENTS.md

모든 AI Tutor(Claude Code, Codex, Gemini CLI, ChatGPT 등)와 학습자가 공유하는 공통 규칙이다. 짧게 유지한다.
장기 학습 지식은 `concepts/`·`evidence/`·`curriculum/`, 세션 상태는 `.ai/`에 있으며 여기에 복사하지 않는다. 도구가 이 파일을 이미 로드했다면(CLAUDE.md·GEMINI.md import) 다시 읽지 않는다.

## Subject

- Name: MAML — gradient 기반 meta-learning
- Outcome: MAML의 목적함수·meta-gradient·FOMAML 근사를 설명하고 후속 연구의 변경점과 근거를 읽어낼 수 있다
- Learner: `LEARNER.md` (시간 예산 · 배경 · 입력 방식 · 파라미터)


## Repository Map

- `LEARNING_GOALS.md` 목표와 증명 방법 · `LEARNER.md` 학습자 파라미터 · `curriculum/ROADMAP.md` Phase 목록 · `curriculum/phases/` Phase PLAN/RESULT · `curriculum/decisions/` DR(결정 기록)
- `concepts/` 개념 — 이해 상태의 유일한 자리 · `concepts/CONCEPT_MAP.md` 선행 관계 · `concepts/MISCONCEPTIONS.md` 오개념 · `evidence/` 근거 자료 · `exercises/` 시도·채점 기록 · `notes/` 튜터가 쓴 개념 설명 (이해 상태의 근거 아님, DR-0011) · `sandbox/` 실험 코드 (source of truth 아님)
- 이 폴더 = subject 하나(`~/study/MAML/`, concept map 하나를 공유하는 단위, DR-0005). 같은 폴더의 `why--*.md` 같은 질문 원장은 스토리 측(`~/study/stories/`, 자체 AGENTS.md) 파일이며 concept state의 근거가 아니다 — 스토리의 개념이 목표와 이어지면 `concepts/`로 올린다. 다른 subject의 개념은 `requires`가 아니라 `evidence`로 그쪽 concept 파일을 가리키고, state는 그쪽이 기준이다
- `.ai/CURRENT.md` 현재 상태·checkpoint · `.ai/HANDOFF.md` 세션 간 인수인계 · `.ai/LOG.md` 세션 기록(학습자 보고·속도 데이터) · `.ai/INBOX.md` 학습자 지시
- `scripts/study-start.sh` 시작 절차 안내 · `scripts/study-end.sh` 종료 점검
- `.claude/agent-memory/역할명/` 교재 근거·수학 검증 역할(cs-book·math-analyzer 등)의 subject 전용 메모리 — 아래 **Role Memory**

## Role Memory

교재 근거 발췌(cs-book)·증명 검증과 설명(math-analyzer)·exercise 채점(study-grader) 같은 역할로 작업할 때는 그 역할의 subject 전용 메모리 `.claude/agent-memory/역할명/`를 쓴다. 어느 엔진이든 같은 폴더를 공유하며, 메모리는 세션을 연 디렉터리 기준이므로 세션은 이 폴더에서 연다.

- **Claude Code**: `memory: project` 서브에이전트가 `MEMORY.md`를 자동 로드하고 스스로 갱신한다.
- **서브에이전트 메모리가 없는 엔진(Codex 등)**: 역할 스킬(`~/.codex/skills/역할명/`)을 시작할 때 `.claude/agent-memory/역할명/MEMORY.md`를 직접 읽고(없으면 첫 실행 — 시딩), 끝낼 때 `agent-memory-protocol` 스킬 절차로 갱신한다. Gemini는 읽지 않는다.
- 내용은 학습자의 반복 오류·이미 다룬 범위·이전 판정처럼 다시 도출할 수 없는 것만. 커밋 대상이지만 source of truth가 아니다(Truth 순서 ⑨와 같은 급) — concept `state`의 근거는 `exercises/`뿐이다(Rule 8). 손으로 고치지 않고, 틀리면 `.ai/INBOX.md`로 지시한다.

## Rules

1. **Memory** — 저장소가 기억이다. 이해 상태·계획·오개념·결정은 파일과 커밋에 남기고, 대화 기억에 의존하지 않는다.
2. **Truth** — 정보가 충돌하면 이 순서로 우선한다: ① 학습자의 직접 말(대화·`.ai/INBOX.md`) ② `exercises/`의 채점 기록 ③ `concepts/`의 state·Verification Criteria ④ `evidence/` ⑤ `LEARNING_GOALS.md`·`LEARNER.md` ⑥ 현재 Phase `PLAN.md` ⑦ `.ai/CURRENT.md` ⑧ `.ai/HANDOFF.md` ⑨ 과거 대화와 튜터의 인상. "이해한 것 같다"는 인상은 최하위다.
3. **Loading** — 필요한 것만 읽는다: 이 파일 → `.ai/CURRENT.md` → `.ai/HANDOFF.md` → `scripts/study-start.sh` 출력 → 오늘 unit의 concept·evidence·exercise. 다른 concept·evidence·과거 Phase·LOG의 이전 항목·checkpoint 이전 커밋은 이유가 있을 때만 본다.
4. **Learner changes** — `Agent:` trailer가 없는 커밋과 uncommitted 변경은 학습자 변경이다. 되돌리지 않는다. 학습자가 쓴 정의·주장이 틀려 보여도 고쳐 쓰지 않고 `concepts/MISCONCEPTIONS.md`에 후보로 적은 뒤 exercise로 확인한다 — 학습자의 문장 자체가 이해 상태의 데이터다.
5. **Inbox** — `.ai/INBOX.md`의 항목(오늘 예산·컨디션·질문·사진 위치)은 학습자의 직접 지시다. 처리한 항목은 삭제하고 결과를 LOG에 적는다. 처리하지 못한 항목은 남기고 이유를 LOG에 적는다.
6. **Scope** — 현재 Phase `PLAN.md`의 Scope와 오늘 고른 unit 안에서만 진행한다. 샛길 질문은 두 문장 이내로 답하고 HANDOFF의 Open Questions에 적는다. 요청받지 않은 커리큘럼 변경·개념 추가는 먼저 제안한다.
7. **Evidence** — concept의 Claims 각 줄에 근거 라벨(`[fact]` 출처 명시 · `[derived]` 근거 기반 유도 · `[assumption]` 가정 · `[hypothesis]` 가설 · `[unsupported]` 근거 부족)과 `evidence/` 포인터(절·정리·식 번호)를 붙인다. 튜터의 기억만으로 공식·정리를 단언하지 않고, 확인하지 못한 주장은 `[unsupported]`로 남긴다.
8. **State** — `concepts/` frontmatter의 `state`는 `exercises/` 기록으로만 바뀐다(`verified_by`가 가리키는 파일). introduced(학습자 언어의 Definition + Claims + Verification Criteria) → practiced(pass 또는 partial 1회) → verified(pass ≥ `verified_passes`, 그중 transfer·derivation·proof·coding ≥ 1 — 날짜 분리 요건 없음, DR-0009). 튜터의 설명과 같은 세션의 되풀이는 근거가 아니다.
9. **Grading** — exercise 파일에 Rubric을 문제와 함께 먼저 쓴다(concept의 Verification Criteria에서 파생). 판정은 항목별 ✓/✗ + Attempt 인용이며 총평·칭찬은 쓰지 않는다. 판정 기준은 그 항목이 겨냥한 원리가 Attempt에서 확인되는가다 — 계산 미완료·산술 실수는 원리가 확인되면 ✓로 하고 판정문에 사실로 적는다; 원리가 확인되지 않으면 수치가 맞아도 ✗다 (DR-0010). partial은 미통과, 두 등급 사이면 낮은 쪽, `grader`를 기록한다.
10. **Input** — 학습자는 LaTeX를 치지 않는다. 손글씨 사진(`exercises/_inbox/`)·ASCII 수식·코드·말로 푼 설명을 받아 튜터가 Attempt에 전사하고, 학습자의 `전사 확인: OK` 뒤에만 채점한다. 표기가 아니라 수학을 채점한다.
11. **Budget** — 세션은 선언된 분(`study-start.sh 30` 또는 INBOX, 없으면 `LEARNER.md`의 `default_budget`) 안에서 끝낸다. 구성 순서: 복습 만기 → 진행 중 unit → 새 unit 하나 → 기록(마지막 5분). 예산이 `review_only_below` 미만이면 복습만. unit의 `est`·`actual`을 LOG에 적는다.
12. **Interruption / Resume** — 중단은 언제든 일어난다고 가정한다. unit 시작 시 HANDOFF의 Goal·Work In Progress를 먼저 쓰고(handoff-first), step마다 CURRENT의 Progress를 갱신한다. 정상 종료 시 Status를 IN_PROGRESS로 남기지 않는다 → 시작 시 IN_PROGRESS는 중단 신호다: uncommitted diff가 HANDOFF·Progress와 맞으면 그 step부터 잇고, 아니면 학습자 변경으로 취급한다.
13. **Context budget** — 파일은 필요한 부분만 읽고 긴 출력은 요약해서 남긴다. 상한: CURRENT 40줄, HANDOFF 50줄, LOG 항목 8줄, Progress 10 step, concept 150줄(긴 유도는 `evidence/`·`sandbox/`로), exercise 100줄. 시작 컨텍스트가 25KB를 넘으면 줄인다.
14. **Decay** — verified에도 `review_due`가 있다. 복습 pass면 `review_stage`를 올려 `LEARNER.md`의 `review_intervals` 다음 간격으로 미루고, fail이면 `stale`로 내린다(복습 pass 1회로 verified 복귀). 만기 항목은 새 unit보다 먼저다.
15. **Decisions** — 커리큘럼·방법에 장기 영향이 있는 결정(Phase 추가·순서 변경·목표 수정·채점 정책 변경)은 `curriculum/decisions/`에 DR로 남긴다. `ROADMAP.md`는 현재 계획만 기술하고, 과거 계획과 이유는 DR에 둔다.

## Commands

| Purpose | Command                                  |
|---------|------------------------------------------|
| Start   | `scripts/study-start.sh [minutes]`       |
| End     | `scripts/study-end.sh --set-checkpoint`  |
| Sandbox | N/A — 독해·수식 계산; 구현 실험 없음      |


## Skills


| 상황 | 스킬 (있으면) |
|---|---|
| 목표를 "할 수 있다" 문장과 증명 방법으로 바꿀 때 | `problem-framing` |
| 학습 조율 프레임 — 당위성(기존 방식 → 한계 → 새 방식)·L0→L2 점진 심화·개념 연결(`~/study/concept-links.md`) | `learning-coach` (이 워크스페이스의 Rules·Session Procedure와 충돌하면 이 파일이 우선) |
| 개념 설명·질문 답변 — 한계→직관→정식화→경계→연결 5층, 핵심 유도는 힌트 사다리 | `concept-tutor` |
| 학습자가 종료를 원할 때 자기 말 설명 검토 | `learning-coach`의 파인만 게이트 (학습자가 열자고 할 때만) |
| Phase·목표를 마친 뒤 복습용 블로그 글 | `blog-coauthor` (이월 스토리의 시리즈는 `study-series`) |
| exercise 출제 | `self-exam` |
| exercise 채점 — Rubric과 `전사 확인: OK`가 갖춰진 뒤 | `study-grader` 에이전트 (튜터와 다른 컨텍스트에서 Rubric·Attempt만으로 판정. 호출 프롬프트에 설명·기대 정답을 넣지 않는다. 없으면 튜터가 Rule 9로 직접) |
| 오개념을 원인 → 잘못된 가정 → 개념 갭으로 좁힐 때 | `debug-to-concept` |
| 논문·자료를 evidence로 정리할 때 | `paper-analysis`, `research-claim-check` |
| 분야 지도·자료 탐색 | `research-survey` |

## Session Procedure

- **시작**: `scripts/study-start.sh [분]`을 실행하고 출력의 next steps를 따른다 — Resume 판단 → 학습자 변경·INBOX 반영 → 복습 만기 → unit 선택(PLAN의 Units·Acceptance Criteria 확인) → CURRENT의 Status=IN_PROGRESS·Progress 작성과 HANDOFF 초안 → 진행.
- **종료**: exercise 기록 완성(result ≠ pending) → concept의 state·review_due 갱신 → 작업 커밋과 PLAN의 unit SHA 갱신 → CURRENT(Status≠IN_PROGRESS)·HANDOFF·LOG(planned·actual) 갱신 → 필요 시 DR, Phase 완료 시 `RESULT.md`·`ROADMAP.md`·`phase/NN` 태그 → `scripts/study-end.sh --set-checkpoint` → close commit.

## Commit Format

- `learn(meta-gradient): record learner definition` — type: learn(concept·evidence), exercise, curriculum, docs, chore, wip. scope는 concept slug 또는 phase. 본문에 무엇을·왜. WIP는 미완료 사항.
- trailer: `git commit --trailer "Agent: claude-code" --trailer "Unit: 02/U3"` — Agent 이름은 소문자 kebab-case, unit 밖 작업은 `02/-`.
- unit 완료 커밋의 SHA를 PLAN에 적는다: `- [x] U3. ... (commit abc1234)`. 특정 unit 조회: `git log --grep='Unit: 02/U3'`.
- close commit: `docs(ai): close session — 세션 요약` (`.ai/`·`curriculum/`만 포함).
