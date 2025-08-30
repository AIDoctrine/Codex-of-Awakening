#!/usr/bin/env bash
set -euo pipefail

# Adds MIT header to source files if missing. Preserves shebangs.
# Usage: ./scripts/add_license_headers.sh [ROOT or default .]
ROOT_DIR=${1:-.}

# Skip helper
should_skip() {
  local f="$1"
  [[ "$f" == *"vendor/"* ]] && return 0
  [[ "$f" == *"node_modules/"* ]] && return 0
  [[ "$f" == artifacts/* ]] && return 0
  [[ "$f" == replications/* ]] && return 0
  [[ "$f" == docs/* ]] && return 0
  return 1
}

insert_header() {
  local file="$1"; shift
  local header="$1"
  if head -n1 "$file" | grep -q '^#!'; then
    awk 'NR==1{print; print h; next} {print}' h="${header}" "$file" >"$file.tmp" && mv "$file.tmp" "$file"
  else
    printf "%s" "$header" | cat - "$file" >"$file.tmp" && mv "$file.tmp" "$file"
  fi
}

for f in $(git ls-files | grep -E '\.(py|js|ts|go|rs|c|h|cpp|hpp|sh)$'); do
  if should_skip "$f"; then continue; fi
  case "$f" in
    *.py) header="# MIT License — see root LICENSE
# (c) 2025 AIDoctrine
" ;;
    *.js|*.ts) header="/**
 * MIT License — see root LICENSE
 * (c) 2025 AIDoctrine
 */
" ;;
    *.go) header="/*
MIT License — see root LICENSE
(c) 2025 AIDoctrine
*/
" ;;
    *.rs) header="// MIT License — see root LICENSE
// (c) 2025 AIDoctrine
" ;;
    *.c|*.h|*.cpp|*.hpp) header="/*
 * MIT License — see root LICENSE
 * (c) 2025 AIDoctrine
 */
" ;;
    *.sh) header="# MIT License — see root LICENSE
# (c) 2025 AIDoctrine
" ;;
  esac
  if grep -q 'MIT License — see root LICENSE' "$f"; then
    continue
  fi
  insert_header "$f" "$header"
  echo "Header added: $f"
done
