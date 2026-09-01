# DR-0001: 저장소를 AI Tutor와 학습자의 공유 학습 기억으로 사용

- Status: Accepted
- Date: 2026-08-29
- Deciders: 템플릿 소유자

## Context

AI Agent를 튜터로 삼아 공부하면 세션마다 문맥이 사라진다. 같은 설명을 반복하고, 튜터가 바뀌면 "어디까지 이해했는지"가 튜터의 인상으로만 남으며, 학습자가 직접 고친 정의를 다음 튜터가 모르고 덮어쓴다. 개발 프로젝트에서는 같은 문제를 [AI-Agent Project Template](https://github.com/jjjung0921/Agent_Project)이 저장소 중심 문서 체계(ADR-0001~0004)로 풀었다: 규칙 한 곳, 장기 지식과 단기 상태 분리, Phase 계획, handoff, checkpoint 기반 변경 감지, 규칙·절차 분리, 실행 가능한 제약.

학습에는 개발과 다른 점이 셋 있다. (1) 산출물이 코드가 아니라 **이해 상태**라 테스트처럼 자동으로 검증되지 않는다. (2) 완료된 것이 시간이 지나면 다시 미완료가 된다(망각). (3) 세션 길이가 하루하루 다르다.

## Problem

개발 템플릿의 구조를 학습에 어떻게 대응시키고, 학습 프로세스(learning goal → curriculum → concept → evidence → exercise → understanding state)의 각 단계에 저장소 안의 자리를 어떻게 줄 것인가.

## Alternatives

1. **개발 템플릿을 그대로 쓰고 docs/에 학습 노트를 쌓는다** — 익숙하지만 이해 상태·근거·exercise가 구분되지 않아 "어디까지 아는가"에 답할 수 없다.
2. **노트 앱·플래시카드 도구(Notion, Anki 등)에 의존** — 복습 스케줄은 편하지만 저장소 밖이라 튜터가 자동으로 읽지 못하고, 규칙·근거·계획과 함께 버전 관리되지 않는다.
3. **프로세스 단계마다 디렉터리를 하나씩 두는 저장소 체계** — 규칙(`AGENTS.md`), 장기 학습 지식(`LEARNING_GOALS.md`, `curriculum/`, `concepts/`, `evidence/`, `exercises/`), 세션 상태(`.ai/`)를 분리하고 스크립트가 절차와 검사를 맡는다.

## Decision

3안을 채택한다. 개발 템플릿과의 대응은 다음과 같다.

| 학습 템플릿 | 개발 템플릿 | 역할 |
|---|---|---|
| `LEARNING_GOALS.md` | `docs/PRD.md` | 무엇을·왜. 목표마다 증명 방법(capstone) |
| `LEARNER.md` | (없음) | 학습자 파라미터 — 시간 예산·입력 방식·스크립트가 읽는 값 |
| `curriculum/ROADMAP.md`, `phases/` | `docs/phases/` | Phase 계획·결과. Task 대신 10–25분 unit + requires + est |
| `curriculum/decisions/` DR | `docs/decisions/` ADR | 장기 영향 결정 |
| `concepts/` | `docs/ARCHITECTURE.md` | 현재 이해의 구조. frontmatter가 이해 상태의 유일한 자리 |
| `evidence/` | 외부 spec·참고 문서 | 개념이 맞다는 근거. concept의 Claims가 위치까지 가리킨다 |
| `exercises/` | `tests/` | 적용 가능한지의 검증. 기록이 곧 state의 근거 |
| `concepts/MISCONCEPTIONS.md` | Known Problems | 관찰된 오개념. 해결돼도 남긴다 |
| `sandbox/` | `src/` (source of truth 아님) | 실험 코드·계산 |
| `.ai/` | `.ai/` | CURRENT·HANDOFF·LOG·INBOX·BOOTSTRAP — 그대로 |
| `scripts/study-*.sh` | `scripts/ai-*.sh` | 절차 안내·종료 점검 + 복습 만기·준비된 unit·속도 계산·state–근거 검사 |

- `AGENTS.md`가 유일한 공통 규칙이며 `CLAUDE.md`·`GEMINI.md`는 import만 한다. Rules는 15개 안팎을 유지한다.
- 정보 충돌 시 우선순위는 학습자의 직접 말 → exercise 기록 → concept state·criteria → evidence → 목표·파라미터 → PLAN → CURRENT → HANDOFF → 대화·인상 순이다 (Rule 2).
- 학습자의 직접 변경은 git checkpoint로 감지하고 되돌리지 않는다. 학습자가 쓴 틀린 정의는 고쳐 쓰지 않고 exercise로 확인한다 (Rule 4).
- 학습 특유의 세 문제는 별도 DR로 다룬다: 판정 기준의 엔진 의존(DR-0002), 수식 입력 비용(DR-0003), 가변 세션 길이(DR-0004).

## Rationale

- 튜터는 대화 기억이 아니라 파일을 읽는다. "어디까지 아는가"가 파일에 있어야 튜터·엔진이 바뀌어도 같은 지점에서 이어진다.
- 프로세스 단계마다 자리가 하나씩 있으면 "이건 어디에 적는가"에 대한 재량이 없어진다. 특히 evidence(근거 자료)와 exercise(적용 검증)를 분리해야 "맞는 개념"과 "내가 쓸 수 있는 개념"이 구분된다.
- 개발 템플릿의 규칙·스크립트·상태 파일을 그대로 계승하면 두 템플릿을 오가는 학습자의 학습 비용이 없다.

## Consequences

- 긍정: 세션·엔진이 바뀌어도 이해 상태·근거·계획이 유지된다. 학습 이력이 git에 남아 "언제 무엇을 어떻게 이해했는지"를 되짚을 수 있다.
- 부정 / 감수한 것: 세션마다 기록 비용(약 5분)이 든다. 학습 주제가 수학·CS처럼 개념 단위로 나뉘는 경우에 맞고, 기능 습득형(악기·언어 회화)에는 exercise 모델을 다시 설계해야 한다.
- 후속 작업: 개발 템플릿의 규칙이 바뀌면 대응하는 Rule을 검토한다. 학습 노트를 외부(포트폴리오 등)로 내보내는 스크립트는 필요해질 때 추가한다.
