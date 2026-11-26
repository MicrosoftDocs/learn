GitHub Copilot can shorten the path from an operational question to a query. It can also produce valid-looking KQL that queries the wrong schema, combines different releases, or treats missing evidence as success.

## Give analysis a bounded evidence contract

Supply the approved workspace/resource scope, actual table schema, release/environment identifiers, UTC window, and sanitized representative records. Identify whether you are using Application Insights resource-context tables, workspace tables, or a native OTLP schema.

For example, resource-context `requests` uses fields such as `timestamp` and `duration`; workspace `AppRequests` uses `TimeGenerated` and `DurationMs`. Don't accept a query merely because it resembles a familiar example.

```text
Using only this supplied workspace schema and sanitized evidence, draft KQL
to summarize the specified release's search requests in the approved UTC window.
Return population, 5xx numerator/denominator, p95 latency and evidence freshness.
Identify sampling, missing fields and incomplete coverage explicitly.
Separate observations, hypotheses and checks needed to test those hypotheses.
Do not execute a query, expand resource scope, change alerts, or recommend
deployment approval as if request telemetry were the complete health contract.
```

In Copilot Chat, attach exported evidence or use only an approved read/query integration if available. Chat alone doesn't grant access to Azure telemetry. Even a read-only query can expose data or incur cost.

## Inspect the query before trusting its result

The following **illustrative workspace query** summarizes only the request portion of the search contract. It assumes unsampled `AppRequests` records, a reviewed `AppRoleName`, and custom release/environment/feature fields populated by the instrumentation contract. Those properties aren't supplied by the companion labs. Verify their existence and mappings first.

```kusto
let WindowEnd = now();
let WindowStart = WindowEnd - 2h;
AppRequests
| where TimeGenerated >= WindowStart and TimeGenerated < WindowEnd
| where AppRoleName == "eshop-search"
| where tostring(Properties["deployment.environment"]) == "production"
| where tostring(Properties["release.id"]) == "illustrative-search-release"
| where tostring(Properties["feature"]) == "catalog-search"
| extend Status = toint(ResultCode)
| summarize RecordedRequests = count(),
            ServerErrors = countif(Status >= 500 and Status < 600),
            MissingStatus = countif(isnull(Status)),
            MissingDuration = countif(isnull(DurationMs)),
            NonUnitWeights = countif(isnull(ItemCount) or ItemCount != 1),
            P95Ms = percentile(DurationMs, 95),
            LatestEvent = max(TimeGenerated)
| extend ServerErrorRate = iff(RecordedRequests > 0,
                              todouble(ServerErrors) / todouble(RecordedRequests),
                              real(null)),
         EvidenceAge = WindowEnd - LatestEvent
```

There is no environment-promotion command or success flag. The query returns observations for independent review. It deliberately doesn't discard bad status/duration records before counting them, which would hide evidence defects.

Review these checks:

1. **Scope and identity:** Inspect raw records and the deployment marker. Do the custom fields actually identify the active candidate and cohort, rather than a stale configuration value?
2. **Population and units:** Is `RecordedRequests` the intended population? `DurationMs` is milliseconds. With sampling, record counts aren't full traffic counts, and unweighted percentile calculations may not represent the full population.
3. **Completeness:** A two-hour filter doesn't prove two hours of continuous coverage or that the candidate was active for the entire window. Check deployment time, ingestion delay, gaps, dropped exports and the independent telemetry heartbeat.
4. **Health contract:** At least 1,000 attributable requests, error rate strictly below 1%, and p95 at or below 500 ms are the fictional request thresholds. Verify required functional checks and freshness separately. Weighted, malformed, absent or stale evidence requires investigation, not automatic acceptance.
5. **Execution:** An authorized engineer or bounded query tool runs the reviewed query against the approved target and retains its text, evaluation time and original results. A query error remains an error.

For a stored snapshot, replace `now()` with the agreed snapshot evaluation time. Otherwise, rerunning the query changes its population and makes comparisons difficult to reproduce.

## Test explanations against competing hypotheses

"The catalog dependency slowed after the release" is an observation only if trace evidence establishes it. "The new filter caused the slowdown" is a hypothesis. Compare deployment timing, affected versus unaffected cohorts, dependency calls, resource saturation, and any concurrent infrastructure change.

Use metrics to establish scale and traces/logs to investigate individual behavior. Avoid retrieving an entire workspace when an attributable request sample and a targeted aggregate answer the question.

Reject a generated explanation that invents a column, omits failed requests, silently substitutes another environment, or cites a query that wasn't executed. If analysis cannot distinguish two plausible causes, retain both and state the next bounded check.

The handoff contains the reviewed query, original result reference, coverage limits, facts, hypotheses, and unresolved checks. It supports a decision; it isn't authorization to restart, scale, or roll back.

Learn more about the [AppRequests schema](/azure/azure-monitor/reference/tables/apprequests) and [Application Insights log queries](/azure/azure-monitor/logs/log-query-overview).
