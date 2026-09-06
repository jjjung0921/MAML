# DR-0007: 이틀 프레임 유지와 Phase 02 잔여 이월

- Status: Accepted
- Date: 2026-09-06
- Deciders: 학습자(일정 선택), claude-code(잔여 분량 산정)

## Context

U2 진단에서 first-order-approximation 문항은 fail, meta-gradient 선수 배경 문항은 partial이었다. 다섯 개념 모두 unseen이며 Definition·Claims는 비어 있다. 09-06 시점의 잔여는 Phase 01 약 20분 + Phase 02 130분 ≈ 150분으로, 오늘 남은 하루 예산 120분을 넘는다.

## Problem

DR-0006이 정한 이틀(09-05~09-06) 안에 Phase 02를 끝낼 수 없다. 일정을 늘릴지, 목표를 줄일지, 잔여를 이월할지 정해야 한다.

## Alternatives

1. 3일차(09-07) 추가 — 이틀 안 완주 / 학습자가 확인하지 않은 예산을 튜터가 가정하게 된다.
2. 목표 축소(개념 2개만 verified 목표) — 이틀 안에 닫힘 / G2·G3의 근거 범위가 좁아진다.
3. 이틀 프레임 유지 + 잔여 이월 — 확인된 예산만 쓰고 목표는 온전히 유지 / Phase 02 완료일이 미정으로 남는다.

## Decision

- 3번 선택. 09-05~09-06 이틀은 확인된 예산 그대로 두고, 오늘 소화하지 못한 unit은 날짜를 정하지 않은 채 이월한다.
- 목표(G1~G3)와 다섯 개념의 검증 기준은 축소하지 않는다. verified_passes 2회와 Rule 8도 완화하지 않는다.
- 이월 시점의 잔여 unit·다음 행동은 HANDOFF의 Exact Next Action에 남기며, ROADMAP의 Phase 02 종료일은 미정으로 표기한다.

## Rationale

학습자가 직접 확인한 시간은 이틀 120분씩뿐이다. 확인되지 않은 3일차를 계획에 넣으면 LEARNER.md의 "직접 확인값과 운영 가정 구분"(AC5) 원칙을 깨게 된다. 목표 축소는 진단 실패를 목표 하향으로 처리하는 것이어서, 근거가 아니라 일정 압박에 목표를 맞추게 된다.

## Consequences

- 긍정: 이틀 예산 안에서만 판단하고, 남은 분량은 다음 세션이 study-start.sh의 remaining으로 그대로 이어받는다.
- 부정 / 감수한 것: Phase 02 완료일이 미정이다. 이틀 뒤 학습이 끊기면 Rule 14의 복습 만기가 먼저 도래할 수 있다.
- 후속 작업: ROADMAP의 Phase 02 일정 표기를 미정으로 유지하고, 이월 시점에 HANDOFF에 잔여 unit을 열거한다. DR-0006의 이틀 계획 자체는 유지되며 이 DR은 그 안의 완주 가정만 보완한다.
