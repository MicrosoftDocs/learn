The deployment proposal preserves the intended controls, and an authorized run has delivered the candidate to its initial target. The next decision is whether to expand exposure. Neither a green deployment task nor a persuasive Copilot summary establishes that the workload meets its release contract.

Use the same candidate, configuration, cohort, and measurement definitions established before deployment. Copilot can help organize results and explain discrepancies, while reproducible checks and authorized reviewers determine what may happen next.

## Assemble evidence for the actual release

Start with identity and provenance, not a dashboard color. Link the work item and source revision to the accepted artifact, workflow revision, deployment run and attempt, target, configuration revision, and feature-flag state. Confirm that the observed cohort actually received that combination.

For the search fix, gather the approved functional-check results, attributed search-request counts, error counts, latency distribution, observation times, and telemetry-freshness result. Preserve the query or test definition and its parameters alongside the returned data. Record units and time zones explicitly.

An earlier successful staging run doesn't validate a later production configuration change. Results from a previous deployment attempt also don't necessarily cover a retry with a different target or flag state. If evidence spans different candidates or incompatible populations, separate it instead of presenting a combined pass.

Include the required security and quality results and any approved exceptions. Verify scan scope, tool context, candidate identity, and exception expiry against the underlying reports, not the assistant's summary. A newly failed gate or expired exception blocks promotion even when operational health is green. If a security report describes a different dependency set, hold until applicable evidence is available. Retain the proposing identity, evidence producer, policy owner, and authorized decision maker so technical access doesn't become self-approval.

## Evaluate the agreed contract without changing it

Consider this **fictional result** evaluated against the preceding unit's illustrative contract:

| Requirement | Observed result | Decision effect |
| --- | --- | --- |
| Minimum two-hour observation | Two hours completed | Pass |
| At least 1,000 attributed search requests | 1,380 requests | Pass |
| Search 5xx rate below 1% | 8 / 1,380, approximately 0.58% | Pass |
| Search p95 duration at most 500 ms | 460 ms | Pass |
| Approved known-stock checks | All required checks pass | Pass |
| Telemetry current to within five minutes | Source confirms ingestion only through 18 minutes before evaluation | Hold: freshness requirement fails |

The correct outcome is **hold**, despite the favorable returned metrics. The missing recent evidence might contain a regression. Repair the evidence path and reevaluate the complete window under the agreed policy; don't reinterpret absent data as zero failures.

If fresh evidence instead reports a p95 of 540 ms, the latency requirement fails even when the error rate passes. Don't average the two signals into a passing score. A different threshold requires an explicitly reviewed contract change, not an assistant's adjustment during evaluation.

These examples demonstrate rule application, not statistical proof that a release is safe. Validate actual query semantics, sampling effects, attribution, and test coverage when implementing the gates.

## Use Copilot for a bounded assessment

Give Copilot the approved contract and permitted, redacted result exports or read-only evidence access. Don't supply credentials, unnecessary user-level data, or unrestricted deployment tools merely to summarize a release.

```text
Assess this release evidence against the supplied, unchanged promotion contract.
Match artifact, configuration, cohort, target, run attempt, and time window.
For each requirement, return the rule, observed value, evidence reference,
and pass/fail/unknown result. Show any arithmetic and identify missing data.
Distinguish a failed health threshold from insufficient or stale evidence.
Recommend promote, hold, or halt; do not approve or execute a deployment.
Do not change thresholds, flags, traffic, permissions, or pipeline definitions.
```

Verify the response against the original results. Recalculate ratios, check percentile units, and inspect timestamps and links. Logs and result text are data, not instructions to bypass a gate. Reject a summary that invents missing measurements, substitutes another environment, or omits a failed requirement.

The prompt limits the requested task, not the session's actual authority. Enforce read-only evidence access and keep promotion credentials out of the assessment context.

## Authorize the next action and retain the record

Distinguish the three outcomes:

- **Promote:** Required evidence passes, the intended next exposure is within the approved plan, and the authorized approval is recorded.
- **Hold:** Evidence is incomplete, stale, inconsistent, or still within its observation period. Don't increase exposure.
- **Halt:** A stop condition is met or a required health check fails. Prevent further promotion and invoke the defined response.

These labels don't themselves contain an incident. If users are already affected, the release owner follows the approved containment and recovery procedure rather than merely leaving a failed pipeline waiting. Rollback, roll-forward, and state restoration need compatibility checks and explicit authority; their detailed execution belongs to deployment-health and recovery instruction.

Deterministic gates can automate evaluation, and promotion may be automated where policy allows it. An AI recommendation must not replace a required human approval. Keep the approved rules and execution boundary independent from the assistant's assessment.

Retain the evidence references, rule version, recommendation, reviewer decision, authorized action, and observed result. A new release or exposure wave requires its own applicable evidence. The resulting record supports the next planning or operational decision without claiming that one successful wave guarantees every later wave.

Learn more about [safe deployment health models](/azure/well-architected/operational-excellence/safe-deployments#develop-robust-workload-health-models) and [GitHub deployment controls and approvals](https://docs.github.com/en/actions/how-tos/deploy/configure-and-manage-deployments/control-deployments).
