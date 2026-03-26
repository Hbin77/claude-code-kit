Autonomously complete the given task with full verification: $ARGUMENTS

> **When to use**: Simple to medium tasks where you want fast, direct execution without agent delegation.
> For complex multi-file tasks with parallel agents, use `/dev` instead.

## Steps

1. Analyze the task and create a mental plan
2. Explore relevant code to understand context
3. Implement the changes
4. Run build to verify no errors
5. Run tests to verify no regressions
6. Run lint to verify code quality
7. Self-review the changes (check for security issues, edge cases)
8. If any verification fails, fix and re-verify
9. Summarize what was done and what was changed

Work autonomously but verify thoroughly. Ask only if genuinely ambiguous.
