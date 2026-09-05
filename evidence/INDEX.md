# Evidence Index

Status는 학습자의 읽기 상태다. 기존 분석의 존재를 read로 해석하지 않는다. 원문 접근 확인·학습용 evidence 카드 생성은 Phase 01 U3에서 수행한다.

| Slug | Title | Type | Concepts | Access | Status |
|---|---|---|---|---|---|
| finn2017-maml | Model-Agnostic Meta-Learning for Fast Adaptation of Deep Networks — Finn, Abbeel, Levine (2017) | paper | task-episode, adaptation-objective, meta-gradient, first-order-approximation, research-transfer | https://proceedings.mlr.press/v70/finn17a.html ; 기존 분석이 가리키는 PDF: /Users/leejungjin/papers/meta-learning/pdfs/12_2017_MAML.pdf | unread |
| maml-analysis | 기존 원문 분석·수식 해설 (튜터 작성 보조 자료) | derivation | task-episode, adaptation-objective, meta-gradient, first-order-approximation | finn2017-maml/raw/task-method-adv.md ; finn2017-maml/raw/equations.md | unread |
| raghu2020-anil | Rapid Learning or Feature Reuse? Towards Understanding the Effectiveness of MAML — Raghu et al. (ICLR 2020) | paper | research-transfer | https://arxiv.org/abs/1909.09157 ; Phase 01 U3에서 원문·발췌 확인 | unread |

## Phase 02

| Concept | 원문 읽을 위치 | 기존 보조 자료 위치 |
|---|---|---|
| task-episode | MAML §2.1, Algorithm 2 | raw/task-method-adv.md §1.2, §2.3 |
| adaptation-objective | MAML §2.2, Eq. (1), Algorithm 1–2 | raw/task-method-adv.md §2.2–2.3 |
| meta-gradient | MAML §2.2의 gradient-through-gradient 설명 | raw/equations.md B.1; B.3은 다중 step 경로만 선택 |
| first-order-approximation | MAML §5.2, Table 1 | raw/equations.md B.2; raw/task-method-adv.md §2.5, §4.1 |

위 raw 경로는 evidence/finn2017-maml/ 아래다. 수식 해설은 분석자 보충을 포함하므로 논문 자체의 정리·식과 구분한다. U3에서 evidence/finn2017-maml.md 카드를 만들고 concept의 포인터를 정확한 앵커로 연결한다. 원문 결과의 독립 재현·공식 코드 확인은 이번 작업 범위 밖이다.

## Phase 03

ANIL 원문의 abstract와 방법 발췌를 후보로 등록한다. U3에서 정확한 절·그림 위치와 접근을 확인하고 G3용 발췌를 선정한다. 아직 방법·성능 주장을 이 문서에서 확정하지 않는다. 발췌만으로 판단할 수 없는 내용은 unknown으로 남기고 전체 논문 이해로 확대하지 않는다.

## Not Used

- 최신 MAML 계열 전체 survey, RL·implicit MAML 상세: 이틀 목표의 범위 밖이다. 자료 선정에는 research-survey의 기존 분석 재사용·원문 근거 원칙만 적용했으며 분야 조사 파이프라인은 수행하지 않았다.
