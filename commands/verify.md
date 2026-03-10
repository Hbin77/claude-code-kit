Verify the current project builds, passes tests, and has no lint errors.

## Steps

1. Detect project type and available scripts (package.json scripts, Makefile, etc.)
2. Run in order:
   a. Install dependencies if needed
   b. Lint check
   c. Type check (if TypeScript/typed language)
   d. Build
   e. Test
3. Report results for each step
4. If any step fails, provide the error details and suggest fixes

This is a read-only verification - do NOT fix anything automatically.
