Perform a thorough code review on the current changes or specified files: $ARGUMENTS

## Steps

1. If no files specified, run `git diff` to see current changes
2. Launch the `code-reviewer` agent to analyze the changes
3. Check for: security issues, code quality, performance, maintainability
4. Provide findings with severity levels (CRITICAL, WARNING, INFO, NITPICK)
5. Give an overall assessment: APPROVE or REQUEST_CHANGES

Focus on actionable feedback. Don't nitpick formatting if a formatter is configured.
