# task-episode — 과제 하나가 훈련 예제 하나

> 튜터 작성 설명. 이해 상태의 근거가 아니다(DR-0011). 읽은 뒤 `concepts/task-episode.md`는 **노트를 닫고** 자기 언어로 쓴다.

## 1. 한계 — 이 개념이 없으면 무엇이 안 되나

보통의 지도학습에서 훈련 단위는 **데이터 포인트 하나**다. 개 사진 5만 장으로 개 분류기를 만든다. 그런데 "본 적 없는 종류를 사진 5장 보고 분류하라"는 요구는 이 틀에서 답이 없다. 5장으로 경사하강을 돌리면 과적합하고, 5만 장짜리 모델은 새 종류를 아예 모른다.

문제는 데이터가 부족한 게 아니라 **훈련 단위가 잘못 잡힌 것**이다. "5장으로 배우기"라는 상황 자체를 여러 번 겪게 해야 하는데, 데이터 포인트를 훈련 단위로 쓰는 한 그 상황은 훈련 중에 한 번도 등장하지 않는다.

## 2. 직관

시험 공부에 비유하면, 기존 방식은 문제 5만 개를 푸는 것이다. meta-learning은 **모의고사를 여러 번 치는 것**이다. 한 번의 모의고사 = 한 개의 task. 모의고사마다 "잠깐 훑어보는 몇 문제(적응용)"와 "실제로 채점되는 문제(평가용)"가 나뉘어 있고, 훈련의 목적은 특정 모의고사를 잘 보는 게 아니라 **처음 보는 모의고사에서 훑기 몇 문제만으로 점수가 오르는 상태**가 되는 것이다.

원문의 표현: "the meta-learning problem treats entire tasks as training examples." [fact] `evidence/finn2017-maml.md` §2.1

## 3. 정식화

원문은 task를 네 요소의 묶음으로 정의한다. [fact] §2.1

$$\mathcal{T}=\{\mathcal{L}(x_1,a_1,\ldots,x_H,a_H),\;q(x_1),\;q(x_{t+1}\mid x_t,a_t),\;H\}$$

- $\mathcal{L}$ — 그 task의 손실. 분류 오류일 수도, MDP의 비용일 수도 있다.
- $q(x_1)$ — 초기 관측의 분포.
- $q(x_{t+1}\mid x_t,a_t)$ — 전이 분포 (RL용).
- $H$ — episode 길이. **i.i.d. 지도학습에서는 $H=1$이다.** [fact] §2.1

우리가 다루는 건 $H=1$인 경우이므로, 전이 분포는 사실상 비어 있고 task는 "손실 + 데이터 분포"로 줄어든다.

그 위에 task들의 분포 $p(\mathcal{T})$가 있고, $K$-shot 설정에서 모델은 $p(\mathcal{T})$에서 뽑은 새 task를 **$K$개 샘플만으로** 배운다. [fact] §2.1

데이터가 두 번 나뉘는 지점이 Algorithm 2에 있다. [fact] `#eq-adapt` 및 Algorithm 2

- **5행** — $D=\{(x,y)\}$ $K$개를 $\mathcal{T}_i$에서 샘플 ← 적응(inner)에 쓴다
- **7행** — $\theta_i'=\theta-\alpha\nabla_\theta\mathcal{L}_{\mathcal{T}_i}(f_\theta)$ ← $D$로 계산한 gradient
- **8행** — $D'=\{(x,y)\}$를 $\mathcal{T}_i$에서 다시 샘플 ← meta-update에 쓴다
- **10행** — $\theta\leftarrow\theta-\beta\nabla_\theta\sum_i\mathcal{L}_{\mathcal{T}_i}(f_{\theta_i'})$ ← $D'$로 계산

**같은 task 안에서 데이터가 두 역할로 갈린다**는 것 — 이게 이 개념의 전부다. 하나는 "적응시키는 데" 쓰고, 다른 하나는 "적응이 잘 됐는지 채점하는 데" 쓴다.

## 4. 경계 — 어디서 깨지나

- **용어 주의**: 원문은 support/query라는 말을 쓰지 않는다. $D$와 $D'$다. [fact] Algorithm 2. 후속 연구들이 support/query로 부르므로 두 표기가 같은 것을 가리킨다는 걸 알아두면 되지만, 원문 인용에서 support/query를 쓰면 원문에 없는 말을 넣는 것이 된다.
- $D$와 $D'$가 겹쳐도 되는지 원문 Algorithm 2는 명시하지 않는다. "Sample datapoints D' from T_i for the meta-update"라고만 쓴다. [unsupported] — 겹침 허용 여부를 이 저장소에서 단정하지 말 것.
- 나누는 지점을 잘못 잡으면 무엇이 깨지는가: 만약 $D'=D$로 두면, 적응에 쓴 바로 그 데이터로 적응 결과를 채점하게 된다. 그러면 "적응 후 이 데이터에서 손실이 낮다"는 것만 확인되고 **일반화**는 확인되지 않는다.
- meta-test에 쓰는 task는 meta-training 동안 held out이다. [fact] §2.1 — task 수준의 분리이지 데이터 포인트 수준의 분리가 아니다.

## 5. 연결

- **다음 개념**: `adaptation-objective`. 위 Algorithm 2의 7번 줄(적응)과 10번 줄(채점)이 하나의 목적함수로 합쳐지면 그게 식 (1)이다.
- **익숙한 것과의 대응**: 일반 학습의 train/validation 분리가 여기서는 task **안**으로 들어왔다. 그리고 task들 사이에 또 한 겹의 train/test 분리(meta-train / meta-test)가 있다. 두 겹이다.

## 미니 체크

1. $K$-shot에서 $K$를 5에서 50으로 늘리면 이 정식화의 어느 기호가 바뀌고, 어느 기호는 그대로인가?
2. "task를 훈련 예제로 본다"는 말이 성립하려면 $p(\mathcal{T})$에 최소한 어떤 조건이 필요할까? (원문이 명시하지 않은 것을 찾는 문제다)
