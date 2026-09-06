# DR-0009: verified 기준을 당일 1회 pass로

- Status: Accepted
- Date: 2026-09-06
- Deciders: 학습자(직접 지시), claude-code(적용 범위 정리)

## Context

Rule 8은 verified를 "서로 다른 날 pass ≥ verified_passes(2), 그중 transfer·derivation·proof·coding ≥ 1"로 정의했다. DR-0007로 이틀 뒤 잔여가 날짜 미정으로 이월되면서, "서로 다른 날" 조건은 학습이 이어지지 않는 기간 동안 개념을 practiced에 묶어 두게 된다. 학습자가 U2 검토 중 직접 지시했다: "pass 기준도 당일 한 번 패스 시 패스로".

## Problem

verified 승격에 필요한 pass 횟수와 날짜 분리 조건을 어떻게 둘 것인가.

## Alternatives

1. 서로 다른 날 2회 유지 — 파지 증거가 강하다 / 이월 일정에서 verified가 사실상 도달 불가능해진다.
2. 당일 1회 pass — 세션 안에서 상태가 닫힌다 / 시간 간격을 둔 파지를 측정하지 않는다.

## Decision

- 2번 선택. `verified_passes: 1`, 날짜 분리 조건 없음(같은 날 허용). Rule 8의 "서로 다른 날" 문구를 이 DR이 대체한다.
- 유지: 그 pass는 transfer·derivation·proof·coding 중 하나여야 한다. 학습자 지시는 횟수와 날짜에 대한 것이었고 문제 유형은 언급되지 않아 기존 기준을 보존한다. 조정을 원하면 새 DR로 연다.
- 유지: practiced는 pass 또는 partial 1회. partial은 미통과(Rule 9). state는 여전히 `exercises/` 기록으로만 바뀐다.
- 유지: 복습(Rule 14)은 DR-0008의 3·7일 두 단계. verified 직후 3일 뒤 첫 만기가 생기므로 시간 간격 파지는 복습 쪽에서 측정한다.

## Rationale

학습자의 직접 지시는 Truth 순서 ①이다. 파지 측정을 완전히 버리는 것도 아니다 — 날짜 분리 요건이 verified 승격에서 복습 만기(3·7일)로 옮겨 갔을 뿐이며, 복습 fail은 여전히 stale로 내린다.

## Consequences

- 긍정: 이월된 일정에서도 세션 안에서 개념 상태가 닫히고, Phase가 REVIEW에 갇히지 않는다. DR-0006의 "서로 다른 날 증거 부족 시 REVIEW 보존" 조항은 사실상 발동하지 않는다.
- 부정 / 감수한 것: verified 시점의 증거는 한 번의 pass다. 하루 안의 되풀이 효과를 배제하지 못하며, 실제 파지 여부는 3일 뒤 첫 복습에서야 드러난다. 복습 fail이 늘어날 수 있다.
- 후속 작업: LEARNER.md의 `verified_passes`·Grading Preferences, AGENTS.md Rule 8 문구 갱신. DR-0006·DR-0008 본문은 수정하지 않는다.
