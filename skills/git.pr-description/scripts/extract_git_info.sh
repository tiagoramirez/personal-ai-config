#!/bin/bash
# Minimal script: just extract git info, Claude handles the rest

set -e

if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo "ERROR: Not in a git repository"
    exit 1
fi

echo "CURRENT_BRANCH:$(git rev-parse --abbrev-ref HEAD)"
echo "DIFF_STAT:$(git diff develop..HEAD --stat 2>/dev/null || echo 'No commits')"
echo "CHANGES:$(git diff develop..HEAD --name-status 2>/dev/null || echo 'No changes')"
echo "COMMITS:$(git log develop..HEAD --oneline 2>/dev/null || echo 'No commits')"
