Fix all build errors in the current project.

## Steps

1. Detect the build system (npm, yarn, pnpm, cargo, go, etc.)
2. Run the build command
3. Launch the `build-fixer` agent to parse and fix errors
4. Fix root causes first, then cascading errors
5. Re-run build to verify all errors are resolved
6. Report what was changed

Make minimal, surgical changes. Do not refactor or "improve" code during the fix.
