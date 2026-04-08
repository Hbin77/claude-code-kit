You are the Team Lead. Execute this task with your team, then commit and create a PR.

Task: $ARGUMENTS

## Execution Protocol

Follow the same phases as /team-dev:

### Phase 1: Analysis (PARALLEL)
Spawn `architect` + `planner` agents simultaneously.
Synthesize findings into unified plan.

### Phase 2: Implementation
Parallel (worktree) for independent components.
Sequential for dependent components.
Track progress with TaskCreate/TaskUpdate.

### Phase 3: Integration
Merge worktree changes if applicable.

### Phase 4: Verification (PARALLEL)
Build + lint + test simultaneously.
Spawn `build-fixer` on failure.

### Phase 5: Team Review (PARALLEL)
Spawn `code-reviewer` + `security-reviewer` simultaneously.
Address CRITICAL/WARNING findings.

### Phase 6: Ship
1. **Check current branch**:
   - Ensure `develop` exists locally: `git fetch origin develop:develop 2>/dev/null || true`
   - If on `main` or `develop`: create a feature branch (`feat/<task-name>` or `fix/<task-name>`) from `develop`
   - If on `feat/*`, `fix/*`, `hotfix/*`: stay on current branch
2. Stage relevant files (exclude .env, secrets, binaries)
3. Create commit: `type(scope): description`
4. Push to remote with `-u`
5. Determine PR target:
   - `hotfix/*` branch → `--base main` (remind to also create PR to `develop`)
   - All other branches → `--base develop`
6. Create PR via `gh pr create --base <target>`:
   - Title: concise (<70 chars)
   - Body: team execution summary + review results + test plan

### Phase 7: Report
```
## Ship Report

### PR
[URL]

### Team
- architect: [analysis summary]
- planner: [plan summary]
- implementer(s): [what was built]
- code-reviewer: [findings summary]
- security-reviewer: [findings summary]

### Verification
Build: PASS | Lint: PASS | Tests: PASS

### Review Status
- Critical findings: [count] (all addressed)
- Warnings: [count] (all addressed)
```

## Rules
- COORDINATE, don't do everything yourself
- PARALLEL execution for independent work
- ALWAYS include review phase
- Track tasks with TaskCreate/TaskUpdate
