#!/bin/bash

# Master installation script for Claude Code and Codex CLI
# Installs shared skills and memory for both tools

set -e

echo "=========================================="
echo "Multi-Tool AI Config Installer"
echo "=========================================="
echo ""

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SHARED_SKILLS="$PROJECT_ROOT/shared/skills"

# ============================================
# 1. Claude Code Setup
# ============================================
echo "🔧 Setting up Claude Code..."

CLAUDE_HOME="$HOME/.claude"
CLAUDE_SKILLS="$CLAUDE_HOME/skills"

mkdir -p "$CLAUDE_SKILLS"

# Copy shared skills to Claude
cp -r "$SHARED_SKILLS"/* "$CLAUDE_SKILLS/"
echo "✓ Copied skills to $CLAUDE_SKILLS/"

# Install Claude memory
"$PROJECT_ROOT/install_memory_claude.sh"

echo ""

# ============================================
# 2. Codex CLI Setup
# ============================================
echo "🔧 Setting up Codex CLI..."

CODEX_HOME="$HOME/.codex"
CODEX_SKILLS="$CODEX_HOME/skills"

mkdir -p "$CODEX_SKILLS"

# Copy shared skills to Codex
cp -r "$SHARED_SKILLS"/* "$CODEX_SKILLS/"
echo "✓ Copied skills to $CODEX_SKILLS/"

# Install Codex memory
"$PROJECT_ROOT/install_memory_codex.sh"

echo ""

# ============================================
# 3. Summary
# ============================================
echo "=========================================="
echo "✅ Installation Complete!"
echo "=========================================="
echo ""
echo "📦 Installed:"
echo "  • Claude Code: $CLAUDE_HOME"
echo "    - CLAUDE.md → global memory"
echo "    - Skills → $CLAUDE_SKILLS (copied)"
echo ""
echo "  • Codex CLI: $CODEX_HOME"
echo "    - AGENTS.md → global memory (copied from CLAUDE.md)"
echo "    - Skills → $CODEX_SKILLS (copied)"
echo ""
echo "📚 Shared Source:"
echo "  • Memory: $PROJECT_ROOT/shared/CLAUDE.md"
echo "  • Skills: $SHARED_SKILLS"
echo ""
echo "🚀 Next Steps:"
echo "  1. Reload your shell or restart Claude Code / Codex CLI"
echo "  2. Test: /git.commit-message (Claude) or ask 'help with commits' (Codex)"
echo ""
