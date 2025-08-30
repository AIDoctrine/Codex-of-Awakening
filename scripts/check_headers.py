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
