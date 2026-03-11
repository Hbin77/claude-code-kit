Orchestrate a complex task by decomposing it into parallel subtasks: $ARGUMENTS

## Process

### Step 1: Decompose
Analyze the task and classify each subtask:

| Type | Agent | Can Parallelize? |
|------|-------|-------------------|
| Architecture analysis | `architect` | Yes (read-only) |
| Implementation (independent files) | direct or `build-fixer` | Yes (use worktree isolation) |
| Implementation (dependent files) | direct | No (sequential) |
| Code review | `code-reviewer` | Yes (read-only) |
| Security review | `security-reviewer` | Yes (read-only) |
| Test writing | `tdd-guide` | Yes (per module) |
| Documentation | `doc-updater` | Yes (independent) |

### Step 2: Build Execution Graph

```
Independent tasks (parallel)     Dependent tasks (sequential)
┌──────────┐ ┌──────────┐      ┌──────────┐
│ Agent A  │ │ Agent B  │      │ Step 1   │
└────┬─────┘ └────┬─────┘      └────┬─────┘
     │             │                 │
     └──────┬──────┘                 ▼
            │                  ┌──────────┐
            ▼                  │ Step 2   │
     ┌──────────┐              └────┬─────┘
     │  Merge   │                   │
     └──────────┘                   ▼
```

### Step 3: Execute with Maximum Parallelism

**CRITICAL**: Use a SINGLE message with MULTIPLE Agent tool calls for independent tasks.

Example - 3 independent subtasks:
```
Message 1 (parallel):
  - Agent(architect): "Analyze auth module architecture"
  - Agent(tdd-guide): "Write tests for user service"
  - Agent(doc-updater): "Update API documentation"
```

For code changes to different files, use `isolation: "worktree"` to prevent conflicts:
```
Message 1 (parallel with worktree isolation):
  - Agent(isolation: "worktree"): "Implement user authentication"
  - Agent(isolation: "worktree"): "Implement email notification service"
```

### Step 4: Merge & Verify
1. Collect all agent results
2. If worktrees were used, review and merge changes
3. Run verification (build + test + lint) in parallel
4. Fix any integration issues

### Step 5: Parallel Review
Launch simultaneously:
- **code-reviewer agent**: Review all changes
- **security-reviewer agent**: Security audit

### Step 6: Report
- Subtasks completed (with which agent)
- Parallel vs sequential execution breakdown
- Time saved by parallelism
- Any integration issues resolved
- Final verification status

## Rules
- ALWAYS launch independent agents in a SINGLE message (this is what makes them parallel)
- Use `isolation: "worktree"` for parallel code modifications to avoid conflicts
- Read-only agents (architect, code-reviewer, security-reviewer) are always safe to parallelize
- Write agents on the SAME files must be sequential
- After parallel execution, always verify integration
