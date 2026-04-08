Create a commit, push, and open a pull request for the current changes.

## Steps

1. Review all changes with `git diff` and `git status`
2. **Check current branch**:
   - If on `main` or `develop`: STOP. Create a feature branch first (`feat/<name>` or `fix/<name>` based on changes)
   - If on `feat/*`, `fix/*`, `hotfix/*`: proceed
3. Stage relevant files (exclude secrets, large files)
4. Create a well-formatted commit message (type(scope): description)
5. Push to remote with `-u` flag
6. Determine PR target:
   - `hotfix/*` branch → PR to `main` AND remind to create a second PR to `develop`
   - All other branches → PR to `develop`
7. Create a PR using `gh pr create --base <target>` with:
   - Clear title (under 70 chars)
   - Summary of changes
   - Test plan checklist
8. Return the PR URL

Title/description hint: $ARGUMENTS
