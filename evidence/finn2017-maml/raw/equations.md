# 부록 A. 수식 목록 (나열)

- **논문:** Model-Agnostic Meta-Learning for Fast Adaptation of Deep Networks
- **확인 범위:** 본문과 부록 13쪽 전체
- **표기 원칙:** 논문 표기를 유지했다. 번호 없는 식은 임시 번호를 붙였다. 논문에 없는 전개는 `[분석자 보충]`으로 분리했다.
- **추출 한계:** 전용 자동 수식 추출기는 PyMuPDF 부재로 실행되지 않았다. 페이지별 텍스트 추출 후 PDF p.3·p.4 화면과 식 번호를 직접 대조했다.

## 기호표

| 기호 | 의미 | 역할 | 출처 |
|---|---|---|---|
| $\mathcal{T},\mathcal{T}_i$ | 과제와 $i$번째 과제 | meta-learning의 학습 단위 | [§2.1, p.2] |
| $p(\mathcal{T})$ | 과제 분포 | meta-train/meta-test 과제 생성 | [§2.1, p.2] |
| $f_\theta$ | 파라미터 $\theta$를 가진 모델 | 예측기 또는 policy | [§2.2, p.3] |
| $\mathcal{L}_{\mathcal{T}_i}$ | 과제 $i$의 손실 | 안쪽 적응과 바깥 평가 | [§2.2, p.3] |
| $\theta$ | 적응 전 공통 초기값 | meta-parameter | [§2.2, p.3] |
| $\theta_i'$ | 과제 $i$에 적응한 파라미터 | inner update 결과 | [§2.2, p.3] |
| $\alpha,\beta$ | inner step size와 meta step size | 하이퍼파라미터 | [Algorithm 1, p.3] |
| $H$ | episode horizon | 시퀀스 길이 | [§2.1, p.2] |
| $q_i$ | 과제 $i$의 초기 상태·전이 분포 | 데이터/trajectory 생성 | [§2.1; §3.2, pp.2, 4] |
| $R_i$ | 과제 $i$의 reward | RL 목적 | [Eq. (4), p.4] |

## 등장 순서별 수식

| 번호 | 이름·역할 | 수식 | 한 줄 직관 | 출처 |
|---|---|---|---|---|
| Eq. (본문-1, 임시) | 과제의 일반 정의 | $\mathcal{T}=\{\mathcal{L}(x_1,a_1,\ldots,x_H,a_H),q(x_1),q(x_{t+1}\mid x_t,a_t),H\}$ | loss, 시작 상태, dynamics, horizon이 한 과제를 규정한다 | [§2.1, p.2] |
| Eq. (본문-2, 임시) | 과제 loss의 출력 | $\mathcal{L}(x_1,a_1,\ldots,x_H,a_H)\to\mathbb{R}$ | 한 episode의 결과를 실수 손실로 바꾼다 | [§2.1, p.2] |
| Eq. (본문-3, 임시) | 한 번의 inner update | $\theta_i'=\theta-\alpha\nabla_\theta\mathcal{L}_{\mathcal{T}_i}(f_\theta)$ | 공통 초기값을 과제 $i$ 쪽으로 한 step 적응한다 | [§2.2, p.3] |
| Eq. (본문-4, 임시) | MAML meta-objective | $\min_\theta\sum_{\mathcal{T}_i\sim p(\mathcal{T})}\mathcal{L}_{\mathcal{T}_i}(f_{\theta_i'})=\sum_{\mathcal{T}_i\sim p(\mathcal{T})}\mathcal{L}_{\mathcal{T}_i}(f_{\theta-\alpha\nabla_\theta\mathcal{L}_{\mathcal{T}_i}(f_\theta)})$ | 업데이트 전이 아니라 업데이트 후 손실이 작은 초기값을 찾는다 | [§2.2, p.3] |
| Eq. (1) | outer/meta update | $\theta\leftarrow\theta-\beta\nabla_\theta\sum_{\mathcal{T}_i\sim p(\mathcal{T})}\mathcal{L}_{\mathcal{T}_i}(f_{\theta_i'})$ | 여러 과제의 적응 후 손실을 합쳐 공통 초기값을 갱신한다 | [Eq. (1), §2.2, p.3] |
| Eq. (2) | 회귀의 제곱오차 | $\mathcal{L}_{\mathcal{T}_i}(f_\phi)=\sum_{x^{(j)},y^{(j)}\sim\mathcal{T}_i}\left\|f_\phi(x^{(j)})-y^{(j)}\right\|_2^2$ | 예측과 실수 target의 제곱 거리를 합한다 | [Eq. (2), §3.1, p.3] |
| Eq. (3) | 분류 식, 원문 그대로 | $\mathcal{L}_{\mathcal{T}_i}(f_\phi)=\sum_{x^{(j)},y^{(j)}\sim\mathcal{T}_i}\left[y^{(j)}\log f_\phi(x^{(j)})+(1-y^{(j)})\log(1-f_\phi(x^{(j)}))\right]$ | 원문은 binary log-likelihood 모양을 “cross-entropy loss”로 제시한다 | [Eq. (3), §3.1, p.3] |
| Eq. (4) | RL loss | $\mathcal{L}_{\mathcal{T}_i}(f_\phi)=-\mathbb{E}_{x_t,a_t\sim f_\phi,q_{\mathcal{T}_i}}\left[\sum_{t=1}^{H}R_i(x_t,a_t)\right]$ | 기대 누적 reward를 최대화하도록 그 음수를 최소화한다 | [Eq. (4), §3.2, p.4] |
| Eq. (본문-5, 임시) | supervised 적응 데이터 | $D_i=\{(x^{(j)},y^{(j)})\}_{j=1}^{K}$ | $K$개 표본으로 inner gradient를 계산한다 | [Algorithm 2, step 5, p.4] |
| Eq. (본문-6, 임시) | supervised meta-update 데이터 | $D_i'=\{(x^{(j)},y^{(j)})\}$ | 같은 과제의 새 표본으로 적응 후 성능을 평가한다 | [Algorithm 2, steps 8–10, p.4] |
| Eq. (본문-7, 임시) | RL 적응 trajectory | $D_i=\{(x_1,a_1,\ldots,x_H)\}_{k=1}^{K}$ | 현재 policy의 $K$개 trajectory로 inner update한다 | [Algorithm 3, step 5, p.4] |

### Eq. (3) 표기 주의

원문 식에는 앞의 음수 부호가 없다. 표시된 식은 보통 **최대화**하는 binary log-likelihood이고, binary cross-entropy loss로 **최소화**하려면 일반적으로 다음과 같이 음수가 필요하다.

$$
-\sum_j\left[y^{(j)}\log f_\phi(x^{(j)})+(1-y^{(j)})\log(1-f_\phi(x^{(j)}))\right]
$$

이 식은 **[분석자 보충]**이다. 원문의 오탈자일 가능성은 있지만, 공식 코드를 확인하지 않았으므로 저자 구현이 어느 형태였는지는 **미검증**이다.

# 부록 B. 주요 수식 유도

## B.1 Inner update가 포함된 meta-gradient

- **출발점:** 논문의 1-step inner update와 meta-objective.
- **목표:** Eq. (1)의 $\nabla_\theta$가 왜 2차 미분을 요구하는지 보인다.
- **표기 보충:** 논문 Algorithm 2의 $D_i,D_i'$를 각각 $S_i$(support)와 $Q_i$(query)로 적어, 적응 손실과 적응 후 평가 손실을 구분한다. 이 명칭은 **[분석자 보충]**이다.

| 단계 | 식 | 이 단계에서 한 일 | 근거 |
|---|---|---|---|
| 1 | $\theta_i'=\theta-\alpha\nabla_\theta\mathcal{L}_{S_i}(\theta)$ | 논문의 inner update에 데이터 역할을 명시 | [§2.2, p.3; Algorithm 2, p.4] |
| 2 | $J_i(\theta)=\mathcal{L}_{Q_i}(\theta_i')$ | 과제 $i$의 post-update objective 정의 | [§2.2, p.3; Algorithm 2, p.4] |
| 3 | $\nabla_\theta J_i(\theta)=\left(\frac{\partial\theta_i'}{\partial\theta}\right)^\top\nabla_{\theta_i'}\mathcal{L}_{Q_i}(\theta_i')$ | chain rule 적용 | [분석자 보충] |
| 4 | $\frac{\partial\theta_i'}{\partial\theta}=I-\alpha\nabla_\theta^2\mathcal{L}_{S_i}(\theta)$ | inner update를 $\theta$로 미분 | [분석자 보충] |
| → | $\nabla_\theta J_i(\theta)=\left(I-\alpha\nabla_\theta^2\mathcal{L}_{S_i}(\theta)\right)^\top\nabla_{\theta_i'}\mathcal{L}_{Q_i}(\theta_i')$ | **결론: query gradient에 inner-loss Hessian이 곱해진다** | [분석자 보충; 논문은 §2.2, p.3에서 Hessian-vector product 필요성을 명시] |

- **논문이 생략한 단계:** chain rule 전개와 support/query 표기.
- **채우지 못한 단계:** 표시한 chain-rule 전개는 완결했다. 단, 실제 autodiff 그래프와 수치 결과는 코드를 실행하지 않아 **미검증**이다.
- **유도에 쓰인 가정:** $\mathcal{L}_{S_i}$가 $\theta$에 대해 두 번 미분 가능하고 차원이 맞아야 한다. 논문은 “gradient 기반 학습에 충분히 smooth”하다고만 명시한다. **[§2.2, p.3]**
- **근사·완화:** 이 절에서는 없음.

## B.2 First-order MAML 근사

- **출발점:** B.1의 exact meta-gradient.
- **목표:** 논문 §5.2가 말하는 “second derivatives are omitted”가 수식에서 무엇을 뜻하는지 보인다.

| 단계 | 식 | 이 단계에서 한 일 | 근거 |
|---|---|---|---|
| 1 | $\nabla_\theta J_i=\left(I-\alpha\nabla_\theta^2\mathcal{L}_{S_i}(\theta)\right)^\top\nabla_{\theta_i'}\mathcal{L}_{Q_i}(\theta_i')$ | exact 식 | [B.1, 분석자 보충] |
| 2 | $I-\alpha\nabla_\theta^2\mathcal{L}_{S_i}(\theta)\approx I$ | 2차 미분 기여를 무시 | [§5.2, p.7의 설명을 수식화한 분석자 보충] |
| → | $\nabla_\theta J_i\approx\nabla_{\theta_i'}\mathcal{L}_{Q_i}(\theta_i')$ | **결론: 적응 후 query gradient를 meta-gradient로 사용** | [분석자 보충; §5.2, p.7] |

- **논문이 생략한 단계:** 근사를 행렬식으로 전개하지 않는다.
- **채우지 못한 단계:** 이 근사의 오차 bound와 성립 조건은 논문에 없으므로 **미검증**이다.
- **근사·완화:** Hessian 항 전체를 버린다. MiniImageNet에서는 full MAML과 유사했지만 일반적 동등성을 의미하지 않는다. **[Table 1; §5.2, p.7]**

## B.3 여러 inner step으로의 확장

- **출발점:** 논문은 여러 gradient update가 “straightforward extension”이라고 서술하지만 수식 유도는 제시하지 않는다. **[§2.2, p.3]**
- **목표:** 반복 적응 시 exact meta-gradient가 모든 update 경로를 통과함을 표시한다.

| 단계 | 식 | 이 단계에서 한 일 | 근거 |
|---|---|---|---|
| 1 | $\theta_i^{(0)}=\theta$ | 초기 상태 정의 | [분석자 보충] |
| 2 | $\theta_i^{(s+1)}=\theta_i^{(s)}-\alpha\nabla_{\theta_i^{(s)}}\mathcal{L}_{S_i}(\theta_i^{(s)})$ | inner update를 $S$회 반복 | [분석자 보충; §2.2, p.3의 서술] |
| 3 | $\frac{\partial\theta_i^{(S)}}{\partial\theta}=\prod_{s=0}^{S-1}\left(I-\alpha\nabla^2\mathcal{L}_{S_i}(\theta_i^{(s)})\right)$ | 각 step의 Jacobian을 chain rule로 연결; 곱은 계산 순서에 맞춘 ordered product | [분석자 보충] |
| → | $\nabla_\theta\mathcal{L}_{Q_i}(\theta_i^{(S)})=\left(\frac{\partial\theta_i^{(S)}}{\partial\theta}\right)^\top\nabla_{\theta_i^{(S)}}\mathcal{L}_{Q_i}(\theta_i^{(S)})$ | **결론: step 수가 늘면 더 긴 미분 경로를 역전파한다** | [분석자 보충] |

- **논문이 생략한 단계:** 반복 update의 Jacobian product 전체.
- **채우지 못한 단계:** ordered product의 수치 안정성과 gradient 소실·폭주 여부는 이 논문에서 분석하지 않아 **미검증**이다.
- **근사·완화:** 각 step의 Hessian을 버리면 multi-step FOMAML 형태가 된다. 이는 분석적 확장이며 저자가 본문에 식으로 제시하지 않았다.

## B.4 강화학습 식의 미분

- **출발점:** Eq. (4)는 expected return의 음수다.
- **목표:** MAML 구조에 넣을 수 있는 gradient를 얻는 것.
- **논문이 제시한 수준:** 환경 dynamics를 몰라 expected reward를 직접 미분하기 어렵기 때문에 policy gradient로 model update와 meta-update의 gradient를 추정한다고 설명한다. **[§3.2, p.4]**
- **논문이 생략한 단계:** log-derivative trick을 이용한 policy-gradient 유도.
- **채우지 못한 단계:** 이 PDF는 estimator 식과 variance 분석을 제시하지 않는다. 외부 이론을 섞지 않는 현재 분석 범위에서는 **미검증**으로 남긴다.
- **근사·완화:** RL 실험의 TRPO meta-optimizer에서는 3차 미분을 피하려 finite differences로 Hessian-vector product를 계산한다. **[§5.3, pp.7–8]**

## KaTeX 검증 메모

본문 수식은 정적 검사에서 괄호 균형, `$` delimiter 짝, 사용 명령어를 점검한다. 정적 통과는 시각 렌더링이나 수학적 참을 보장하지 않는다.
