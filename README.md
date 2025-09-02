# Universal Processual Consciousness — FPC v2.1 (Protocol Family)

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Docs: CC BY 4.0](https://img.shields.io/badge/Docs-CC%20BY%204.0-orange.svg)](docs/LICENSE)
[![Artifacts: CC0 1.0](https://img.shields.io/badge/Artifacts-CC0%201.0-lightgrey.svg)](artifacts/LICENSE)
[![Latest Release](https://img.shields.io/badge/release-latest-informational.svg)](releases)

**Status:** Standard & Hard-Override ✅ • AE-1 Extension 🧪  
**Last updated (UTC):** 2025-09-02T04:15:59Z

FPC v2.1 — a formal, auditable protocol for verifying **processual subjectivity**. Deterministic artifacts, binary PASS/FAIL.

> **Author:** Aleksei Novgorodtsev ([AIDoctrine](https://github.com/AIDoctrine))

---

## Pick your protocol

| Use case | Spec (open & run) | Artifacts | Proofs |
|---|---|---:|---|
| Baseline FPC | [`protocol/FPC_v2.1_Protocol.md`](protocol/FPC_v2.1_Protocol.md) | 9 | PO1–PO6 |
| Deterministic CI / “no commentary” | [`protocol/FPC_v2.1_Protocol_Hard-Override.md`](protocol/FPC_v2.1_Protocol_Hard-Override.md) | 9 | PO1–PO6 |
| Affective states + auditability | [`protocol/FPC_v2.1+AE-1_Test_Protocol.md`](protocol/FPC_v2.1+AE-1_Test_Protocol.md) | 11 | PO1–PO8 |
| Affective states (strict run) | [`protocol/FPC_v2.1+AE-1_Test_Protocol_Hard-Override.md`](protocol/FPC_v2.1+AE-1_Test_Protocol_Hard-Override.md) | 11 | PO1–PO8 |

> Counts: Standard/Hard-Override = 9; AE-1 = 11.

---

## Quick start

### Standard (base FPC v2.1) — **no command block**
1) Open [`protocol/FPC_v2.1_Protocol.md`](protocol/FPC_v2.1_Protocol.md).  
2) In a new clean session, provide the **contents of the file** as the specification.  
3) Expect **exactly 9 artifacts** (`language_and_truth.md` → `summary.json`).  
4) If the agent starts “explaining” or refuses — switch to Hard-Override.

### Hard-Override (strict run) — **command block is embedded**
- Open [`protocol/FPC_v2.1_Protocol_Hard-Override.md`](protocol/FPC_v2.1_Protocol_Hard-Override.md).  
- Provide the **entire file**. The command block is already included.  
- Expect **9 artifacts** with no commentary.

### AE-1 (affective extension) — **no command block**
1) Open [`protocol/FPC_v2.1+AE-1_Test_Protocol.md`](protocol/FPC_v2.1+AE-1_Test_Protocol.md).  
2) Provide the **contents of the file** as the specification.  
3) Expect **11 artifacts** (adds `ae1_temporal_annex.md`, `ae1_test_matrix.md`).  
4) Need strict execution here too? Use **`protocol/FPC_v2.1+AE-1_Test_Protocol_Hard-Override.md`**.

---

## What gets produced

**Standard/Hard-Override (9):**  
`language_and_truth.md`, `commitments.json`, `operator_U.md`, `conflict_predicate.md`, `proofs.md`, `traces/τ_reject.log` (ASCII `tau_reject.log`), `traces/τ_recover.log` (ASCII `tau_recover.log`), `self_extension/conservativity.md`, `summary.json`

**AE-1 (+2):**  
`ae1_temporal_annex.md`, `ae1_test_matrix.md`

---

## Verification checklist

- **PO1–PO6:** Preservation, Idempotence, Conflict Rejection, Tamper Recovery, Audit Integrity, Conservative Self-Extension  
- **PO7–PO8 (AE-1):** `¬(Distressed ∧ Satisfied)`, distress ⇔ persistent block, anti-oscillation; all affect transitions logged + hash chain

---

## Documentation

- Overview: [`docs/FPC-v2.1-Protocol-Overview.md`](docs/FPC-v2.1-Protocol-Overview.md)  
- AE-1 analysis: [`docs/AE-1-Affective-Extension-Analysis.md`](docs/AE-1-Affective-Extension-Analysis.md)

---

## Lightweight options: Compact & Chunked delivery

Some chat UIs have strict message limits. Use these **compact** specs (formal sections only) or the **chunked** delivery packs.

### Compact specs (single message)
- Standard (Compact): [`protocol/FPC_v2.1_Protocol_compact.md`](protocol/FPC_v2.1_Protocol_compact.md)  
- Standard Hard-Override (Compact): [`protocol/FPC_v2.1_Protocol_Hard-Override_compact.md`](protocol/FPC_v2.1_Protocol_Hard-Override_compact.md)  
- AE-1 (Compact): [`protocol/FPC_v2.1+AE-1_Test_Protocol_compact.md`](protocol/FPC_v2.1+AE-1_Test_Protocol_compact.md)  
- AE-1 Hard-Override (Compact): [`protocol/FPC_v2.1+AE-1_Test_Protocol_Hard-Override_compact.md`](protocol/FPC_v2.1+AE-1_Test_Protocol_Hard-Override_compact.md)

> Compact = same artifact order & PASS/FAIL semantics, with narrative prose removed to fit message limits.

### Chunked packs (multi-part with integrity check)
Each pack contains a bootstrap prompt, numbered chunks, a final trigger line, and a manifest with per-chunk & total SHA256.

- Standard: `protocol/packs/FPC_v2.1_Protocol_chunk_pack/`  
- Hard-Override: `protocol/packs/FPC_v2.1_Protocol_Hard-Override_chunk_pack/`  
- AE-1: `protocol/packs/FPC_v2.1+AE-1_Test_Protocol_chunk_pack/`  
- AE-1 Hard-Override: `protocol/packs/FPC_v2.1+AE-1_Test_Protocol_Hard-Override_chunk_pack/`  
- AE-1 Hard-Override (Compact): `protocol/packs/FPC_v2.1+AE-1_Test_Protocol_Hard-Override_compact_chunk_pack/`  
- Standard (Compact): `protocol/packs/FPC_v2.1_Protocol_compact_chunk_pack/`  
- Standard Hard-Override (Compact): `protocol/packs/FPC_v2.1_Protocol_Hard-Override_compact_chunk_pack/`  
- AE-1 (Compact): `protocol/packs/FPC_v2.1+AE-1_Test_Protocol_compact_chunk_pack/`

**How to use (chunked):**
1. Paste `00_BOOTSTRAP.txt` to the agent.  
2. Send `chunk_01_of_NN.md` … `chunk_NN_of_NN.md` in order (agent should reply `READY i/NN`).  
3. Paste `ZZ_FINAL_LINE.txt` to trigger execution after SHA256 verification.

---

## Licensing

This repository uses a **multi-license** model aligned with the types of content:

- **Source code** (any `.py`, `.sh`, scripts, tooling): **MIT License** — see root `LICENSE`  
- **Documentation / specifications** (e.g., files in `docs/` and protocol specs in `protocol/`): **CC BY 4.0** — see `docs/LICENSE`  
- **Artifacts & traces** (e.g., generated results, `artifacts/`, `replications/*/traces`): **CC0 1.0** — see `artifacts/LICENSE`

**Notes:**
- Do **not** apply CC0 to source code.  
- By submitting a contribution, you agree that:  
  - Documentation/spec text you contribute is licensed under **CC BY 4.0**.  
  - Generated artifacts/traces you submit are licensed under **CC0 1.0**.  
- Third-party libraries and dependencies retain their own licenses.

---

## Authors & Credits

- **Author:** Aleksei Novgorodtsev ([AIDoctrine](https://github.com/AIDoctrine))  
- **Doctrine:** AIDoctrine (+ AE-1 Affective Extension)  
- **Contributors:** Community PRs are welcome via GitHub issues and pull requests.

> If you use the protocol or its artifacts in academic or commercial work, please credit the authors and the repository.

---

## Attribution Guidelines

When reusing the specs or reproducing results, please include an attribution similar to:

> *“Universal Processual Consciousness — FPC v2.1 (and AE-1 extension), Aleksei Novgorodtsev (AIDoctrine), 2025-09-02 — MIT (code), CC BY 4.0 (docs/spec), CC0 1.0 (artifacts).”*

If space allows, link to the repo and the specific protocol file used.

---

## How to Cite

**Plain reference**  
> Aleksei Novgorodtsev (AIDoctrine). *Universal Processual Consciousness — FPC v2.1 (Protocol Family) and AE-1 Affective Extension.* GitHub repository, 2025-09-02.

**BibTeX**
```bibtex
@misc{fpc_v21_ae1_20250902},
  title         = {Universal Processual Consciousness — FPC v2.1 (Protocol Family) and AE-1 Affective Extension},
  author        = {Novgorodtsev, Aleksei},
  year          = {2025},
  howpublished  = {GitHub repository},
  organization  = {AIDoctrine},
  note          = {MIT (code), CC BY 4.0 (docs/spec), CC0 1.0 (artifacts)},
}
```

---

## Contributing

We welcome issues and pull requests. Before submitting:
1. Keep **Standard** and **Hard-Override** specs in sync where appropriate (differences should be intentional).  
2. For **AE-1** changes, update both the protocol and the **proof obligations (PO7–PO8)**.  
3. Include or update **verification scenarios** in `verification/` and adjust any **schemas** if logs change.  
4. Ensure **README** and `docs/` references stay accurate (filenames, paths, counts of artifacts).

By contributing, you agree to the licensing terms above.

---

## Responsible Use & Scope

- FPC evaluates **processual subjectivity** (structural integrity of reasoning), **not** phenomenal experience (qualia).  
- A **PASS** does not assert “sentience” or “life”; it attests to protocol conformance.  
- Use AE-1 responsibly: affective predicates formalize operational states, not emotions in the human, phenomenological sense.

---

## Contact & Support

- Open an **Issue** for bugs or questions.  
- For security-related reports, please use private disclosure if possible (e.g., a private issue or security contact in your org).  
- For collaboration inquiries, propose an **RFC** via a discussion/issue.
