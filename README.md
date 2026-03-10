# Claude Code Kit

Claude Code를 풀스택 개발 플랫폼으로 업그레이드하는 확장 킷.

한 줄 명령으로 기능 구현부터 PR 생성까지 자동화합니다.

## Features

| Category | Count | Description |
|----------|-------|-------------|
| Agents | 8 | 전문 분야별 AI 에이전트 (Opus/Sonnet) |
| Commands | 17 | 슬래시 명령어 |
| Skills | 4 | 멀티스텝 워크플로우 |
| Hooks | 3 | 보안 가드 & 품질 리마인더 |

## Quick Start

```bash
git clone https://github.com/YOUR_USERNAME/claude-code-kit.git
cd claude-code-kit
./install.sh
```

## Usage

### One-Command Development
```
/dev 로그인 페이지에 소셜 로그인 추가
```
탐색 → 계획 → 구현 → 빌드/테스트 검증 → 셀프 리뷰까지 자동 실행.

### Full Ship Pipeline
```
/ship 사용자 프로필 API에 이미지 업로드 기능 추가
```
위 전체 + 커밋 → 푸시 → PR 생성까지 완전 자동.

## Agents

| Agent | Model | Purpose |
|-------|-------|---------|
| `architect` | Opus | Architecture analysis & design |
| `planner` | Opus | Implementation planning |
| `code-reviewer` | Opus | Code review (security, quality, performance) |
| `security-reviewer` | Opus | OWASP-based security audit |
| `build-fixer` | Sonnet | Auto-fix build errors |
| `tdd-guide` | Sonnet | Test-driven development |
| `doc-updater` | Sonnet | Documentation sync |
| `refactor-cleaner` | Sonnet | Dead code removal |

## Commands

### Development
| Command | Description |
|---------|-------------|
| `/dev <task>` | Full auto pipeline (explore → implement → verify → review) |
| `/ship <task>` | Full pipeline + commit + PR |
| `/auto <task>` | Autonomous implementation with verification |
| `/plan <feature>` | Create implementation plan |
| `/build-fix` | Auto-fix build errors |
| `/tdd <feature>` | Test-driven development |
| `/explore` | Analyze project architecture |

### Quality
| Command | Description |
|---------|-------------|
| `/code-review` | Thorough code review |
| `/security-review` | Security vulnerability scan |
| `/verify` | Run build + lint + test |
| `/test-coverage` | Analyze and improve test coverage |
| `/refactor-clean` | Remove dead code |

### Git
| Command | Description |
|---------|-------------|
| `/quick-commit` | Well-formatted commit |
| `/commit-push-pr` | Commit + push + create PR |
| `/worktree-start` | Parallel work with git worktree |

### Documentation & Analysis
| Command | Description |
|---------|-------------|
| `/sync-docs` | Update docs to match code |
| `/orchestrate <task>` | Parallel multi-agent execution |
| `/summarize` | Summarize code, PRs, or sessions |

### Skills (Multi-step Workflows)
| Skill | Description |
|-------|-------------|
| `/debugging-strategies` | Systematic debugging approaches |
| `/dependency-upgrade` | Safe dependency upgrade process |
| `/extract-errors` | Parse and fix error logs |
| `/summarize` | Generate concise summaries |

## Hooks (Auto-protection)

| Hook | Trigger | Purpose |
|------|---------|---------|
| `remote-command-guard` | PreToolUse(Bash) | Blocks `rm -rf /`, force push, DROP TABLE, etc. |
| `secret-filter` | PostToolUse(*) | Warns when secrets appear in output |
| `quality-reminder` | PostToolUse(Edit/Write) | Reminds to run lint/typecheck after changes |

## Settings

Pre-configured with:
- **Agent Teams** enabled for multi-agent orchestration
- **Tool Search** enabled
- **Auto-allow** for common dev tools (git, npm, docker, gh, etc.)
- **Auto-deny** for destructive operations

## Structure

```
claude-code-kit/
├── agents/          # 8 specialized agent definitions
├── commands/        # 17 slash commands + 4 skills
├── hooks/           # 3 security & quality hooks
├── settings.json    # Permissions, hooks, environment config
├── install.sh       # One-click installer
└── README.md
```

## License

MIT
