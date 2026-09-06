# DR-0008: 복습 간격을 3·7일 두 단계로 종료

- Status: Accepted
- Date: 2026-09-06
- Deciders: 학습자(직접 선택), claude-code(적용 범위 정리)

## Context

DR-0006은 템플릿 기본값인 복습 간격 3·7·21·60일을 유지했고, LEARNER.md는 이를 "학습자가 개별 확인하지 않은 운영 가정"으로 공개했다. U2의 기준·파라미터 검토(AC5)에서 학습자에게 직접 확인했다.

## Problem

verified 이후 복습을 몇 단계까지 유지할지. 나머지 파라미터(default_budget 30·min_session 5·review_only_below 15·verified_passes 2)는 이번 검토에서 조정 요청이 없었다.

## Alternatives

1. 3·7·21·60일 유지 — 장기 파지 / 이틀 집중 뒤 두 달간 만기 항목이 계속 남는다.
2. 3·7일로 종료 — 학습 직후 정착 구간만 확인하고 닫는다 / 장기 파지는 보증하지 않는다.

## Decision

- 2번 선택. `review_intervals: 3 7`. review_stage 2를 통과한 concept은 `review_due`를 비우고 더 이상 만기를 만들지 않는다.
- 나머지 파라미터는 학습자 확인값으로 승격한다: default_budget 30 · min_session 5 · review_only_below 15 · verified_passes 2(서로 다른 날, 그중 transfer·derivation·proof·coding 1회 이상).
- Rule 14의 fail 처리는 그대로다: 복습에서 fail이면 stale로 내리고 복습 pass 1회로 verified 복귀한다.

## Rationale

학습자의 직접 선택이며 Truth 순서 ①이다. 이 subject의 목표는 연구 독해의 기반 확보이고, 이틀 집중 뒤 21·60일 만기는 학습이 이어지지 않는 기간에 만기 목록만 쌓는다.

## Consequences

- 긍정: LEARNER.md의 파라미터가 전부 직접 확인값이 되어 AC5의 "가정과 확인값 구분"이 해소된다.
- 부정 / 감수한 것: 두 달 뒤의 파지는 측정하지 않는다. 필요하면 새 DR로 간격을 다시 연다.
- 후속 작업: LEARNER.md의 `review_intervals`와 Parameter Basis 갱신. DR-0006의 "복습 3·7·21·60일 계속 적용" 항목은 이 DR이 대체한다(DR-0006 본문은 수정하지 않는다).
