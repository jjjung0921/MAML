# Evidence Index

Status는 학습자의 읽기 상태다. 기존 분석의 존재를 read로 해석하지 않는다. 원문 접근과 evidence 카드는 2026-09-06 U3에서 확인·생성했다.

| Slug | Title | Type | Concepts | Access | Status |
|---|---|---|---|---|---|
| finn2017-maml | Model-Agnostic Meta-Learning for Fast Adaptation of Deep Networks — Finn, Abbeel, Levine (2017) | paper | task-episode, adaptation-objective, meta-gradient, first-order-approximation, research-transfer | 로컬 PDF `~/papers/meta-learning/pdfs/12_2017_MAML.pdf` (2026-09-06 접근 확인) ; 카드 `evidence/finn2017-maml.md` ; https://proceedings.mlr.press/v70/finn17a.html | unread |
| maml-analysis | 기존 원문 분석·수식 해설 (튜터 작성 보조 자료) | derivation | task-episode, adaptation-objective, meta-gradient, first-order-approximation | finn2017-maml/raw/task-method-adv.md ; finn2017-maml/raw/equations.md | unread |
| raghu2020-anil | Rapid Learning or Feature Reuse? Towards Understanding the Effectiveness of MAML — Raghu et al. (ICLR 2020) | paper | research-transfer | 로컬 PDF `~/papers/meta-learning/pdfs/17_2020_ANIL.pdf` (2026-09-06 접근 확인) ; https://arxiv.org/abs/1909.09157 | unread |

## Phase 02

| Concept | 원문 읽을 위치 | 기존 보조 자료 위치 |
|---|---|---|
| task-episode | MAML §2.1, Algorithm 2 | raw/task-method-adv.md §1.2, §2.3 |
| adaptation-objective | MAML §2.2, Eq. (1), Algorithm 1–2 | raw/task-method-adv.md §2.2–2.3 |
| meta-gradient | MAML §2.2의 gradient-through-gradient 설명 | raw/equations.md B.1; B.3은 다중 step 경로만 선택 |
| first-order-approximation | MAML §5.2, Table 1 | raw/equations.md B.2; raw/task-method-adv.md §2.5, §4.1 |

카드 앵커(2026-09-06 원문 대조 완료): `#eq-adapt`(§2.2 한 step 적응식, Algorithm 1 line 6) · `#eq-1`(§2.2 식 (1) meta-objective·meta-update) · `#gradient-through-gradient`(§2.2 식 (1) 직후, Hessian-vector product 언급) · `#sec-5-2-first-order`(§5.2 second derivatives 생략·post-update gradient 유지·33% speed-up, Table 1 MiniImagenet 5-way). concept 4개의 frontmatter가 이 앵커를 가리킨다.

위 raw 경로는 evidence/finn2017-maml/ 아래다. 수식 해설은 분석자 보충을 포함하므로 논문 자체의 정리·식과 구분한다. U3에서 evidence/finn2017-maml.md 카드를 만들고 concept의 포인터를 정확한 앵커로 연결한다. 원문 결과의 독립 재현·공식 코드 확인은 이번 작업 범위 밖이다.

## Phase 03

G3용 발췌 선정 완료 (2026-09-06): **ANIL §4 "The ANIL (Almost No Inner Loop) Algorithm"** — 로컬 PDF p.6. 이 한 절 안에 후속 연구를 읽을 때 분리해야 할 세 가지가 모두 들어 있다.

- 변경점: inner loop 업데이트를 network body에서 제거하고 head에만 적용한다. 파라미터 식 한 줄과 Figure 4 도식.
- 근거: Figure 3(inner loop가 body 표현을 거의 바꾸지 않는다)을 가리키는 문장. 근거는 이 절 밖에 있다 — 발췌만으로는 확인할 수 없는 지점이다.
- 주장: 학습 1.7x, 추론 4.1x 속도 향상, MAML과 성능 동등.

발췌만으로 판단할 수 없는 내용(Figure 3의 측정 방법, CCA·CKA 해석, NIL 변형, 벤치마크 조건)은 unknown으로 남기고 전체 논문 이해로 확대하지 않는다. abstract는 보조로만 쓴다.

## Not Used

- 최신 MAML 계열 전체 survey, RL·implicit MAML 상세: 이틀 목표의 범위 밖이다. 자료 선정에는 research-survey의 기존 분석 재사용·원문 근거 원칙만 적용했으며 분야 조사 파이프라인은 수행하지 않았다.
