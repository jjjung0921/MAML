# Bootstrap — 템플릿을 실제 학습 프로젝트로 초기화

<!-- 새 주제를 시작할 때 한 번 수행하는 절차다. 초기화가 끝나면 이 파일을 삭제한다. -->

너는 이 학습 프로젝트의 커리큘럼을 설계하는 Tutor이자 AI Agent Workflow Designer다.

이 저장소는 AI Agent를 튜터로 삼아 공부하기 위한 템플릿에서 생성되었다. 규칙은 `AGENTS.md`에 있고, 각 문서의 작성 지침은 문서 안의 `<!-- -->` 주석에 있다. 아래 Topic Description을 바탕으로 템플릿을 실제 학습 프로젝트로 바꿔라.

## Topic Description

<여기에 주제 설명을 입력한다: 무엇을 배우려는지, 왜(연구·프로젝트·시험), 끝나면 무엇을 할 수 있어야 하는지, 기한, 이미 아는 것과 배경, 하루·주간 시간 예산, 수식 입력 방식(손글씨 사진 / ASCII / 코드), 갖고 있는 자료(논문·교재·강의), 이미 결정된 사항.>

## Procedure

1. `AGENTS.md`를 읽는다. 그 규칙은 이 절차에도 적용된다 (특히 Rule 4 Learner changes, 6 Scope, 8 State — 근거 없이 state를 올리지 않는다).
2. Topic Description을 읽는다. 부족한 정보는 **합리적인 최소 가정**으로 채우되, 모든 가정을 `.ai/HANDOFF.md`의 Unverified Assumptions에 기록한다. 목표·범위·기한·시간 예산처럼 방향을 좌우하는 것은 학습자에게 먼저 묻는다.
   이 폴더가 subject 폴더(`~/study/<subject>/`)인지 확인한다 — 아래 **Subject** 절. 이미 있는 스토리 원장(`why--<topic>.md` 등)과 `~/study/stories/`의 story는 학습자 파일이다(Rule 4): 고치지 않고, Prior Knowledge와 evidence 후보로만 읽는다.
3. 목표를 정식화한다 — 아래 **Curriculum Design**의 Goals 절차를 따른다 (`problem-framing` 스킬이 있으면 사용). `LEARNING_GOALS.md`를 채운다: 목표마다 "…를 할 수 있다"와 Proof(capstone exercise), Non-Goals, Prior Knowledge(아직 state에 반영하지 않는다), Constraints.
4. `LEARNER.md`를 채운다: 시간 예산, 배경, Input Preferences(수식 입력 경로 우선순위), Grading Preferences, Parameters(기본값을 학습자와 확인).
5. 개념 목록을 만든다 — Curriculum Design의 Concepts 절차. `concepts/<slug>.md`를 `_template.md`에서 만들되 **Definition은 비워 둔다**(학습자 언어로 채워야 한다, Rule 4). Why It Matters·Verification Criteria(3–6개)·Connections는 채운다. state는 모두 `unseen`. `CONCEPT_MAP.md`에 그래프·Reading Order·Boundaries.
6. 근거 자료를 등록한다 — `evidence/INDEX.md`에 자료·유형·접근 경로·관련 개념 (`research-survey` 스킬이 있으면 사용). 접근 확인과 evidence 파일 생성은 Phase 01 U3에서 한다.
7. 계획을 나눈다 — Curriculum Design의 Phases & Units 절차. `curriculum/ROADMAP.md`에 전체 Phase(Est 포함)를 등록하고, Phase 02(첫 학습 Phase)의 PLAN을 상세히 쓴다. Phase 01 PLAN의 Scope·Units를 주제에 맞게 조정한다.
8. 다음 파일의 placeholder(`<...>`)와 작성 지침 주석을 주제 내용으로 교체한다: `AGENTS.md`(Subject, Commands의 Sandbox), `README.md`(템플릿 소개 → 주제 소개: 무엇을·왜·어떻게 진행하는지), `LEARNING_GOALS.md`, `LEARNER.md`.
9. 주제별 결정(자료 선택, 범위 제외, 파라미터 변경)을 `curriculum/decisions/`의 다음 번호 DR부터 기록한다 (`_template.md` 사용; DR-0001~0005는 이 템플릿의 방법 결정이므로 유지). 사소한 결정은 DR로 만들지 않는다.
10. 이 파일(`.ai/BOOTSTRAP.md`)을 삭제하고, `README.md`·`.ai/CURRENT.md`·Phase 01 PLAN에서 BOOTSTRAP 참조를 제거한다.
11. 작업 커밋을 남긴다: `chore: bootstrap study from template` (Commit Format대로 `Agent:`·`Unit: 01/U1` trailer 포함).
12. `.ai/LOG.md`에서 템플릿 생성 세션 항목을 지우고, `AGENTS.md`의 Session Procedure(종료)대로 끝낸다 (CURRENT.md가 U2를 가리키게, HANDOFF.md 갱신, LOG 항목 추가, `scripts/study-end.sh --set-checkpoint`, close commit).

## Output Checklist

- [ ] `AGENTS.md`, `README.md`, `LEARNING_GOALS.md`, `LEARNER.md`에 placeholder와 작성 지침 주석이 없다
- [ ] `LEARNING_GOALS.md`의 목표마다 Proof(exercise 유형과 조건)와 Phase가 있다
- [ ] 모든 `concepts/*.md`에 `requires`·Verification Criteria가 있고 state가 `unseen`이며 Definition이 비어 있다; `CONCEPT_MAP.md`와 `requires`가 일치한다
- [ ] `evidence/INDEX.md`에 Phase 02 Scope 개념의 자료가 있다
- [ ] `ROADMAP.md`의 Phase마다 Est가 있고, Phase 02 PLAN의 unit이 10–25분·requires·est·Done when을 갖췄다
- [ ] `LEARNER.md` Parameters가 학습자와 확인되었다
- [ ] 모든 가정이 `.ai/HANDOFF.md`의 Unverified Assumptions에 있다
- [ ] `.ai/CURRENT.md`가 Phase 01 U2(진단)를 가리킨다
- [ ] `.ai/BOOTSTRAP.md`가 삭제되었고 남은 참조가 없다
- [ ] `scripts/study-end.sh`가 통과했다

---

## Curriculum Design — 목표에서 unit까지

<!-- 계약은 Phase 01 PLAN의 AC2·AC3·AC5(목표마다 Proof, concept마다 requires·state, Phase마다 Est와 준비된 unit)다. 아래는 그 계약을 채우는 절차이며 주제에 맞게 바꾼다. -->

### Subject

1. subject = concept map 하나를 공유하는 단위 (DR-0005). 목표에서 역방향으로 뽑을 개념들이 서로 선행 관계로 이어지면 이 폴더가 맞다. 이어지지 않는 덩어리가 둘이면 목표가 두 subject에 걸친 것이다 — 주된 쪽을 이 폴더로 하고 나머지 개념은 그 subject 폴더의 concept을 `evidence`로 가리킨다(`requires`에 넣지 않는다).
2. 폴더 이름은 kebab-case 도메인 이름(`optimization`, `game-ai`, `web`)이며 포트폴리오 `field`보다 한 단계 아래 크기다. 워크스페이스는 목표·Phase를 계속 추가하며 오래 가므로, "이번 목표"의 이름(`bilevel-hypergradient`)을 폴더 이름으로 쓰지 않는다.
3. 이미 `~/study/stories/`에 이 subject의 story가 있으면 Prior Knowledge의 근거이자 evidence 후보(`type: experiment`)다. 진단 exercise(U2)로 확인한 뒤에만 state에 반영한다.

### Goals

1. Topic Description의 "끝나면 무엇을 할 수 있어야 하는가"를 목표 3–6개로 쪼갠다. 각 목표는 관찰 가능한 행동이다: "…를 유도할 수 있다", "…를 구현하고 수치로 검증할 수 있다", "논문 X의 주장을 근거와 함께 평가할 수 있다". "…를 안다/이해한다"는 목표가 아니다.
2. 목표마다 Proof를 정한다 — 통과하면 목표가 증명되는 exercise 하나: 유형(`exercises/README.md`)과 조건(처음 보는 문제 설정, 수치 검증 포함 등). 이것이 해당 Phase의 capstone이다.
3. Non-Goals를 적는다. 주제 옆에 있어서 끌리는 것(일반화된 이론, 최신 변형, 구현 최적화)을 명시적으로 뺀다.
4. Prior Knowledge는 학습자가 안다고 말한 것을 그대로 적는다. state에는 반영하지 않는다 — Phase 01 U2의 진단 exercise(low cost, 개념당 1개)에서 pass면 practiced, 서로 다른 날 조건이 없으므로 verified는 아니다(첫 복습 pass 때 verified).

### Concepts

1. 각 Proof에서 역방향으로 묻는다: "이 exercise를 풀려면 무엇을 쓸 수 있어야 하는가?" → 그것을 쓰려면? — 학습자의 Prior Knowledge에 닿을 때까지. 나온 것이 개념 목록이다. 5–15개로 시작하고, 20개를 넘으면 목표가 너무 넓다.
2. 개념은 "한 세션에 도입하고 low-cost exercise 하나로 확인할 수 있는 크기"다. 더 크면 나눈다(예: "implicit function theorem" → 조건·결론 / 도함수 공식 적용).
3. `requires`로 DAG를 만든다. 순환이 있으면 개념 경계가 잘못된 것이다. `CONCEPT_MAP.md`의 Reading Order는 위상 정렬이다.
4. Verification Criteria는 개념마다 3–6개. C1 조건(성립 조건을 말할 수 있다) · C2 판별(적용 가능 여부를 판단할 수 있다) · C3 계산(구체적 예에서 계산할 수 있다) · C4 전이(처음 보는 문제에 세울 수 있다)의 골격을 쓰되 주제에 맞게 바꾼다. Rubric은 여기서 파생되므로(DR-0002) 학습자가 검토해야 한다 — 초기화 세션에서 함께 읽는다.
5. Boundaries: 혼동하기 쉬운 개념 쌍(gradient vs Jacobian, 최적성 조건 vs 볼록성)을 적는다. error-spot·condition exercise의 재료가 된다.

### Evidence

1. 개념마다 "이 개념이 맞다는 것을 어디서 확인하는가"를 정한다: 원 논문, 교재의 정리, 강의, 공식 문서, 또는 직접 유도·수치 실험(sandbox). 하나의 개념에 근거가 없으면 `[unsupported]`로 시작하고 자료를 찾는 unit을 둔다.
2. `evidence/INDEX.md`에 등록한다. 접근 가능 여부(유료 논문, 절판 교재)는 Phase 01 U3에서 확인한다. 자료 전체를 읽는 것은 unit이 아니다 — 개념이 가리키는 위치(절·정리)만 읽는다.

### Phases & Units

1. DAG를 2–4개 Phase로 자른다. 한 Phase = 목표 하나(또는 밀접한 둘)의 개념 묶음 + capstone. Phase가 6주(예상 세션 수 기준)를 넘으면 나눈다.
2. Phase 안의 unit: 개념마다 learn(도입 + evidence 읽기, 15–25분) → practice(low-cost exercise, 10–15분)를 기본으로 하고, 개념 2–3개마다 review, Phase 끝에 capstone(high cost, 30–60분 — 두 세션에 걸쳐도 된다). unit마다 `est`와 `requires`를 적는다.
3. est는 처음엔 틀린다. `scripts/study-start.sh`가 LOG의 actual로 비율을 보정하므로 정밀하게 맞추려 하지 않는다. 다만 25분을 넘는 unit은 나눈다.
4. Phase Est = unit est 합계 → `ROADMAP.md`. 처음 2개 Phase만 상세 PLAN을 쓰고 나머지는 목록만 둔다.
5. Phase 02 PLAN의 Validation Plan에 복습 스케줄(verified 후 3·7·21·60일)이 다음 Phase와 겹치는 것을 적는다 — 복습은 Phase와 무관하게 먼저다.

### Parameters

- `default_budget`·`min_session`·`review_only_below`: 학습자의 Typical week에서 정한다. 평일 예산이 20분이면 `review_only_below`는 10 정도.
- `review_est`·`record_est`: 첫 3세션은 기본값(5분)으로 두고 LOG의 actual로 조정한다.
- `verified_passes`: 기본 2. 시험 대비처럼 정확도가 중요하면 3.
- `review_intervals`: 기본 `3 7 21 60`. 기한이 짧으면 앞을 촘촘히(`2 5 14 30`).
