#!/bin/bash

# Copy all skill folders from ./skills to ~/.claude/skills
mkdir -p ~/.claude/skills
cp -r skills/* ~/.claude/skills/

echo "Skills installed successfully to ~/.claude/skills"
