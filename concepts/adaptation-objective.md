---
name: adaptation-objective
title: 적응과 적응 후 목적함수
state: unseen
requires: [task-episode]
evidence: [evidence/finn2017-maml.md#eq-adapt, evidence/finn2017-maml.md#eq-1]
verified_by: []
verified_on:
review_stage: 0
review_due:
last_reviewed:
---

# 적응과 적응 후 목적함수

## Definition

## Why It Matters

- G1 — 현재 성능과 업데이트 후 성능은 다른 목표이므로 초기값을 학습하는 이유를 구분해야 한다.

## Claims

## Verification Criteria

- [ ] C1. 공통 초기값과 과제별 적응 결과, 고정 학습률과 최적화 변수를 구분할 수 있다.
- [ ] C2. support로 적응하고 query로 outer loss를 평가하는 이유를 설명할 수 있다.
- [ ] C3. 한 step 적응을 목적함수에 대입하고 각 기호를 정의할 수 있다.
- [ ] C4. 새 과제에서 pretraining/fine-tuning과 MAML의 최적화 목표를 비교할 수 있다.

## Connections

- requires: task-episode
- used by: meta-gradient
- contrasts with: 현재 평균 손실 vs 적응 후 손실

## Misconceptions

없음. 진단 전 판단하지 않는다.

## Revisions

없음.
