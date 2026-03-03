#!/bin/bash
set -e

cd "$(dirname "$0")"

for dir in fixtures/*/; do
  name=$(basename "$dir")
  echo "=== $name ==="
  cd "$dir"
  echo "DEBUG: cwd=$(pwd)"
  echo "DEBUG: deno=$(which deno)"
  echo "DEBUG: deno-2.7.1 exists=$(test -f "$HOME/deno-2.7.1" && echo yes || echo no)"
  echo "DEBUG: testing prepare command..."
  bash -c 'deno clean || true; rm -rf node_modules deno.lock || true'
  echo "DEBUG: prepare exited with $?"
  echo "DEBUG: testing benchmark command..."
  "$HOME/deno-2.7.1" install 2>&1 | head -5 || true
  echo "DEBUG: benchmark exited with $?"
  hyperfine --warmup 2 -N --show-output \
    --prepare "bash -c 'deno clean || true; rm -rf node_modules deno.lock || true'" \
    -n=deno-2.7.1 "$HOME/deno-2.7.1 install" \
    -n=deno-canary "deno install"
  cd - >/dev/null
done
