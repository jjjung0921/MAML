---
date: 2026-09-05
concept: first-order-approximation
type: recall
purpose: diagnostic
input: text
cost: low
est: 5
actual: 8
grader: claude-code (general-purpose 분리 컨텍스트; study-grader 에이전트 미설치)
result: fail
---

# FOMAML 사전 지식 진단 — 계산 경로와 근거 범위

## Problem

자료를 찾아보지 않고 각 문항에 2~3문장으로 답한다. 수식 없이 말로 설명해도 되고, 모르는 부분은 모른다고 적는다. 이 문항은 C1/C2/C4 범위이며 C3 계산 숙련도는 별도로 확인한다.

1. MAML에서는 왜 2차 미분이 등장하나요? FOMAML은 그중 무엇을 생략하고, 무엇은 그대로 계산하나요?
2. “정확한 MAML을 계산하려면 Hessian 행렬의 모든 원소를 만들어 저장해야 한다.” 이 말은 맞나요? 이유를 설명해 주세요.
3. FOMAML이 계산을 줄인다는 사실만으로 MAML과 항상 같은 성능을 낸다고 말할 수 있나요? 그렇게 판단하는 이유는 무엇인가요?

## Rubric

<details>
<summary>답변 후에 연다</summary>

- R1. (필수, C1) outer loss가 적응 결과를 거쳐 초기값에 의존하고, 적응식 속 inner gradient를 다시 미분하면서 2차 미분이 등장함을 설명한다. “Hessian은 2차 미분”이라는 정의만으로는 충족하지 않는다.
- R2. (필수, C1) FOMAML이 적응 경로의 2차 미분 기여를 생략하지만 inner gradient update와 적응 후 query gradient는 계산한다는 점을 구분한다.
- R3. (필수, C2) 문장을 부정하고 Hessian 전체의 명시적 구성 없이 Hessian-vector product를 계산할 수 있다는 점을 설명한다. 원소를 모두 저장해야 한다고 답하면 미충족.
- R4. (필수, C4) 계산 절감만으로 성능 동등성을 결론 낼 수 없음을 말하고, 근사로 정보가 생략되거나 과제·모델·곡률 등 조건에 따라 차이가 날 수 있음을 설명한다. 특정 실험과 보편적 보장을 구분한다.
- 판정: 필수 항목 전부 충족 시 pass; 일부만 충족하면 partial, 핵심 계산 경로를 구분하지 못하면 fail. 판정마다 Attempt 인용. “비용이 크다”만으로 계산 원리를 이해했다고 판정하지 않는다.
- 근거 위치: 기존 evidence/finn2017-maml/raw/equations.md B.1–B.2; raw/task-method-adv.md §2.2·§2.5·§4.1이 가리키는 MAML §2.2·§5.2. 이 Rubric은 원문 성능의 독립 재현을 주장하지 않는다.

</details>

## Attempt

학습자 응답(2026-09-06, 텍스트 입력, 원문 그대로):

1. MAML에서는 task별 gradient 업데이트(1)가 존재하며 이후에 meta gradient를 update(2)하므로 (1)에서의 2차 미분이 발생한다. 이때, Hessian Matrix의 연산이 등장하는데, FOMAML은 이를 생략한다.
2. 중간 계산 결과를 저장함으로써 메모리의 사용을 줄일 수 있을 듯 한데 방법은 잘 모르겠다.
3. 같다고 말하기는 어렵다. 정확한 Hessian의 연산이 아닌 연산량이 작은 surrogate한 값을 통해 경사하강을 연산하기 때문이다.

전사 확인: OK (학습자, 2026-09-06)

## Grading

grader: claude-code (general-purpose 분리 컨텍스트, Rubric·Attempt만 전달). 2026-09-06.

- R1. ✗ — 인용 "task별 gradient 업데이트(1)가 존재하며 이후에 meta gradient를 update(2)하므로 (1)에서의 2차 미분이 발생한다" — 두 단계가 있다는 서술에 그치고, outer loss가 적응된 파라미터를 거쳐 초기값에 의존한다는 연결과 적응식 안의 inner gradient를 다시 미분하는 경로가 없다. 힌트: 적응식을 초기값으로 미분할 때 어떤 항이 한 번 더 미분되는지 식의 흐름으로 써 본다.
- R2. ✗ — 인용 "이때, Hessian Matrix의 연산이 등장하는데, FOMAML은 이를 생략한다" — 생략 대상만 말하고 FOMAML에서도 그대로 계산되는 부분의 구분이 없다. 힌트: FOMAML에서 여전히 수행되는 두 번의 gradient 계산이 무엇인지 명시한다.
- R3. ✗ — 인용 "중간 계산 결과를 저장함으로써 메모리의 사용을 줄일 수 있을 듯 한데 방법은 잘 모르겠다" — 문항 2의 명제를 부정하지 않았고, Hessian 전체를 만들지 않고 벡터와의 곱만 계산할 수 있다는 설명이 없다. 힌트: 필요한 것이 행렬 자체인지 행렬과 특정 벡터의 곱 하나인지부터 구분한다.
- R4. ✗ — 인용 "정확한 Hessian의 연산이 아닌 연산량이 작은 surrogate한 값을 통해 경사하강을 연산하기 때문이다" — 동등성을 단정하지 않은 점은 맞으나 근거가 "근사값이라서"에 머물고, 생략된 정보·조건 의존성·특정 실험과 보편적 보장의 구분이 없다. 힌트: "다를 수 있다"의 이유를 어떤 조건에서 차이가 커지는지로 특정한다.

판정: fail (필수 4항목 모두 미충족; R2에서 핵심 계산 경로를 구분하지 못함).

DR-0010(원리 기준 판정) 적용 후 재검토: 판정 유지. R1~R4의 미충족 사유는 계산 미완료·산술 실수가 아니라 원리 층위(2차 미분의 발생 지점, FOMAML이 남기는 계산, 명제 부정, 조건 의존성)이므로 완화 대상이 아니다.

## Next

- State: unseen 유지. fail이므로 state 변경 없음(Rule 8).
- Review: 설정하지 않음.
- 관찰: 사전 자기보고("FOMAML이 Hessian의 계산 복잡도로 인해 선호되었다")는 비용 층위까지이며, 계산 경로(C1/C2) 구분은 미확인 상태로 확인됐다. 오개념 후보 2건을 MISCONCEPTIONS에 기록.
- 재사용 금지: `notes/first-order-approximation.md`가 이 3문항의 답을 포함한다(DR-0011). 같은 문항으로 재시도하지 않고 변형·전이 문항으로 확인한다.
- Next exercise: meta-gradient 선수 배경(합성함수 연쇄법칙) 진단 → Phase 02 진입 속도 결정. C3 수치 비교는 C1/C2 도입 이후로 미룬다.
