# Phase 01 — orientation

- Status: IN_PROGRESS
- Start: 2026-09-05 · End: 미완료
- Goals: G1–G3의 목표·증명 방법·학습 환경 확정

## Goal

MAML 연구 독해 목표, 학습자 예산, 다섯 개념의 선행 관계·검증 기준, 근거 목록을 갖추고 진단 후 첫 학습 unit을 시작할 수 있다.

## Motivation

기존 분석 자료와 실제 이해 상태를 구분하고, 이틀 240분을 학습자의 배경에 맞게 사용한다.

## Scope

- 초기화 문서·개념 기준·자료 목록·Phase 계획.
- FOMAML 자기보고 진단과 기본 미분·연쇄법칙 배경 확인.
- 자료 접근·필요 evidence 카드 생성, 시작·종료 스크립트와 세부 파라미터 확인.

## Out of Scope

- 새 개념의 본 학습과 학습자의 Definition/Attempt 대필.
- 전체 구현·벤치마크 재현·자료 전체 읽기.

## Dependencies

- 학습자 응답: MAML 계열 연구 독해, 이틀 완료, 하루 120분.
- 기존 MAML 분석 자료, 템플릿 기본 파라미터.

## Units

- [x] U1. MAML 학습 프로젝트 초기화 — setup · est 20m · requires — · Done when: 목표/Proof·개념 DAG·기준·자료 목록·시간 계획 작성, 초기화 안내 제거, 작업 커밋·종료 검사 완료 (commit 8d4181c)
- [x] U2. FOMAML 사전 지식과 선수 배경 진단 — practice · est 10m · requires U1 · Done when: first-order-approximation C1/C2/C4 중심의 low-cost diagnostic과 필요시 meta-gradient 선수 질문의 Rubric·확인된 Attempt·판정 기록, 기준과 파라미터 검토; 실패 시 HANDOFF에 보완 범위 (commit 2b46f48)
- [ ] U3. 원문 접근 및 evidence 카드 확보 — setup · est 10m · requires U1 · Done when: MAML/ANIL 원문 접근 확인, Phase 02 개념별 절·식 포인터가 있는 evidence 카드 생성 및 concept 포인터 연결; ANIL 발췌 위치 선정
- [ ] U4. 운영 점검과 첫 학습 계획 확정 — setup · est 10m · requires U2,U3 · Done when: 스크립트 FAIL 없음, 진단을 반영한 Phase 02 PLAN·시간 예산 확인, CURRENT가 02 U1을 가리킴

U1은 이번 튜터 초기화 작업이다. 다음 U2부터 orientation 잔여 30분을 이틀 학습 예산에 포함한다. 원문의 진술·공식과 학습자 진단의 pass는 서로 다른 근거다. 진단 pass 한 번은 practiced까지만 가능하다.

## Relevant Documents

- LEARNING_GOALS.md, LEARNER.md, concepts/CONCEPT_MAP.md 및 각 concept의 Verification Criteria.
- evidence/INDEX.md, exercises/README.md, curriculum/decisions/DR-0006-two-day-maml-reading.md.

## Acceptance Criteria

- [x] AC1. AGENTS·README·목표·학습자 문서의 placeholder/작성 지침 제거, 초기화 안내 파일 및 참조 제거.
- [x] AC2. 목표별 Proof·Phase, concept별 requires·기준, 동일한 DAG와 Reading Order, ROADMAP Est와 상세 unit 시간 합계 일치.
- [x] AC3. U2의 확인된 Attempt·진단 결과 존재; 이해 상태는 exercise가 뒷받침하는 범위만 반영.
- [ ] AC4. U3에서 원문 접근·Phase 02 evidence 포인터·Phase 03 독해 발췌 위치 확인.
- [x] AC5. 예산·파라미터의 직접 확인값과 기본 운영 가정 구분; U2/U4에서 기준과 운영값 검토.
- [ ] AC6. 시작 스크립트가 준비된 unit과 remaining을 출력하고 종료 검사 FAIL 없음; CURRENT가 Phase 02 U1로 이동.

## Validation Plan

- U1: placeholder·참조 검색, DAG 위상 정렬·requires 대조, Est 합계, Definition 공란·unseen·빈 verified_by 확인.
- U2: self-exam 절차로 Problem+Rubric 작성 → 학습자 응답 전사 확인 → 분리된 study-grader 판정. 초기화에서는 exercise를 출제·채점하지 않는다.
- U3: 원문 해당 페이지를 직접 열고 자료 카드의 절·식 포인터와 대조한다.
- U4: scripts/study-start.sh 20과 scripts/study-end.sh --set-checkpoint; 검사 통과 후 close commit.
