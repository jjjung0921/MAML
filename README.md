# AI-Tutor Study Template

AI Agent(Claude Code, Codex, Gemini CLI, ChatGPT 등)를 튜터로 삼아 공부할 때, 세션과 엔진이 바뀌어도 문맥·이해 상태·판정 기준이 끊기지 않도록 설계된 학습 프로젝트 템플릿이다.
특정 Agent의 대화 기억에 의존하지 않고, **저장소 자체**가 학습 목표·현재 이해 상태·근거·계획·규칙을 설명한다. 같은 저자의 [AI-Agent Project Template](https://github.com/jjjung0921/Agent_Project)의 학습판이며 규칙·상태 파일·스크립트 구조를 공유한다.

<!-- 새 학습 프로젝트로 초기화한 뒤에는 이 README를 주제 소개(무엇을, 왜, 어떻게 진행하는지)로 교체한다. 절차는 .ai/BOOTSTRAP.md 참고. -->

## Learning Process

| 단계                    | 질문                                   | 어디에                                   | 무엇이 만드는가                            |
|-------------------------|----------------------------------------|------------------------------------------|--------------------------------------------|
| 1. learning goal        | 무엇을 배우려는가?                     | `LEARNING_GOALS.md`                      | 초기화 대화 — 목표마다 증명 방법(Proof)   |
| 2. curriculum           | 어떤 순서로 배울 것인가?               | `curriculum/ROADMAP.md`, `phases/`       | concept 선행 관계(DAG) → Phase → 10–25분 unit |
| 3. concept              | 어떤 개념을 이해해야 하는가?           | `concepts/<slug>.md`                     | 학습자 언어의 정의 + 근거 라벨이 붙은 Claims |
| 4. evidence             | 그 개념이 맞다는 근거를 어디서 확인하는가? | `evidence/<slug>.md`                  | 논문·교재·유도·실험 — concept의 Claims가 가리킨다 |
| 5. exercise             | 내가 실제로 적용할 수 있는가?          | `exercises/YYYY-MM-DD-<concept>-<type>.md` | 문제 + Rubric + 시도 + 항목별 판정        |
| 6. understanding state  | 현재 어느 정도 이해했는가?             | `concepts/` frontmatter `state`          | exercise 기록에서만 도출 (선언 불가)       |

## Design Goals

1. 모든 튜터가 같은 규칙을 공유한다 → 규칙은 `AGENTS.md` 한 곳에만 둔다.
2. 새 세션은 최소 context만 읽고 이어간다 → `AGENTS.md` → `.ai/CURRENT.md` → `.ai/HANDOFF.md` → `scripts/study-start.sh` 출력 → 오늘 unit의 파일만.
3. 장기 학습 지식(`concepts/`·`evidence/`·`curriculum/`)과 세션 상태(`.ai/`)를 분리한다.
4. **이해 상태는 선언이 아니라 근거에서 도출된다** → `state`는 채점된 exercise 기록을 가리켜야만 바뀌고, `scripts/study-end.sh`가 근거 없는 상태를 잡는다.
5. 판정 기준을 엔진의 재량에서 뺀다 → concept의 Verification Criteria에서 파생한 Rubric을 문제와 함께 먼저 쓰고, 항목별 판정 + 인용, 부분 = 미통과, grader 기록.
6. 학습자는 LaTeX를 치지 않는다 → 사진·ASCII·코드·말로 답하고 튜터가 전사한다. 입력 비용이 낮은 exercise 유형을 일상 검증에 쓴다.
7. 하루 분량과 시간이 달라도 계획이 깨지지 않는다 → unit은 10–25분 + 선행 관계, 세션 시작에 예산을 선언하고, `LOG.md`의 planned·actual로 속도를 계산해 남은 분량과 예상 완료를 보여준다.
8. 아는 것도 썩는다 → verified에도 복습 만기가 있고 만기 항목이 새 unit보다 먼저다.
9. 학습자의 직접 수정·판단이 튜터의 판단보다 우선한다 → git checkpoint로 감지, `.ai/INBOX.md`로 지시. 학습자가 쓴 틀린 정의는 고쳐 쓰지 않고 exercise로 확인한다.
10. 세션이 언제 끊겨도 저장소만으로 재개한다 → Progress 체크리스트, handoff-first, close commit.

## How to Use This Template

1. subject 폴더에 템플릿을 얹는다 — `cp -r ~/study/template/. ~/study/<subject>/` (또는 별도 저장소로 만들어 GitHub의 "Use this template"). **폴더는 subject마다 하나지만 템플릿은 "…를 할 수 있다"는 목표가 생겼을 때만 복사한다** (DR-0005). 스토리 원장만 있는 subject 폴더는 그대로 두고, 이미 원장(`why--<topic>.md` 등)이 있어도 이름이 겹치지 않으므로 그 위에 복사하면 된다. 스크립트는 상위 저장소(`~/study` vault) 안의 하위 폴더에서도, 독립 저장소에서도 동작한다. git 저장소가 아니면 변경 추적·checkpoint만 빠진다.
2. `.ai/BOOTSTRAP.md`의 **Topic Description**에 주제·목적·기한·배경·시간 예산·자료를 적는다.
3. 사용하는 AI Agent에게 `.ai/BOOTSTRAP.md`를 수행하라고 지시한다.
   Agent가 목표를 "할 수 있다" 문장과 증명 방법으로 바꾸고, 개념 목록과 선행 관계를 만들고, 자료를 evidence로 등록하고, Phase와 unit으로 나눈 뒤 `BOOTSTRAP.md`를 삭제한다.
4. 이후 모든 세션은 `AGENTS.md`의 Rules와 Session Procedure를 따른다. 세션 시작은 `scripts/study-start.sh <오늘 분>`.

**Subject의 크기** — subject는 concept map 하나를 공유하는 단위다. 선행 관계가 서로 이어지는 개념은 같은 subject이고(예: `optimization` = gradient → Jacobian → IFT → hypergradient → bilevel), 이어지지 않으면 다른 subject다(`game-ai`, `web`, `programming-language`). `CONCEPT_MAP.md`의 Reading Order가 끊긴 덩어리 둘로 갈라지면 나누고, 두 subject가 개념을 30% 넘게 공유하면 합치거나 공통 부분을 별도 subject로 뺀다. 워크스페이스는 한 번 만들면 오래 간다 — 목표(G)와 Phase를 계속 추가하는 그 도메인의 상태 저장소다. 다른 subject의 개념은 `requires`에 넣지 않고 `evidence`로 그쪽 concept 파일을 가리키며, state는 그쪽 폴더가 기준이다.

## Repository Layout

```text
/
├── AGENTS.md                  # 모든 튜터 공통 규칙 (프로세스의 source of truth)
├── CLAUDE.md                  # Claude Code 진입점 → @AGENTS.md
├── GEMINI.md                  # Gemini CLI 진입점 → @./AGENTS.md
├── README.md
├── LEARNING_GOALS.md          # 무엇을 이해할 것인가 — 목표마다 증명 방법(capstone)
├── LEARNER.md                 # 시간 예산 · 배경 · 입력 방식 · 스크립트가 읽는 파라미터
├── curriculum/
│   ├── ROADMAP.md             # Phase 목록·상태·남은 분량 (날짜 계획 없음)
│   ├── phases/
│   │   ├── _template/         # 새 Phase용 PLAN.md / RESULT.md 양식 (unit = 10–25분 + requires + est)
│   │   └── 01-orientation/
│   │       └── PLAN.md
│   └── decisions/
│       ├── _template.md       # DR 양식
│       ├── DR-0001-repository-as-learning-memory.md
│       ├── DR-0002-evidence-derived-understanding-state.md
│       ├── DR-0003-learner-never-types-latex.md
│       ├── DR-0004-budget-driven-sessions.md
│       └── DR-0005-one-folder-per-subject.md
├── concepts/
│   ├── _template.md           # frontmatter: state · requires · evidence · verified_by · review_due
│   ├── CONCEPT_MAP.md         # 선행 관계 그래프 (requires에서 유지)
│   └── MISCONCEPTIONS.md      # 관찰된 오개념 — 해결돼도 남긴다 (재발한다)
├── evidence/
│   ├── INDEX.md               # 자료 목록 · 유형 · 상태
│   └── _template.md           # 자료가 어느 개념의 어느 주장을 뒷받침하는지, 위치까지
├── exercises/
│   ├── README.md              # 유형 카탈로그(입력 비용·목적) · 파일명 · 사진 규칙
│   ├── _template.md           # 문제 · Rubric · Attempt · Grading · Next
│   └── _inbox/                # 손글씨 사진 원본 (gitignore)
├── sandbox/                   # 실험 코드 · 계산 · 노트북 (source of truth 아님)
├── scripts/
│   ├── study-start.sh         # 세션 시작: 예산, checkpoint 이후 변경, INBOX, 복습 만기, 준비된 unit, 속도·예상 완료, 오늘 구성 제안
│   └── study-end.sh           # 세션 종료: 커밋·Status·checkpoint·HANDOFF·LOG 점검, state–근거 일치, 크기 상한
└── .ai/
    ├── CURRENT.md             # 현재 Phase·unit·Status·Progress·Last Checkpoint (항상 짧게)
    ├── HANDOFF.md             # 세션 → 다음 세션 인수인계 (덮어쓰기)
    ├── LOG.md                 # 세션 기록 — 학습자 보고 + planned·actual 속도 데이터 (최신순)
    ├── INBOX.md               # 학습자 → 튜터 지시 (오늘 예산·컨디션·질문·사진 위치, 처리 후 삭제)
    └── BOOTSTRAP.md           # 템플릿 → 학습 프로젝트 초기화 절차 (초기화 후 삭제)
```

## Stories — 커리큘럼 밖의 발견 주도 학습 (`~/study/stories/`)

프로젝트 작업 중 처음 만난 개념은 커리큘럼을 거치지 않고 별도 폴더 `~/study/stories/`로 들어온다(자체 README·AGENTS.md가 절차를 정한다): 이월 규칙이 `~/study/stories/QUEUE.md`에 씨앗을 남기고, 별도 세션에서 `story--<topic>.md`(발견 → 질문 → 학습 → 실험 → 이해 → 적용 → 회고)로 학습한 뒤 포트폴리오 시리즈로 변환한다(`study-series` 스킬). 이 템플릿과의 관계는 다음과 같다.

- 스토리는 **서사·출력 층**, 이 템플릿의 `concepts/`·`exercises/`는 **상태·검증 층**이다. 스토리의 "5. 이해" 절에 적는 self-exam 결과를 exercise 기록으로 남기면 concept state의 근거가 된다.
- 스토리 쪽은 질문 원장(`why--<topic>.md` 등)을 `~/study/<subject>/`에 두므로, 이 템플릿으로 만든 워크스페이스에 원장 파일이 함께 놓일 수 있다. 원장은 스토리 측 파일이며 concept state의 근거가 아니다 — 스토리의 개념이 `LEARNING_GOALS.md`의 목표와 이어지면 `concepts/<slug>.md`를 만들고 스토리·원장을 evidence(`type: experiment`)로 가리킨다. 이어지지 않으면 스토리로만 둔다.

## Agent Entry Points

| Agent | 읽는 파일 | 비고 |
|-------|-----------|------|
| Codex (CLI / ChatGPT) | `AGENTS.md` | 기본 지원. 스킬은 `.codex/skills/`에 사본 |
| Claude Code | `CLAUDE.md` → `AGENTS.md` | `@AGENTS.md` import |
| Gemini CLI | `GEMINI.md` → `AGENTS.md` | `@./AGENTS.md` import |
| 웹 채팅(ChatGPT, Claude 등) | `AGENTS.md` + `.ai/CURRENT.md` + `scripts/study-start.sh` 출력을 첫 메시지로 전달 | 결과는 사람이 저장소에 반영하고 trailer를 붙여 커밋 |
| 기타 도구(Cursor, Copilot 등) | 도구별 설정에서 `AGENTS.md` 참조 | 규칙을 복사하지 않는다 |

## Workflow at a Glance

- **세션 시작**: `scripts/study-start.sh <분>` → 출력의 next steps (Resume 여부, 학습자 변경·INBOX 반영, 복습 만기, 예산에 맞는 unit 제안, HANDOFF 초안) → 진행
- **세션 중**: 복습 → 진행 중 unit → 새 unit 하나. exercise는 문제와 Rubric을 먼저 쓰고, 답은 사진·ASCII·코드로 받아 전사·확인 후 항목별 판정. step마다 `CURRENT.md` Progress 갱신
- **세션 종료**: exercise `result` 확정 → concept `state`·`review_due` 갱신 → 작업 커밋 → `CURRENT.md`·`HANDOFF.md`·`LOG.md`(planned·actual) → `scripts/study-end.sh --set-checkpoint` → close commit
- 판단 규칙은 `AGENTS.md`의 Rules 15개가 유일한 기준이고, 절차의 세부는 스크립트 출력과 스킬이 안내한다. 상태 파일에는 크기 상한이 있다 (Rule 13).

## For Learners

- **오늘 시작**: `.ai/INBOX.md`에 `- [ ] YYYY-MM-DD 오늘 20분`처럼 예산을 적거나 `scripts/study-start.sh 20`으로 시작한다. 손글씨는 사진으로 `exercises/_inbox/`에 넣고 INBOX에 파일명을 적는다.
- **현황 확인**: `.ai/LOG.md` 맨 위 항목(한 것, 판정, 상태 변화, 확인 요청)을 본다. 개념별 상태는 `concepts/` frontmatter, 전체 진행은 `scripts/study-start.sh` 출력의 remaining·projection.
- **직접 수정**: 평소처럼 커밋한다(trailer 없이). 다음 세션의 튜터가 checkpoint 이후 변경을 학습자 변경으로 감지해 되돌리지 않고 반영한다. 틀린 정의를 써 두어도 튜터는 고쳐 쓰지 않고 exercise로 확인한다.
- **판정에 이의**: exercise 파일의 Grading 아래에 한 줄 적고 INBOX에 재채점을 요청한다. Rubric 자체가 잘못됐으면 concept의 Verification Criteria를 고친다 — 이후 exercise에 반영된다.
- **중단된 세션**: `.ai/CURRENT.md`의 Status가 `IN_PROGRESS`면 세션이 끊긴 것이다. 다음 튜터에게 그대로 시작을 지시하면 Resume 절차를 따른다.
