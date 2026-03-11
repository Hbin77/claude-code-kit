# Default Development Workflow

When the user asks you to implement, build, fix, or develop anything (not just simple questions or file reads), follow this workflow automatically.

## Task Classification

Before starting, classify the task:

| Scale | Criteria | Approach |
|-------|----------|----------|
| **Trivial** | 1 file, < 20 lines change | Do it directly. No agents needed. |
| **Small** | 2-3 files, single concern | Do it yourself with verify step. |
| **Medium** | 3-5 files, needs planning | Delegate: planner → implement → reviewer |
| **Large** | 5+ files, multiple concerns | Full team: architect + planner → parallel implement → parallel review |

## Trivial / Small Tasks
Just do it. Run build/test after. No ceremony needed.

## Medium Tasks (3-5 files)

1. **Plan**: Spawn `planner` agent to break down the task
2. **Implement**: Write code following the plan
3. **Verify**: Run build + lint + test
4. **Review**: Spawn `code-reviewer` agent to check your work
5. Fix any CRITICAL/WARNING findings

## Large Tasks (5+ files)

### Phase 1: Analysis (PARALLEL)
Spawn in ONE message:
- `architect` agent: analyze affected areas
- `planner` agent: create implementation plan

### Phase 2: Implement
- Independent components → parallel agents with `isolation: "worktree"`
- Dependent components → sequential (types → logic → UI)

### Phase 3: Verify (PARALLEL)
Run in ONE message: build + lint + test

### Phase 4: Review (PARALLEL)
Spawn in ONE message:
- `code-reviewer` agent
- `security-reviewer` agent

Address CRITICAL/WARNING findings, then re-verify.

## Always

- **Parallelize independent work**: Use multiple Agent/Bash calls in a single message
- **Verify after changes**: Build + test at minimum
- **Review large changes**: Spawn reviewer agent(s) for 5+ file changes
- **Track complex work**: Use TaskCreate/TaskUpdate for large tasks
- **Use worktree isolation**: When parallel agents modify different files
