# Misconceptions

<!--
관찰된 오개념의 목록. 장기 학습 지식이다 — 해결돼도 지우지 않는다 (같은 오개념은 재발한다).
- Status: active(아직 관찰됨) | resolved(이후 exercise에서 재발 없음) | recurred(resolved 후 다시 관찰 → 원인 재조사, `debug-to-concept` 스킬)
- 학습자 표현을 그대로 적는다. 튜터가 "틀렸다"고 판단한 것뿐 아니라 학습자가 스스로 "헷갈린다"고 말한 것도 후보다 (Rule 4).
- 튜터는 active 항목을 새 exercise의 Rubric(흔한 오답)에 반영한다. 세션 시작 시 활성 목록은 scripts/study-start.sh가 보여준다.
-->

| Date       | Concept | Misconception (학습자 표현)               | Correct                          | Evidence (exercise)          | Status | Resolved by |
|------------|---------|-------------------------------------------|----------------------------------|------------------------------|--------|-------------|
| <YYYY-MM-DD> | <slug> | "<…라고 생각했다>"                        | <바로잡은 내용 한 줄>            | `exercises/<file>.md`        | active | —           |
| 2026-09-06 | first-order-approximation | "task별 gradient 업데이트(1)가 존재하며 … (1)에서의 2차 미분이 발생한다" | 2차 미분은 inner update 자체가 아니라 적응 결과를 초기값으로 다시 미분하는 outer 단계에서 등장한다 (확인 예정: evidence/finn2017-maml/raw/equations.md B.1–B.2) | `exercises/2026-09-05-first-order-approximation-recall.md` | active | — |
| 2026-09-06 | first-order-approximation | "중간 계산 결과를 저장함으로써 메모리의 사용을 줄일 수 있을 듯 한데 방법은 잘 모르겠다" (학습자가 모른다고 밝힘) | Hessian 전체를 명시적으로 구성하지 않고 Hessian-vector product만 계산하는 경로가 있다 (확인 예정: 같은 evidence B.1–B.2) | `exercises/2026-09-05-first-order-approximation-recall.md` | active | — |
