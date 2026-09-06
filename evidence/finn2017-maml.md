---
name: finn2017-maml
title: Model-Agnostic Meta-Learning for Fast Adaptation of Deep Networks (Finn, Abbeel, Levine, ICML 2017)
type: paper
ref: https://proceedings.mlr.press/v70/finn17a.html · 로컬 PDF /Users/leejungjin/papers/meta-learning/pdfs/12_2017_MAML.pdf (2026-09-06 접근 확인)
concepts: [task-episode, adaptation-objective, meta-gradient, first-order-approximation]
status: unread
---

# Model-Agnostic Meta-Learning for Fast Adaptation of Deep Networks

원문 PDF의 절·식 위치를 대조해 만든 카드다. status는 학습자의 읽기 상태이며 unread다 — 이 카드의 존재는 읽었다는 뜻이 아니다.

## What It Supports

Claim 열은 학습자가 concept의 Claims를 쓴 뒤 채운다. 지금은 어느 개념이 어느 위치를 근거로 삼는지만 고정한다.

| Concept | Claim | Location |
|---|---|---|
| task-episode | (미작성) | §2.1 Meta-Learning Problem Set-Up; Algorithm 2 (few-shot supervised) |
| adaptation-objective | (미작성) | §2.2 [#eq-adapt], [#eq-1], Algorithm 1 |
| meta-gradient | (미작성) | §2.2 [#gradient-through-gradient] |
| first-order-approximation | (미작성) | §5.2 [#sec-5-2-first-order], Table 1 |

## Key Statements

원문 표기 그대로. 모두 논문 명시 사실이며 해석은 Caveats에 분리한다.

### eq-adapt

§2.2, Algorithm 1 line 6과 같은 식. 한 step 적응:

    θ_i' = θ - α ∇_θ L_{T_i}(f_θ)

원문: "the updated parameter vector θi' is computed using one or more gradient descent updates on task Ti. For example, when using one gradient update, θi' = θ − α∇θ LTi(fθ)." 이어서 "The step size α may be fixed as a hyperparameter or meta-learned." 그리고 "For simplicity of notation, we will consider one gradient update for the rest of this section, but using multiple gradient updates is a straightforward extension."

### eq-1

§2.2, 식 (1). meta-objective와 meta-update:

    min_θ  Σ_{T_i∼p(T)} L_{T_i}(f_{θ_i'}) = Σ_{T_i∼p(T)} L_{T_i}(f_{θ - α∇_θ L_{T_i}(f_θ)})
    θ ← θ - β ∇_θ Σ_{T_i∼p(T)} L_{T_i}(f_{θ_i'})            (1)

원문: "Note that the meta-optimization is performed over the model parameters θ, whereas the objective is computed using the updated model parameters θ'." β는 meta step size다.

### gradient-through-gradient

§2.2, 식 (1) 바로 뒤 문단. 원문:

> "The MAML meta-gradient update involves a gradient through a gradient. Computationally, this requires an additional backward pass through f to compute Hessian-vector products, which is supported by standard deep learning libraries such as TensorFlow."

원문이 말하는 계산 대상은 Hessian-vector product이며, Hessian 행렬 전체의 명시적 구성이 아니다.

### sec-5-2-first-order

§5.2 Classification. 원문:

> "A significant computational expense in MAML comes from the use of second derivatives when backpropagating the meta-gradient through the gradient operator in the meta-objective (see Equation (1)). On MiniImagenet, we show a comparison to a first-order approximation of MAML, where these second derivatives are omitted. Note that the resulting method still computes the meta-gradient at the post-update parameter values θi', which provides for effective meta-learning."

> "Surprisingly however, the performance of this method is nearly the same as that obtained with full second derivatives, suggesting that most of the improvement in MAML comes from the gradients of the objective at the post-update parameter values, rather than the second order updates from differentiating through the gradient update."

> "This approximation removes the need for computing Hessian-vector products in an additional backward pass, which we found led to roughly 33% speed-up in network computation."

Table 1 (MiniImagenet 5-way): MAML 48.70 ± 1.84% (1-shot) / 63.11 ± 0.92% (5-shot), MAML first order approx. 48.07 ± 1.75% / 63.15 ± 0.91%.

## Caveats

- §5.2의 "nearly the same"은 MiniImagenet 5-way 분류 한 설정의 결과다. 원문은 이를 보편적 동등성으로 주장하지 않는다.
- "most of the improvement ... rather than the second order updates"는 원문의 해석(suggesting)이며 증명이 아니다. ReLU 망의 국소 선형성 언급도 "partially explaining"으로 제한된다.
- 33% speed-up은 저자 실험 환경의 수치이며 이 저장소에서 재현하지 않았다.
- `finn2017-maml/raw/`의 수식 해설은 분석자 보충을 포함한다. 논문의 정리·식과 구분한다.

## Reading Notes

- 2026-09-06 튜터가 PDF 접근과 위 절·식 위치만 대조. 학습자 읽기는 Phase 02에서 시작한다.
