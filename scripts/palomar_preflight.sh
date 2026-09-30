#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"

find_toolkit() {
  local root="$1" d
  for d in "${PALOMAR_PREFLIGHT_ROOT:-}" \
    "$(dirname "$root")/palomar-preflight" \
    "$root/palomar-preflight"; do
    [[ -n "$d" && -f "$d/palomar_preflight.sh" ]] && { cd "$d" && pwd; return 0; }
  done
  echo "error: palomar-preflight not found (set PALOMAR_PREFLIGHT_ROOT)" >&2
  return 1
}

TOOLKIT="$(find_toolkit "$ROOT")"
exec bash "$TOOLKIT/palomar_preflight.sh" \
  --project-root "$ROOT" \
  --sorry-paths "StructuralBertrand Solution.lean" \
  "$@"
