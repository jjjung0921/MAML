# DR-0004: 세션은 선언된 예산으로 구성한다 — 10–25분 unit, 속도 데이터, 날짜 없는 계획

- Status: Accepted
- Date: 2026-08-29
- Deciders: 템플릿 소유자

## Context

매일 쓸 수 있는 시간이 다르다(어떤 날 15분, 어떤 날 90분). 날짜별 계획("3일차: 3.2절")은 첫 결손에서 깨지고, 깨진 계획은 튜터가 어디서부터 이어야 할지 모르게 만든다. 또 "오늘 얼마나 했는가"가 기록되지 않으면 예상 분량이 보정되지 않아 계획이 계속 낙관적이다.

## Problem

세션 길이가 매번 달라도 튜터가 매번 적절한 양을 고르고, 실제 소요 시간이 계획에 되먹임되게 하려면 계획·기록·선택을 어떻게 구성할 것인가.

## Alternatives

1. **날짜별 계획 + 밀린 것 이월** — 단순하지만 결손이 누적되고, 이월 판단이 튜터 재량이다.
2. **세션마다 튜터가 즉흥적으로 고른다** — 유연하지만 진행이 보이지 않고 튜터마다 다르다.
3. **작은 unit + 선행 관계 + 선언된 예산 + 속도 계산** — Phase의 unit을 10–25분으로 쪼개고 requires로 DAG를 만들며, 세션 시작에 예산을 선언하면 스크립트가 만기 복습·진행 중 unit·준비된 unit을 예산에 맞춰 제안한다. LOG의 planned·actual로 속도를 계산해 est를 보정한다.

## Decision

3안을 채택한다.

- **Unit** (`curriculum/phases/_template/PLAN.md`): `- [ ] U3. <unit> — <kind> · est 20m · requires U1,U2 · Done when: <조건>`. kind는 learn·practice·review·capstone·setup. 선행이 모두 [x]인 unit이 "준비된 unit"이다.
- **예산 선언** (Rule 11): `scripts/study-start.sh <분>` 또는 `.ai/INBOX.md`의 `오늘 N분`, 없으면 `LEARNER.md`의 `default_budget`.
- **세션 구성 순서**: 복습 만기(`review_est`분씩) → 진행 중 unit(HANDOFF의 Work In Progress) → 예산이 남으면 준비된 unit 하나 → 기록(`record_est`분). 예산이 `review_only_below` 미만이면 복습만. 최소 세션 `min_session`분은 회상 질문 1개로 정의해 끊김을 막는다.
- **기록** (`.ai/LOG.md`): 세션 항목 헤더에 `planned Nm · actual Mm`, Units 줄에 unit별 `est Nm · actual Mm`. 이것이 속도 데이터의 유일한 출처다.
- **계산** (`scripts/study-start.sh`): 최근 세션의 actual/planned, unit의 actual/est 비율, 세션당 평균 실제 시간, 최근 2주 세션 빈도 → 남은 est(현재 Phase 미완료 unit + ROADMAP의 PLANNED Phase Est)에 비율을 곱해 예상 세션 수와 예상 완료 주를 출력한다.
- **ROADMAP에는 날짜가 없다**: Phase별 Est(분)와 상태만 둔다. 완료 예측은 매 세션 다시 계산된다.

## Rationale

- 계획을 DAG로 두면 "다음 것"이 아니라 "지금 가능한 것들"이 있어 어떤 예산에도 맞는 조각이 있다.
- 예산을 학습자가 선언하면 튜터가 학습자의 하루를 추측하지 않는다. 재량이 후보 목록 안의 선택으로 줄어든다.
- actual을 적는 비용은 한 줄이고, 그것으로 est 보정·완료 예측·주간 빈도가 모두 나온다. 별도 추적 도구가 필요 없다.
- 날짜 계획은 깨질 때 죄책감을 만들고 죄책감은 세션을 건너뛰게 한다. 남은 분량과 예측은 깨지지 않는다.

## Consequences

- 긍정: 15분 세션과 90분 세션이 같은 규칙으로 돌아간다. 완료 예측이 데이터에서 나온다. 복습이 새 학습보다 먼저라 verified가 실제로 유지된다.
- 부정 / 감수한 것: unit을 잘게 쪼개는 계획 비용이 든다(초기화와 각 Phase 시작에서). est는 처음엔 틀린다 — 비율이 보정하지만 5세션 정도는 지나야 안정된다. LOG 형식을 지키지 않으면 계산이 빠진다(`study-end.sh`가 경고).
- 후속 작업: 파라미터(`review_est`, `record_est`, `review_only_below`)는 몇 세션 뒤 실제 값으로 조정하고 DR 없이 `LEARNER.md`만 고친다. 세션 빈도가 계산되면 ROADMAP의 Est와 함께 목표 기한의 현실성을 재검토한다.
