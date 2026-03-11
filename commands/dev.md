You are executing a full development pipeline. Follow every step in order automatically without asking for confirmation unless genuinely ambiguous.

Task: $ARGUMENTS

## Pipeline

### Phase 1: Understand (PARALLEL)
Launch these agents simultaneously using multiple Agent tool calls in a single message:
- **Agent 1** (Explore): Scan project structure, tech stack, architecture patterns
- **Agent 2** (Explore): Find and read files directly related to the task

Wait for both to complete, then synthesize findings.

### Phase 2: Plan
Based on Phase 1 results:
1. Create a brief implementation plan (files to modify, approach, risks)
2. If the task involves multiple independent components, identify which can be implemented in parallel

### Phase 3: Implement
- If multiple independent files/components identified in Phase 2:
  Launch parallel agents with `isolation: "worktree"` for each independent component
- If changes are interdependent:
  Implement sequentially, starting with the foundation (types/interfaces → logic → UI)

### Phase 4: Verify (PARALLEL)
Launch these checks simultaneously in a single message:
- `Bash`: Run build
- `Bash`: Run lint/type-check
- `Bash`: Run tests

If any fails, fix and re-verify automatically (up to 3 attempts).

### Phase 5: Review (PARALLEL)
Launch two review agents simultaneously:
- **code-reviewer agent**: Quality, maintainability, performance check
- **security-reviewer agent**: Security vulnerability scan

Collect both results, fix any CRITICAL or WARNING findings.

### Phase 6: Finalize
Summarize:
- Files changed/created
- Key decisions made
- Review findings addressed
- What to test manually (if applicable)

## Rules
- MAXIMIZE PARALLELISM: Always launch independent operations in a single message with multiple tool calls
- Do NOT ask for permission between phases - just execute
- If build/test fails, fix it automatically (up to 3 attempts)
- If genuinely ambiguous (multiple valid approaches), ask once then proceed
- Follow existing project conventions (naming, file structure, patterns)
- Commit is NOT included - user will decide when to commit
