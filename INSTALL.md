# 🚀 Install Multi-Tool AI Config

Hi! I need you to install my personal AI config for both Claude Code and Codex CLI with shared memory and skills.

## Installation Steps

1. **Run the master installer script**:
   ```bash
   chmod +x install.sh && ./install.sh
   ```
   
   This will:
   - Copy CLAUDE.md to `~/.claude/CLAUDE.md` (Claude Code memory)
   - Copy CLAUDE.md to `~/.codex/AGENTS.md` (Codex CLI memory)
   - Copy all skills to both tools

2. **Configure Claude Code** (do these interactively):
   - Ask for my OS (Windows/Linux/Mac) and fill the `{{OS}}` placeholder in `~/.claude/CLAUDE.md`
   - Set up status-line format: `<user>@<host> | Context:<%>% | Cost:$<USD>`
     - Colors: user@host (cyan), Context (yellow, red if >70%), Cost (green, red if >$5)

3. **Reload the environment** (restart terminal/IDE for Codex)

## What Gets Installed

Both tools will have:
- **Memory** (shared across tools):
  - Claude Code: `~/.claude/CLAUDE.md` (copied from `shared/CLAUDE.md`)
  - Codex CLI: `~/.codex/AGENTS.md` (copied from `shared/CLAUDE.md`)
  
- **Skills** (copied to each tool):
  - `~/.claude/skills/git.commit-message/` and `git.pr-description/`
  - `~/.codex/skills/git.commit-message/` and `git.pr-description/`

## After Installation

Test both tools:
- **Claude Code**: Type `/git.commit-message` 
- **Codex CLI**: Ask "help me with commit messages"

Both should have access to the same skills and conventions.