#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "$0")/.." && pwd)"
POST_FILE="$1"

if [ -z "$POST_FILE" ]; then
  echo "Usage: $0 <filename.md>"
  exit 1
fi

cd "$REPO_DIR"

git add "content/post/$POST_FILE"
git commit -m "new post: $POST_FILE"
git push origin main

echo "✅ Published: $POST_FILE"
