<div align="center">

# Claude Code Kit

### Upgrade your Claude Code into a full-stack development platform.

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Agents](https://img.shields.io/badge/Agents-9-blueviolet)]()
[![Commands](https://img.shields.io/badge/Commands-20-green)]()
[![Skills](https://img.shields.io/badge/Skills-4-orange)]()
[![Hooks](https://img.shields.io/badge/Hooks-3-red)]()
[![Rules](https://img.shields.io/badge/Rules-2-yellow)]()

**커맨드 없이도** 작업 규모에 따라 자동으로 팀 에이전트가 협업합니다.

</div>

---

## How It Works

커맨드를 입력하지 않아도 Claude Code가 **자동으로 작업 규모를 판단**하고, 적절한 팀 플로우를 실행합니다.

```
  "OAuth2 로그인 구현해줘"              "이 타입 에러 고쳐줘"
         │                                    │
    규모 판단: Large (5+ files)           규모 판단: Trivial
         │                                    │
         ▼                                    ▼
  ┌─────────────┐                        바로 수정 + 검증
  │  Team Lead  │
  │   (Opus)    │
  └──────┬──────┘
         │
    ┌────┴────┐ Phase 1: 분석 (병렬)
    ▼         ▼
┌────────┐ ┌────────┐
│architect│ │planner │
│구조 분석│ │계획 수립│
└───┬────┘ └───┬────┘
    └────┬─────┘
         │
    ┌────┴────┐ Phase 2: 구현 (병렬 worktree)
    ▼         ▼
┌────────┐ ┌────────┐
│구현 A   │ │구현 B   │
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
| **Small** | 2-3 files | 직접 처리 + 검증 |
| **Medium** | 3-5 files | planner → 구현 → code-reviewer |
| **Large** | 5+ files | 전체 팀 플로우 (위 다이어그램) |

> Rules(`workflow.md`)가 매 세션 자동 로드되어 별도 커맨드 없이 동작합니다.

---

## Getting Started

```bash
git clone https://github.com/Hbin77/claude-code-kit.git
cd claude-code-kit
./install.sh
```

> Requires: `git`, `jq`, Claude Code CLI

설치 후 바로 사용 가능합니다. 커맨드를 외울 필요 없이 그냥 작업을 요청하면 됩니다.

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

### `workflow.md` — 작업 규모 자동 판단 + 팀 플로우

```
사용자 요청 → 규모 분류 (Trivial/Small/Medium/Large) → 자동 팀 배정

Large 작업 시:
  architect + planner (병렬) → 구현 (worktree 병렬) → 검증 (병렬) → 리뷰 (병렬)
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
│   ├── workflow.md            #   Auto team scaling by task size
│   └── quality.md             #   Code quality standards
├── settings.json              # Permissions, hooks, env config
├── install.sh                 # One-click installer
└── README.md
```

---

## Comparison

| | Without Kit | With Kit (Solo) | With Kit (Team) |
|:--|:-----------|:----------------|:----------------|
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

**Built with Claude Code**

*Just tell Claude what to build. The team handles the rest.*

</div>
