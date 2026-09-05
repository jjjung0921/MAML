# MAML — 후속 연구를 읽기 위한 핵심 개념

MAML의 과제 설정, 적응 후 목적함수, meta-gradient, FOMAML 근사를 배우고, 후속 논문에서 무엇을 바꾸었는지 읽어내는 학습 워크스페이스다. 목표는 [Learning Goals](LEARNING_GOALS.md), 전체 순서는 [Roadmap](curriculum/ROADMAP.md)에 있다.

## 이틀 진행

하루 120분을 30분 블록 4개로 사용한다. 각 블록의 마지막 5분은 기록한다. 다음 진단부터 unit 200분과 기록 40분, 총 240분이며 휴식은 별도다.

| 날짜 | 학습 unit | 기록 | 산출물 |
|---|---|---|---|
| 1일차 · 09-05 | 진단·자료·운영 확인 30분 + Phase 02 U1~U6 70분 | 20분 | 과제와 목적함수 구분, meta-gradient 의존 경로 초안 |
| 2일차 · 09-06 | Phase 02 U7~U10 50분 + Phase 03 50분 | 20분 | exact/FOMAML 비교, 후속 논문 독해 capstone |

unit이 블록 경계에 걸리면 Progress와 HANDOFF에 남기고 이어간다. 이틀은 학습과 초회 평가의 목표이며, 이해 상태 verified와 공식 Phase 완료는 서로 다른 날의 exercise 증거가 갖춰져야 한다. 재시도·추가 복습은 별도 시간이 필요할 수 있다.

## 학습 순서

1. 과제와 support/query를 구분한다.
2. 왜 적응 후 성능을 최적화하는지 목적함수로 표현한다.
3. 초기값 → 적응 결과 → query 손실의 미분 경로를 추적한다.
4. FOMAML에서 생략하는 계산과 근사의 경계를 확인한다.
5. 새로운 논문의 적응 대상·목적함수·gradient 경로·실험 근거를 비교한다.

원문을 가리키는 [자료 목록](evidence/INDEX.md)과 기존 분석을 함께 사용한다. 분석 문서가 있다는 사실은 학습자의 이해를 증명하지 않는다. 개념 Definition은 학습자가 채우며, Attempt 전사 확인 후에만 채점한다.

## 시작과 재개

- 현재 단계: Phase 01 U2 사전 지식 진단. [Current](.ai/CURRENT.md)와 [Handoff](.ai/HANDOFF.md)를 먼저 읽는다.
- 시작: `scripts/study-start.sh 30`
- 종료: `scripts/study-end.sh --set-checkpoint` 후 규칙에 맞는 close commit.
- Sandbox: N/A. 이번 목표는 독해·작은 수식 계산이며 구현 실험은 아직 없다.
- 초기 설정의 선택과 가정: [DR-0006](curriculum/decisions/DR-0006-two-day-maml-reading.md).

concepts/는 이해 상태, exercises/는 채점 증거, evidence/는 자료, curriculum/은 계획, .ai/는 재개 상태를 담당한다. 모든 튜터는 AGENTS.md를 따른다.
