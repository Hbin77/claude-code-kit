Full pipeline: implement, verify, commit, and create PR. Execute all steps automatically.

Task: $ARGUMENTS

## Pipeline

### Phase 1: Understand & Plan
1. Explore project structure and relevant code
2. Create implementation plan

### Phase 2: Implement
3. Write the code following existing patterns
4. Keep changes minimal and focused

### Phase 3: Verify (auto-fix on failure, up to 3 retries)
5. Build
6. Lint / type-check
7. Tests

### Phase 4: Self-Review & Fix
8. Check for security issues, code quality, performance
9. Fix any issues found

### Phase 5: Git & PR
10. Stage relevant files (exclude .env, secrets, large binaries)
11. Create commit with format: `type(scope): description`
12. Create a new branch if on main/master
13. Push to remote
14. Create PR with `gh pr create`:
    - Clear title
    - Summary of changes
    - Test plan

### Phase 6: Report
15. Output:
    - PR URL
    - Summary of changes
    - Any manual testing needed

## Rules
- Execute autonomously - don't ask between phases
- Auto-fix failures up to 3 attempts
- Ask only if genuinely ambiguous
