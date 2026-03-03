#!/bin/bash
set -e

cd "$(dirname "$0")"

for dir in fixtures/*/; do
  name=$(basename "$dir")
  echo "=== $name ==="
  cd "$dir"
  hyperfine --warmup 2 -N \
    --prepare "bash ../../prepare.sh" \
    -n=deno-2.7.1 "$HOME/Documents/Code/misc/deno-2.7.1 install" \
    -n=deno-canary "deno install"
  cd - >/dev/null
done
