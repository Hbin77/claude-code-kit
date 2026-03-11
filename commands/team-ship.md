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
1. Stage relevant files (exclude .env, secrets, binaries)
2. Create commit: `type(scope): description`
3. Create new branch if on main/master (name from task)
4. Push to remote with `-u`
5. Create PR via `gh pr create`:
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
