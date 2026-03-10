Create a commit, push, and open a pull request for the current changes.

## Steps

1. Review all changes with `git diff` and `git status`
2. Stage relevant files (exclude secrets, large files)
3. Create a well-formatted commit message (type(scope): description)
4. Push to remote with `-u` flag
5. Create a PR using `gh pr create` with:
   - Clear title (under 70 chars)
   - Summary of changes
   - Test plan checklist
6. Return the PR URL

Title/description hint: $ARGUMENTS
