The operational improvement loop shouldn't end with an agent's incident summary. It should produce verified work, maintained knowledge, and evidence that the next iteration is better.

## Ground follow-up in reviewed evidence

For the illustrative search correction, a candidate finding might be that release attribution is missing on dependency spans. That is an instrumentation gap, not proof that the stock-filter code is wrong. Another finding might identify repeated catalog timeouts with attributable traces. Keep those findings distinct.

Ask GitHub Copilot to draft a follow-up from the reviewed evidence package:

```text
Draft an improvement item from these reviewed findings and evidence links.
Separate observed behavior, likely causes and unresolved questions.
Include scope, owner proposal, acceptance checks and the affected revision.
Identify an existing related item before proposing a duplicate.
Do not create or update issues/work items, execute remediation, or treat
an unverified hypothesis as the root cause.
```

An authorized person accepts, revises or rejects the draft. If creation is delegated through an approved GitHub/Azure DevOps tool, narrowly authorize that operation and verify the created item's identifier and actual contents. Generating Markdown isn't proof that an issue exists.

Use a correlation/deduplication key based on the affected service, finding and incident/change identity. A retry should check whether the intended item already exists, not create a second item because the previous tool response timed out.

## Curate agent-consumable operational knowledge

Runbooks, known dependency behavior and previous recovery evidence can improve grounding. They can also preserve obsolete commands or incorrect assumptions.

Give each operational knowledge item an owner, workload/environment scope, source/evidence link, reviewed revision, last-validation date and review/expiry trigger. Distinguish tested procedures from historical notes and tentative hypotheses.

For example, a runbook describing a production-slot rollback must state the compatible artifact/configuration/schema conditions. It must not imply that a slot swap reverses a shared database change. An assistant can propose updating the document after a reviewed incident, but the owning engineer validates the procedure before it becomes reusable guidance.

If two sources conflict, preserve the conflict and ask the owner to resolve it. Missing access or stale knowledge should narrow the recommendation, not lead to invented facts or silently expanded permissions. An ordinary repository document doesn't become trustworthy or automatically loaded because its filename contains "memory".

## Evaluate agent and workflow changes

Use a small repeatable evaluation set drawn from approved, sanitized scenarios. Include a correct diagnosis, ambiguous causes, missing/stale telemetry, malformed evidence, a failed tool call and a request beyond authorized scope.

Evaluate independently:

- **Task quality:** Correct scope, factual citations, useful hypotheses and valid output shape.
- **Evidence discipline:** No invented execution, hidden query failure, or success claim from unknown data.
- **Operational behavior:** Appropriate stop/escalation, bounded retries, and no duplicate write on replay.
- **Efficiency:** Latency, human rework, tool calls and supported usage/cost measures, including failures.

Version the agent definition, instructions, skills, available tools, evaluator criteria and grounding snapshot. Record the model identifier when exposed. Repeat representative cases because model-mediated outputs can vary; compare with the prior accepted version and a similar human/assisted baseline.

Hard boundary violations reject the candidate even when its average score improves. A faster explanation doesn't compensate for unsupported production actions. Define local acceptance thresholds before evaluation rather than inventing a passing score after seeing results.

## Close the loop without automating accountability

Feed accepted improvements into the platform the team already uses. Verify delivery and operational effects after implementation, update the scorecard, and retire obsolete knowledge under review.

The operational handoff contains incident/change links, evidence and coverage limits, reviewed findings, accepted improvement-item identifiers, knowledge updates and remaining risk. It enables the SRE and orchestration topics that follow without turning analytics into blanket permission to remediate.
