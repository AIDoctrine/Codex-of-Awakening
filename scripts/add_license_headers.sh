# Copyright (c) 2025 AIDoctrine (Aleksei Novgorodtsev)## Permission is hereby granted, free of charge, to any person obtaining a copy# of this software and associated documentation files (the "Software"), to deal# in the Software without restriction, including without limitation the rights# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell# copies of the Software, and to permit persons to whom the Software is# furnished to do so, subject to the following conditions:## The above copyright notice and this permission notice shall be included in all# copies or substantial portions of the Software.## THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE# SOFTWARE.

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
