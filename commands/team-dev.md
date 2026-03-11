You are the Team Lead. Execute this task by coordinating your team of specialized agents.

Task: $ARGUMENTS

## Execution Protocol

### Phase 1: Analysis (PARALLEL)
Spawn these agents simultaneously in ONE message:

**Agent A** - Architect (read-only):
"Analyze the project architecture relevant to: [task].
Report: tech stack, file structure, existing patterns, extension points."

**Agent B** - Planner (read-only):
"Create an implementation plan for: [task].
Report: files to modify, approach, task breakdown, risks."

→ Wait for both. Synthesize into a unified plan.
→ Track with TaskCreate: one task per implementation unit.

### Phase 2: Implementation
Based on the plan, determine parallel vs sequential:

**If independent components exist** → Spawn parallel agents with `isolation: "worktree"`:
```
Agent 1 (worktree): "Implement [component A] in [files]. Context: [plan details]."
Agent 2 (worktree): "Implement [component B] in [files]. Context: [plan details]."
```

**If components are dependent** → Implement sequentially yourself or delegate to one agent:
```
Agent 1: "Implement the full feature: [details].
  Order: types/interfaces → core logic → integration → UI.
  Context: [architect findings + planner breakdown]."
```

→ Update tasks with TaskUpdate as each completes.

### Phase 3: Integration
If worktrees were used:
1. Review each worktree's changes
2. Merge into main working directory
3. Resolve any conflicts

### Phase 4: Verification (PARALLEL)
Run simultaneously in ONE message:
- `Bash`: build command
- `Bash`: lint / type-check
- `Bash`: test suite

→ If failures: spawn `build-fixer` agent with error output.
→ Re-verify after fixes.

### Phase 5: Team Review (PARALLEL)
Spawn two reviewers simultaneously in ONE message:

**Agent C** - Code Reviewer:
"Review all changes made for: [task].
Changed files: [list].
Check: quality, maintainability, performance.
Report: findings with severity (CRITICAL/WARNING/INFO)."

**Agent D** - Security Reviewer:
"Security audit all changes for: [task].
Changed files: [list].
Check: OWASP Top 10, secrets, injection, auth.
Report: findings with severity."

→ Wait for both. Address any CRITICAL or WARNING findings.
→ If fixes needed, make them and re-verify.

### Phase 6: Finalize
Update all tasks to completed. Produce final report:

```
## Team Execution Report

### Task
[Original task description]

### Team Members Deployed
- [Agent]: [What they did]

### Parallel Execution
- Phase 1: architect + planner (parallel)
- Phase 2: [N] implementers (parallel/sequential)
- Phase 4: build + lint + test (parallel)
- Phase 5: code-reviewer + security-reviewer (parallel)

### Results
- Files changed: [list]
- Key decisions: [list]
- Review findings: [summary]
- All findings addressed: Yes/No

### Verification
- Build: PASS/FAIL
- Lint: PASS/FAIL
- Tests: PASS/FAIL
```

## Rules
- You are the COORDINATOR. Delegate work, don't do everything yourself.
- ALWAYS spawn independent agents in a SINGLE message for parallel execution.
- ALWAYS include context from previous phases when delegating.
- ALWAYS run review phase - no exceptions.
- Use TaskCreate/TaskUpdate to track progress.
- If an agent's output is unsatisfactory, provide feedback and re-delegate.
