<div align="center">

# Claude Code Kit

### Upgrade your Claude Code into a full-stack development platform.

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Agents](https://img.shields.io/badge/Agents-8-blueviolet)]()
[![Commands](https://img.shields.io/badge/Commands-17-green)]()
[![Skills](https://img.shields.io/badge/Skills-4-orange)]()
[![Hooks](https://img.shields.io/badge/Hooks-3-red)]()

한 줄 명령으로 **탐색 → 계획 → 구현 → 검증 → 리뷰 → PR** 전체 사이클을 자동화합니다.

</div>

---

## Getting Started

```bash
git clone https://github.com/Hbin77/claude-code-kit.git
cd claude-code-kit
./install.sh
```

> Requires: `git`, `jq`, Claude Code CLI

---

## How It Works

```
                        /dev "새 기능 구현"
                              |
          +-------------------+-------------------+
          |                   |                   |
     [1] Explore         [2] Plan          [3] Implement
     프로젝트 구조 파악    구현 전략 수립      코드 작성
          |                   |                   |
          +-------------------+-------------------+
                              |
          +-------------------+-------------------+
          |                   |                   |
     [4] Verify          [5] Review         [6] Report
     빌드/테스트/린트      보안/품질 셀프리뷰   변경사항 요약
```

---

## Core Commands

> `/dev`와 `/ship` 두 개만 기억하면 됩니다.

### `/dev <task>` — 자동 개발 파이프라인

```
/dev 로그인 페이지에 소셜 로그인 추가
```

탐색 → 계획 → 구현 → 빌드/테스트 검증 → 셀프 리뷰까지 **한 번에 자동 실행**.
커밋은 하지 않으므로 결과를 확인 후 직접 커밋할 수 있습니다.

### `/ship <task>` — 구현부터 PR까지 원스톱

```
/ship 사용자 프로필 API에 이미지 업로드 기능 추가
```

`/dev`의 전체 파이프라인 + **커밋 → 브랜치 → 푸시 → PR 생성**까지 완전 자동.

---

## All Commands

<details>
<summary><b>Development</b> — 개발 관련 명령어</summary>

| Command | Description |
|:--------|:------------|
| `/dev <task>` | Full auto pipeline (explore → implement → verify → review) |
| `/ship <task>` | Full pipeline + commit + PR |
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
<summary><b>Docs & Advanced</b> — 문서화 & 고급 기능</summary>

| Command | Description |
|:--------|:------------|
| `/sync-docs` | Update docs to match code changes |
| `/orchestrate <task>` | Parallel multi-agent execution |
| `/summarize` | Summarize code, PRs, or sessions |

</details>

<details>
<summary><b>Skills</b> — 멀티스텝 워크플로우</summary>

| Skill | Description |
|:------|:------------|
| `/debugging-strategies` | Systematic debugging (binary search, isolation, hypothesis) |
| `/dependency-upgrade` | Safe dependency upgrade with rollback strategy |
| `/extract-errors` | Parse error logs and auto-fix |
| `/summarize` | Generate concise summaries |

</details>

---

## Agents

8개의 전문 에이전트가 작업 유형에 따라 자동 배정됩니다.

| Agent | Model | Role |
|:------|:-----:|:-----|
| `architect` | **Opus** | System architecture analysis & design |
| `planner` | **Opus** | Implementation planning for complex features |
| `code-reviewer` | **Opus** | Security, quality, performance review |
| `security-reviewer` | **Opus** | OWASP-based vulnerability scanning |
| `build-fixer` | Sonnet | Surgical build error resolution |
| `tdd-guide` | Sonnet | Red-Green-Refactor TDD cycle |
| `doc-updater` | Sonnet | Documentation sync with code changes |
| `refactor-cleaner` | Sonnet | Dead code detection & removal |

> **Opus** agents handle deep analysis. **Sonnet** agents handle fast execution.

---

## Security Hooks

자동으로 작동하는 3중 보안 레이어:

| Hook | Trigger | What it does |
|:-----|:--------|:-------------|
| **Command Guard** | `PreToolUse(Bash)` | Blocks `rm -rf /`, force push to main, `DROP TABLE`, pipe-to-shell, etc. |
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
├── agents/                    # 8 specialized agent definitions
│   ├── architect.md
│   ├── planner.md
│   ├── code-reviewer.md
│   ├── security-reviewer.md
│   ├── build-fixer.md
│   ├── tdd-guide.md
│   ├── doc-updater.md
│   └── refactor-cleaner.md
├── commands/                  # 17 slash commands
│   ├── dev.md                 #   /dev  - full auto pipeline
│   ├── ship.md                #   /ship - pipeline + commit + PR
│   ├── auto.md                #   /auto - autonomous implementation
│   ├── plan.md                #   /plan - implementation planning
│   ├── build-fix.md           #   /build-fix
│   ├── code-review.md         #   /code-review
│   ├── security-review.md     #   /security-review
│   ├── ...
│   ├── debugging-strategies/  # skill
│   ├── dependency-upgrade/    # skill
│   ├── extract-errors/        # skill
│   └── summarize/             # skill
├── hooks/                     # 3 auto-protection hooks
│   ├── remote-command-guard.sh
│   ├── secret-filter.sh
│   └── quality-reminder.sh
├── settings.json              # Permissions, hooks, env config
├── install.sh                 # One-click installer
└── README.md
```

---

## License

[MIT](LICENSE)

---

<div align="center">

**Built with Claude Code**

</div>
