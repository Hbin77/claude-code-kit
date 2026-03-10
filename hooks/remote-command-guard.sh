#!/bin/bash
# Blocks dangerous bash commands before execution
# Trigger: PreToolUse (Bash)

INPUT=$(cat)
COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command // empty')

if [ -z "$COMMAND" ]; then
  echo '{"decision":"allow"}'
  exit 0
fi

# Dangerous patterns
BLOCKED_PATTERNS=(
  "rm -rf /"
  "rm -rf ~"
  "rm -rf \*"
  ":(){ :|:& };:"
  "mkfs\."
  "dd if=/dev"
  "> /dev/sd"
  "chmod -R 777 /"
  "curl .+\| *bash"
  "curl .+\| *sh -"
  "wget .+\| *bash"
  "wget .+\| *sh -"
  "git push.*--force.*main"
  "git push.*--force.*master"
  "git reset --hard.*origin"
  "npm publish"
  "DROP DATABASE"
  "DROP TABLE"
  "TRUNCATE"
  "DELETE FROM.*WHERE 1"
  "eval("
)

for pattern in "${BLOCKED_PATTERNS[@]}"; do
  if echo "$COMMAND" | grep -qiE "$pattern"; then
    echo "{\"decision\":\"block\",\"reason\":\"Blocked dangerous command matching pattern: $pattern\"}"
    exit 0
  fi
done

echo '{"decision":"allow"}'
