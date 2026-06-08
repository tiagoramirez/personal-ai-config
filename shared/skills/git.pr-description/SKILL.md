---
name: git.pr-description
description: Intelligently fill PR descriptions with git changes. Use when you've finished a feature and want to create/complete a PR description. Automatically detects issue numbers (JIRA-X, TASK-X, PEPE-X, custom prefixes), suggests test cases with curl examples, and handles any template format (checkboxes, placeholders, dynamic URLs). Always targets develop branch. Asks whether to create PR automatically or save locally.
compatibility: Requires git and gh CLI (for pushing)
---

# PR Description Skill

Fill PR templates efficiently by analyzing your git changes and intelligently populating the template.

## Workflow

When you invoke this skill after completing a feature:

1. **Validate branch** — Check you're on `feature/*` (create from develop if needed)
2. **Find template** — Search for PR template in common locations
3. **Analyze changes** — Extract git diff, commits, and categorize files
4. **Fill template** — Intelligently populate template with your changes
5. **Suggest tests** — Offer test case templates (new/regression/both)
6. **Deploy** — Push to GitHub or save locally

## How Claude Does It

The skill works by having Claude:

- Read your PR template (any format: placeholders, checkboxes, plain text)
- Understand what fields need filling based on content analysis
- Run minimal bash script to get git info:
  ```bash
  git diff develop..HEAD --stat
  git diff develop..HEAD --name-status
  git log develop..HEAD --oneline
  ```
- Analyze output and intelligently fill the template
- Detect issue patterns from branch name + commits (JIRA-123, TASK-X, PEPE-Y, etc)
- Auto-fill issue links if template has them
- Suggest test cases with curl examples
- Ask: push to GitHub or save locally?

## Why This Approach

- **Flexible**: Works with ANY template format (placeholders, checkboxes, plain text)
- **Semantic**: Claude understands context, not just regex patterns
- **Token-efficient**: Scripts only extract data, Claude only processes
- **Adaptive**: Handles custom issue prefixes, dynamic URLs, variable formats

## Example

```
You: "Done with TASK-456 auth feature, create the PR"

Claude:
1. Validates: feature/auth-refactor branch ✓
2. Finds: .github/pull_request_template.md
3. Analyzes: 8 files modified (src/auth/, tests/, docs/)
4. Fills template:
   - Description: "Added JWT authentication..."
   - [TASK-456](jira.com/browse/TASK-456) auto-linked
   - Type: marked ✓ New feature
   - Architecture: marked ✓ Follows hexagonal pattern
   - Tests: marked ✓ Added unit + integration tests
5. Suggests: "New test case" + "Regression test" templates
6. Asks: Push or save?
7. Creates PR → https://github.com/org/repo/pull/456
```

## Template Support

Works with any template format:

- ✅ Placeholder syntax: `{{JIRA}}`, `[ISSUE]`
- ✅ Dynamic URLs: `(www.jira.com/TASK-X)` → `(www.jira.com/TASK-123)`
- ✅ Checkboxes: `[ ] New feature` → detects type and marks
- ✅ Plain text: `Add issue here →` → inserts intelligently
- ✅ Custom prefixes: JIRA-X, TASK-X, PEPE-X, CUSTOM-X—all detected
- ✅ Multiple issue formats: `#123`, `JIRA-456`, `TASK-789` in same PR

## Branch Handling

- If on `develop` or `master`: Creates `feature/name` from develop
- If on other branch: Errors with instructions to switch
- If on `feature/*`: Proceeds with that branch
- Target branch is always `develop`

## Test Case Format

When suggesting tests, offers collapsible templates:

```html
<details>
<summary>New Test Case</summary>

**Request:**
curl -X POST ...

**Response:**
```json
...
```

**Expected:** ...

</details>
```

Each suggestion is optional—you can skip, edit, or keep as-is before publishing.
