# Personal AI Config

Unified setup for **Claude Code** and **Codex CLI** with shared skills and conventions.

## Quick Start

Copy and paste **[INSTALL.md](INSTALL.md)** into Claude Code or Codex CLI to install everything automatically.

## Project Structure

```
personal-ai-config/
├── shared/
│   ├── CLAUDE.md                   # Shared memory/conventions (for all tools)
│   └── skills/
│       ├── git.commit-message/
│       │   ├── SKILL.md
│       │   ├── evals/evals.json
│       │   └── test-fixtures/setup.sh
│       └── git.pr-description/
│           ├── SKILL.md
│           ├── evals/evals.json
│           └── scripts/extract_git_info.sh
│
├── install.sh                       # Master installer (both tools)
├── install_memory_claude.sh         # Claude Code memory installer
├── install_memory_codex.sh          # Codex CLI memory installer
├── INSTALL.md                       # Installation prompt
└── README.md                        # This file
```

## How It Works

1. **Shared source** — `shared/CLAUDE.md` and `shared/skills/` contain the single source of truth
2. **Claude Code** — Gets `CLAUDE.md` copied to `~/.claude/CLAUDE.md` + skills copied to `~/.claude/skills/`
3. **Codex CLI** — Gets `CLAUDE.md` copied to `~/.codex/AGENTS.md` + skills copied to `~/.codex/skills/`
4. **Maintenance** — Keep originals in `shared/`, run `install.sh` to sync both tools

## Installation

### Automated (Recommended)

Paste [INSTALL.md](INSTALL.md) into Claude Code or Codex CLI. The agent will:
1. Run `install.sh` to copy CLAUDE.md and skills to both tools
2. Configure Claude Code (status-line, MCPs, OS placeholder)
3. Configure Codex CLI

### Manual

```bash
chmod +x install.sh && ./install.sh
```

Then configure Claude Code:
- Fill OS placeholder in `~/.claude/CLAUDE.md`
- Status-line: `user@host | Context:<%>% | Cost:$<USD>`
- Playwright MCP (optional)

## Skills

### git.commit-message
Analyzes git changes and suggests conventional commit messages. Supports feat, fix, docs, refactor, test, chore, style, perf.

- **Claude Code**: `/git.commit-message`
- **Codex CLI**: Ask "help me with commit messages"

### git.pr-description
Intelligently fills PR templates with change analysis, auto-detects issues, suggests tests.

- **Claude Code**: `/git.pr-description`
- **Codex CLI**: Ask "create a PR description"

## Conventions

All conventions are in `shared/CLAUDE.md`:
- Code style & comments
- Error handling & logging
- Diagrams (Mermaid only)
- Tests (100% coverage on business logic)
- Documentation standards
- Git workflow
- Plan mode guidelines

## For More Information

- See `shared/CLAUDE.md` for full conventions
- See `shared/skills/*/SKILL.md` for skill details
