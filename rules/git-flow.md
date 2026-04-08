# Git Flow Branching Strategy

## Branch Structure

| Branch | Purpose | Base | Merge Target |
|--------|---------|------|--------------|
| `main` | Production releases only | - | - |
| `develop` | Integration branch for development | `main` | `main` (release) |
| `feat/<name>` | New features | `develop` | `develop` |
| `fix/<name>` | Bug fixes | `develop` | `develop` |
| `hotfix/<name>` | Urgent production fixes | `main` | `main` + `develop` |

## Rules

### Protected Branches
- **main**: Never push directly. Only merge from `develop` (release) or `hotfix/*`.
- **develop**: Never force push. Merge from feature/fix branches via PR.

### Branch Naming
- `feat/add-user-auth` - new functionality
- `fix/login-redirect-loop` - bug fixes
- `hotfix/critical-security-patch` - urgent production fixes
- Use kebab-case, keep names short and descriptive

### Workflow
1. **New feature/fix**: Create branch from `develop` → work → PR to `develop`
2. **Release**: Merge `develop` into `main` via PR
3. **Hotfix**: Create branch from `main` → fix → PR to `main`, then also create PR to `develop` (or cherry-pick)

### Branch Detection
Before creating commits or PRs, always check the current branch:
- If on `main` or `develop`: warn and create a feature branch first
- If on `feat/*`, `fix/*`, `hotfix/*`: proceed normally
- PR target: `develop` (default), `main` (only for hotfix/* branches)

### Commit Convention
Format: `type(scope): description`
- Types: feat, fix, refactor, docs, test, chore, style, perf
- Keep under 72 characters
