# DR-0002: 이해 상태는 선언이 아니라 exercise 기록에서 도출한다 — 판정 기준을 엔진의 재량에서 뺀다

- Status: Accepted
- Date: 2026-08-29
- Deciders: 템플릿 소유자

## Context

AI 엔진마다 답변을 판정하는 기준이 다르다. 같은 답을 두고 한 엔진은 "조건을 빠뜨렸다"고 하고 다른 엔진은 "핵심은 이해했다"고 통과시킨다(관찰: ChatGPT가 엄격, Claude가 관대). 학습자는 주로 한 엔진을 쓰지만 세션마다 같은 엔진도 판정이 흔들린다. 원인은 채점이 인상(impression)에 맡겨져 있고, 무엇을 보는지(논지만 / 조건·가정까지)가 그때그때 정해지며, "이해했다"는 상태가 튜터의 문장으로 선언되기 때문이다.

또 하나: 개념을 설명한 직후의 확인 질문은 통과율이 높지만 며칠 뒤에는 남아 있지 않다. 설명 직후의 되풀이를 이해의 근거로 삼으면 상태가 실제보다 앞서 나간다.

## Problem

엔진·세션이 달라도 같은 답에 같은 판정이 나오고, 이해 상태가 실제 적용 능력을 반영하게 하려면 판정과 상태 변경을 어떻게 고정할 것인가.

## Alternatives

1. **AGENTS.md에 "엄격하게 채점하라"고 쓴다** — 프로즈 지시는 엔진의 기본 성향을 조금 옮길 뿐 기준을 통일하지 못한다.
2. **엔진 하나로 고정한다** — 세션 간 흔들림은 남고, 엔진을 바꿀 자유를 잃는다.
3. **판정을 체크리스트로, 상태를 기록의 함수로 바꾼다** — Rubric을 문제와 함께 먼저 쓰고, 항목별 판정에 인용을 요구하며, state는 exercise 기록이 있을 때만 바뀌고 스크립트가 근거 없는 상태를 잡는다.

## Decision

3안을 채택한다.

- **Rubric-first** (Rule 9): exercise 파일에 Problem과 함께 Rubric(정답이 반드시 포함해야 할 항목, 흔한 오답)을 먼저 쓴다. Rubric은 concept의 **Verification Criteria**에서 파생한다 — 개념마다 "이해했다고 볼 기준"을 한 번 적어 두고 학습자가 검토하므로, 어떤 엔진이 출제해도 같은 기준을 본다. 학습자는 답변 전에 Rubric을 보지 않는다(접힘 블록, honor system).
- **항목별 판정 + 인용**: Grading은 Rubric 항목마다 ✓/✗와 Attempt의 인용이다. 총평·칭찬을 쓰지 않는다. 근거 인용이 없는 판정은 무효다.
- **Strict default**: `pass | partial | fail` 3등급. partial은 미통과. 두 등급 사이면 낮은 쪽. 오탐(모르는데 통과)의 비용이 미탐(아는데 한 번 더)보다 크다.
- **Grader 기록**: 모든 exercise에 `grader:`를 적는다(커밋의 `Agent:` trailer와 같은 역할). 엔진을 바꾸면 LOG·exercise에서 grader별 통과율을 볼 수 있다. 여러 엔진을 번갈아 쓰는 경우에는 verified 조건에 "서로 다른 grader"를 추가할 수 있다(이 템플릿의 기본값은 아니다 — 학습자가 엔진을 자주 바꾸지 않는다).
- **State는 기록의 함수** (Rule 8): `concepts/` frontmatter의 `state`는 `verified_by`가 가리키는 exercise 파일로만 정당화된다. introduced(학습자 언어의 Definition + 근거 라벨이 붙은 Claims + Verification Criteria) → practiced(pass 또는 partial 1회) → verified(**서로 다른 날** pass ≥ `verified_passes`, 그중 transfer·derivation·proof·coding 1회 이상). `scripts/study-end.sh`가 verified·practiced 개념의 `verified_by`를 열어 존재·result·날짜·유형을 검사하고, 어긋나면 FAIL이다.
- **같은 세션의 되풀이는 근거가 아니다**: 설명 직후의 확인 질문은 practiced의 근거는 되어도 verified의 근거는 되지 않는다(다른 날 조건).
- **객관 판정 우선**: 수치 답, sandbox 코드 테스트, 오류 위치 찾기처럼 재량이 없는 유형을 검증에 우선 쓴다 (`exercises/README.md`).
- **Decay** (Rule 14): verified에도 `review_due`가 있다. 복습 pass면 `review_stage`를 올려 `LEARNER.md`의 `review_intervals`(기본 3·7·21·60일) 다음 간격으로 미루고, fail이면 `stale`로 내린다. stale은 복습 pass 1회로 verified로 돌아온다.

## Rationale

- 엔진의 성향 차이는 "무엇을 볼지"가 정해져 있지 않을 때 드러난다. 항목이 고정되면 남는 차이는 항목 해석뿐이고, 인용 요구가 그 해석을 드러낸다.
- 기준을 concept에 두면 exercise마다 기준을 새로 만들지 않는다. 학습자가 기준을 고치면 이후 모든 exercise에 반영된다.
- 상태를 기록의 함수로 두면 "이해했다"는 문장을 쓸 수 없다 — 파일을 가리켜야 한다. 스크립트가 이를 검사하므로 튜터의 성실성에 의존하지 않는다 (개발 템플릿 ADR-0004의 "실행 가능한 제약"과 같은 원리).
- 다른 날 조건은 망각 곡선의 가장 싼 대리 지표다.

## Consequences

- 긍정: 엔진이 바뀌어도 판정이 크게 흔들리지 않는다. 이해 상태가 파일과 스크립트로 검증된다. 판정 이의가 생기면 Rubric 항목 단위로 논의할 수 있다.
- 부정 / 감수한 것: 출제 비용이 늘어난다(Rubric 작성). Rubric을 미리 보지 않는 것은 honor system이다. strict default는 초반에 통과율이 낮아 보여 사기를 떨어뜨릴 수 있다 — LOG에는 판정만 적고 해석을 붙이지 않는다.
- 후속 작업: Verification Criteria의 품질이 전체를 좌우한다. 초기화 시 concept마다 3–6개를 쓰고 학습자가 검토한다. 판정에 이의가 반복되면 기준을 고치고 DR로 남긴다.
