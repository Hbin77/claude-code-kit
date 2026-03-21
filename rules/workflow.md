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
- **연결되어 있지 않으면 즉시 아래 경고를 출력한다:**

```
⚠️ [Stitch MCP 미연결] 디자인 단계를 진행하려면 Stitch MCP 연결이 필요합니다.

아래 명령어를 터미널에 입력하여 연결해주세요:

  claude mcp add stitch \
    --transport http \
    --url "https://stitch.googleapis.com/mcp" \
    --header "X-Goog-Api-Key: YOUR_API_KEY"

API 키는 https://stitch.withgoogle.com 에서 발급받을 수 있습니다.
```

- **Fallback**: 사용자에게 두 가지 선택지를 제시한다:
  1. Stitch MCP를 연결하고 디자인 단계부터 진행
  2. 디자인 단계를 건너뛰고 바로 Plan/구현 단계로 진행 (사용자의 구두 설명 기반)
- 사용자가 선택한 경로에 따라 진행한다.

### Step 1: Design Generation
- Stitch MCP를 사용해 사용자의 요구사항을 UI 디자인으로 생성
- 프롬프트에 분위기/용도를 명시: "Modern SaaS dashboard with dark theme" 등
- 생성된 디자인을 사용자에게 확인 요청

### Step 2: Color System Extraction
Stitch가 생성한 디자인에서 색상 시스템을 추출하고 정리한다:

- **Primary**: 주요 브랜드/액션 색상 (버튼, 링크, CTA)
- **Secondary**: 보조 강조 색상
- **Neutral**: 배경, 텍스트, 보더에 사용할 그레이 스케일 (50~950)
- **Semantic**: 성공(green), 경고(amber), 에러(red), 정보(blue)
- **Surface**: 카드, 모달, 사이드바 등 표면 배경색

추출 형식 (CSS 변수 또는 Tailwind config):
```
--color-primary: #3B82F6;
--color-primary-hover: #2563EB;
--color-primary-light: #EFF6FF;
--color-secondary: #8B5CF6;
--color-neutral-50: #F9FAFB;
--color-neutral-900: #111827;
--color-success: #10B981;
--color-warning: #F59E0B;
--color-error: #EF4444;
--color-surface: #FFFFFF;
--color-surface-elevated: #F3F4F6;
```

- 색상 간 **대비율(contrast ratio)** 확인: 텍스트/배경 조합이 WCAG AA(4.5:1) 이상 충족하는지 체크
- 사용자에게 추출된 팔레트를 보여주고 확인/수정 요청

### Step 3: Design Review & Iteration
- 사용자 피드백 반영하여 디자인 수정
- 컴포넌트 구조, 레이아웃, 색상 등 확정
- 색상 변경 시 Step 2의 Color System도 함께 업데이트

### Step 4: Design → Code Handoff
확정된 디자인에서 아래 산출물을 추출하여 planner/architect에게 전달:

**컴포넌트 구조:**
- 컴포넌트 트리 (페이지 → 섹션 → 개별 컴포넌트)
- 각 컴포넌트의 props 인터페이스 초안

**디자인 토큰 파일 생성:**
- 색상 팔레트 (Step 2에서 확정된 값)
- 타이포그래피 (font-family, size scale, weight, line-height)
- 간격 체계 (spacing scale: 4px 단위)
- 반응형 브레이크포인트 (sm, md, lg, xl)
- 그림자/보더 반경 등

**구현 가이드:**
- 색상은 반드시 디자인 토큰 변수를 사용 (하드코딩 금지)
- 시맨틱 색상은 용도에 맞게 적용 (에러 메시지에 error 색상 등)
- 다크모드 대응이 필요하면 light/dark 토큰 쌍으로 정의

## Trivial / Small Tasks
Just do it. Run build/test after. No ceremony needed.
- UI 변경이 있으면 Stitch로 빠른 목업 생성 후 진행 가능 (선택사항).

## Medium Tasks (3-5 files)

1. **Design** (UI 포함 시): Stitch MCP로 디자인 생성 → 사용자 확인
2. **Plan**: Spawn `planner` agent to break down the task (디자인 컨텍스트 포함)
3. **Implement**: Write code following the plan + design specs
4. **Verify**: Run build + lint + test
5. **Review**: Spawn `code-reviewer` agent to check your work
6. Fix any CRITICAL/WARNING findings, then re-verify

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
- **Use design tokens**: When Stitch design specs exist, never hardcode colors/spacing — use token variables
