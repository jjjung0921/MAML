# agent-memory — 역할별 subject 전용 메모리

교재 근거 발췌(cs-book)·증명 검증과 설명(math-analyzer) 같은 역할이 **이 subject에서** 배운 것을 두는 곳. 역할마다 하위 폴더 하나(`<역할>/`), 그 안에 `MEMORY.md`(인덱스, 100줄 상한)와 토픽 파일. 형식과 절차는 `~/.agents/skills/agent-memory-protocol/SKILL.md`가 소유한다.

- **Claude Code**: `memory: project` 서브에이전트가 자기 폴더의 `MEMORY.md`를 자동 로드하고 종료 전 갱신한다. 폴더는 첫 호출 때 스스로 만든다.
- **Codex 등 서브에이전트 메모리가 없는 엔진**: 역할 스킬(`~/.codex/skills/<역할>/`)의 `[메모리]` 줄에 따라 같은 폴더를 직접 읽고 쓴다.
- **학습자**: 읽어도 되지만 손으로 고치지 않는다 — 틀린 기억은 `.ai/INBOX.md`로 지시한다.

내용은 학습자의 반복 오류·이미 다룬 범위·이전 판정처럼 다시 도출할 수 없는 것만. 커밋 대상이지만 source of truth가 아니다 — concept `state`의 근거는 `exercises/`뿐이다(Rule 8). 메모리는 세션을 연 디렉터리 기준이므로 세션은 이 subject 폴더에서 연다(vault 루트에서 열면 과목이 섞인다).
