---
name: first-order-approximation
title: FOMAML의 근사와 계산 비용
state: unseen
requires: [meta-gradient]
evidence: [evidence/INDEX.md#phase-02]
verified_by: []
verified_on:
review_stage: 0
review_due:
last_reviewed:
---

# FOMAML의 근사와 계산 비용

## Definition

## Why It Matters

- G2 — 계산 절감의 이유와 어떤 정보가 사라지는지 알아야 후속 연구의 비용·정확도 주장을 평가할 수 있다.

## Claims

## Verification Criteria

- [ ] C1. FOMAML이 inner 적응을 유지하면서 어느 미분 기여를 생략하는지 설명할 수 있다.
- [ ] C2. dense Hessian 전체 구성과 HVP를 구분하고 원문이 말하는 계산 경로를 짚을 수 있다.
- [ ] C3. 주어진 작은 손실에서 exact와 first-order 신호의 차이를 계산할 수 있다.
- [ ] C4. 특정 실험의 유사 성능·비용 감소를 일반적 동등성 또는 보편적 선호 주장과 구분할 수 있다.

## Connections

- requires: meta-gradient
- used by: research-transfer
- contrasts with: 2차 미분 기여 생략 vs 적응 생략

## Misconceptions

없음. 진단 전 판단하지 않는다.

## Revisions

없음.
