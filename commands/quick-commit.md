Create a well-formatted git commit for the current staged/unstaged changes.

## Steps

1. Run `git status` and `git diff` to understand all changes
2. **Check current branch**:
   - If on `main`: WARN user ("main은 배포 전용입니다") and suggest creating a branch first
   - If on `develop`: STOP and suggest creating a feature branch first ("develop에 직접 커밋 대신 feature 브랜치를 생성하세요")
   - If on `feat/*`, `fix/*`, `hotfix/*`: proceed normally
3. Check `git log --oneline -5` for commit message style
4. Stage relevant files (avoid .env, credentials, large binaries)
5. Write a concise commit message:
   - Format: `type(scope): description`
   - Types: feat, fix, refactor, docs, test, chore, style, perf
   - Keep under 72 characters
6. Create the commit

Do NOT push. Just commit locally.
