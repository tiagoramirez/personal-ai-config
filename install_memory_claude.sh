#!/bin/bash

# Install Claude Code memory (CLAUDE.md) to ~/.claude/

set -e

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_HOME="$HOME/.claude"

mkdir -p "$CLAUDE_HOME"

# Copy CLAUDE.md from shared/
cp "$PROJECT_ROOT/shared/CLAUDE.md" "$CLAUDE_HOME/CLAUDE.md"

echo "✓ Installed Claude Code memory: $CLAUDE_HOME/CLAUDE.md"
