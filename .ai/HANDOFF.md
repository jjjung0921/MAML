# Handoff

<!-- 50줄 이내. unit 시작 시 Goal·Work In Progress를 먼저 쓰고(handoff-first) 진행하며 갱신, 종료 시 완성. 덮어쓴다(이력은 git log). 모든 항목을 채운다(없으면 "없음"). -->

- From: claude-cowork — 템플릿 생성 세션
- Date: 2026-08-29
- Phase / Unit: 01-orientation / 시작 전 (unit 밖 작업)

## Goal

개발 템플릿과 같은 규칙·상태 파일·스크립트 구조 위에서, 이해 상태가 exercise 기록에서만 도출되고 입력 비용·세션 길이 문제를 파일과 스크립트로 다루는 학습 템플릿을 만든다.

## Work Completed

- 저장소 구조, AGENTS/CLAUDE/GEMINI/README, LEARNING_GOALS·LEARNER, curriculum(ROADMAP·Phase 양식·Phase 01·DR-0001~0005), concepts·evidence·exercises·sandbox 양식, `.ai/` 상태 파일, `scripts/study-start.sh`·`study-end.sh`

## Work In Progress

- 없음

## Decisions Made

- 이해 상태는 exercise 기록에서만 도출, Rubric-first·strict default·grader 기록 — DR-0002
- 학습자는 LaTeX를 치지 않는다; 입력 비용이 낮은 유형을 일상 검증에 — DR-0003
- 세션은 선언된 예산으로 구성, unit 10–25분 + requires + est, LOG의 planned·actual로 속도 계산 — DR-0004
- 폴더는 subject(concept map 단위)마다 하나, 템플릿 복사는 목표가 생길 때만; 스토리 원장과 같은 폴더 — DR-0005

## Exercises Graded

- 없음

## Misconceptions Observed

- 없음

## Open Questions

- 없음

## Unverified Assumptions

- 주제가 아직 없다. 개념 단위로 나뉘는 주제(수학·CS·ML 이론)를 가정했다. 기능 습득형 주제는 exercise 유형을 다시 설계해야 한다.
- 학습자 git이 `--trailer`(2.32+)를 지원한다고 가정한다. 스크립트는 Linux bash 5 + mawk/gawk에서 독립 저장소·상위 저장소의 하위 폴더·git 없음 세 경우를 테스트했다 (bash 3.2·BSD awk 호환 문법 사용, macOS에서는 미실행).
- `LEARNER.md`의 파라미터 기본값(예산 30분, 복습 간격 3·7·21·60일)은 첫 몇 세션 뒤 조정이 필요하다.

## Exact Next Action

`.ai/BOOTSTRAP.md`의 Topic Description을 채운 뒤 튜터에게 수행을 지시한다. 튜터는 `scripts/study-start.sh`로 시작한다.
