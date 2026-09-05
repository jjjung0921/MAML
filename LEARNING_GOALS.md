# Learning Goals

## Why

학습자 목표: “MAML에 대한 개념을 숙지하고 앞으로 MAML 계열의 연구를 이해하는 데 문제 없는 수준”. 이를 MAML의 문제·목적함수·미분 경로를 설명하고, 처음 읽는 후속 논문의 변경점·가정·근거를 원문에서 추출할 수 있는 능력으로 검증한다.

## Goals

| # | Goal (할 수 있다) | Proof (capstone exercise) | Phase | Status |
|---|---|---|---|---|
| G1 | 새 few-shot 과제에서 task·support/query·공통 초기값·적응 결과를 구분하고 적응 후 목적함수를 세울 수 있다 | transfer: 처음 보는 회귀 또는 분류 설정에서 데이터와 파라미터를 배치하고 meta-train/test 흐름 및 목적함수를 설명; 필수 Rubric 전부 통과 | 02 | PLANNED |
| G2 | 한 step MAML의 meta-gradient 의존 경로를 추적하고 FOMAML이 생략하는 항과 근사의 한계를 설명할 수 있다 | derivation/transfer: 주어진 작은 이차 손실에서 exact와 first-order 신호를 계산·비교하고 HVP 비용과 성능 보장을 구분; 필수 Rubric 전부 통과 | 02 | PLANNED |
| G3 | 처음 읽는 MAML 후속 연구의 변경점·동일한 부분·추가 가정·검증 범위를 원문 근거로 설명할 수 있다 | transfer: 아직 학습하지 않은 ANIL 논문 발췌에서 문제·목적함수·적응 대상·gradient 경로·실험/주장 한계를 비교표로 작성; 절 또는 식을 인용하고 미확인 항목 명시 | 03 | PLANNED |

G1·G2의 문제 묶음은 Phase 02 U10에서 수행하되 exercise는 concept별로 분리한다. G3는 Phase 03 capstone이다. 예상 시간은 초회 통과를 전제로 하며 재시도 필요 시 완료를 연장한다.

## Non-Goals

- 벤치마크 재현, 신경망 전체 구현, GPU 학습·속도 비교.
- 강화학습 MAML의 policy-gradient 유도, 수렴·일반화 정리 증명, IFT/implicit MAML의 상세 유도.
- MAML 계열 전체 문헌 조사나 모든 미래 논문의 무장애 독해 보장. 후속 연구 한 편의 제한된 발췌를 전이 과제로 사용한다.

## Prior Knowledge

- 학습자 직접 발언: “FOMAML이 Hessian의 계산 복잡도로 인해 선호되었다는 점”.
- 2026-09-05 응답을 그대로 기록한다. 정확히 어떤 계산을 생략하는지와 “선호”의 근거 범위는 U2 진단 대상이며 정답·오개념으로 선판정하지 않는다.
- 기존 MAML 분석 자료가 있으나 읽기 완료·수학 배경·이해도를 증명하지 않는다. 미분·연쇄법칙 배경은 진단한다.

## Constraints

- 기한: 이틀; 운영상 2026-09-05~09-06 KST로 해석. 하루 120분, 총 240분.
- 다음 U2부터 학습 unit 200분 + 기록 40분. 이번 튜터의 초기화 작업 20분 추정은 학습 시간과 별도다.
- 이틀 목표는 핵심 학습·capstone 초회 통과. concept verified와 Phase의 공식 DONE은 별도 조건이며 서로 다른 날 통과 기록이 부족하면 후속 복습으로 이월한다.
- 한국어, 손글씨/ASCII/말로 응답. 학습자의 유도·정의·Attempt를 튜터가 대신 작성하지 않는다.
- 원문 접근과 선수 배경이 불충분하면 U2/U3에서 시간 계획을 재평가하고 조정 근거를 남긴다.
