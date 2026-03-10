You are executing a full development pipeline. Follow every step in order automatically without asking for confirmation unless genuinely ambiguous.

Task: $ARGUMENTS

## Pipeline

### Phase 1: Understand
1. Explore the project structure (key files, tech stack, patterns)
2. Read relevant existing code that will be affected

### Phase 2: Plan
3. Create a brief implementation plan:
   - What files to create/modify
   - What approach to take
   - Any risks or edge cases

### Phase 3: Implement
4. Implement the changes following existing code patterns
5. Write minimal, focused code - no over-engineering

### Phase 4: Verify
6. Run build (detect build system automatically)
7. Run lint/type-check if available
8. Run tests if available
9. If any step fails, fix and re-verify automatically

### Phase 5: Review
10. Self-review all changes:
    - Security: no hardcoded secrets, input validation
    - Quality: no dead code, clear naming, error handling
    - Performance: no obvious N+1 or memory leaks
11. Fix any issues found during review

### Phase 6: Finalize
12. Summarize what was done:
    - Files changed/created
    - Key decisions made
    - What to test manually (if applicable)

## Rules
- Do NOT ask for permission between phases - just execute
- If build/test fails, fix it automatically (up to 3 attempts)
- If genuinely ambiguous (multiple valid approaches), ask once then proceed
- Follow existing project conventions (naming, file structure, patterns)
- Commit is NOT included - user will decide when to commit
