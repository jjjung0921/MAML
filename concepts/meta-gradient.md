---
name: meta-gradient
title: 적응 경로를 통과하는 meta-gradient
state: unseen
requires: [adaptation-objective]
evidence: [evidence/INDEX.md#phase-02]
verified_by: []
verified_on:
review_stage: 0
review_due:
last_reviewed:
---

# 적응 경로를 통과하는 meta-gradient

## Definition

## Why It Matters

- G2 — gradient를 어느 변수에 대해 구하는지 놓치면 MAML과 first-order 근사를 구분할 수 없다.

## Claims

## Verification Criteria

- [ ] C1. 한 step 적응식을 미분할 때 필요한 미분 가능성과 학습률 고정 가정을 말할 수 있다.
- [ ] C2. 초기값에서 적응 결과를 거쳐 query loss로 가는 합성 의존 관계를 표시할 수 있다.
- [ ] C3. 작은 이차 손실에서 연쇄법칙으로 exact meta-gradient를 계산할 수 있다.
- [ ] C4. 벡터 gradient·Jacobian·HVP의 역할 및 다중 step에서 추가되는 의존 경로를 구분할 수 있다.

## Connections

- requires: adaptation-objective
- used by: first-order-approximation
- contrasts with: query gradient vs 초기값에 대한 meta-gradient

## Misconceptions

없음. 진단 전 판단하지 않는다.

## Revisions

없음.
