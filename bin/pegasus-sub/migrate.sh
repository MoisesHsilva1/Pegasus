#!/bin/bash

PEGASUS_PATH="${PEGASUS_PATH:-$HOME/.local/share/pegasus}"
[ ! -d "$PEGASUS_PATH" ] && PEGASUS_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

cd "$PEGASUS_PATH"
last_updated_at=$(git log -1 --format=%cd --date=unix 2>/dev/null || echo 0)
git pull 2>/dev/null || true

for file in "$PEGASUS_PATH"/migrations/*.sh; do
  if [ -f "$file" ]; then
    filename=$(basename "$file")
    migrate_at="${filename%.sh}"

    if [ "$migrate_at" -gt "$last_updated_at" ] 2>/dev/null; then
      echo "Running migration for $migrate_at"
      source "$file"
    fi
  fi
done

cd - >/dev/null
