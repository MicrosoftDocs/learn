A useful dashboard answers a decision question. A wall of green build badges can hide slow reviews, failing users, or an expensive agent that repeatedly proposes unusable changes.

## Connect delivery, reliability, and agent effectiveness

Start with the existing GitHub or Azure DevOps views for PRs, runs, tests, and work. Link them to Azure workload views through the correlation contract rather than replace every platform view with a new dashboard. Native insights, analytics, APIs, and retention vary by platform and license; verify the available data before promising a report.

Use a small scorecard:

| Decision | Example measure | Measurement discipline |
| --- | --- | --- |
| Is delivery improving? | Deployment frequency and change lead time | Count successful production deployments; define the commit-to-production clock and treatment of hotfixes/redeployments |
| Is delivery becoming less reliable? | Change failure rate and failed-deployment recovery time | Define which production changes require remediation and when service recovery is verified; don't substitute every failed CI job |
| Is the requirement working? | Known-stock search checks and attributable user outcomes | Link functional evidence to the release/cohort; a lower HTTP error rate doesn't prove correct search results |
| Is assistance helping? | Accepted proposals, review rework, task success and tool failures | Define eligible tasks, evaluated outputs, retries and human review effort |
| Is assistance affordable? | Task latency, available usage/cost records and query spend | Include failed attempts; distinguish measured usage from estimates |

These delivery measures are commonly discussed through DORA. Use agreed definitions and trends, not a claim that one local threshold or four numbers certify team performance.

Compare assisted and non-assisted work with similar scope and risk over a declared period. Attribution must be recorded where possible; don't assume GitHub or Azure DevOps can label every change as Copilot-assisted automatically. A higher acceptance rate can reflect easier tasks or weaker review rather than better engineering.

## Make dashboards explain their limits

For the illustrative search correction, show the release/environment, traffic population, error rate, latency, functional-check status, and evidence freshness together. Link the release marker to the producer run and reviewed contribution.

Display **unknown** when the required data is missing or stale. Separate candidate and baseline cohorts and disclose sampling. A chart combining staging and production can produce an attractive trend that answers neither environment's question.

Copilot can draft a dashboard specification from a supplied schema and decision contract. Ask it to list source tables, filters, denominators, refresh behavior, and drill-down links. Review those definitions before creating or editing a shared dashboard. Dashboard changes are writes even if their purpose is observation.

## Design actionable alerts

An alert should identify the condition, affected scope, owner, evidence link, and next diagnostic step. Add appropriate evaluation windows and recovery criteria so a short fluctuation doesn't create repeated work.

For the fictional search acceptance contract used earlier in the course, the health review requires a two-hour window, at least 1,000 attributed requests, 5xx below 1%, p95 at or below 500 ms, current functional checks, and telemetry no more than five minutes old. Those are teaching values, not universal production targets. Missing traffic, a partial window, or stale data is **unknown**, not a passed health gate.

Separate the service-health condition from telemetry-health conditions such as exporter failure or ingestion delay. Suppression during maintenance needs an owner, scope, expiry, and retained evidence; an agent shouldn't silence alerts merely because they are noisy.

Use a read-and-propose request such as:

```text
Review this alert definition and sanitized incident history.
Identify duplicate notifications, missing owners, ambiguous populations,
and cases where absent telemetry could appear healthy.
Propose changes with evidence and expected trade-offs.
Do not change alert rules, suppress notifications, or create work items.
```

Route accepted findings to existing GitHub issues or Azure Boards work. Keep incident response distinct from longer-term instrumentation or process improvements. The next unit shows how to verify the queries and explanations behind those findings.

Learn more about [Azure Monitor alerts](/azure/azure-monitor/alerts/alerts-overview) and [GitHub Actions metrics](https://docs.github.com/en/actions/how-tos/administer/view-metrics).
