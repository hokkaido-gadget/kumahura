#!/bin/sh
set -eu

ROOT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
cd "$ROOT_DIR"

BRANCH=$(git branch --show-current)
if [ -z "$BRANCH" ]; then
  echo "No current git branch found." >&2
  exit 1
fi

MESSAGE=${1:-"Auto publish kumahura updates"}

git add index.html styles.css script.js assets .gitignore scripts

if git diff --cached --quiet; then
  echo "No publishable changes to commit."
else
  git commit -m "$MESSAGE"
fi

git pull --rebase origin "$BRANCH"
git push -u origin "$BRANCH"

echo "Published: https://hokkaido-gadget.github.io/kumahura/"

