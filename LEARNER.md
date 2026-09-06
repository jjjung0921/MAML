# Learner

## Time Budget

- 집중 일정: 2026-09-05~09-06, 하루 120분(학습자 직접 확인).
- Default session: 최대 30분. 한 세션은 현재 unit을 마치고 새 unit 하나까지 진행하며 마지막 5분은 기록한다. 이번 단축 일정은 대개 unit 10~15분 + 기록 5분이다.
- Typical week: 이번 이틀만 확정. 이후 주간 예산은 미정.
- Velocity: scripts/study-start.sh가 LOG의 planned·actual로 계산한다. 초기화 소요는 학습 속도 추정에 사용하지 않는다.

## Background

- 사전 지식 발언: “FOMAML이 Hessian의 계산 복잡도로 인해 선호되었다는 점”. 진단 전 자기보고다.
- 기존 evidence에는 MAML 원문 분석·수식 해설이 있다. 읽기 완료·선수 수학 숙련도·코딩 경험은 미확인이다.

## Input Preferences

- 수식: 손글씨 사진 또는 ASCII → 말로 설명 → 필요한 경우 코드. 세부 우선순위는 운영 가정이다.
- 사진 위치: exercises/_inbox/. 튜터 전사 후 학습자의 `전사 확인: OK`를 받아 채점한다.
- 설명: 한국어, 원문의 영어 용어 병기. 큰 틀에서 시작해 한 번에 하나의 의존 관계를 설명한다.
- 긴 LaTeX·증명 타이핑을 요구하지 않는다.

## Grading Preferences

- Default grader: study-grader. Rubric·확인된 Attempt만 전달하고 실행 Agent 이름을 grader에 기록한다. 역할이 없으면 codex가 규칙대로 판정한다.
- 필수 기준별 ✓/✗와 Attempt 인용, 오답에는 다음 시도를 위한 짧은 힌트. partial은 미통과.
- 원리 이해가 확인되면 계산 미완료·산술 실수가 있어도 ✓ (DR-0010). 원리 미확인은 수치가 맞아도 ✗.
- pass 1회로 verified (같은 날 허용, DR-0009). 그 pass는 transfer·derivation·proof·coding 중 하나여야 한다.

## Parameters

- default_budget: 30
- min_session: 5
- review_only_below: 15
- review_est: 5
- record_est: 5
- verified_passes: 1 (같은 날 허용 — DR-0009)
- review_intervals: 3 7 (stage 2 통과 후 review_due 비움 — DR-0008)
- context_warn_kb: 25

## Parameter Basis

- 하루 120분은 직접 확인. 한국어/손글씨/ASCII 입력도 직접 확인값이다.
- 2026-09-06 U2 검토에서 학습자가 직접 확인: default_budget 30 · min_session 5 · review_only_below 15 · verified_passes 1(당일 1회 pass, DR-0009) · review_intervals 3 7(두 단계로 종료, DR-0008). 더 이상 운영 가정이 아니다.
- 일정: 이틀 프레임(09-05~09-06)을 유지하고 소화하지 못한 unit은 날짜 미정으로 이월한다(DR-0007). 이후 주간 예산은 미정.
