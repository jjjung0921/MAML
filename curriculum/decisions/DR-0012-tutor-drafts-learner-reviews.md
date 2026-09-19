<!-- Agent_Study 템플릿 DR-0006(2026-09-19)을 이 워크스페이스에 채택한 기록. 본문은 템플릿과 동일. -->
<!-- DR-0011의 항목 중 "concepts/의 Definition·Claims·Verification Criteria는 학습자가 쓴다"와 notes/README의 "노트를 보지 않고 쓴다"를 대체한다. notes/ 분리·근거 라벨·정답 미포함 규칙은 DR-0011 그대로 유효. -->
# DR-0012: 개념 서술은 튜터 초안·학습자 검토, 이해 확인은 학습자 요청 시 한 번

- Status: Accepted
- Date: 2026-09-19
- Deciders: 학습자(직접 요청), claude(cowork)

## Context

학습 스킬(learning-coach·concept-tutor·self-exam·study-series)을 2026-09-19에 개정했다. 세션 마무리마다 자기 말 설명을 요구하고 오개념을 잡아 재질문하던 파인만 게이트, 설명 뒤 자동 미니 체크, 학습자가 처음부터 써야 하는 concept Definition이 학습 속도를 늦춘다는 학습자 판단이 배경이다. MAML 워크스페이스는 DR-0011로 튜터 설명을 `notes/`에 분리하되 `concepts/`의 Definition은 학습자가 쓰는 절충을 택했는데, 이번 요청은 개념 서술 전부를 튜터 초안·학습자 검토로 바꾸는 것이다.

## Problem

(1) `concepts/<slug>.md`의 Definition·Claims·Verification Criteria를 누가 쓰는가, (2) 튜터의 설명은 어디에 두는가, (3) `introduced`의 뜻, (4) 세션 마무리의 이해 확인을 어떻게 하는가 — Rule 8(상태는 exercise로만)을 깨지 않으면서 정해야 한다.

## Alternatives

1. 현행 유지 + DR-0011 방식 — 튜터는 `notes/`만 쓰고 Definition은 학습자가 쓴다. 학습자 언어가 그대로 남는다 / 서술 작성이 병목으로 남고, 학습자의 직접 요청과 어긋난다.
2. 튜터가 `concepts/` 초안을 쓰고 표시를 두며 학습자가 검토한다; 긴 설명은 `notes/`; 상태는 여전히 exercise로만 — 병목이 사라지고 Rule 8이 그대로다 / 튜터 문장이 학습자 이해로 오인될 위험이 있다.
3. `concepts/`의 Definition을 없애고 `notes/`만 둔다 — 파일이 준다 / 개념 단위의 상태 앵커가 사라지고 Rubric 파생 근거(Verification Criteria)가 흔들린다.

## Decision

2번. 적용 범위는 이 템플릿과 이후 클론하는 모든 워크스페이스.

- `notes/<slug>.md`: 튜터의 5층 설명. 이해 상태의 근거가 아니다(Truth ⑨).
- `concepts/<slug>.md`의 Definition·Claims·Verification Criteria: 튜터가 초안을 쓰고 `<!-- ai:draft -->` … `<!-- /ai:draft -->` 마킹으로 감싼다 — 블로그 초안(blog-coauthor·study-series)·draft-scout(`PLAN-2026-fall.md`)와 같은 마킹이다: 초안은 서술을 포함해 완성된 형태로 쓰고, 사용자가 검토·수정한 절에서 마킹을 걷으며, 마킹이 남은 것은 미검토다. 학습자가 검토(직접 수정, 또는 INBOX `검토: OK <slug>`)하면 표시를 걷는다. 그 시점이 `introduced`다(Rule 8 개정).
- Rule 4는 학습자가 **고친** 문장에 그대로 적용된다 — 틀려 보여도 고쳐 쓰지 않고 `MISCONCEPTIONS.md` 후보 + exercise로 확인.
- 이해 확인: 튜터가 자기 말 설명·확인 질문을 먼저 요구하지 않는다. 학습자가 "이렇게 이해했는데 맞아?"라고 물을 때만 한 번 검토(정확한 부분 → 어긋난 부분과 이유 → 교정된 이해)하고 끝낸다. 재질문·반복 없음. 어긋남은 `MISCONCEPTIONS.md` 후보와 다음 exercise 소재. 이해 확인은 종료 조건이 아니고 state의 근거도 아니다.
- 핵심 유도와 출제된 exercise의 정답은 초안·노트에 쓰지 않는다(힌트 사다리 유지).

## Rationale

학습자의 직접 요청(Truth ①)이며, 이 저장소가 지키려는 유일한 선은 "이해 상태는 선언이 아니라 채점 기록에서 나온다"(DR-0002)다. 초안을 누가 썼는지는 그 선과 무관하다 — 초안을 읽고 검토한 것이 state를 올리지 않고, 판정은 여전히 Rubric 항목별로 Attempt에서 원리가 확인되는가로 한다. 병목이었던 서술 작성과 강제 확인을 걷어내면 unit당 시간이 줄고, 남는 시간은 exercise(진짜 근거)로 간다.

## Consequences

- 긍정: 서술 작성·강제 확인이 사라져 unit이 짧아진다. 튜터 설명과 학습자 검토가 파일 표시로 구분된다.
- 부정 / 감수한 것: 튜터 문장을 그대로 승인하면 학습자 언어가 남지 않는다 — 채점자는 Attempt가 초안 문장의 복사인지 살피고, 의심되면 변형·전이 문항으로 확인한다(verified 조건의 transfer·derivation 요건이 이 위험을 막는다). `ai:draft` 마킹가 걷히지 않은 concept가 쌓이면 introduced가 늦어진다 — study-start.sh 출력에서 검토 대기 목록을 보여주는 것은 후속 작업.
- 후속 작업: 기존 워크스페이스(MAML·optimization·xai·typescript 등)는 AGENTS.md Rule 4·8·Skills 표·Session Procedure와 `concepts/_template.md`를 이 템플릿에 맞춰 갱신하고, MAML은 DR-0011의 "concepts/ Definition은 학습자가 쓴다" 항목을 Superseded로 표시하는 DR을 쓴다. `scripts/study-start.sh`에 `ai:draft` 마킹가 남은 concept 목록 출력 추가.
