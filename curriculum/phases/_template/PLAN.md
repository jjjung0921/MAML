# Phase NN — <phase-name>

<!--
새 Phase 시작 시 작성한다. Scope가 곧 튜터의 작업 허용 범위이므로 구체적으로 적는다.
Unit은 한 세션(10–25분)에 끝나고 독립적으로 판정 가능한 크기로 나눈다. requires로 선행 관계를 적어 DAG로 만든다 —
튜터는 예산에 맞는 "준비된 unit"(선행이 모두 [x])을 고른다. 줄 형식은 스크립트가 읽으므로 유지한다.
-->

- Status: PLANNED | IN_PROGRESS | DONE
- Start: <YYYY-MM-DD> · End: <YYYY-MM-DD>
- Goals: <G1, G2 — LEARNING_GOALS.md>

## Goal

<이 Phase가 끝났을 때 참이 되어야 하는 한 문장. 예: "<concept>들이 verified이고 <capstone>을 통과했다".>

## Motivation

<왜 지금 이 Phase인가. 어떤 목표(G)·어떤 상위 개념에 필요한가.>

## Scope

- Concepts: <slug, slug — 이 Phase에서 introduced → verified로 올릴 개념>
- Evidence: <읽을 자료 (evidence/<slug>.md)>
- Sandbox: <할 실험·계산이 있으면>

## Out of Scope

- <이번 Phase에서 하지 않는 것. 하고 싶어지기 쉬운 것일수록 명시한다>

## Dependencies

- <선행 Phase, verified여야 하는 개념, 확보해야 하는 자료, 학습자 결정 대기 항목>

## Units

<!-- 형식: `- [ ] U<n>. <unit> — <kind> · est <분>m · requires <U1,U2 또는 —> · Done when: <조건>`
kind: learn(개념 도입 + evidence) | practice(exercise) | review | capstone | setup(계획·환경). 진행 중인 unit은 .ai/CURRENT.md의 Current Unit과 일치해야 한다.
완료 시 [x]로 바꾸고 근거를 끝에 적는다: `(commit abc1234)` 또는 `(exercises/....md)`. -->

- [ ] U1. <개념 A 도입> — learn · est 20m · requires — · Done when: concepts/<a>.md state=introduced, Claims에 evidence 포인터
- [ ] U2. <개념 A 연습> — practice · est 15m · requires U1 · Done when: low-cost exercise pass (concepts/<a>.md practiced)
- [ ] U3. <개념 B 도입> — learn · est 20m · requires U1 · Done when: <...>
- [ ] U4. <capstone> — capstone · est 40m · requires U2,U3 · Done when: exercises/<...> pass (transfer)

## Relevant Documents

- `LEARNING_GOALS.md` — <G1>
- `concepts/<slug>.md` — <해당 Claims·Criteria>
- `evidence/<slug>.md` — <절·정리 번호>
- `curriculum/decisions/DR-xxxx-*.md`

## Acceptance Criteria

- [ ] AC1. `concepts/<a>.md`, `concepts/<b>.md`의 state = verified (verified_by에 서로 다른 날 pass ≥ verified_passes, transfer 포함)
- [ ] AC2. capstone exercise <...> result = pass
- [ ] AC3. <이 Phase에서 관찰된 오개념이 MISCONCEPTIONS.md에 resolved로 기록됨 등>

## Validation Plan

- <어떤 exercise(유형·입력 비용)가 어떤 AC를 덮는가>
- <복습 스케줄: verified 후 review_due 설정 확인>
- <sandbox 실험이 있으면 재현 명령과 기대 결과>
