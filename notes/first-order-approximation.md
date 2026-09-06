# first-order-approximation — FOMAML이 버리는 것과 남기는 것

> 튜터 작성 설명. 이해 상태의 근거가 아니다(DR-0011). 읽은 뒤 `concepts/first-order-approximation.md`는 **노트를 닫고** 자기 언어로 쓴다.
> 이 노트는 `exercises/2026-09-05-first-order-approximation-recall.md`의 답을 포함한다. 그 문항은 재사용하지 않는다(DR-0011).

## 1. 한계 — 왜 근사를 하려 하나

`meta-gradient`의 계산은 backward pass 한 번을 더 요구한다. [fact] `#gradient-through-gradient` 파라미터가 많은 망에서 이건 공짜가 아니다. 원문은 §5.2에서 이 비용을 이렇게 말한다:

> "A significant computational expense in MAML comes from the use of second derivatives when backpropagating the meta-gradient through the gradient operator in the meta-objective (see Equation (1))." [fact] `#sec-5-2-first-order`

그래서 묻게 된다 — **그 2차 미분을 그냥 빼면 안 되나?**

## 2. 직관

`meta-gradient`에서 meta-gradient가 두 인수의 곱이라고 했다. 하나는 "적응 사상이 θ에 어떻게 반응하는가"(2차 미분이 여기 산다), 다른 하나는 "적응된 지점에서의 손실 gradient"다.

FOMAML은 **첫 번째 인수를 항등으로 취급한다.** 즉 "θ를 밀면 θ'도 그만큼 밀린다"고 치는 것이다. 그러면 남는 건 두 번째 인수뿐이다.

중요한 건 **적응 자체는 그대로 한다**는 점이다. 버리는 건 "적응이 θ에 어떻게 반응하는가"에 대한 미분이지, 적응이 아니다.

## 3. 정식화 — 원문이 말하는 것

> "On MiniImagenet, we show a comparison to a first-order approximation of MAML, where these second derivatives are omitted. **Note that the resulting method still computes the meta-gradient at the post-update parameter values θ_i'**, which provides for effective meta-learning." [fact] `#sec-5-2-first-order` (강조는 튜터)

계산 경로를 세 조각으로 갈라 보면:

| 조각 | exact MAML | FOMAML |
|---|---|---|
| inner gradient `∇_θ L(f_θ)`로 θ' 만들기 | 계산한다 | **계산한다** |
| 적응 사상의 미분 (2차 미분이 사는 곳) | 계산한다 | **생략한다** |
| 적응 후 지점 θ'에서의 손실 gradient | 계산한다 | **계산한다** |

세 조각 중 **하나만** 빠진다. "FOMAML은 2차 미분을 생략한다"까지만 말하면 나머지 둘이 남아 있다는 사실이 빠진다.

### Hessian 행렬 vs Hessian-vector product

원문이 §2.2에서 말한 계산 대상은 **Hessian-vector product**이지 Hessian 행렬이 아니다. [fact] `#gradient-through-gradient`

이 구분이 중요한 이유: 파라미터가 n개면 Hessian은 n×n이다. n이 백만이면 원소가 1조 개고 저장이 불가능하다. 하지만 **필요한 건 행렬 전체가 아니라 그 행렬에 특정 벡터를 곱한 결과 하나**(길이 n)다. 그리고 행렬을 만들지 않고 그 곱만 얻는 방법이 있다 — 그래서 원문이 "an additional backward pass"라고 쓴 것이다. 행렬을 만들었다면 backward pass 한 번으로 끝날 수 없다.

즉 **"정확한 MAML을 하려면 Hessian 전체를 만들어 저장해야 한다"는 명제는 거짓이다.** exact MAML의 비용은 저장이 아니라 backward pass 한 번 추가다.

### 실제로 뺐더니

> "Surprisingly however, the performance of this method is nearly the same as that obtained with full second derivatives, suggesting that most of the improvement in MAML comes from the gradients of the objective at the post-update parameter values, rather than the second order updates from differentiating through the gradient update." [fact] `#sec-5-2-first-order`

> "This approximation removes the need for computing Hessian-vector products in an additional backward pass, which we found led to roughly 33% speed-up in network computation." [fact] `#sec-5-2-first-order`

Table 1, MiniImagenet 5-way: [fact] `#sec-5-2-first-order`

| | 1-shot | 5-shot |
|---|---|---|
| MAML | 48.70 ± 1.84% | 63.11 ± 0.92% |
| MAML, first order approx. | 48.07 ± 1.75% | 63.15 ± 0.91% |

## 4. 경계 — 이 결과로 무엇을 말할 수 있고 없나

여기가 이 개념에서 제일 자주 미끄러지는 곳이다. 세 층을 분리해야 한다.

1. **논문 명시 사실**: MiniImagenet 5-way 1-shot/5-shot에서 두 방법의 정확도가 위 표와 같았고, 33% 속도 향상이 있었다. [fact]
2. **저자의 해석**: "most of the improvement ... comes from the gradients at the post-update parameter values." 원문이 **suggesting**이라고 쓴다 — 관찰에서 끌어낸 설명이지 증명이 아니다. ReLU 망의 국소 선형성 언급도 "partially explaining"으로 제한된다. [derived] `#sec-5-2-first-order`
3. **말할 수 없는 것**: "FOMAML은 MAML과 성능이 같다", "그러므로 항상 FOMAML을 쓰면 된다". 근거는 **한 데이터셋, 한 아키텍처, 한 few-shot 설정**의 결과다. [unsupported] — 원문은 이 주장을 하지 않는다.

계산량이 줄었다는 사실은 **성능이 같다는 근거가 될 수 없다.** 둘은 서로 다른 종류의 주장이다. 비용은 알고리즘에서 연역되고, 성능은 실험에서만 나온다. 근사가 버린 항이 실제로 작은지는 손실 곡면의 곡률에 달렸고, 그건 과제·모델·데이터에 따라 달라진다.

**후속 연구를 읽을 때 이 세 층 분리가 그대로 도구가 된다** — 어떤 변경을 했고(사실), 왜 그게 통한다고 보며(해석), 어떤 조건에서 검증했는가(범위).

## 5. 연결

- **앞**: `meta-gradient`의 두 인수 중 첫 번째가 여기서 버려진다. 그 인수의 정체를 모르면 무엇이 버려졌는지도 말할 수 없다.
- **다음**: Phase 03의 `research-transfer`. ANIL(§4)은 다른 것을 버린다 — 2차 미분이 아니라 **network body의 inner loop 자체**를. 같은 질문을 던지면 된다: 무엇을 뺐나, 무엇이 남았나, 근거는 어디에 있고 어떤 조건에서 확인됐나.
- **역사적 연결**: Reptile(2018)은 meta-gradient를 아예 다르게 근사한다. 이 저장소 범위 밖이지만 `~/papers/meta-learning/pdfs/14_2018_ReptileFirstOrder.pdf`에 있다.

## 미니 체크

1. 어떤 손실 함수에서는 exact MAML과 FOMAML의 meta-gradient가 **정확히** 같아진다. 어떤 조건인가?
2. 33% speed-up과 Table 1의 정확도 중, 다른 데이터셋으로 옮겼을 때 더 잘 유지될 것 같은 쪽은 어느 쪽이고 왜인가? (원문이 답하지 않는 질문이다 — 근거의 종류를 구분하는 문제다)
