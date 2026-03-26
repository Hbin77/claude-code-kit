#!/bin/bash
set -e

# Claude Code Kit Uninstaller
# Removes kit-installed files from ~/.claude/ and restores backup if available

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
CLAUDE_DIR="$HOME/.claude"

echo "============================================"
echo "  Claude Code Kit - Uninstaller"
echo "============================================"
echo ""

if [ ! -d "$CLAUDE_DIR" ]; then
  echo "~/.claude/ not found. Nothing to uninstall."
  exit 0
fi

# Collect kit file names for targeted removal
echo "[1/4] Removing kit agents..."
for f in "$SCRIPT_DIR/agents/"*.md; do
  fname=$(basename "$f")
  target="$CLAUDE_DIR/agents/$fname"
  if [ -f "$target" ]; then
    rm "$target"
    echo "  ✗ agents/$fname"
  fi
done

echo "[2/4] Removing kit commands & skills..."
for f in "$SCRIPT_DIR/commands/"*.md; do
  fname=$(basename "$f")
  target="$CLAUDE_DIR/commands/$fname"
  if [ -f "$target" ]; then
    rm "$target"
    echo "  ✗ commands/$fname"
  fi
done
# Remove skill directories
for d in "$SCRIPT_DIR/commands/"*/; do
  [ -d "$d" ] || continue
  dname=$(basename "$d")
  target="$CLAUDE_DIR/commands/$dname"
  if [ -d "$target" ]; then
    rm -rf "$target"
    echo "  ✗ commands/$dname/"
  fi
done

echo "[3/4] Removing kit hooks..."
for f in "$SCRIPT_DIR/hooks/"*.sh; do
  fname=$(basename "$f")
  target="$CLAUDE_DIR/hooks/$fname"
  if [ -f "$target" ]; then
    rm "$target"
    echo "  ✗ hooks/$fname"
  fi
done

echo "[4/4] Removing kit rules..."
for f in "$SCRIPT_DIR/rules/"*.md; do
  fname=$(basename "$f")
  target="$CLAUDE_DIR/rules/$fname"
  if [ -f "$target" ]; then
    rm "$target"
    echo "  ✗ rules/$fname"
  fi
done

# Check for backup to restore
LATEST_BACKUP=$(ls -dt "$CLAUDE_DIR/backups/pre-kit-"* 2>/dev/null | head -1)
if [ -n "$LATEST_BACKUP" ]; then
  echo ""
  read -p "Restore backup from $LATEST_BACKUP? (y/N) " -n 1 -r
  echo ""
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    for dir in agents commands hooks rules; do
      if [ -d "$LATEST_BACKUP/$dir" ]; then
        mkdir -p "$CLAUDE_DIR/$dir"
        cp -r "$LATEST_BACKUP/$dir/"* "$CLAUDE_DIR/$dir/" 2>/dev/null || true
        echo "  ✓ Restored $dir/"
      fi
    done
    echo "  Backup restored."
  fi
fi

# Clean up empty directories
for dir in agents commands hooks rules; do
  if [ -d "$CLAUDE_DIR/$dir" ] && [ -z "$(ls -A "$CLAUDE_DIR/$dir" 2>/dev/null)" ]; then
    rmdir "$CLAUDE_DIR/$dir"
  fi
done

# Restore settings.json from backup if available
if [ -n "$LATEST_BACKUP" ] && [ -f "$LATEST_BACKUP/settings.json" ]; then
  read -p "Restore settings.json from backup? (y/N) " -n 1 -r
  echo ""
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    cp "$LATEST_BACKUP/settings.json" "$CLAUDE_DIR/settings.json"
    echo "  ✓ settings.json restored from backup"
  else
    echo "  settings.json left as-is (manually edit if needed)"
  fi
else
  echo "Note: settings.json was not reverted (no backup found)."
  echo "  To reset, manually edit ~/.claude/settings.json"
fi

echo ""
echo "============================================"
echo "  Uninstall Complete!"
echo "============================================"
