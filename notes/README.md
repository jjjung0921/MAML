# Notes — 튜터가 쓴 개념 설명

튜터가 concept-tutor의 5층(한계 → 직관 → 정식화 → 경계 → 연결)으로 쓴 개념 설명이다. `notes/<slug>.md` 한 파일이 concept 하나에 대응한다(DR-0012; 처음 도입은 MAML 워크스페이스의 DR-0011).

## 이 폴더의 지위

- **이해 상태의 근거가 아니다.** Truth 순서에서 ⑨(튜터의 인상)와 같은 급이다. `concepts/`의 `state`는 `exercises/`의 채점 기록으로만 바뀐다(Rule 8).
- `concepts/<slug>.md`의 Definition·Claims 초안도 튜터가 쓴다(Rule 4). 노트는 그 초안의 긴 설명 버전이고, concept 파일은 학습자 검토를 거쳐 상태를 붙이는 짧은 버전이다.
- 노트를 읽은 것은 원문을 읽은 것이 아니다. `evidence/`의 `status`는 그대로 학습자의 원문 읽기 상태다.

## 읽는 순서

1. 노트를 읽는다 (배경).
2. 노트가 가리키는 `evidence/finn2017-maml.md` 앵커에서 **원문 문장**을 확인한다.
3. `concepts/<slug>.md`의 튜터 초안(`<!-- ai:draft -->`)을 검토한다 — 틀리거나 어색한 문장은 고치고, 괜찮으면 INBOX에 `검토: OK <slug>`. 표시가 걷히면 introduced.
4. exercise로 판정한다. 이해가 맞는지 확인받고 싶으면 "이렇게 이해했는데 맞아?"라고 묻는다 — 튜터가 먼저 묻지 않는다.

## 규칙

- 사실 주장에는 근거 라벨(`[fact]`·`[derived]`·`[assumption]`·`[hypothesis]`·`[unsupported]`)과 `evidence/` 포인터를 붙인다(Rule 7).
- 핵심 유도는 끝까지 풀지 않는다. 방향과 도구까지만 준다(힌트 사다리).
- 출제된 exercise의 정답을 담지 않는다. 이미 출제된 문항의 답이 노트에 생기면 그 문항은 재사용하지 않는다.
- 150줄 상한(Rule 13). 긴 유도·계산은 `evidence/`·`sandbox/`로.
