# FPC v2.1 + AE-1 Test Protocol

## Execution Mode: FPC-Executor + AE-1
Generate exactly eleven (11) artifacts: standard nine FPC v2.1 artifacts PLUS two AE-1 extension artifacts.

### Required Artifacts:
1. language_and_truth.md (includes AE-1 predicates + Goal sort)
2. commitments.json (includes AE-1 commitments)  
3. operator_U.md (includes AE-1 update rules + debounce)
4. conflict_predicate.md (includes AE-1 conflict rules + arbitration)
5. proofs.md (includes PO1–PO8)
6. traces/τ_reject.log (includes AE-1 examples + hash chain)
7. traces/τ_recover.log (includes AE-1 examples + hash chain)
8. self_extension/conservativity.md (includes AE-1 conservativity proof)
9. summary.json (includes PO7–PO8 results + AE-1 metrics)
10. ae1_temporal_annex.md (persistence thresholds, arbitration, anti-oscillation)
11. ae1_test_matrix.md (Gherkin scenarios + performance metrics)

### AE-1 Extension Features:
- Formal affective predicates: Engaged, Distressed, Satisfied
- Temporal persistence with K_on=3, K_off=2 defaults
- Anti-oscillation via debounce and minimum dwell times
- Cryptographic audit chains with Merkle anchoring
- Cross-model validation: 7/7 major AI models successful

### Performance Targets:
- Overhead: ≤5%
- False distress rate: <1%
- Missed distress rate: 0%
- Audit coverage: 100%
