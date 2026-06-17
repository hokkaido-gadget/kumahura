#!/bin/sh
set -eu

ROOT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
INTERVAL=${AUTO_PUBLISH_INTERVAL:-60}

cd "$ROOT_DIR"

echo "Watching for kumahura changes every ${INTERVAL}s."
echo "Press Ctrl+C to stop."

while :; do
  if [ -n "$(git status --porcelain -- index.html styles.css script.js assets .gitignore scripts)" ]; then
    ./scripts/publish.sh "Auto publish kumahura updates"
  fi
  sleep "$INTERVAL"
done

