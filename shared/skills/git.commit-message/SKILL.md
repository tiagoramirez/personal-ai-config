---
name: git.commit-message
description: Analyze git changes and suggest commit messages in conventional format. Use this skill whenever you need commit messages—any time the user mentions commits, commit messages, organizing changes, staging, pushing branches, or preparing to merge. Especially use this when the user has mixed changes (code + docs + tests) and needs help splitting them logically. Compares current branch against develop, analyzes diffs, suggests conventionally-formatted commits (feat, fix, docs, test, chore, refactor, style, perf), and for multi-type changes automatically groups related files and asks user confirmation before suggesting individual commits. Perfect for cleanup before pushing, ensuring semantic git history, preventing mixed-concern commits.
compatibility: Requires git repository and git CLI access
---

## Overview

This skill analyzes recent changes in your git repository and suggests commit message(s) following conventional commits format. It automatically compares your current branch against `develop`, examines what changed, and intelligently groups changes into one or more commits.

## How It Works

### Single Commit Flow
When all changes are the same type (only features, only fixes, only docs, etc.), the skill suggests a single commit message.

### Multi-Commit Flow
When changes span multiple categories (e.g., documentation + code changes), the skill:
1. Analyzes the diff to identify distinct change types
2. Groups related changes together
3. **Proposes a commit strategy** (shows which files go in which commit)
4. Waits for your confirmation before suggesting the final messages
5. Then provides the individual commit messages

This prevents bundling unrelated changes and keeps your git history clean and logical.

## Supported Commit Types

- `feat:` New feature
- `fix:` Bug fix
- `docs:` Documentation changes (README, ADRs, comments, API docs)
- `refactor:` Code refactoring (no functional change)
- `test:` Adding or updating tests
- `chore:` Build/tooling changes, dependency updates
- `style:` Code style changes (formatting, whitespace)
- `perf:` Performance improvements

## Process

### Step 1: Get Changes
Execute `git diff develop...HEAD --name-status` to see all changed files. If that fails, try `git diff origin/develop...HEAD --name-status`. This shows:
- Status codes: M (modified), A (added), D (deleted)
- File paths for each change

### Step 2: Categorize Files
Analyze each file path to determine its type:

**Documentation files** → `docs` type:
- README.md, *.md files
- Files in docs/, adr/, documentation/ directories
- API documentation, CONTRIBUTING files

**Test files** → `test` type:
- *.test.ts, *.test.js, *.spec.ts, *.spec.js
- Files in tests/, __tests__, test/ directories

**Configuration/Build** → `chore` type:
- package.json, package-lock.json
- *.yml, *.yaml files (CI/CD, docker-compose, helm)
- Dockerfile, .dockerignore
- tsconfig.json, webpack.config.js

**Style/Format** → `style` type:
- .prettierrc, .eslintrc, stylelint config files

**Source code** (feat/fix/refactor/perf):
- *.ts, *.js, *.tsx, *.jsx files
- Without additional context, ask the user to clarify

### Step 3: Group and Suggest

**If only ONE type detected:**
Suggest a single commit message: `type: description`

**If MULTIPLE types detected:**
1. Show the proposed grouping (which files go in which commit)
2. Ask: "Should I proceed with this grouping? (yes/no)"
3. If yes → suggest individual commit messages
4. If no → ask how they'd prefer to organize the changes

### Step 4: Handle Ambiguity
For source code files where the type is unclear:
- Ask: "Is this a new feature, a bug fix, a refactor, or a performance improvement?"
- Use their answer to categorize correctly

## Examples

### Example 1: Single Feature
```
Changes: Added new authentication middleware
Suggested commit:
feat: add JWT-based authentication middleware
```

### Example 2: Multi-type Changes (requires confirmation)
```
Changes detected:
- Added new ADR document (docs)
- Implemented caching layer (feat)
- Added cache tests (test)

Proposed grouping:
1. Commit 1: docs/new-caching-adr.md → docs: document caching strategy
2. Commit 2: src/cache.ts + tests/cache.test.ts → feat: implement in-memory caching with tests

Waiting for confirmation...

[User confirms]

Suggested commits:
1. docs: document caching architecture decision
2. feat: implement in-memory caching with tests
```

## What You Need to Do

Simply run this skill and let it analyze your changes. When prompted for multi-commit confirmation, review the grouping and confirm. That's it!
