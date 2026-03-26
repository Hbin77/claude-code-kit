#!/bin/bash
# Reminds about quality checks after code edits
# Trigger: PostToolUse (Edit, Write)

INPUT=$(cat)
TOOL=$(echo "$INPUT" | jq -r '.tool_name // empty')
FILE=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')

if [ -z "$FILE" ]; then
  exit 0
fi

# Debounce: suppress if reminded within last 30 seconds
DEBOUNCE_FILE="/tmp/.claude-quality-reminder-last"
if [ -f "$DEBOUNCE_FILE" ]; then
  LAST=$(cat "$DEBOUNCE_FILE")
  NOW=$(date +%s)
  if [ $((NOW - LAST)) -lt 30 ]; then
    exit 0
  fi
fi

# Check if it's a source code file
if echo "$FILE" | grep -qE '\.(ts|tsx|js|jsx|py|go|rs|java|rb)$'; then
  EXT="${FILE##*.}"
  case "$EXT" in
    ts|tsx|js|jsx)
      echo "Reminder: Consider running type-check and lint after changes."
      ;;
    py)
      echo "Reminder: Consider running mypy/ruff after changes."
      ;;
    go)
      echo "Reminder: Consider running go vet/golint after changes."
      ;;
    rs)
      echo "Reminder: Consider running cargo check/clippy after changes."
      ;;
    java)
      echo "Reminder: Consider running build/checkstyle after changes."
      ;;
    rb)
      echo "Reminder: Consider running rubocop after changes."
      ;;
  esac
  date +%s > "$DEBOUNCE_FILE"
fi
