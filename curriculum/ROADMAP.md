# Roadmap

| # | Phase | Goal | Concepts | Est (m) | Status | Result |
|---|---|---|---|---|---|---|
| 01 | [orientation](phases/01-orientation/PLAN.md) | 목표·진단·자료·운영 확정 | — | 50 | DONE | [RESULT](phases/01-orientation/RESULT.md) |
| 02 | [maml-core](phases/02-maml-core/PLAN.md) | G1·G2: 과제/목적함수와 exact/FO 미분 경로 | task-episode, adaptation-objective, meta-gradient, first-order-approximation | 100 | IN_PROGRESS | — |
| 03 | research-reading | G3: 새 후속 연구 발췌 비교 | research-transfer | 30 | PLANNED | — |

Phase 02 완료일은 미정이다 — 이틀 프레임을 유지하고 잔여를 이월한다(DR-0007). 복습 간격은 3·7일(DR-0008), verified는 pass 1회(DR-0009), 채점은 원리 기준(DR-0010)이다.

총 unit 추정 180분 중 초기화 U1의 튜터 작업 20분은 별도다. 다음 진단부터 unit 160분 + 15개 unit의 기록 75분 + 하루 경계의 재개 기록 5분 = 학습자 예산 240분. 휴식·재시도·추가 verified 판정·장기 복습 시간은 포함하지 않는다. 초기화 작업 actual/est로 학습 속도를 예측하지 않는다.

## Phase 03 — 진입 시 상세화할 목록

- 진입: Phase 02 G1·G2 capstone pass. 자료는 확보 완료 — ANIL 발췌는 §4 The ANIL (Almost No Inner Loop) Algorithm (로컬 PDF p.6)로 선정했다(2026-09-06). Phase 02가 날짜별 검증만 대기하면 REVIEW로 보존하고 독해 진행 가능.
- 연구 독해 기준 도입 10분: research-transfer Definition·근거 위치·비교 축을 학습자 언어로 작성.
- 비교표 연습 10분: MAML의 이미 학습한 구간을 기준선으로 정리하고 research-transfer low-cost exercise pass.
- G3 capstone 10분: 새 ANIL 발췌를 문제·적응 대상·목적함수·gradient 경로·가정·증거 범위로 비교하는 transfer exercise pass.
- Est = 10 + 10 + 10 = 30분. 발췌는 사전 선정한 짧은 방법 구간으로 제한하고 전문 전체를 읽었다고 판정하지 않는다. detailed PLAN은 Phase 01 진단과 Phase 02 결과를 읽고 진입 시 작성한다. 아직 ANIL 답안이나 학습자의 Definition을 작성하지 않는다.
- 공식 DONE은 research-transfer verified와 G3 capstone pass가 갖춰져야 한다. 이틀 끝에 날짜별 증거가 부족하면 REVIEW와 다음 평가 날짜를 기록한다.

## Phase Rules

- 첫 두 Phase만 상세 PLAN을 둔다. 상태는 PLANNED / IN_PROGRESS / REVIEW / DONE / CANCELLED. REVIEW는 학습·capstone을 마쳤지만 날짜별 검증만 남은 상태다(DR-0006).
- 진행 중(IN_PROGRESS)인 Phase는 하나만 둔다. REVIEW의 검증 대기는 HANDOFF에서 추적하고 만기 복습은 새 unit보다 먼저다.
- Phase 01은 운영·진단 AC로 완료. 학습 Phase의 공식 DONE은 지정 concept verified + capstone pass + AC 전부 충족 + RESULT·phase 태그가 필요하다.
- 학습자 Goal PROVEN은 해당 capstone 증거로 판단한다. Phase DONE과 concept verified는 각각의 조건을 따로 확인한다.
- Phase·완료 정책의 변경은 DR에 남긴다. 초기 학습과 날짜별 검증의 진행 상태 분리는 DR-0006에 기록했다.
