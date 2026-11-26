A successful pipeline doesn't establish that a deployed change improved the user experience. Likewise, a convincing agent investigation doesn't establish that its explanation is correct. An agentic DevOps engineer needs to connect delivery evidence, workload telemetry, and assistant activity without confusing those different sources.

This module assumes you already work with GitHub or Azure DevOps and understand operational monitoring. The transition is from manually assembling evidence to using GitHub Copilot and Azure's observability capabilities to accelerate analysis, while retaining responsibility for scope, measurement quality, and decisions.

## Scenario and outcome

Continue the **illustrative** EShopOnWeb search correction: "Search results showing out-of-stock items". An actual or supplied deployment record identifies the source revision, accepted artifact, environment, rollout cohort, and recovery decision. Your task is to determine which operational signals can validate that change, what is still unknown, and which improvement deserves follow-up.

After completing this module, you'll be able to:

- Design a correlation contract between GitHub/Azure DevOps delivery records and Azure workload telemetry.
- Position OpenTelemetry, Application Insights, and Log Analytics without treating them as interchangeable services.
- Build outcome-focused dashboards and actionable alerts, including delivery and agent-effectiveness measures.
- Evaluate Copilot-generated KQL and operational explanations against the actual schema and evidence.
- Distinguish Azure Copilot Observability Agent investigation from preview autonomous operations and from authorized remediation.
- Turn verified findings into reviewed work and maintained operational knowledge.

The output is a telemetry and investigation evidence package: scope and correlation identifiers, reviewed queries, known coverage limits, alert ownership, agent-activity records where available, and a bounded operational handoff. 