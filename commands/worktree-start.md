Start a parallel work session using git worktree for: $ARGUMENTS

## Steps

1. Verify we're in a git repository
2. Create a descriptive branch name from the task description:
   - Use `feat/<name>` for new features
   - Use `fix/<name>` for bug fixes
   - Use `hotfix/<name>` for urgent production fixes
3. Base the worktree on `develop` (or `main` for hotfix):
   `git worktree add ../worktree-[name] -b feat/[name] develop`
4. Report the worktree path and branch name
5. Suggest next steps for working in the worktree

This allows parallel development without stashing or switching branches.
