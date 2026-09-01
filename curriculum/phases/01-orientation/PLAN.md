# Phase 01 — orientation

<!-- 템플릿에 포함된 첫 Phase다. 초기화(.ai/BOOTSTRAP.md) 시 주제에 맞게 Scope·Units를 조정한다. -->

- Status: PLANNED
- Start: <YYYY-MM-DD> · End: <YYYY-MM-DD>
- Goals: 전체 (목표 확정 자체가 이 Phase의 결과)

## Goal

템플릿이 실제 학습 프로젝트가 되어, 목표마다 증명 방법이 있고, 개념 지도·근거 목록·학습자 파라미터가 갖춰지고, 어떤 튜터든 `scripts/study-start.sh`로 오늘 할 unit을 고를 수 있는 상태.

## Motivation

이후 모든 Phase가 같은 규칙·기준·속도 데이터 위에서 진행되려면 그 기반이 먼저 있어야 한다. 이 Phase가 끝나기 전에는 개념 학습을 시작하지 않는다 — 단, 진단 exercise(U2)는 예외다.

## Scope

- 템플릿 placeholder를 주제 내용으로 교체 (`AGENTS.md`, `README.md`, `LEARNING_GOALS.md`, `LEARNER.md`)
- 개념 목록과 선행 관계(`concepts/`, `CONCEPT_MAP.md`), 근거 자료 목록(`evidence/INDEX.md`)
- Prior Knowledge 진단 — 근거 없이 state를 올리지 않는다
- 전체 계획을 Phase·unit으로 나누고 `ROADMAP.md`에 등록
- 스크립트와 파라미터가 이 저장소에서 동작하는지 확인

## Out of Scope

- 새 개념의 학습·설명 (Phase 02부터)
- 자료 전체 읽기 (접근 확인과 목록만; 읽기는 해당 unit에서)
- sandbox 환경의 세부 구성 (첫 coding exercise 전에 별도 unit으로)

## Dependencies

- 학습자가 제공하는 주제 설명 (`.ai/BOOTSTRAP.md`의 Topic Description)
- 목표·범위·시간 예산에 대한 학습자 확인

## Units

<!-- 완료 시 [x]로 바꾸고 근거를 끝에 적는다: (commit abc1234) -->

- [ ] U1. `.ai/BOOTSTRAP.md` 수행 — setup · est 40m · requires — · Done when: BOOTSTRAP의 Output Checklist 전부 충족
- [ ] U2. Prior Knowledge 진단 — practice · est 20m · requires U1 · Done when: `LEARNING_GOALS.md` Prior Knowledge의 개념마다 low-cost exercise 기록이 있고, 통과한 것만 practiced/verified로 표시됨
- [ ] U3. 근거 자료 확보 — learn · est 20m · requires U1 · Done when: `evidence/INDEX.md`의 자료가 접근 가능하고(파일·링크), Phase 02 Scope 개념의 evidence 파일이 있음 (status unread 허용)
- [ ] U4. 스크립트·파라미터 확인 — setup · est 10m · requires U1 · Done when: `scripts/study-start.sh 20`이 복습·준비된 unit·remaining을 출력하고 `scripts/study-end.sh`가 FAIL 없이 통과
- [ ] U5. Phase 02 PLAN 확정 — setup · est 15m · requires U2,U3,U4 · Done when: `ROADMAP.md`에 등록되고 `.ai/CURRENT.md`가 Phase 02 U1을 가리킴

## Relevant Documents

- `LEARNING_GOALS.md`, `LEARNER.md` — 전체 (작성 대상)
- `concepts/_template.md`, `evidence/_template.md`, `exercises/README.md`
- `curriculum/decisions/_template.md`
- `.ai/BOOTSTRAP.md`

## Acceptance Criteria

- [ ] AC1. `AGENTS.md`, `README.md`, `LEARNING_GOALS.md`, `LEARNER.md`에 placeholder(`<...>`)와 작성 지침 주석이 남아 있지 않다
- [ ] AC2. `LEARNING_GOALS.md`의 목표마다 Proof와 Phase가 있고, 모든 `concepts/*.md`에 `state`·`requires`가 있으며 `CONCEPT_MAP.md`와 일치한다
- [ ] AC3. 진단 결과가 `exercises/`에 있고 practiced/verified 개념은 `verified_by`가 그 파일을 가리킨다 — `scripts/study-end.sh`가 FAIL 없이 통과
- [ ] AC4. `evidence/INDEX.md`의 모든 자료에 유형·위치(경로 또는 링크)·관련 개념이 있고 접근이 확인되었다
- [ ] AC5. `ROADMAP.md`의 Phase마다 Est가 있고 `scripts/study-start.sh`가 remaining과 projection을 출력한다
- [ ] AC6. `.ai/BOOTSTRAP.md`가 삭제되었고 남은 참조가 없다
- [ ] AC7. `LEARNER.md`의 Parameters가 학습자와 합의된 값이고, Input Preferences에 수식 입력 경로가 적혀 있다

## Validation Plan

- AC1: `grep -n "<" AGENTS.md README.md LEARNING_GOALS.md LEARNER.md`의 출력에 placeholder·주석이 없는지 눈으로 확인
- AC2·AC3: `scripts/study-end.sh` 실행 (state–근거 일치 검사 포함), `CONCEPT_MAP.md`의 화살표와 각 concept의 `requires` 대조
- AC4: 자료마다 파일을 열거나 링크에 접근해 첫 페이지를 확인
- AC5: `scripts/study-start.sh 20` 출력의 remaining·projection 줄 확인
- AC6·AC7: 해당 파일의 존재·내용 확인
