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
1. Stage relevant files (exclude .env, secrets, large binaries)
2. Create commit: `type(scope): description`
3. Create new branch if on main/master
4. Push to remote
5. Create PR with `gh pr create`:
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
