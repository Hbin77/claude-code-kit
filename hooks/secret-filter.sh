#!/bin/bash
# Masks secrets in tool output
# Trigger: PostToolUse

INPUT=$(cat)
OUTPUT=$(echo "$INPUT" | jq -r '.tool_output // empty')

if [ -z "$OUTPUT" ]; then
  exit 0
fi

# Check for common secret patterns
if echo "$OUTPUT" | grep -qiE '(api[_-]?key|secret[_-]?key|password|token|bearer)\s*[:=]\s*["\x27]?[A-Za-z0-9+/=_-]{16,}'; then
  echo "WARNING: Potential secret detected in output. Review carefully before sharing."
fi
