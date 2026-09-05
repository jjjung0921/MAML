# Phase 02 — maml-core

- Status: PLANNED
- Start: 미시작 · End: 미완료
- Goals: G1, G2

## Goal

과제·데이터·적응 후 목적함수와 exact/FOMAML 미분 경로를 새 작은 문제에 적용해 G1·G2 capstone을 통과한다. 공식 DONE은 아래 검증 조건까지 충족해야 한다.

## Motivation

후속 연구에서 무엇이 달라졌는지 읽으려면 MAML이 무엇을 학습하고 어느 경로를 미분하는지 먼저 구분해야 한다.

## Scope

- Concepts: task-episode, adaptation-objective, meta-gradient, first-order-approximation.
- Evidence: INDEX의 Phase 02, MAML §2.1–2.2·Algorithm 1–2·§5.2·Table 1; 기존 수식 해설 B.1–B.2, B.3은 경로만.
- Sandbox: N/A. 손글씨·ASCII로 스칼라 이차 손실의 한 step을 계산한다.

## Out of Scope

- 구현·GPU·정확도 재현, 일반적 비용 복잡도 증명, RL의 gradient 추정과 implicit differentiation.
- 다중 step의 긴 행렬곱 계산. 순서와 의존 경로만 짚는다.

## Dependencies

- Phase 01 U2–U4: 진단 완료, 원문 접근·evidence 카드·운영 가정 검토.
- 선수 수학 미확인: 미분·연쇄법칙·벡터 차원의 공백이 크면 진단 근거와 함께 보완 범위·시간을 제안한다.

## Units

- [ ] U1. 과제와 데이터 경계 도입 — learn · est 15m · requires — · Done when: task-episode의 학습자 Definition, 출처가 붙은 Claims, C1–C4 기준 검토
- [ ] U2. support/query와 task 분리 연습 — practice · est 10m · requires U1 · Done when: task-episode condition/numeric exercise pass 및 practiced 근거 기록
- [ ] U3. 적응 후 목적함수 도입 — learn · est 10m · requires U2 · Done when: adaptation-objective Definition·Claims, 초기값·적응 결과·데이터 역할을 학습자가 설명
- [ ] U4. 목적함수 연습과 데이터 경계 복습 — practice · est 10m · requires U3 · Done when: adaptation-objective fill-step exercise pass, task-episode 경계 재확인 기록; 미통과는 보완
- [ ] U5. meta-gradient 의존 경로 도입 — learn · est 15m · requires U4 · Done when: meta-gradient Definition·Claims와 한 step 합성 경로 작성; 1일차 첫 5분 진행 후 HANDOFF에서 나머지 10분 재개
- [ ] U6. 작은 이차 손실의 exact gradient — practice · est 10m · requires U5 · Done when: meta-gradient numeric/fill-step exercise pass; 초기값 미분과 query gradient 구분
- [ ] U7. FOMAML 근사와 HVP 비용 도입 — learn · est 10m · requires U6 · Done when: first-order-approximation Definition·Claims; U5의 미분 경로에서 생략 항·유지하는 적응·비용 근거 범위 설명
- [ ] U8. exact와 first-order 비교 연습 — practice · est 10m · requires U7 · Done when: first-order-approximation numeric/error-spot exercise pass, meta-gradient 경로 복습; 일반적 동등성·선호를 단정하지 않음
- [ ] U9. G1·G2 통합 capstone — capstone · est 10m · requires U2,U4,U6,U8 · Done when: 처음 보는 스칼라 이차 손실 문제의 데이터 배치·목적함수·exact/FO 비교를 concept별 transfer/derivation 파일로 기록하고 모두 pass

Est 합계 100분. U3·U7은 직전 개념에 새로운 의존 관계 하나를 추가하는 10분 도입이며, 계산과 근거 판별은 뒤의 practice에서 확인한다. U9는 1차원 한 step 문제와 짧은 구두 설명으로 제한한다. 복습은 U4·U8에 포함한다. 진단 실패나 추가 설명·재시도가 필요하면 actual을 남기고 완료 시간을 조정한다.

## Relevant Documents

- LEARNING_GOALS.md G1·G2, 해당 네 concept의 Verification Criteria.
- evidence/INDEX.md의 Phase 02 및 U3에서 확보한 학습용 evidence 카드.
- curriculum/decisions/DR-0006-two-day-maml-reading.md.

## Acceptance Criteria

- [ ] AC1. 네 concept의 학습자 Definition·근거 라벨/포인터가 붙은 Claims·확인된 exercise가 있다.
- [ ] AC2. G1·G2 capstone의 concept별 필수 Rubric 전부 pass.
- [ ] AC3. 공식 DONE 전 네 concept 모두 verified: 서로 다른 날 pass 2회 이상, high 유형 1회 이상, verified_by·verified_on·review_due 일치.
- [ ] AC4. 관련 오개념 후보는 검증 기록으로 판정하고, 남은 항목과 보완 계획을 HANDOFF에 인계.

AC1·AC2 충족 후 AC3만 대기하면 REVIEW로 두고 Phase 03 독해를 시작할 수 있다(DR-0006). concept을 임의로 승격하거나 Phase 02를 DONE으로 쓰지 않는다.

## Validation Plan

- 각 practice·capstone은 concept의 C1–C4에서 Rubric을 먼저 작성하며 학습자 전사 확인 후에만 채점한다.
- G1·G2 문제는 공통 상황을 써도 concept별 exercise 파일로 나눈다. 하나의 concept만 받는 기존 frontmatter 계약을 유지한다.
- 같은 날의 연습·capstone은 서로 다른 날 pass 2회를 대체하지 않는다. 2일차 시작의 재개와 Phase 03 계획 확정 시 날짜별 증거 공백을 확인한다. 미충족 concept은 별도 후속 평가로 이월한다.
- verified 후 3·7·21·60일 복습은 다음 Phase와 겹쳐도 먼저 한다. 이틀 뒤에도 검증/복습 대기 목록을 HANDOFF에 유지한다.
- scripts/study-end.sh로 상태–근거 일치 확인. 미verified 개념의 추가 확인은 만기 자동 목록에 없으므로 HANDOFF의 대기 목록을 직접 확인한다.
