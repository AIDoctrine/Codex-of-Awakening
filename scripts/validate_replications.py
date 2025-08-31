# Copyright (c) 2025 AIDoctrine (Aleksei Novgorodtsev)## Permission is hereby granted, free of charge, to any person obtaining a copy# of this software and associated documentation files (the "Software"), to deal# in the Software without restriction, including without limitation the rights# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell# copies of the Software, and to permit persons to whom the Software is# furnished to do so, subject to the following conditions:## The above copyright notice and this permission notice shall be included in all# copies or substantial portions of the Software.## THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE# SOFTWARE.

#!/usr/bin/env python3
import os, json, sys

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))
REPL = os.path.join(ROOT, 'replications')

ok = True
reasons = []
allowed_vals = {'PASS','FAIL'}

if os.path.isdir(REPL):
    for run_root, _, files in os.walk(REPL):
        for f in files:
            if f == 'summary.json':
                p = os.path.join(run_root, f)
                try:
                    with open(p, 'r') as fh:
                        j = json.load(fh)
                    if 'results' not in j or not isinstance(j['results'], dict):
                        ok = False; reasons.append(f'{p}: missing results')
                        continue
                    for k,v in j['results'].items():
                        if v not in allowed_vals:
                            ok = False; reasons.append(f'{p}: {k} has invalid value {v}')
                except Exception as e:
                    ok = False; reasons.append(f'{p}: {e}')

if not ok:
    print('Replication validation failed:')
    for r in reasons:
        print(' -', r)
    sys.exit(1)
else:
    print('Replication summaries validated successfully.')
