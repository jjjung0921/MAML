---
date: <YYYY-MM-DD>
concept: <slug>
type: <recall | condition | error-spot | fill-step | choice | numeric | skeleton | derivation | proof | coding | transfer>
purpose: <diagnostic | practice | verify | review>
input: <text | photo | code | speech | choice>
cost: <low | high>
est: <분>
actual:
grader: <agent-name>
result: pending
---

<!-- 파일명 YYYY-MM-DD-<concept>-<type>.md. 유형·등급·후처리는 exercises/README.md. 100줄 상한. 작성 지침 주석은 채우면서 지운다. -->

# <문제 제목>

## Problem

<!-- 학습자가 읽는 부분. 필요한 조건·기호·주어진 것을 다 적는다. 답의 형식(뼈대만 / 값만 / 틀린 단계 번호)을 명시한다. -->

<문제>

## Rubric

<!-- 문제와 함께 먼저 쓴다. concept의 Verification Criteria(C1–C4)에서 파생. 필수 항목에 (필수) 표시. 학습자는 답변 전에 열지 않는다. -->

<details>
<summary>답변 후에 연다</summary>

- R1. (필수) <정답이 반드시 포함해야 할 요소> — C1
- R2. (필수) <…> — C3
- R3. <있으면 좋은 요소>
- 흔한 오답: <MISCONCEPTIONS.md의 active 항목 반영>
</details>

## Attempt

<!-- 학습자의 답. 사진·ASCII·말이면 튜터가 전사하고 아래에 학습자가 `전사 확인: OK`를 남긴다. 튜터가 답을 고쳐 쓰지 않는다. -->

<전사 또는 학습자 입력>

전사 확인: <OK / 수정 사항>

## Grading

<!-- 항목별 판정 + Attempt 인용. 총평·칭찬 없음. partial = 미통과. 애매하면 낮은 쪽 (Rule 9). -->

| Rubric | 판정 | 근거 (Attempt 인용)          |
|--------|------|------------------------------|
| R1     | ✓/✗  | "<인용>"                     |
| R2     | ✓/✗  | "<인용>"                     |

- Result: <pass | partial | fail>
- Misconception: <없음 / 학습자 표현 → MISCONCEPTIONS.md 반영>

## Next

<!-- 이 결과로 바뀐 것과 다음 조치. -->

- State: `concepts/<slug>.md` <introduced → practiced 등, 또는 변화 없음>
- Review: <review_due 설정·변경>
- Next exercise: <유형과 이유 — 예: R2 ✗ → numeric으로 계산 재확인>
