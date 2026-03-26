Execute a safe, systematic refactoring workflow on the target scope.

Task: $ARGUMENTS

## Pipeline

### Phase 1: Analysis (PARALLEL)

Spawn in ONE message:
- `refactor-analyst` agent: detect code smells and produce analysis report
- `architect` agent: analyze module dependencies and coupling

Synthesize both reports into a unified findings list.

### Phase 2: Refactoring Plan

Present findings to user with severity ratings.
Create a **safe refactoring order** based on:
1. Dependency direction (leaf modules first, core modules last)
2. Test coverage (well-tested code first, untested code needs tests first)
3. Risk level (pure functions → utilities → business logic → public API)

Each refactoring step must specify:
- Target file(s)
- Smell being addressed
- Refactoring pattern to apply (Extract Method, Move Function, Replace Conditional with Polymorphism, etc.)
- Expected behavior: MUST remain identical (no feature changes)

**Wait for user approval before proceeding.**

### Phase 3: Test Baseline

Before any code changes:
1. Run full test suite → record baseline pass count
2. If no tests exist for target code, write characterization tests first
3. Store baseline: `build PASS | lint PASS | test X/Y PASS`

### Phase 4: Refactoring Execution

For each approved refactoring step:
1. Apply ONE refactoring pattern at a time
2. Run build + lint + test immediately after
3. If tests fail → revert and report
4. If tests pass → proceed to next step
5. Create atomic commits per step (descriptive message: `refactor(scope): pattern applied`)

**Execution strategy by task size:**
- 1-3 findings: execute sequentially
- 4+ findings on independent modules: parallel agents with `isolation: "worktree"`
- Dependent modules: strictly sequential (leaf → root order)

### Phase 5: Verification (PARALLEL)

Run in ONE message:
- Full build
- Full lint
- Full test suite
- Compare test count: baseline vs current (must be equal or greater)

If any step fails, spawn `build-fixer` agent.

### Phase 6: Review

Spawn `code-reviewer` agent with explicit instruction:
> "Review this refactoring. Verify: (1) no behavior changes, (2) improved structure, (3) no regressions."

### Phase 7: Report

```
## Refactoring Report

### Before → After
| Metric | Before | After |
|--------|--------|-------|
| Files changed | | |
| Lines removed | | |
| Lines added | | |
| Avg function length | | |
| Max nesting depth | | |
| Test count | | |

### Applied Refactorings
| # | Pattern | Target | Result |
|---|---------|--------|--------|

### Smells Resolved
- [x] [Smell 1]
- [x] [Smell 2]

### Remaining (deferred)
- [ ] [Smell N] — reason deferred

### Verification
Build: PASS | Lint: PASS | Tests: X/Y PASS
```

## Rules

- NEVER change behavior. Refactoring = same behavior, better structure.
- ONE pattern per commit. Easy to revert if something breaks.
- TEST FIRST. No refactoring without a green test baseline.
- If a refactoring breaks tests, revert immediately — don't fix forward.
- Don't refactor code you don't understand. Read it first.
- Preserve public API unless user explicitly approves breaking changes.
- Track progress with TaskCreate/TaskUpdate for 4+ step refactorings.
