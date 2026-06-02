Install the following globally for claude (~/.claude):

# 1. Memory (CLAUDE.md)
Install CLAUDE.md with system context.
Ask current OS [Windows | Linux | Mac] and fill {{OS}}

# 2. Skills
Run @install_skills.sh
→ Fallback: ask user for file if not found

# 3. MCPs
Install:
- Playwright:
```
{
  "mcpServers": {
    "playwright": {
      "command": "npx",
      "args": [
        "@playwright/mcp@latest"
      ]
    }
  }
}
```

# 4. Status-line
Format: `<user>@<host> | Context:<%%>% | Cost:$<USD>`

Colors:
- user@host: cyan
- Context: yellow (red if >70%)
- Cost: green (red if >$5.00)

Include sub-agent costs in total.