Orchestrate a complex task by breaking it into parallel subtasks: $ARGUMENTS

## Steps

1. Analyze the task and identify independent subtasks
2. For each subtask, determine the best agent type:
   - Architecture decisions → `architect` agent
   - Code changes → `build-fixer` or direct implementation
   - Reviews → `code-reviewer` or `security-reviewer`
   - Tests → `tdd-guide`
   - Documentation → `doc-updater`
3. Launch independent subtasks in parallel using the Agent tool
4. Collect and synthesize results
5. Handle any dependencies between subtasks sequentially
6. Present a unified summary

Maximize parallelism for speed. Use worktrees for independent code changes.
