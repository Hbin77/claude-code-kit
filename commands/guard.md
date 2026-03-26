Activate safety guard mode. Restricts editing scope and adds extra confirmation for destructive operations.

Scope: $ARGUMENTS

## Modes

### Mode 1: Freeze (edit scope restriction)
When $ARGUMENTS contains a path or file pattern:
- ONLY files matching the specified scope can be edited
- All other files are READ-ONLY for this session
- Before every Edit/Write, verify the target file is within scope
- If out of scope: warn and ask for explicit confirmation

Example: `/guard src/auth/` → only files in `src/auth/` can be modified

### Mode 2: Careful (destructive operation warnings)
When $ARGUMENTS is empty or contains "careful":
- Before any destructive Bash command, print a warning and ask confirmation:
  - `rm`, `git reset`, `git checkout .`, `git clean`
  - `DROP`, `TRUNCATE`, `DELETE FROM`
  - `docker rm`, `docker system prune`
  - Any command modifying files outside the project directory
- Before large-scale edits (touching 5+ files), show a summary first
- Before any git push, show what will be pushed

### Mode 3: Full Guard (freeze + careful combined)
When $ARGUMENTS contains both a path and "careful":
- Apply both freeze scope and careful mode

## Activation

Print confirmation:
```
🛡️ Guard Mode Activated
├─ Scope: [restricted path or "all files"]
├─ Mode: [freeze / careful / full]
└─ To deactivate: tell me "guard off"
```

## During Session

Before every Edit/Write/Bash operation, check:
1. **Freeze check**: Is the target file within the allowed scope?
2. **Careful check**: Is this a destructive or large-scale operation?
3. If either fails → warn + ask confirmation before proceeding

## Deactivation

When the user says "guard off" or "가드 해제":
```
🛡️ Guard Mode Deactivated
└─ All restrictions removed
```

## Rules
- Guard mode is advisory — the user can always override with explicit confirmation
- Don't be annoying — only warn on genuinely risky operations, not every file edit
- Always show what you're about to do when asking for confirmation
- Keep track of which files have been modified during guard mode for the deactivation summary
