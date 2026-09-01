---
name: <slug>
title: <개념 이름>
state: unseen
requires: []
evidence: []
verified_by: []
verified_on:
review_stage: 0
review_due:
last_reviewed:
---

<!--
파일명은 `<slug>.md` (kebab-case). frontmatter는 스크립트가 읽는다 — key 이름을 바꾸지 않고 리스트는 한 줄 `[a, b]`로 쓴다.
- state: unseen | introduced | practiced | verified | stale — exercise 기록으로만 바뀐다 (Rule 8). 승격 조건은 AGENTS.md.
- requires: 같은 subject 안의 선행 개념 slug만. CONCEPT_MAP.md와 일치. 다른 subject의 개념은 evidence로 가리킨다 (`~/study/<other>/concepts/<slug>.md`).
- evidence: 이 개념이 맞다는 근거 — `evidence/<slug>.md#<위치>` (Claims의 포인터와 일치).
- verified_by: state의 근거 — `exercises/<file>.md`. pass(또는 practiced는 partial) 기록만.
- verified_on · review_stage · review_due · last_reviewed: Rule 14. review_due = last_reviewed(또는 verified_on) + review_intervals[review_stage].
150줄 상한. 긴 유도·계산은 evidence/·sandbox/로.
-->

# <개념 이름>

## Definition

<!-- 학습자의 문장으로 쓴다. 튜터가 대신 쓰지 않는다 (Rule 4). 처음엔 틀려도 지우지 않고 Revisions에 남긴다. -->

<한 문단. "…는 …이다. …일 때 성립하고, …를 위해 쓴다.">

## Why It Matters

<!-- LEARNING_GOALS의 어느 목표(G), 어느 상위 개념에 필요한가. -->

- <G1 — 이 개념 없이는 …를 계산할 수 없다>

## Claims

<!-- 이 개념에 대해 참이라고 믿는 진술. 각 줄에 근거 라벨과 evidence 포인터 (Rule 7).
[fact] 출처 명시 · [derived] 근거 기반 유도(sandbox·evidence의 derivation) · [assumption] 가정 · [hypothesis] 가설 · [unsupported] 근거 부족 -->

- [fact] <진술> — `evidence/<slug>.md#<정리·식 번호>`
- [derived] <진술> — `sandbox/<file>` 또는 `evidence/<derivation>.md`
- [unsupported] <아직 확인하지 못한 진술>

## Verification Criteria

<!-- 이 개념을 이해했다고 볼 기준. exercise의 Rubric은 여기서 파생된다 (DR-0002). 3–6개. 학습자가 한 번 검토한다.
정의 암기가 아니라 "말할 수 있다 / 판별할 수 있다 / 계산할 수 있다 / 새 조건에 쓸 수 있다"로. -->

- [ ] C1. <조건: 이 개념이 성립하려면 무엇이 필요한지 말할 수 있다>
- [ ] C2. <판별: 주어진 상황에서 적용 가능 여부를 판단할 수 있다>
- [ ] C3. <계산: 구체적 예에서 …를 계산할 수 있다>
- [ ] C4. <전이: 처음 보는 문제에 …를 세울 수 있다>

## Connections

- requires: <slug — 왜 먼저 알아야 하는가>
- used by: <slug — 어디에 쓰이는가>
- contrasts with: <혼동하기 쉬운 개념과 경계>

## Misconceptions

<!-- 이 개념에서 관찰된 오개념. concepts/MISCONCEPTIONS.md에도 한 줄 (그쪽이 목록, 여기는 맥락). -->

- <YYYY-MM-DD> <오개념 (학습자 표현)> → <바로잡은 내용> — `exercises/<file>.md`

## Revisions

<!-- Definition을 고친 이력. 이전 문장을 지우지 않는다. -->

- <YYYY-MM-DD> "<이전 문장>" → "<수정>" — 근거: `exercises/<file>.md`
