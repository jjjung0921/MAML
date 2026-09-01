---
name: <slug>
title: <자료 제목>
type: paper
ref: <저자, 연도, DOI/URL 또는 로컬 경로 · derivation/experiment면 sandbox 경로>
concepts: []
status: unread
---

<!--
파일명은 `<slug>.md` (예: finn2017-maml.md, boyd-convex-ch5.md, hypergradient-derivation.md).
- type: paper | book | lecture | doc | derivation | experiment — derivation·experiment는 학습자·튜터가 만든 근거(유도·수치 확인)다.
- concepts: 이 자료가 근거가 되는 개념 slug (한 줄 리스트). status: unread | reading | read.
- concept의 Claims는 이 파일의 위치(#앵커)를 가리킨다. 아래 소제목이 앵커다 — 정리·식 번호를 소제목으로 쓴다.
- 자료가 논문이면 `paper-analysis` 스킬의 근거 라벨(논문 명시 사실 / 근거 기반 해석 / 구현상 가정 / 가설 / 근거 부족)로 Key Statements를 적는다. 해석을 원문과 섞지 않는다.
-->

# <자료 제목>

## What It Supports

<!-- 어느 개념의 어느 주장을 뒷받침하는가. 위치(절·정리·식·페이지)까지. -->

| Concept | Claim                         | Location          |
|---------|-------------------------------|-------------------|
| <slug>  | <concept Claims의 진술>       | <§3.2, Thm 1, (7)> |

## Key Statements

<!-- 원문의 정의·정리·식을 원문 표기로. 소제목 = 앵커 (예: `### thm-1`, `### eq-7`). -->

### <thm-1>

<원문 진술. 가정과 결론을 분리해서.>

### <eq-7>

<식과 각 기호의 의미.>

## Caveats

- <가정·적용 범위 · 다른 자료와 충돌하는 점 · 표기 차이>

## Reading Notes

<!-- 읽은 범위와 날짜. 상세 요약은 쓰지 않는다 — 개념 정리는 concepts/에, 실습은 sandbox/에. -->

- <YYYY-MM-DD> <§1–3 읽음. §4는 Phase 03에서>
