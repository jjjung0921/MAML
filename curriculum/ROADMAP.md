# Roadmap

<!--
전체 학습 계획의 Phase 목록. 순서·목표·개념·예상 분량·상태만 적고, 상세는 각 디렉터리의 PLAN.md / RESULT.md에 둔다.
- 날짜 계획은 두지 않는다. 예상 완료는 `scripts/study-start.sh`가 남은 분량과 최근 속도로 계산한다.
- Est(분)는 PLAN의 unit est 합계. Status: PLANNED | IN_PROGRESS | DONE | CANCELLED — Phase 시작·종료 시에만 갱신한다. 진행 중인 unit은 .ai/CURRENT.md가 기준이다.
- 새 Phase 추가: `phases/_template/`를 `NN-<phase-name>/`으로 복사하고 표에 한 줄 추가한다. 번호는 두 자리, 이름은 kebab-case.
-->

| #  | Phase                                     | Goal                                                         | Concepts        | Est (m) | Status  | Result |
|----|-------------------------------------------|--------------------------------------------------------------|-----------------|---------|---------|--------|
| 01 | [orientation](phases/01-orientation/PLAN.md) | 목표·학습자 파라미터·개념 지도·근거 목록·Phase 계획을 갖춘다 | —               | 105     | PLANNED | —      |
| 02 | <phase-name>                              | <목표>                                                       | <slug, slug>    | <est>   | PLANNED | —      |

## Phase Rules

- 한 Phase는 `LEARNING_GOALS.md`의 목표 하나 이상을 증명한다: 지정한 concept이 verified가 되고 capstone exercise가 pass여야 한다. 결과를 한 문장으로 말할 수 없으면 나눈다.
- Phase 종료 조건: PLAN의 Acceptance Criteria 전부 충족 + Validation Plan 수행 + RESULT.md 작성 + `phase/NN` 태그 (`git tag -a phase/01 -m "..."`).
- 진행 중인 Phase는 하나만 둔다. 복습 만기 항목은 Phase와 무관하게 먼저 처리한다 (Rule 14).
- Phase를 추가·삭제·순서 변경하면 DR을 남긴다 (Rule 15).
