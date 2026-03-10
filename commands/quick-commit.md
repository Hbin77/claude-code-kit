Create a well-formatted git commit for the current staged/unstaged changes.

## Steps

1. Run `git status` and `git diff` to understand all changes
2. Check `git log --oneline -5` for commit message style
3. Stage relevant files (avoid .env, credentials, large binaries)
4. Write a concise commit message:
   - Format: `type(scope): description`
   - Types: feat, fix, refactor, docs, test, chore, style, perf
   - Keep under 72 characters
5. Create the commit

Do NOT push. Just commit locally.
