# Learner

<!--
학습자의 고정 파라미터. 튜터가 세션을 구성할 때 참조하고, Parameters는 스크립트가 읽는다.
자주 바뀌는 것(오늘 컨디션·오늘 예산)은 여기가 아니라 .ai/INBOX.md에 적는다. 초기화 시 채운다.
-->

## Time Budget

- Default session: `default_budget`분 · 최소 세션: `min_session`분 (회상 질문 1개)
- Typical week: <요일별 예산 또는 "평일 20–30분, 주말 60분">
- Velocity: 손으로 적지 않는다 — `scripts/study-start.sh`가 `.ai/LOG.md`의 planned·actual에서 계산한다

## Background

- <이미 아는 분야·수준, 쓰는 언어·도구, 학습 방식의 특징>

## Input Preferences

<!-- Rule 10. 학습자는 LaTeX를 치지 않는다. 우선순위대로 적는다. -->

- 수식: <손글씨 사진 / ASCII 수식 / 코드(sympy·numpy) / 말로 설명 — 우선순위>
- 사진 위치: `exercises/_inbox/` (gitignore. 튜터가 전사한 뒤 `전사 확인: OK`를 받는다)
- 설명: <한국어 / 영어 병기 여부>
- 피하고 싶은 유형: <예: 긴 증명 타이핑>

## Grading Preferences

<!-- Rule 9의 기본값은 strict(부분=미통과, 애매하면 낮은 쪽)다. 바꾸려면 DR을 남긴다. -->

- Default grader: <주로 쓰는 Agent 이름 — 예: claude-code>
- 피드백 형식: <항목별 판정만 / 오답에 대한 힌트 포함>

## Parameters

<!-- 스크립트와 규칙이 읽는 값. `- key: value` 형식과 key 이름을 바꾸지 않는다. review_intervals는 공백 구분(일). -->

- default_budget: 30
- min_session: 5
- review_only_below: 15
- review_est: 5
- record_est: 5
- verified_passes: 2
- review_intervals: 3 7 21 60
- context_warn_kb: 25
