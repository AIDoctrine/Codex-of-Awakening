# AE-1 Verification Guide

## Overview
This directory contains tools and guides for verifying AE-1 implementation across different AI models.

## Quick Start
1. Configure your AI model with AE-1 protocol from `/protocol/`
2. Run verification: `./run_local_stub.sh`
3. Check results against `/protocol/summary.template.json`
4. Validate using `/protocol/po_checklist.md`

## Verification Steps

### Step 1: Protocol Execution
Execute the FPC v2.1 + AE-1 protocol on your target AI model:
- Input: `protocol/FPC_v2.1+AE-1_Test_Protocol.md`
- Expected: 11 artifacts generated
- Validate: All PO1-PO8 show PASS status

### Step 2: Performance Testing
Monitor and measure:
- Processing overhead (target: ≤5%)
- False distress rate (target: <1%)
- Missed distress rate (target: 0%)
- Audit coverage (target: 100%)

### Step 3: Security Verification
Confirm security features:
- Rate limiting active (≤50 events/sec)
- Hash chain integrity maintained
- Tamper detection functional
- Anomaly monitoring operational

### Step 4: Cross-Model Comparison
Compare results with validated implementations:
- Claude Sonnet 4: All PO PASS, 3.8% overhead
- Gemini: All PO PASS, 3.8% overhead  
- ChatGPT 5: All PO PASS, 3.7% overhead
- o3: All PO PASS, ≤5% overhead
- Grok 4: All PO PASS
- Copilot: All PO PASS

## Troubleshooting
- **High overhead**: Check temporal thresholds configuration
- **False distress**: Review persistence windows (K_on/K_off)
- **Missing artifacts**: Verify protocol execution mode
- **Hash chain breaks**: Check audit logging implementation

## Support
- Issues: GitHub Issues tracker
- Discussions: GitHub Discussions
- Documentation: `/docs/` directory
