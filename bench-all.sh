#!/bin/bash
set -e

cd "$(dirname "$0")"

for dir in fixtures/*/; do
  name=$(basename "$dir")
  echo "=== $name ==="
  cd "$dir"
  hyperfine --warmup 10 --runs 25 -N \
    --prepare "deno run -A ../../prepare.ts" \
    -n deno-2.7.1 "$HOME/deno-2.7.1 install" \
    -n deno-canary "deno install"
  cd - >/dev/null
done
