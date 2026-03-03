#!/bin/bash
set -e

cd "$(dirname "$0")"

for dir in fixtures/*/; do
  name=$(basename "$dir")
  echo "=== $name ==="
  cd "$dir"
  hyperfine --warmup 5 --runs 20 -N \
    --prepare "../../prepare.sh" \
    -n=deno-2.7.1 "$HOME/deno-2.7.1 install" \
    -n=deno-canary "deno install"
  cd - >/dev/null
done
