#!/usr/bin/env python3
"""One-click deploy: stage, commit, push to GitHub. Triggers Netlify auto-deploy."""
import os
import subprocess
import sys
from datetime import datetime

ROOT = os.path.dirname(os.path.abspath(__file__))
os.chdir(ROOT)

def run(cmd, check=True, capture=False):
    print(f"$ {cmd}")
    if capture:
        return subprocess.run(cmd, shell=True, check=check, capture_output=True, text=True).stdout.strip()
    return subprocess.run(cmd, shell=True, check=check)

def need(cmd):
    return subprocess.run(f"where {cmd}" if os.name == "nt" else f"which {cmd}",
                          shell=True, capture_output=True).returncode == 0

print("=" * 40)
print("  Todo List - One-click Deploy")
print("=" * 40)
print()

# Sanity checks
for tool in ("git", "gh"):
    if not need(tool):
        print(f"[ERROR] {tool} not found. Install it first.")
        input("Press Enter to exit...")
        sys.exit(1)

if run("git status", check=False).returncode != 0:
    print("[ERROR] Not a git repo. Run: git init")
    input("Press Enter to exit...")
    sys.exit(1)

# Check for changes
diff_unstaged = run("git diff --quiet", check=False).returncode
diff_staged = run("git diff --cached --quiet", check=False).returncode

if diff_unstaged == 0 and diff_staged == 0:
    print("[INFO] No changes to commit.")
    input("Press Enter to exit...")
    sys.exit(0)

print("Changes detected. Committing...")
print()

# Commit message
default_msg = f"update: auto deploy at {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}"
msg = input(f"Commit message (Enter for default): ").strip() or default_msg

run("git add .")
run(f'git commit -m "{msg}"')

# Push
print()
print("Pushing to GitHub...")
token = run("gh auth token", capture=True)
if not token:
    print("[ERROR] gh not logged in. Run: gh auth login")
    input("Press Enter to exit...")
    sys.exit(1)

run(f'git push https://MU-uu:{token}@github.com/MU-uu/todo-list.git main')

print()
print("=" * 40)
print("  Done! Netlify will deploy in 30s.")
print("  URL: https://mu-todo-list.netlify.app")
print("=" * 40)
input("\nPress Enter to exit...")
