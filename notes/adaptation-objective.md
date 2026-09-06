# adaptation-objective — 적응 후 성능을 목적함수로 삼기

> 튜터 작성 설명. 이해 상태의 근거가 아니다(DR-0011). 읽은 뒤 `concepts/adaptation-objective.md`는 **노트를 닫고** 자기 언어로 쓴다.

## 1. 한계 — 이 개념이 없으면 무엇이 안 되나

`task-episode`로 "여러 task로 훈련한다"까지는 왔다. 그럼 무엇을 최소화할 것인가?

가장 단순한 답은 **모든 task의 평균 손실을 최소화하는 것**이다.

    min_θ  Σ_i  L_{T_i}(f_θ)

이건 그냥 다중 과제 학습(multi-task learning)이고, 결과는 "모든 task에 어중간하게 맞는 하나의 θ"다. 문제는 이 목적함수 어디에도 **"적응한다"는 사실이 들어 있지 않다**는 것이다. 실제 사용 시점에는 K개 샘플로 몇 스텝 경사하강을 돌릴 텐데, 훈련은 그 스텝이 존재하지 않는 것처럼 진행된다. 훈련과 사용이 어긋난다.

원문의 문제의식: 모델이 어차피 gradient 기반으로 fine-tune될 것이므로, **그 학습 규칙이 빠르게 진전할 수 있는 파라미터**를 찾자는 것이다. [fact] §2.2

## 2. 직관

"어느 과목이든 시험을 잘 보는 학생"이 아니라 **"어느 과목이든 하루만 공부하면 시험을 잘 보게 되는 학생"**을 만드는 것이다.

두 번째 학생을 뽑고 싶으면, 평가 기준이 "지금 점수"가 아니라 **"하루 공부시킨 뒤의 점수"**여야 한다. 목적함수 안에 "하루 공부"라는 절차가 들어가야 한다는 뜻이다.

## 3. 정식화

한 step 적응: [fact] `#eq-adapt`, Algorithm 1 line 6

    θ_i' = θ - α ∇_θ L_{T_i}(f_θ)

원문 표현: "the updated parameter vector θ_i' is computed using one or more gradient descent updates on task T_i." α는 하이퍼파라미터로 고정할 수도, meta-learn할 수도 있다. 표기 편의상 원문은 이후 한 step만 다루지만 여러 step으로의 확장은 straightforward라고 말한다. [fact] §2.2

meta-objective: [fact] `#eq-1`

    min_θ  Σ_{T_i ~ p(T)}  L_{T_i}(f_{θ_i'})  =  Σ_{T_i ~ p(T)}  L_{T_i}( f_{θ - α ∇_θ L_{T_i}(f_θ)} )

meta-update (식 (1)):

    θ  ←  θ - β ∇_θ  Σ_{T_i ~ p(T)}  L_{T_i}(f_{θ_i'})

**이 개념의 핵심 한 문장**은 원문에 그대로 있다:

> "Note that the meta-optimization is performed over the model parameters θ, whereas the objective is computed using the updated model parameters θ'." [fact] `#eq-1`

즉 **최적화 변수는 θ, 손실을 재는 위치는 θ'**다. 둘이 다르다. 위 두 번째 줄에서 오른쪽 등식을 보면 θ'가 θ의 함수로 풀려 있는데, 이 대입이 전부다 — 목적함수는 θ 하나의 함수다.

각 기호가 맡는 자리:

| 기호 | 자리 |
|---|---|
| `θ` | 학습하는 것. 모든 task의 **출발점** |
| `α` | inner step size. 적응을 얼마나 시킬지 |
| `θ_i'` | task i에 적응한 결과. θ에 **의존하는 값**이지 독립 변수가 아니다 |
| `β` | meta step size. 출발점을 얼마나 옮길지 |
| `D` / `D'` | θ_i' 계산용 / L_{T_i}(f_{θ_i'}) 계산용 (`task-episode`) |

## 4. 경계 — 어디서 깨지나

- **α = 0으로 두면** θ' = θ가 되어 목적함수가 그냥 multi-task 평균 손실로 무너진다. 적응이 목적함수에 들어 있다는 성질이 사라진다.
- **θ'를 θ와 무관한 자유 변수로 취급하면** 각 task가 자기 마음대로 최적해로 가버리고 공통 출발점을 학습할 이유가 없어진다. θ'가 θ의 **함수**라는 게 이 목적함수를 지탱한다.
- 원문은 손실이 θ에 대해 gradient 기반 기법을 쓸 만큼 매끄럽다고 가정한다("smooth enough in θ"). [fact] §2.2 — 이 가정이 다음 개념(`meta-gradient`)에서 결정적으로 쓰인다.
- 이 목적함수는 "적응이 빠른 θ"를 보장하는가? 원문은 "aim to find model parameters that are sensitive to changes in the task"라고 **의도**를 말한다. [fact] §2.2 — 의도이지 정리가 아니다.

## 5. 연결

- **앞**: `task-episode`가 D/D'를 나눴기 때문에 위 목적함수가 "적응에 쓴 데이터로 채점하기"를 피한다.
- **다음**: `meta-gradient`. 위 식 (1)의 `∇_θ`를 실제로 어떻게 계산하는가 — θ'가 θ의 함수이므로 이 미분은 단순하지 않다. 거기서 2차 미분이 나온다.
- **익숙한 것과의 대응**: 바깥 변수를 최적화하는데 목적함수 값이 안쪽 최적화의 **결과**에 의존하는 구조는 bi-level optimization의 일반형이다. hyperparameter optimization도 같은 모양이다.

## 미니 체크

1. 식 (1)에서 β를 0으로 두면 무슨 일이 일어나나? α를 0으로 두는 것과 어떻게 다른가?
2. `L_{T_i}(f_{θ_i'})`를 계산할 때 쓰는 데이터가 D(적응에 쓴 것)라면, 이 목적함수는 무엇을 측정하게 되나?
