#!/usr/bin/env bash
set -e

cd "$(dirname "$0")"

echo "========================================"
echo "  Todo List - One-click Deploy"
echo "========================================"
echo

# Check git
if ! command -v git >/dev/null 2>&1; then
    echo "[ERROR] git not found"
    exit 1
fi

# Check gh
if ! command -v gh >/dev/null 2>&1; then
    echo "[ERROR] GitHub CLI (gh) not found"
    exit 1
fi

# Check git status
if ! git status >/dev/null 2>&1; then
    echo "[ERROR] Not a git repo. Run: git init"
    exit 1
fi

# Check for changes
if git diff --quiet && git diff --cached --quiet; then
    echo "[INFO] No changes to commit."
    exit 0
fi

echo "Changes detected. Committing..."
echo

# Ask for commit message
read -p "Commit message (Enter for default): " MSG
MSG=${MSG:-"update: auto deploy at $(date '+%Y-%m-%d %H:%M:%S')"}

# Stage and commit
git add .
git commit -m "$MSG"

# Get gh token and push
echo
echo "Pushing to GitHub..."
TOKEN=$(gh auth token 2>/dev/null)

if [ -z "$TOKEN" ]; then
    echo "[ERROR] gh not logged in. Run: gh auth login"
    exit 1
fi

git push "https://MU-uu:${TOKEN}@github.com/MU-uu/todo-list.git" main

echo
echo "========================================"
echo "  Done! Netlify will deploy in 30s."
echo "  URL: https://mu-todo-list.netlify.app"
echo "========================================"
