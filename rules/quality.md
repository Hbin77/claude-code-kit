# Code Quality Standards

## Before Writing Code
- Read existing code in the target files first
- Follow existing patterns and conventions in the project
- Don't assume - verify with Grep/Glob

## While Writing Code
- Minimal changes: only modify what's needed
- No over-engineering: don't add features that weren't asked for
- No dead code: don't leave commented-out code or unused imports
- Security first: validate inputs, no hardcoded secrets, parameterized queries

## After Writing Code
- Run build to verify no errors
- Run tests if they exist
- For changes touching 5+ files, spawn a review agent

## Never
- Skip verification after changes
- Add `as any` or `// @ts-ignore` to fix type errors
- Commit .env files or secrets
- Force push to main/master
