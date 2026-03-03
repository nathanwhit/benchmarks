#!/bin/bash
set -e

cd "$(dirname "$0")"

for dir in fixtures/*/; do
  name=$(basename "$dir")
  echo "=== $name ==="
  cd "$dir"
  EXTRA_FLAGS="-N"
  if [[ "$OSTYPE" == msys* || "$OSTYPE" == cygwin* ]]; then
    EXTRA_FLAGS=""
  fi
  hyperfine --warmup 2 $EXTRA_FLAGS \
    --prepare "deno clean || true; rm -rf node_modules deno.lock || true" \
    -n=deno-2.7.1 "$HOME/deno-2.7.1 install" \
    -n=deno-canary "deno install"
  cd - >/dev/null
done
