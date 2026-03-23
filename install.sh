#!/bin/bash
set -e

# Claude Code Kit Installer
# Symlinks agents, commands, hooks into ~/.claude/

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
CLAUDE_DIR="$HOME/.claude"

echo "============================================"
echo "  Claude Code Kit - Installer"
echo "============================================"
echo ""

# Check prerequisites
for cmd in jq git; do
  if ! command -v "$cmd" &> /dev/null; then
    echo "ERROR: $cmd is required. Install it first."
    exit 1
  fi
done

# Backup existing config
if [ -d "$CLAUDE_DIR" ]; then
  BACKUP_DIR="$CLAUDE_DIR/backups/pre-kit-$(date +%Y%m%d-%H%M%S)"
  echo "[1/5] Backing up existing config to $BACKUP_DIR"
  mkdir -p "$BACKUP_DIR"
  for dir in agents commands hooks rules; do
    if [ -d "$CLAUDE_DIR/$dir" ] || [ -L "$CLAUDE_DIR/$dir" ]; then
      cp -rL "$CLAUDE_DIR/$dir" "$BACKUP_DIR/" 2>/dev/null || true
    fi
  done
else
  echo "[1/5] Creating ~/.claude/"
  mkdir -p "$CLAUDE_DIR"
fi

# Remove existing symlinks or directories
echo "[2/6] Preparing directories..."
for dir in agents commands hooks rules; do
  if [ -L "$CLAUDE_DIR/$dir" ]; then
    rm "$CLAUDE_DIR/$dir"
  elif [ -d "$CLAUDE_DIR/$dir" ]; then
    # Merge instead of replace - don't delete user's existing files
    echo "  Merging into existing $dir/"
  fi
done

# Create symlinks (or copy on WSL/Windows filesystem)
echo "[3/6] Installing components..."
for dir in agents commands hooks rules; do
  if [ -d "$CLAUDE_DIR/$dir" ]; then
    # Directory exists - copy files into it
    cp -r "$SCRIPT_DIR/$dir/"* "$CLAUDE_DIR/$dir/" 2>/dev/null || true
    echo "  ✓ Merged $dir/"
  else
    # Create symlink
    ln -sf "$SCRIPT_DIR/$dir" "$CLAUDE_DIR/$dir"
    echo "  ✓ Linked $dir/"
  fi
done

# Merge settings (don't overwrite existing)
echo "[4/6] Configuring settings..."
if [ -f "$CLAUDE_DIR/settings.json" ]; then
  echo "  settings.json exists - merging hooks and permissions..."
  # Merge using jq: keep existing settings, add new hooks/permissions
  MERGED=$(jq -s '.[0] * .[1]' "$CLAUDE_DIR/settings.json" "$SCRIPT_DIR/settings.json")
  echo "$MERGED" > "$CLAUDE_DIR/settings.json"
  echo "  ✓ Settings merged"
else
  cp "$SCRIPT_DIR/settings.json" "$CLAUDE_DIR/settings.json"
  echo "  ✓ Settings installed"
fi

# Make hooks executable
echo "[5/6] Setting permissions..."
chmod +x "$CLAUDE_DIR/hooks/"*.sh 2>/dev/null || true
echo "  ✓ Hooks are executable"

echo ""
echo "============================================"
echo "  Installation Complete!"
echo "============================================"
echo ""
echo "Installed:"
echo "  • $(ls "$CLAUDE_DIR/agents/"*.md 2>/dev/null | wc -l | tr -d ' ') agents"
echo "  • $(ls "$CLAUDE_DIR/commands/"*.md 2>/dev/null | wc -l | tr -d ' ') commands"
echo "  • $(find "$CLAUDE_DIR/commands" -name "SKILL.md" 2>/dev/null | wc -l | tr -d ' ') skills"
echo "  • $(ls "$CLAUDE_DIR/hooks/"*.sh 2>/dev/null | wc -l | tr -d ' ') hooks"
echo ""
echo "Quick start:"
echo "  /dev <task>     Full auto development pipeline"
echo "  /ship <task>    Implement + commit + PR"
echo "  /explore        Analyze project structure"
echo "  /plan <feature> Create implementation plan"
echo ""
echo "[6/6] Stitch MCP (optional - for UI design phase)..."
echo "  To enable AI design workflow, run:"
echo "    claude mcp add stitch \\"
echo "      --transport http \\"
echo "      --url \"https://stitch.googleapis.com/mcp\" \\"
echo "      --header \"X-Goog-Api-Key: YOUR_API_KEY\""
echo "  Get your API key at: https://stitch.withgoogle.com"
echo ""
echo "All commands: ls ~/.claude/commands/"
