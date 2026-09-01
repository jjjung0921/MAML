# DR-0003: 학습자는 LaTeX를 치지 않는다 — 입력 비용이 낮은 답변 경로와 exercise 유형

- Status: Accepted
- Date: 2026-08-29
- Deciders: 템플릿 소유자

## Context

수학·최적화 주제에서 exercise의 답은 수식이다. 채팅에 LaTeX로 유도를 타이핑하는 시간이 생각하는 시간보다 길고, 20분 세션이면 입력에 절반이 간다. 학습자는 손으로 쓰는 것이 빠르다. 한편 튜터는 이미지를 읽을 수 있고(Claude Code·Codex·Gemini CLI 모두 이미지 입력 지원), 표기 정리는 튜터에게 비용이 거의 없다.

## Problem

답변의 입력 비용을 학습자에게서 튜터로 옮기되, 채점의 근거(무엇을 답했는가)는 저장소에 정확히 남게 하려면 어떻게 할 것인가.

## Alternatives

1. **수식 편집기·OCR 도구 도입** — 도구 학습 비용과 환경 의존이 생기고, 저장소 밖 도구다.
2. **답을 말로만 받는다** — 개념 설명형에는 맞지만 유도·계산은 검증이 안 된다.
3. **입력 경로를 여러 개 열고 튜터가 전사한다 + 입력 비용이 낮은 exercise 유형을 일상 검증에 쓴다.**

## Decision

3안을 채택한다.

- **입력 경로** (Rule 10, `LEARNER.md` Input Preferences): 손글씨 사진(`exercises/_inbox/`에 넣고 INBOX에 파일명), ASCII 수식(`d/dx`, `sum_i`, `^`, `_`, `partial`), 코드(sympy·numpy — 실행이 곧 검증), 말로 푼 설명. 튜터가 Attempt에 전사하고 학습자가 `전사 확인: OK`를 남긴 뒤에만 채점한다. 원본 사진은 gitignore하고 전사만 커밋한다.
- **표기가 아니라 수학을 채점한다**: 기호 선택·표기 관례는 Rubric 항목이 아니다(Verification Criteria가 명시적으로 요구하지 않는 한).
- **exercise 유형에 입력 비용을 붙인다** (`exercises/README.md`): low — recall, condition, error-spot, fill-step, choice, numeric, skeleton; high — derivation, proof, coding, transfer. 일상 검증(practice·review)은 low 유형, verified 승격과 capstone에만 high 유형을 쓴다. 예산이 적은 날일수록 low 유형만 나온다.
- **뼈대 유도(skeleton)**: 어떤 정리를 어디에 적용하는지 구조만 쓰고 대수 계산은 튜터가 채우거나 sympy로 확인한다. 구조를 아는지와 계산을 할 수 있는지를 분리한다.
- **튜터가 쓰고 학습자가 판단한다**: error-spot(튜터가 쓴 유도에서 틀린 단계 지목), fill-step(빈 단계 채우기), choice(다음 단계 고르기)는 답이 짧으면서 이해를 가른다.

## Rationale

- 입력 비용이 높으면 학습자는 exercise를 피하고, exercise가 없으면 state가 바뀌지 않는다(DR-0002). 입력 비용은 학습 시스템의 병목이다.
- 전사 + 확인 절차가 있으면 사진을 커밋하지 않아도 근거가 정확히 남는다. 전사 오류는 학습자의 확인 단계에서 잡힌다.
- 유형에 비용을 붙여 두면 예산 규칙(DR-0004)이 유형을 자동으로 고를 수 있다.

## Consequences

- 긍정: 20분 세션에서도 exercise 1–2개가 돌아간다. 유도 능력과 계산 능력을 따로 본다.
- 부정 / 감수한 것: 전사 확인이 한 단계 더 든다. 손글씨 인식 오류가 있는 엔진에서는 학습자가 고쳐 줘야 한다. 전체 유도(high)를 아예 안 하게 될 위험 → verified 조건이 high 유형 1회를 요구한다.
- 후속 작업: 학습자가 실제로 쓰는 입력 경로를 `LEARNER.md`에 우선순위로 적고, 쓰지 않는 경로는 지운다.
