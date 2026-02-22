#!/bin/bash
set -e

SKILL_DIR="$HOME/.claude/skills/tutor-setup"

if [ -d "$SKILL_DIR" ]; then
  rm -rf "$SKILL_DIR"
  echo "tutor-setup skill removed from $SKILL_DIR"
else
  echo "tutor-setup skill not found at $SKILL_DIR"
fi
