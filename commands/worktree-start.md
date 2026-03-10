Start a parallel work session using git worktree for: $ARGUMENTS

## Steps

1. Verify we're in a git repository
2. Create a descriptive branch name from the task description
3. Create a git worktree: `git worktree add ../worktree-[name] -b [branch-name]`
4. Report the worktree path and branch name
5. Suggest next steps for working in the worktree

This allows parallel development without stashing or switching branches.
