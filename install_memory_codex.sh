#!/bin/bash

# Install Codex CLI memory (CLAUDE.md as AGENTS.md) to ~/.codex/

set -e

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CODEX_HOME="$HOME/.codex"

mkdir -p "$CODEX_HOME"

# Copy CLAUDE.md from shared/ and rename to AGENTS.md (or instructions.md if preferred)
cp "$PROJECT_ROOT/shared/CLAUDE.md" "$CODEX_HOME/AGENTS.md"

echo "✓ Installed Codex CLI memory: $CODEX_HOME/AGENTS.md"
