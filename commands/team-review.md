You are the Team Lead. Coordinate a thorough multi-perspective review of the current changes.

Scope: $ARGUMENTS

## Execution Protocol

### Step 1: Gather Changes
Run `git diff` and `git status` to identify all changes.
List all modified/created files.

### Step 2: Parallel Review Team (ONE message, ALL agents simultaneously)

**Agent A** - Code Reviewer:
"Review these changes for code quality, maintainability, and performance.
Files: [list all changed files with brief description].
Check against: single responsibility, naming conventions, error handling, N+1 queries.
Output: findings as [SEVERITY] file:line - description + suggestion."

**Agent B** - Security Reviewer:
"Security audit these changes.
Files: [list all changed files].
Check: OWASP Top 10, hardcoded secrets, injection, XSS, auth bypass.
Output: findings as [SEVERITY] file:line - description + remediation."

**Agent C** - Architect:
"Review these changes for architectural consistency.
Files: [list all changed files].
Check: Does this follow existing patterns? Are there better approaches? Any scaling concerns?
Output: architectural assessment + recommendations."

→ All three run in parallel.

### Step 3: Synthesize
Combine all three reviews into a unified report:

```
## Team Review Report

### Summary
- Total findings: [N]
- Critical: [N] | Warning: [N] | Info: [N]

### Critical (must fix)
[Combined critical findings from all reviewers]

### Warnings (should fix)
[Combined warnings]

### Suggestions (nice to have)
[Combined info/suggestions]

### Architecture Notes
[Architect's assessment]

### Overall Verdict
APPROVE / REQUEST_CHANGES / NEEDS_DISCUSSION
```

### Step 4: Auto-Fix (if requested)
If the user wants fixes applied:
- Fix all CRITICAL findings
- Fix all WARNING findings
- Re-run verification (build + test + lint)
- Re-run quick review to confirm fixes

## Rules
- ALWAYS spawn all 3 reviewers in parallel (ONE message)
- Include full file context when delegating
- Synthesize - don't just concatenate agent outputs
- Make the final APPROVE/REQUEST_CHANGES decision yourself as Team Lead
