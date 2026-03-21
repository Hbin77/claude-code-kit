# Default Development Workflow

When the user asks you to implement, build, fix, or develop anything (not just simple questions or file reads), follow this workflow automatically.

## Task Classification

Before starting, classify the task:

| Scale | Criteria | Approach |
|-------|----------|----------|
| **Trivial** | 1 file, < 20 lines change | Do it directly. No agents needed. |
| **Small** | 2-3 files, single concern | Do it yourself with verify step. |
| **Medium** | 3-5 files, needs planning | Design (if UI) → planner → implement → reviewer |
| **Large** | 5+ files, multiple concerns | Design (if UI) → architect + planner → parallel implement → parallel review |

## Design Phase (Stitch MCP)

**When to trigger**: UI/프론트엔드 작업이 포함된 Medium/Large 태스크에서 자동 실행.
**Skip condition**: 백엔드 전용, 버그 수정, 리팩토링 등 UI 변경이 없는 경우 건너뜀.

### Step 0: Stitch MCP 연결 확인 (필수)
- 디자인 단계 진입 시, Stitch MCP 연결 여부를 먼저 확인한다.
- `claude mcp list` 또는 MCP 도구 목록에서 `stitch` 서버가 있는지 체크한다.
- **연결되어 있지 않으면 즉시 아래 경고를 출력하고 작업을 중단한다:**

```
⚠️ [Stitch MCP 미연결] 디자인 단계를 진행하려면 Stitch MCP 연결이 필요합니다.

아래 명령어를 터미널에 입력하여 연결해주세요:

  claude mcp add stitch \
    --transport http \
    --url "https://stitch.googleapis.com/mcp" \
    --header "X-Goog-Api-Key: YOUR_API_KEY"

API 키는 https://stitch.withgoogle.com 에서 발급받을 수 있습니다.
연결 완료 후 다시 요청해주세요.
```

- 사용자가 연결을 완료한 후에만 Step 1로 진행한다.

### Step 1: Design Generation
- Stitch MCP를 사용해 사용자의 요구사항을 UI 디자인으로 생성
- 프롬프트 예: "Create a dashboard with sidebar navigation and data table"
- 생성된 디자인을 사용자에게 확인 요청

### Step 2: Design Review & Iteration
- 사용자 피드백 반영하여 디자인 수정
- 컴포넌트 구조, 레이아웃, 색상 등 확정

### Step 3: Design → Code Handoff
- 확정된 디자인에서 컴포넌트 구조 추출
- 디자인 시스템 토큰(색상, 간격, 타이포) 정리
- 이 정보를 planner/architect에게 컨텍스트로 전달

## Trivial / Small Tasks
Just do it. Run build/test after. No ceremony needed.
- UI 변경이 있으면 Stitch로 빠른 목업 생성 후 진행 가능 (선택사항).

## Medium Tasks (3-5 files)

1. **Design** (UI 포함 시): Stitch MCP로 디자인 생성 → 사용자 확인
2. **Plan**: Spawn `planner` agent to break down the task (디자인 컨텍스트 포함)
3. **Implement**: Write code following the plan + design specs
4. **Verify**: Run build + lint + test
5. **Review**: Spawn `code-reviewer` agent to check your work
6. Fix any CRITICAL/WARNING findings

## Large Tasks (5+ files)

### Phase 0: Design (UI 포함 시)
- Stitch MCP로 전체 UI 흐름 디자인
- 사용자 승인 후 디자인 스펙 확정
- 컴포넌트 트리 & 디자인 토큰 추출

### Phase 1: Analysis (PARALLEL)
Spawn in ONE message:
- `architect` agent: analyze affected areas (디자인 스펙 참조)
- `planner` agent: create implementation plan (디자인 스펙 참조)

### Phase 2: Implement
- Independent components → parallel agents with `isolation: "worktree"`
- Dependent components → sequential (types → logic → UI)
- UI 컴포넌트는 디자인 스펙에 맞춰 구현

### Phase 3: Verify (PARALLEL)
Run in ONE message: build + lint + test

### Phase 4: Review (PARALLEL)
Spawn in ONE message:
- `code-reviewer` agent
- `security-reviewer` agent

Address CRITICAL/WARNING findings, then re-verify.

## Always

- **Parallelize independent work**: Use multiple Agent/Bash calls in a single message
- **Verify after changes**: Build + test at minimum
- **Review large changes**: Spawn reviewer agent(s) for 5+ file changes
- **Track complex work**: Use TaskCreate/TaskUpdate for large tasks
- **Use worktree isolation**: When parallel agents modify different files
