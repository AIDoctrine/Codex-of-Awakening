#!/usr/bin/env python3
# MIT License — see root LICENSE
# (c) 2025 AIDoctrine
import os, json, sys
ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))
REPL = os.path.join(ROOT, 'replications')
ok=True
reasons=[]
allowed={'PASS','FAIL'}
if os.path.isdir(REPL):
    for run_root, _, files in os.walk(REPL):
        for f in files:
            if f=='summary.json':
                p=os.path.join(run_root,f)
                try:
                    with open(p,'r') as fh:
                        j=json.load(fh)
                    if 'results' not in j or not isinstance(j['results'],dict):
                        ok=False; reasons.append(f'{p}: missing results'); continue
                    for k,v in j['results'].items():
                        if v not in allowed:
                            ok=False; reasons.append(f'{p}: {k} has invalid value {v}')
                except Exception as e:
                    ok=False; reasons.append(f'{p}: {e}')
if not ok:
    print('Replication validation failed:')
    for r in reasons:
        print(' -', r)
    sys.exit(1)
else:
    print('Replication summaries validated successfully.')
