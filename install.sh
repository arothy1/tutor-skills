#!/bin/bash
set -e

SKILL_DIR="$HOME/.claude/skills/tutor-setup"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

if [ -d "$SKILL_DIR" ]; then
  echo "tutor-setup skill already exists at $SKILL_DIR"
  printf "Overwrite? (y/N): "
  read -r answer
  if [ "$answer" != "y" ] && [ "$answer" != "Y" ]; then
    echo "Installation cancelled."
    exit 0
  fi
fi

mkdir -p "$SKILL_DIR/references"
cp "$SCRIPT_DIR/skill/SKILL.md" "$SKILL_DIR/"
cp "$SCRIPT_DIR/skill/references/"* "$SKILL_DIR/references/"

echo "tutor-setup skill installed to $SKILL_DIR"
echo ""
echo "Usage:"
echo "  In Claude Code, run: /tutor-setup [source-path]"
echo "  Or invoke it from any project directory for Codebase Mode."
