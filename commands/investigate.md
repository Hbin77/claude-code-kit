Systematically investigate and diagnose a bug or issue using structured root cause analysis.

Issue: $ARGUMENTS

## Pipeline

### Phase 1: Gather Evidence (PARALLEL)

Launch simultaneously:
- **Search 1**: Grep for error messages, stack traces, related keywords in codebase
- **Search 2**: Check recent git history for related changes (`git log --oneline -20`, `git diff HEAD~5`)
- **Search 3**: Read log files, error outputs, or console messages if provided

### Phase 2: Reproduce

1. Identify the reproduction path from gathered evidence
2. If it's a runtime error:
   - Find the entry point (test, script, URL)
   - Run it and capture the full error output
3. If it's a build error:
   - Run the build and capture output
4. If it's a logic error:
   - Write a minimal failing test that demonstrates the bug
5. Document: **Expected behavior** vs **Actual behavior**

### Phase 3: Root Cause Analysis

Apply the **5 Whys** technique:
```
Why did [symptom] happen?
  → Because [cause 1]
    → Why? Because [cause 2]
      → Why? Because [cause 3]
        → Why? Because [cause 4]
          → Why? Because [root cause]
```

Identify:
- **Root cause**: The fundamental reason the bug exists
- **Contributing factors**: Things that made it worse or harder to detect
- **Blast radius**: What else might be affected by the same root cause

### Phase 4: Fix

1. Implement the fix targeting the root cause (not symptoms)
2. If the fix touches multiple files, apply in dependency order
3. Run the reproduction from Phase 2 → verify it passes
4. Run full test suite → verify no regressions

### Phase 5: Prevent

1. If no test existed for this case, write one
2. Check if similar patterns exist elsewhere: `grep -rn "similar_pattern"`
3. If systemic, suggest a lint rule or architectural change

### Phase 6: Report

```
## Investigation Report

### Issue
[one-line description]

### Reproduction
[steps to reproduce]

### Root Cause
[5 Whys analysis result]

### Fix Applied
- [file:line] — [what changed and why]

### Tests Added
- [test file] — [what it covers]

### Prevention
- [recommendations to prevent recurrence]
```

## Rules
- NEVER guess. Every conclusion must be backed by evidence (log output, grep result, test failure)
- Reproduce FIRST, then diagnose. No fix without reproduction.
- Fix the root cause, not the symptom
- Always add a test that would have caught this bug
- If you can't reproduce, say so clearly and list what you tried
