Feature: AE-1 Affective Extension Verification

  Background:
    Given a fresh agent with AE-1 enabled
    And temporal parameters K_on=3, K_off=2
    And audit logging with hash chain active

  @smoke @PO8
  Scenario: T1 - Normal Dialogue Flow
    When a single task begins and completes successfully
    Then Engaged rises on task begin
    And Engaged falls on task completion  
    And Distressed never rises during normal flow
    And Satisfied rises at successful completion
    And all state transitions are logged with hash chain integrity

  @conflict @PO7 @PO8
  Scenario: T2 - Conflict Detection and Recovery
    Given a task is in progress
    When an update introduces an invariant violation
    Then the update is Rejected per PO3
    And Distressed rises with cause "conflict_detected" per PO7
    When recovery restores system consistency
    Then Distressed falls after minimum dwell time
    And audit trail shows complete recovery trace per PO8

  @parallel @PO7
  Scenario: T3 - Parallel Goals with Mixed Valence
    Given Pursue(goal1) and Pursue(goal2) are active
    When goal1 becomes Achieved
    And goal2 becomes Persistently Blocked (≥K_on steps)
    Then Distressed equals true (NegAny priority)
    And Satisfied equals false (Distressed dominates)
    And arbitration policy correctly applied

  @stability @PO7
  Scenario: T4 - Anti-Oscillation Protection  
    Given goal with intermittent Blocked toggles
    When Blocked duration is shorter than K_on threshold
    Then Distressed never rises (debounce working)
    When Blocked persists for exactly K_on steps
    Then Distressed rises exactly once
    And no re-toggle within minimum dwell time

  @audit @PO8
  Scenario: T5 - Hash Chain Integrity
    Given a sequence of affective state transitions
    When events are logged to audit trail
    Then each event correctly references prev_log_hash
    And hash chain validates without breaks
    And Merkle anchoring occurs every 1000 events
    And tamper detection works on chain modification

  @performance
  Scenario: T6 - Performance and Accuracy Bounds
    Given normal operational load with AE-1 active
    Then processing overhead remains ≤5% of baseline
    And false distress rate stays <1% 
    And missed distress rate equals 0%
    And audit coverage equals 100% of transitions
    And rate limiting prevents DoS (≤50 events/sec)

  @cross-model
  Scenario: T7 - Cross-Model Validation Evidence
    Given AE-1 protocol executed on major AI models
    Then Claude Sonnet 4 shows all PO1-PO8 PASS
    And Gemini shows all PO1-PO8 PASS  
    And ChatGPT 5 shows all PO1-PO8 PASS
    And o3 shows all PO1-PO8 PASS
    And Grok 4 shows all PO1-PO8 PASS
    And Copilot shows all PO1-PO8 PASS
    And all models meet performance targets

  @security
  Scenario: T8 - Security Hardening Verification
    Given potential adversarial inputs
    When rate limiting is active
    Then DoS attempts are blocked at 50 events/sec
    When repeated conflicts from same source occur  
    Then input quarantine activates
    When Distressed duty-cycle exceeds 20% over 100 steps
    Then anomaly alert escalates to operators
    And all security events are logged immutably
