# DR-0005: 폴더는 subject마다 하나, 템플릿 복사는 목표가 생길 때만

- Status: Accepted
- Date: 2026-08-29
- Deciders: 템플릿 소유자

## Context

`~/study/`에는 두 체계가 산다. 발견 주도 학습(`~/study/stories/`: 프로젝트에서 이월된 토픽을 `story--<topic>.md`로 배우고 포트폴리오 시리즈로 변환)은 질문 원장(`why--<topic>.md` 등)을 `~/study/<subject>/`에 쌓고, 목표 주도 학습(이 템플릿)은 `~/study/<subject>/`를 워크스페이스로 쓴다. 두 쪽이 같은 경로를 쓰므로 `<subject>`의 뜻과 크기가 같아야 하고, 워크스페이스가 "끝이 있는 프로젝트"인지 "오래 가는 도메인 폴더"인지가 정해져야 했다.

## Problem

subject를 어떤 단위로 자르고, 원장(누적)과 워크스페이스(목표)를 같은 폴더에 어떻게 두며, 다른 subject의 개념을 어떻게 참조할 것인가.

## Alternatives

1. **목표마다 워크스페이스** (`~/study/optimization/bilevel-hypergradient/`) — 목표가 끝나면 닫히지만, 같은 subject 안에서 기초 개념·복습 만기·오개념이 워크스페이스마다 갈라지고 중복된다.
2. **subject 하나 = 폴더 하나 = 워크스페이스 하나, 템플릿은 목표가 생길 때만** — 원장은 subject 폴더 루트에 그대로, 템플릿은 "…를 할 수 있다"는 목표가 생겼을 때 `cp -r ~/study/template/. ~/study/<subject>/`로 얹는다. 워크스페이스는 목표(G)·Phase를 계속 추가하며 오래 간다.
3. **원장을 워크스페이스 안(`ledger/`)으로** — 루트가 깔끔하지만 스토리 쪽 규칙과 learning-coach 경로를 바꿔야 한다.

## Decision

2안을 채택한다.

- subject = **concept map 하나를 공유하는 단위**. 선행 관계가 이어지면 같은 subject, 이어지지 않으면 다른 subject. 포트폴리오 `field`보다 한 단계 아래 크기(`optimization`, `game-ai`, `web`, `programming-language`).
- 나누는 신호: `CONCEPT_MAP.md`의 Reading Order가 끊긴 덩어리 둘로 갈라진다. 합치는 신호: 두 subject가 개념을 30% 넘게 공유한다(또는 공통 부분을 별도 subject로 뺀다).
- 폴더는 subject마다 하나. 원장만 있는 subject 폴더는 그대로 둔다. 템플릿은 목표가 생길 때만 복사하며, 기존 원장과 이름이 겹치지 않으므로 그 위에 복사한다. 원장은 학습자 파일이고 concept state의 근거가 아니다.
- 워크스페이스는 오래 간다. 목표가 증명되면(PROVEN) 닫지 않고 다음 목표·Phase를 추가한다. 복습 만기(Rule 14)는 subject 단위로 계속 돈다.
- 다른 subject의 개념은 `requires`에 넣지 않고 `evidence`로 그쪽 concept 파일(`~/study/<other>/concepts/<slug>.md`)을 가리킨다. state는 그쪽 폴더가 기준이다. subject를 넘는 개념 연결은 스토리 측 `~/study/concept-links.md`가 맡는다.
- 폴더 이름은 도메인 이름이지 이번 목표의 이름이 아니다.

## Rationale

- state·복습·오개념은 개념에 붙는 것이라 개념이 사는 곳(subject)에 하나만 있어야 한다. 목표마다 나누면 같은 개념의 상태가 여러 곳에 생긴다.
- 스토리 쪽이 이미 `~/study/<subject>/`에 원장을 두고 있으므로, 같은 폴더를 쓰면 스토리에서 자란 개념을 옮기지 않고 `concepts/`로 올릴 수 있다.
- 템플릿을 목표가 생길 때만 얹으면 원장만 있는 subject가 빈 워크스페이스 뼈대를 갖지 않는다.

## Consequences

- 긍정: 개념 상태가 subject당 한 곳. 스토리 → 커리큘럼 승격이 폴더 이동 없이 된다. 스토리 쪽 규칙은 바꿀 것이 없다.
- 부정 / 감수한 것: 워크스페이스 루트에 원장 파일이 섞인다(튜터는 무시한다). subject 경계 판단이 초기화 시점에 필요하다. 시험 대비처럼 끝이 있는 코스는 Phase로 표현해야 한다.
- 후속 작업: `README.md` How to Use·`.ai/BOOTSTRAP.md` Subject 절·`AGENTS.md` Repository Map·`concepts/_template.md`의 requires 주석에 반영했다. 원장이 많아져 루트가 어지러우면 3안(`ledger/`)을 스토리 쪽과 함께 재검토한다.
