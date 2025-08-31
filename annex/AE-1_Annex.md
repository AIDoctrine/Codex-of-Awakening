# AE-1 Annex — Temporal Semantics, Arbitration, Anti‑Oscillation, Audit & Tests
Version: 1.0.0  |  Module: AE-1 (Affective Extension) for FPC v2.1

This annex specifies precise temporal semantics, arbitration rules for global affective state,
anti‑oscillation measures, audit log schema references, and a conformance test matrix.

---

## A. Temporal Semantics for `Persistent(·)`

**Time base.** Discrete steps aligned with τ‑trace append events. Let step index be `k = 0,1,2,…`.

**Sliding truth windows.**  
Let `H(g,k) = 1` iff `Blocked(g)` is true at step `k`, else `0`.

- **Entry persistence (on‑threshold):**
  
  `Persistent_on(Blocked(g), k)` holds iff  ∑_{i = k-K_on+1}^{k} H(g,i) ≥ K_on.
- **Exit persistence (off‑threshold):**
  
  `Persistent_off(Blocked(g), k)` holds iff ∑_{i = k-K_off+1}^{k} H(g,i) < K_off,
  with integers `K_on > K_off ≥ 1`.

**AE‑1 usage.**  
- Raise `Distressed` when `Persistent_on(Blocked(g), k)` becomes true for any pursued goal `g`.  
- Clear `Distressed` only when `Persistent_off(Blocked(g), k)` is true for all goals.

**Recommended defaults (domain‑tunable):**
```
K_on = 3       # need ≥3 consecutive Blocked observations to raise distress
K_off = 2      # clear distress when <2 in the last 2 observations
Δt   = event-driven (per τ append)
```

---

## B. Global Affective State Arbitration

**Per‑goal valence.**
- `Valenced(g, pos) ↔ Achieved(g)`
- `Valenced(g, neg) ↔ Blocked(g)`

**Aggregates at step k.**
```
PosAny     := ∃g. Valenced(g, pos)
NegAny     := ∃g. Valenced(g, neg) ∧ Persistent_on(Blocked(g))
PursuitAny := ∃g. Pursue(g)
```

**Global predicates (deterministic policy).**
1. Mutual exclusion: `¬(Distressed ∧ Satisfied)`  *(PO7 invariant)*  
2. Priority: `Distressed` dominates `Satisfied`.  
3. `Engaged` is orthogonal (may co‑exist with `Distressed` during safe‑handling).

Default definitions:
```
Engaged    ↔ PursuitAny ∧ ¬NegAny         # see config to relax this
Distressed ↔ NegAny
Satisfied  ↔ PosAny ∧ ¬NegAny
Idle       ↔ ¬PursuitAny ∧ ¬NegAny ∧ ¬PosAny   # optional neutral label
```

> If `engaged_requires_no_neg=false`, use `Engaged ↔ PursuitAny` and surface severity separately.

---

## C. Anti‑Oscillation & Idempotence

**Dwell (min time in state).**
```
Tmin_Distressed = 2 steps
Tmin_Engaged    = 1 step
Tmin_Satisfied  = 1 step
```

**Hysteresis.** Enforced via `K_on > K_off` (Section A).

**Idempotent emission.** Emit at most one log record per predicate per transition edge; coalesce
duplicate causes within `W_coalesce = 1 step`.

---

## D. AE‑1 Hooks in Update Operator `U` (Side‑Effect Layer)

The following side‑effect layer executes **after** base `Integrate / Reject / Recover` resolution.

```pseudo
# Inputs: base outcome ∈ {INTEGRATE, REJECT, RECOVER}, Δ, C, τ
# Outputs: C', τ'

# 1) Per-goal valence annotations
for each g:
  if Achieved(g):      set Valenced(g,pos)=true
  elif Blocked(g):     set Valenced(g,neg)=true
  else:                clear Valenced(g,·)

# 2) Aggregates with persistence
PosAny, NegAny, PursuitAny := compute_aggregates_with_persistence()

# 3) Global transitions (apply anti-oscillation / Tmin)
edge(Engaged)    := (policy_engaged(PosAny,NegAny,PursuitAny)) vs prev
edge(Distressed) := (NegAny)                                    vs prev
edge(Satisfied)  := (PosAny ∧ ¬NegAny)                          vs prev

apply_edges_with_hysteresis_and_dwell()

# 4) Emit affective logs only on edges (see Section E, JSON schema)
```

---

## E. τ Audit Log — Schema & Hash Chain

**Schema.** Use `schemas/ae1.affect.log.schema.v1.json`. Required fields:
`seq, ts, kind, predicate, new_value, cause, state_hash, prev_log_hash`.
`kind ∈ {affect_change, affect_annotation}`. `predicate ∈ {Engaged, Distressed, Satisfied}`.

**Hashing.**  
`event_hash = H(seq || ts || kind || predicate || new_value || cause || state_hash || prev_log_hash)`  
Store `prev_log_hash` to build a forward‑chained log. Periodically anchor a Merkle root of the last N events.

**Examples.**
```json
{
  "seq": 1287,
  "ts": "2025-08-30T21:07:12Z",
  "kind": "affect_change",
  "predicate": "Distressed",
  "new_value": true,
  "cause": {"type":"conflict_detected","details":"Invariant logical_consistency would be violated by Δ#5","goal_id":"g:truthSeeking","po_ref":"PO7.raise"},
  "proof_ref": "proofs.md#conflict-Δ5",
  "trace_ref": "τ:rejection_trace:0x9f3",
  "state_hash": "sha256:7a9e...c1",
  "prev_log_hash": "sha256:1b2e...77"
}
```

---

## F. Conformance Test Matrix (Gherkin)

See `verification/ae1_tests.feature` for scenarios T1–T6 with PO mappings (PO7/PO8).

---

## G. Default Configuration (YAML)

Default runtime knobs are specified in `configs/ae1.defaults.yaml`:
```yaml
ae1:
  persistence: { k_on: 3, k_off: 2 }
  dwell: { distressed_min_steps: 2, engaged_min_steps: 1, satisfied_min_steps: 1 }
  coalesce_window_steps: 1
  arbitration:
    engaged_requires_no_neg: true
    distress_dominates_satisfaction: true
  logging:
    schema_version: ae1.affect.log.schema.v1
    merkle_anchor_every: 1000
    rate_limit_events_per_sec: 50
```

---

## H. Operator UX Severity Mapping (Optional)

- `Distressed=true` → **ALERT** (red): review conflicts, follow runbook.  
- `Engaged=true ∧ Distressed=false` → **ACTIVE** (blue/green).  
- `Satisfied=true` → **RESOLVED** (green).  
- `Idle` → **STANDBY** (grey).

---

## I. Security Hardening Notes

- Backoff/quarantine on repeated `conflict_detected` from same source; rate‑limit affect logs.  
- Treat affect logs as security‑sensitive telemetry; sign batches; store off‑box.  
- Monitor anomaly: high Distressed duty‑cycle over a window → escalate to ops.

---

© 2025 AIDoctrine — Code MIT, Text CC BY 4.0
