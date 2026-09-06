# DR-0011: 튜터 작성 개념 설명 노트(notes/) 도입

- Status: Accepted
- Date: 2026-09-06
- Deciders: 학습자(직접 선택), claude-code(대필 경계 설정)

## Context

U2 진단으로 MAML의 계산 경로가 미학습임이 확인됐다. 학습자가 Phase 02 진입 전 "개념 학습을 위한 자료"를 요청했고, 제시된 선택지(읽기 가이드 / 개념 설명 노트 / 문제 세트) 중 **개념 설명 노트**를 선택했다.

## Problem

기존 규칙은 튜터가 학습자의 Definition·Attempt를 대필하지 않는다(Phase 01 Out of Scope, Rule 8). 튜터가 쓴 개념 설명을 어디에 두고, 이해 상태와 어떻게 분리할 것인가.

## Alternatives

1. concepts/에 튜터가 설명을 채운다 — 한 파일에 모인다 / Rule 8의 "이해 상태의 유일한 자리"가 오염되고, 학습자 언어의 Definition과 튜터 문장이 섞여 state 판정 근거를 잃는다.
2. 별도 폴더 notes/ — 분리가 명확하다 / 파일이 늘고 학습자가 두 곳을 본다.
3. 노트를 만들지 않는다 — 규칙 그대로 / 학습자의 직접 요청을 거부하게 된다.

## Decision

- 2번 선택. `notes/<concept-slug>.md`에 튜터가 개념 설명을 쓴다. concept-tutor의 5층(한계 → 직관 → 정식화 → 경계 → 연결)을 따른다.
- notes/는 **이해 상태의 근거가 아니다**. Truth 순서에서 ⑨(튜터의 인상)와 같은 급이며, `concepts/`의 state는 여전히 `exercises/` 기록으로만 바뀐다(Rule 8 불변).
- `concepts/`의 Definition·Claims·Verification Criteria는 학습자가 쓴다. 노트의 문장을 그대로 옮겨 적는 것은 학습자 언어가 아니므로 introduced 근거로 쓰지 않는다.
- 노트의 사실 주장에는 Rule 7의 근거 라벨과 `evidence/` 포인터를 붙인다. 튜터의 기억만으로 공식·정리를 단언하지 않는다.
- 핵심 유도는 노트에서 끝까지 풀지 않는다. concept-tutor의 힌트 사다리를 유지하고, exercise가 요구하는 유도는 노트에서 완성 형태로 제공하지 않는다.
- 노트는 exercise의 정답을 담지 않는다. 이미 출제된 문항의 답이 노트에 생기면 그 문항은 재사용하지 않는다.

## Rationale

학습자의 직접 요청이며 Truth 순서 ①이다. 진단 결과가 "비용은 알지만 경로를 모른다"였으므로, 원문을 바로 읽히기보다 배경 설명을 먼저 주는 편이 §2.2 한 문단에서 얻는 것을 늘린다. 대신 설명을 읽었다는 사실이 이해의 증거가 되지 않도록 저장 위치로 분리한다 — 이게 이 저장소가 지키려는 유일한 선이다.

## Consequences

- 긍정: 튜터 설명과 학습자 이해가 파일 단위로 분리된다. Phase 02의 도입 unit이 짧아질 수 있다.
- 부정 / 감수한 것: 노트를 읽고 그 언어로 Definition을 쓰면 학습자 언어인지 구분이 어려워진다 — 채점자는 Attempt가 노트 문장의 복사인지 살펴야 하고, 의심되면 변형 문항으로 확인한다. 노트 유지보수 부담도 생긴다(원문 대조가 틀리면 concepts까지 오염).
- 후속 작업: `notes/README.md`에 위 지위를 명시. AGENTS.md Repository Map에 notes/ 추가. Phase 02 PLAN의 Scope·Relevant Documents에 반영.
