---
name: task-episode
title: 과제·support/query·meta-train/test
state: unseen
requires: []
evidence: [evidence/finn2017-maml.md, evidence/finn2017-maml.md#eq-adapt]
verified_by: []
verified_on:
review_stage: 0
review_due:
last_reviewed:
---

# 과제·support/query·meta-train/test

## Definition

## Why It Matters

- G1 — 데이터점의 분리와 과제의 분리를 혼동하면 새 과제 적응을 평가할 수 없다.

## Claims

## Verification Criteria

- [ ] C1. 한 과제의 데이터와 여러 과제의 분포를 구분할 수 있다.
- [ ] C2. support/query 및 meta-train/test task 분리의 목적을 구분할 수 있다.
- [ ] C3. 작은 회귀 예에서 적응·평가에 쓸 표본을 배치할 수 있다.
- [ ] C4. 새 few-shot 분류 설정에서 데이터 누수 없는 평가 절차를 세울 수 있다.

## Connections

- requires: 없음 — 진단에서 기본 데이터·미분 배경 확인
- used by: adaptation-objective
- contrasts with: 표본 분리 vs 과제 분리

## Misconceptions

없음. 진단 전 판단하지 않는다.

## Revisions

없음.
