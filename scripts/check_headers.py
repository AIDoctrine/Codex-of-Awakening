# Copyright (c) 2025 AIDoctrine (Aleksei Novgorodtsev)
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

#!/usr/bin/env python3
import os, sys

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))
SRC_DIRS = [
    os.path.join(ROOT, 'src'),
    os.path.join(ROOT, 'tools'),
    os.path.join(ROOT, 'scripts'),
]

REQUIRED = 'MIT License — see root LICENSE'
exts = ('.py', '.js', '.ts', '.go', '.rs', '.c', '.h', '.cpp', '.hpp', '.sh')
missing = []

for base in SRC_DIRS:
    if not os.path.isdir(base):
        continue
    for dirpath, _, filenames in os.walk(base):
        if any(seg in dirpath for seg in ('vendor', 'node_modules')):
            continue
        for fn in filenames:
            if not fn.endswith(exts):
                continue
            path = os.path.join(dirpath, fn)
            try:
                with open(path, 'r', errors='ignore') as f:
                    head = f.read(512)
            except Exception:
                head = ''
            if REQUIRED not in head:
                missing.append(path)

if missing:
    print('Missing license header in files:')
    for m in missing:
        print(' -', m)
    sys.exit(1)
else:
    print('All checked files contain MIT header.')
