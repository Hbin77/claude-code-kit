Full pipeline: implement, verify, commit, and create PR. Execute all steps automatically.

Task: $ARGUMENTS

## Pipeline

### Phase 1: Understand (PARALLEL)
Launch simultaneously in a single message:
- **Agent 1** (`architect` agent): Scan project structure, tech stack, patterns
- **Agent 2** (Explore subagent): Find and read files related to the task

### Phase 2: Plan
Create implementation plan. Identify independent vs dependent components.

### Phase 3: Implement
- Independent components → parallel agents with `isolation: "worktree"`
- Dependent components → sequential (types → logic → UI)

### Phase 4: Verify (PARALLEL)
Run simultaneously in a single message:
- `Bash`: build
- `Bash`: lint/type-check
- `Bash`: tests

Auto-fix failures up to 3 retries.

### Phase 5: Review (PARALLEL)
Launch simultaneously:
- **code-reviewer agent**: Quality & maintainability
- **security-reviewer agent**: Vulnerability scan

Fix CRITICAL/WARNING findings.

### Phase 6: Git & PR
1. **Check current branch**:
   - Ensure `develop` exists locally: `git fetch origin develop:develop 2>/dev/null || true`
   - If on `main` or `develop`: create a feature branch (`feat/<task-name>` or `fix/<task-name>`) from `develop`
   - If on `feat/*`, `fix/*`, `hotfix/*`: stay on current branch
2. Stage relevant files (exclude .env, secrets, large binaries)
3. Create commit: `type(scope): description`
4. Push to remote with `-u`
5. Determine PR target:
   - `hotfix/*` branch → `--base main` (remind to also create PR to `develop`)
   - All other branches → `--base develop`
6. Create PR with `gh pr create --base <target>`:
   - Clear title (<70 chars)
   - Summary of changes
   - Test plan
   - Review findings addressed

### Phase 7: Report
- PR URL
- Summary of changes
- Review results (code + security)
- Manual testing needed

## Rules
- MAXIMIZE PARALLELISM: Always launch independent operations in a single message
- Execute autonomously - don't ask between phases
- Auto-fix failures up to 3 attempts
- Ask only if genuinely ambiguous
