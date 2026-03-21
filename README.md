<div align="center">

# Claude Code Kit

### Upgrade your Claude Code into a full-stack development platform.

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Agents](https://img.shields.io/badge/Agents-9-blueviolet)]()
[![Commands](https://img.shields.io/badge/Commands-20-green)]()
[![Skills](https://img.shields.io/badge/Skills-4-orange)]()
[![Hooks](https://img.shields.io/badge/Hooks-3-red)]()
[![Rules](https://img.shields.io/badge/Rules-2-yellow)]()
[![Stitch MCP](https://img.shields.io/badge/Stitch_MCP-Design_Phase-ff69b4)]()

**커맨드 없이도** 작업 규모에 따라 자동으로 팀 에이전트가 협업합니다.
**UI 작업은** Stitch MCP로 디자인 → 코드 구현까지 자동 연결됩니다.

</div>

---

## How It Works

커맨드를 입력하지 않아도 Claude Code가 **자동으로 작업 규모를 판단**하고, 적절한 팀 플로우를 실행합니다.
**UI 작업이 포함되면** Stitch MCP 디자인 단계가 자동 삽입됩니다.

```
  "대시보드 페이지 만들어줘"              "이 타입 에러 고쳐줘"
         │                                    │
    규모 판단: Large (5+ files)           규모 판단: Trivial
    UI 포함: Yes                              │
         │                                    ▼
         ▼                               바로 수정 + 검증
  ┌─────────────┐
  │ Phase 0:    │  Stitch MCP
  │ Design      │  UI 디자인 생성 → 사용자 확인 → 스펙 확정
  └──────┬──────┘
         │
  ┌──────┴──────┐
  │  Team Lead  │
  │   (Opus)    │
  └──────┬──────┘
         │
    ┌────┴────┐ Phase 1: 분석 (병렬)
    ▼         ▼
┌────────┐ ┌────────┐
│architect│ │planner │  ← 디자인 스펙 참조
│구조 분석│ │계획 수립│
└───┬────┘ └───┬────┘
    └────┬─────┘
         │
    ┌────┴────┐ Phase 2: 구현 (병렬 worktree)
    ▼         ▼
┌────────┐ ┌────────┐
│구현 A   │ │구현 B   │  ← 디자인 스펙에 맞춰 UI 구현
│(worktree)│(worktree)│
└───┬────┘ └───┬────┘
    └────┬─────┘
         │
    ┌────┼────┐ Phase 3: 검증 (병렬)
    ▼    ▼    ▼
  build lint  test
    └────┬────┘
         │
    ┌────┴────┐ Phase 4: 리뷰 (병렬)
    ▼         ▼
┌─────────┐ ┌──────────┐
│code-    │ │security- │
│reviewer │ │reviewer  │
│품질 리뷰│ │보안 감사  │
└───┬─────┘ └───┬──────┘
    └────┬──────┘
         ▼
  Team Lead: 종합 판단 + 최종 보고
```

### Auto-Scaling by Task Size

| 규모 | 기준 | 자동 동작 |
|:-----|:-----|:---------|
| **Trivial** | 1 file, < 20 lines | 바로 수정 + 검증 |
| **Small** | 2-3 files | 직접 처리 + 검증 (UI 시 Stitch 목업 선택 가능) |
| **Medium** | 3-5 files | **Design (if UI)** → planner → 구현 → code-reviewer |
| **Large** | 5+ files | **Design (if UI)** → 전체 팀 플로우 (위 다이어그램) |

> Rules(`workflow.md`)가 매 세션 자동 로드되어 별도 커맨드 없이 동작합니다.

---

## Stitch MCP Setup (Design Phase)

UI/프론트엔드 작업 시 **Stitch MCP**를 통해 디자인 단계가 자동 실행됩니다.
사용 전 1회 연결이 필요합니다.

### 1. API 키 발급

[stitch.withgoogle.com](https://stitch.withgoogle.com) 접속 → MCP 설정 페이지에서 API 키 복사

### 2. MCP 연결

```bash
claude mcp add stitch \
  --transport http \
  --url "https://stitch.googleapis.com/mcp" \
  --header "X-Goog-Api-Key: YOUR_API_KEY"
```

> `YOUR_API_KEY`를 발급받은 키로 교체하세요.

### 3. 연결 확인

```bash
claude mcp list
```

`stitch` 서버가 목록에 보이면 완료입니다.

### 미연결 시 동작

Stitch MCP가 연결되지 않은 상태에서 UI 작업을 요청하면, 자동으로 아래 경고가 출력되고 작업이 중단됩니다:

```
⚠️ [Stitch MCP 미연결] 디자인 단계를 진행하려면 Stitch MCP 연결이 필요합니다.

아래 명령어를 터미널에 입력하여 연결해주세요:

  claude mcp add stitch \
    --transport http \
    --url "https://stitch.googleapis.com/mcp" \
    --header "X-Goog-Api-Key: YOUR_API_KEY"

API 키는 https://stitch.withgoogle.com 에서 발급받을 수 있습니다.
```

### Design → Code 워크플로우

```
Step 0: Stitch MCP 연결 확인
   │
   ├─ 미연결 → ⚠️ 경고 출력
   │              ├─ [1] 연결 후 재시도
   │              └─ [2] 디자인 건너뛰고 바로 구현 (fallback)
   │
   └─ 연결됨 ↓
Step 1: Design Generation (Stitch로 UI 생성)
   ↓
Step 2: Color System Extraction
         ├─ Primary / Secondary / Neutral / Semantic / Surface 분류
         ├─ CSS 변수 또는 Tailwind config 형식으로 정리
         └─ WCAG AA 대비율(4.5:1) 체크
   ↓
Step 3: Design Review & Iteration (사용자 피드백 반영)
   ↓
Step 4: Design → Code Handoff
         ├─ 컴포넌트 트리 + props 인터페이스 초안
         ├─ 디자인 토큰 파일 (색상, 타이포, 간격, 브레이크포인트)
         └─ 구현 가이드 → planner / architect 에 컨텍스트 전달
   ↓
Planning → Implementation → Verify → Review
```

---

## Getting Started

```bash
git clone https://github.com/Hbin77/claude-code-kit.git
cd claude-code-kit
./install.sh
```

> Requires: `git`, `jq`, Claude Code CLI

설치 후 바로 사용 가능합니다. 커맨드를 외울 필요 없이 그냥 작업을 요청하면 됩니다.

### (선택) Stitch MCP 연결

UI 작업을 위해 Stitch MCP를 연결하려면 위 [Stitch MCP Setup](#stitch-mcp-setup-design-phase) 섹션을 참고하세요.

---

## Team Agents

<div align="center">

### 9개의 전문 에이전트가 하나의 팀으로 작동합니다.

</div>

```
                    ┌──────────────┐
                    │  Team Lead   │  Opus - 조율, 위임, 종합 판단
                    │  (Coordinator)│
                    └──────┬───────┘
           ┌───────┬───────┼───────┬────────┐
           ▼       ▼       ▼       ▼        ▼
      ┌────────┐┌──────┐┌──────┐┌──────┐┌────────┐
      │architect││planner││code- ││secur-││build-  │
      │        ││      ││review││ity-  ││fixer   │
      │ Opus   ││ Opus ││ Opus ││review││ Sonnet │
      └────────┘└──────┘└──────┘│ Opus │└────────┘
                                └──────┘
           ┌───────┬───────┐
           ▼       ▼       ▼
      ┌────────┐┌──────┐┌────────┐
      │tdd-    ││doc-  ││refactor│
      │guide   ││update││-cleaner│
      │ Sonnet ││Sonnet││ Sonnet │
      └────────┘└──────┘└────────┘
```

| Agent | Model | Role |
|:------|:-----:|:-----|
| **team-lead** | **Opus** | Coordinator - delegates, reviews, makes final decisions |
| `architect` | **Opus** | System architecture analysis & design |
| `planner` | **Opus** | Implementation planning for complex features |
| `code-reviewer` | **Opus** | Security, quality, performance review |
| `security-reviewer` | **Opus** | OWASP-based vulnerability scanning |
| `build-fixer` | Sonnet | Surgical build error resolution |
| `tdd-guide` | Sonnet | Red-Green-Refactor TDD cycle |
| `doc-updater` | Sonnet | Documentation sync with code changes |
| `refactor-cleaner` | Sonnet | Dead code detection & removal |

> **Opus** = deep analysis & judgment. **Sonnet** = fast execution.

---

## Commands

커맨드 없이도 자동 동작하지만, 특정 워크플로우를 강제하고 싶을 때 사용합니다.

### Team Commands (recommended)

> 팀 리더가 전문 에이전트들을 조율하며 진행합니다.

| Command | Description |
|:--------|:------------|
| `/team-dev <task>` | Team Lead가 팀을 조율하여 개발 (커밋 없음) |
| `/team-ship <task>` | Team 개발 + commit + PR |
| `/team-review` | 3명 리뷰어 동시 투입 (코드 + 보안 + 아키텍처) |

### Solo Commands

> 에이전트 위임 없이 직접 처리합니다. 간단한 작업에 적합.

<details>
<summary><b>Development</b> — 개발</summary>

| Command | Description |
|:--------|:------------|
| `/dev <task>` | Solo auto pipeline (explore → implement → verify → review) |
| `/ship <task>` | Solo pipeline + commit + PR |
| `/auto <task>` | Autonomous implementation with verification |
| `/plan <feature>` | Create implementation plan |
| `/build-fix` | Auto-fix build errors |
| `/tdd <feature>` | Test-driven development |
| `/explore` | Analyze project architecture |

</details>

<details>
<summary><b>Quality</b> — 코드 품질 & 보안</summary>

| Command | Description |
|:--------|:------------|
| `/code-review` | Thorough code review |
| `/security-review` | Security vulnerability scan (OWASP Top 10) |
| `/verify` | Run build + lint + test |
| `/test-coverage` | Analyze and improve test coverage |
| `/refactor-clean` | Remove dead code and unused dependencies |

</details>

<details>
<summary><b>Git</b> — 버전 관리</summary>

| Command | Description |
|:--------|:------------|
| `/quick-commit` | Well-formatted conventional commit |
| `/commit-push-pr` | Commit + push + create PR |
| `/worktree-start` | Parallel work with git worktree |

</details>

<details>
<summary><b>Advanced</b> — 고급</summary>

| Command | Description |
|:--------|:------------|
| `/sync-docs` | Update docs to match code changes |
| `/orchestrate <task>` | Parallel multi-agent task decomposition |
| `/summarize` | Summarize code, PRs, or sessions |
| `/debugging-strategies` | Systematic debugging approaches |
| `/dependency-upgrade` | Safe dependency upgrade process |
| `/extract-errors` | Parse error logs and auto-fix |

</details>

---

## Auto Rules

커맨드 없이 자동 적용되는 규칙입니다.

### `workflow.md` — 작업 규모 자동 판단 + 디자인 + 팀 플로우

```
사용자 요청 → 규모 분류 → UI 포함 여부 체크
                              │
                     ┌────────┴────────┐
                     ▼                 ▼
                UI 있음             UI 없음
                     │                 │
              Stitch MCP 체크     바로 Plan/구현
                     │
              ┌──────┴──────┐
              ▼              ▼
          연결됨          미연결
              │              │
        디자인 생성      ⚠️ 경고 + 중단
              │
        Plan → 구현 → 검증 → 리뷰
```

### `quality.md` — 코드 품질 기본 규칙

- 기존 코드 먼저 읽기
- 최소한의 변경만
- 변경 후 항상 검증
- 5+ 파일 변경 시 리뷰 에이전트 자동 실행

---

## Security Hooks

자동으로 작동하는 3중 보안 레이어:

| Hook | Trigger | What it does |
|:-----|:--------|:-------------|
| **Command Guard** | `PreToolUse(Bash)` | Blocks `rm -rf /`, force push to main, `DROP TABLE`, pipe-to-shell |
| **Secret Filter** | `PostToolUse(*)` | Warns when API keys, tokens, or passwords appear in output |
| **Quality Reminder** | `PostToolUse(Edit\|Write)` | Reminds to run lint/typecheck after code changes |

---

## Pre-configured Settings

| Setting | Value |
|:--------|:------|
| Agent Teams | Enabled |
| Tool Search | Enabled |
| Stitch MCP | User-connected (API Key) |
| Auto-allow | `git`, `npm`, `docker`, `gh`, `python`, `go`, `cargo`, and more |
| Auto-deny | `rm -rf /`, force push to main/master, `npm publish`, `DROP DATABASE` |

---

## Project Structure

```
claude-code-kit/
├── agents/                    # 9 specialized agent definitions
│   ├── team-lead.md           #   Team coordinator (Opus)
│   ├── architect.md           #   Architecture analysis (Opus)
│   ├── planner.md             #   Implementation planning (Opus)
│   ├── code-reviewer.md       #   Code review (Opus)
│   ├── security-reviewer.md   #   Security audit (Opus)
│   ├── build-fixer.md         #   Build error fix (Sonnet)
│   ├── tdd-guide.md           #   TDD guide (Sonnet)
│   ├── doc-updater.md         #   Doc sync (Sonnet)
│   └── refactor-cleaner.md    #   Dead code removal (Sonnet)
├── commands/                  # 20 slash commands + 4 skills
│   ├── team-dev.md            #   /team-dev  (team pipeline)
│   ├── team-ship.md           #   /team-ship (team + PR)
│   ├── team-review.md         #   /team-review (3-agent review)
│   ├── dev.md                 #   /dev  (solo pipeline)
│   ├── ship.md                #   /ship (solo + PR)
│   ├── ...
│   ├── debugging-strategies/  # skill
│   ├── dependency-upgrade/    # skill
│   ├── extract-errors/        # skill
│   └── summarize/             # skill
├── hooks/                     # 3 auto-protection hooks
│   ├── remote-command-guard.sh
│   ├── secret-filter.sh
│   └── quality-reminder.sh
├── rules/                     # 2 auto-loaded rules
│   ├── workflow.md            #   Auto team scaling + Stitch design phase
│   └── quality.md             #   Code quality standards
├── settings.json              # Permissions, hooks, env config
├── install.sh                 # One-click installer
└── README.md
```

---

## Comparison

| | Without Kit | With Kit (Solo) | With Kit (Team) |
|:--|:-----------|:----------------|:----------------|
| Design | None | Stitch mockup (optional) | Stitch → auto spec handoff |
| Workflow | Manual | `/dev`, `/ship` | Auto or `/team-dev` |
| Planning | None | Self-planning | architect + planner agents |
| Review | None | Self-review | code-reviewer + security-reviewer |
| Parallelism | None | Partial | Full (worktree + multi-agent) |
| Security | None | 3 hooks | 3 hooks + security-reviewer agent |
| Task Tracking | None | None | TaskCreate/TaskUpdate |

---

## License

[MIT](LICENSE)

---

<div align="center">

**Built with Claude Code + Stitch MCP**

*Design first, then code. The team handles the rest.*

</div>
