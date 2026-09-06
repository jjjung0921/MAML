# meta-gradient — 적응 경로를 통과하는 미분

> 튜터 작성 설명. 이해 상태의 근거가 아니다(DR-0011). 읽은 뒤 `concepts/meta-gradient.md`는 **노트를 닫고** 자기 언어로 쓴다.
> 이 노트는 **의도적으로 끝까지 풀지 않는다.** 마지막 한 걸음은 U5·U6에서 직접 밟아야 하는 과제다(concept-tutor 힌트 사다리).

## 1. 한계 — 이 개념이 없으면 무엇이 안 되나

식 (1)을 다시 보자.

    θ  ←  θ - β ∇_θ  Σ_i  L_{T_i}(f_{θ_i'}),      θ_i' = θ - α ∇_θ L_{T_i}(f_θ)

여기서 `∇_θ L_{T_i}(f_{θ_i'})`를 계산해야 한다. 순진한 방법은 **θ'에서 재고 끝내는 것**이다:

    ∇_{θ'} L_{T_i}(f_{θ'})    ← 적응된 지점에서의 보통 gradient

이게 왜 틀린가. 우리가 알고 싶은 건 "**출발점 θ를 조금 움직이면 적응 후 손실이 얼마나 변하는가**"다. 그런데 θ를 움직이면 두 가지가 동시에 일어난다: 도착점 θ'가 움직이고, 손실은 그 움직인 도착점에서 재어진다. 위 식은 두 번째만 반영하고 **첫 번째를 무시한다** — θ'가 θ에 어떻게 반응하는지를 빼먹었다.

## 2. 직관

θ에서 θ'로 가는 것은 **함수 하나**다. 부르자면 적응 사상(adaptation map):

    θ  --[적응]-->  θ'(θ)  --[손실]-->  L

θ를 1만큼 밀면 θ'는 1만큼 밀리지 않는다. 적응 자체가 θ에 따라 달라지기 때문이다 — 어떤 방향으로는 적응이 밀린 만큼을 되돌리고, 어떤 방향으로는 증폭한다. 그 "밀린 정도의 변환"을 곱해야 전체 변화율이 나온다.

**이건 이미 계산해 본 구조다.** 2026-09-06 선수 진단에서

    u(x) = x - a·f'(x),   g(x) = f(u(x))

의 `dg/dx`를 구했다. `θ ↔ x`, `적응 ↔ u`, `적응 후 손실 ↔ g`. 스칼라에서 벡터로 올라올 뿐 구조는 같다.

## 3. 정식화 — 여기까지만

원문이 이 계산에 대해 말하는 것은 두 문장이다. [fact] `#gradient-through-gradient`

> "The MAML meta-gradient update involves a gradient through a gradient. Computationally, this requires an additional backward pass through f to compute Hessian-vector products, which is supported by standard deep learning libraries such as TensorFlow."

읽어낼 것 세 가지:

1. **gradient through a gradient** — 미분해야 할 대상 안에 이미 gradient가 들어 있다(`θ' = θ - α∇L` 의 `∇L`). 그걸 다시 미분하니 2차 미분이 나온다.
2. **additional backward pass** — 계산 비용은 backward pass **한 번 추가**다. 파라미터 수의 제곱에 비례하는 무언가가 아니다.
3. **Hessian-vector products** — 계산되는 것은 Hessian **행렬**이 아니라 Hessian과 어떤 벡터의 **곱**이다. 이 구분이 다음 개념의 핵심이다.

### 여기서 멈춘다

`∇_θ L_{T_i}(f_{θ_i'})`를 연쇄법칙으로 전개하면 **두 인수의 곱**이 된다. 하나는 적응 사상의 미분(θ'가 θ에 어떻게 반응하는가), 다른 하나는 적응된 지점에서의 손실 gradient다.

- 방향 힌트: 선수 진단에서 `u'(x) = 1 - a·f''(x)`를 구했다. 벡터 θ에서 같은 자리에 오는 것이 무엇인지 — 그게 U5의 과제다.
- 순서 힌트: 두 인수 중 **어느 쪽이 2차 미분을 담고 있는지**를 먼저 정하면 나머지는 따라온다.

이 형태를 여기 적어 두면 U5·U6이 베껴 쓰기가 된다. 직접 쓴 뒤에 비교하자.

## 4. 경계 — 어디서 깨지나

- **α를 meta-learn하면** α도 미분 대상이 되어 경로가 하나 더 생긴다. 원문은 α를 고정 하이퍼파라미터로 두거나 meta-learn할 수 있다고만 한다. [fact] §2.2 — 우리는 고정으로 본다.
- **여러 step 적응**은 경로가 step 수만큼 중첩된다. 원문은 한 step으로 표기하고 확장은 straightforward라 말한다. [fact] §2.2. Phase 02 Out of Scope — 순서와 의존 경로만 짚는다.
- **손실이 두 번 미분 가능하지 않으면** 이 계산이 성립하지 않는다. 원문의 "smooth enough" 가정이 여기서 값을 한다. [fact] §2.2
- 자주 하는 착각: "2차 미분은 inner update를 계산할 때 생긴다." **아니다.** inner update는 1차 gradient 한 번이면 끝난다. 2차 미분은 그 update **결과를 다시 θ로 미분할 때** 생긴다. (`concepts/MISCONCEPTIONS.md` 2026-09-06 항목)

## 5. 연결

- **앞**: `adaptation-objective`의 "최적화 변수는 θ, 손실은 θ'에서 잰다"가 그대로 이 미분의 난이도가 된다.
- **다음**: `first-order-approximation`. 위 두 인수 중 하나를 통째로 버리면 무엇이 남고 무엇이 사라지는가.
- **익숙한 것과의 대응**: bi-level optimization의 hypergradient가 정확히 이 구조다. implicit differentiation은 여기서 적응을 "수렴한 최적해"로 바꿨을 때의 변형이다(Phase 02 범위 밖).

## 미니 체크

1. `∇_{θ'} L(f_{θ'})`(적응 지점의 보통 gradient)와 `∇_θ L(f_{θ'})`(meta-gradient)는 언제 같아지나?
2. 적응 step 수를 1에서 2로 늘리면 위 "두 인수" 구조에서 무엇이 늘어나나? 인수의 개수인가, 각 인수의 복잡도인가?
