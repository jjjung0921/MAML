# Sandbox

실험 코드·계산·노트북을 두는 곳이다. Source of truth가 아니며, 여기서 확인한 사실은 `evidence/`(type: derivation | experiment)나 concept의 Claims(`[derived]`)로 옮겨야 근거가 된다.

- 용도: 수치 확인(유한차분으로 gradient 검증 등), 소규모 구현, sympy 유도, 그림
- 파일명: `<concept>-<what>.py` / `.ipynb` — exercise와 연결되면 exercise 파일에서 경로를 가리킨다
- coding exercise의 채점은 여기의 테스트·출력으로 한다 (`AGENTS.md` Commands의 Sandbox 명령)
- 생성물(캐시·체크포인트·큰 데이터)은 커밋하지 않는다 — `.gitignore`에 도구별 항목 추가
