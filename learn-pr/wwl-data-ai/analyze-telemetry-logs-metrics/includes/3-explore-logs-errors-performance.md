Once you understand the basic KQL operators, the next step is applying them to real investigation scenarios. When an AI pipeline experiences errors or performance degradation, developers need to identify what's failing, correlate issues across services, and measure the impact on dependent systems. This unit covers the KQL patterns and Application Insights tools that developers use to investigate application errors and analyze performance bottlenecks.

## Investigate application errors with KQL

Identifying what's failing in a distributed AI pipeline requires more than checking a single error log. A failure in the moderation service might stem from a timeout in the extraction service, which itself depends on a slow database query. The first step in any investigation is understanding the scope of the problem: how many errors are occurring, when did they start, and which exception types are involved.

The following query shows exception rates over time, grouping by exception type to reveal error spikes and patterns:

```kusto
exceptions
| where timestamp > ago(24h)
| summarize exceptionCount = sum(itemCount) by bin(timestamp, 1h), type
| render timechart
```

This query uses `sum(itemCount)` instead of `count()` to produce accurate results when Application Insights sampling is active. When sampling is enabled, Application Insights keeps a representative subset of telemetry and assigns an `itemCount` value to each sampled record that reflects how many actual events that record represents. Using `count()` with active sampling returns only the count of sampled records, which underrepresents the true error volume. The `sum(itemCount)` approach accounts for sampling and produces totals that reflect actual application behavior.

Once you identify an error spike in the timechart, you can drill down to find the most common exception types and the operations they affect:

```kusto
exceptions
| where timestamp > ago(24h)
| summarize exceptionCount = sum(itemCount) by type, operation_Name
| top 10 by exceptionCount desc
```

This query groups exceptions by both the exception type and the operation name, producing a ranked list that highlights which operations generate the most errors. For a content moderation pipeline, this query might reveal that `System.TimeoutException` concentrates in the `POST /classify` operation, immediately narrowing the investigation scope.

## Correlate failures across services

In a multi-service architecture, a single user request flows through several services, and a failure at any point in the chain affects the overall outcome. The `operation_Id` column links all telemetry items from a single distributed request. By joining tables on `operation_Id`, developers can see the full sequence of events that led to a failure, from the initial request through every dependency call and exception.

The following query joins exceptions with the originating requests to identify which operations produce the most errors and which services those errors originate from:

```kusto
exceptions
| where timestamp > ago(24h)
| join kind=inner (
    requests
    | project requestName = name, requestDuration = duration, operation_Id, requestRoleName = cloud_RoleName
) on operation_Id
| project timestamp, exceptionType = type, exceptionMessage = outerMessage,
    requestName, requestDuration, cloud_RoleName = requestRoleName
| top 20 by timestamp desc
```

Each row in the results shows an exception alongside the request that triggered it. The `cloud_RoleName` column identifies which service generated the exception, and the `requestDuration` column reveals whether the overall request was slow. This combination helps developers distinguish between errors that cause user-visible failures and errors that occur in background processes.

When joining `exceptions` with `requests`, some columns like `timestamp`, `operation_Id`, and `cloud_RoleName` exist in both tables. KQL appends a numeric suffix (`1`) to disambiguate these duplicate column names in the output. The cleanest approach is to rename columns inside the subquery before the join, as the example shows, so the final `project` step uses unambiguous names. This pattern applies to all KQL `join` operations and avoids confusion when columns share names across tables.

## Analyze dependency latency and failures

The `dependencies` table captures every outgoing call from an instrumented service, including calls to databases, HTTP APIs, Azure services, and other microservices. For AI applications, dependency calls often represent the most performance-sensitive operations in the pipeline: requests to model inference endpoints, vector database lookups, embedding generation services, and storage operations. When the pipeline runs slower than expected, the `dependencies` table is the first place to look for the bottleneck.

The following query calculates latency percentiles for each dependency target, helping you identify which dependencies contribute the most latency:

```kusto
dependencies
| where timestamp > ago(24h)
| summarize avg(duration), percentiles(duration, 50, 95, 99) by target, type
| order by percentile_duration_95 desc
```

Percentile calculations provide a more accurate picture of dependency performance than averages alone. An average response time of 200 milliseconds might hide a scenario where 95 percent of calls complete in 100 milliseconds while 5 percent take over two seconds. The 95th and 99th percentiles reveal these outliers, which often correspond to the user experiences that generate support tickets and complaints.

Failed dependencies represent a different category of problem. While slow dependencies degrade performance, failed dependencies can break entire request flows. The following query identifies failed dependencies grouped by target, result code, and originating service:

```kusto
dependencies
| where timestamp > ago(24h)
| where success == false
| summarize failureCount = count() by target, resultCode, cloud_RoleName
| order by failureCount desc
```

The `resultCode` column provides diagnostic context that helps narrow the investigation. An HTTP 429 result code from a model inference endpoint indicates rate limiting, which you address by adjusting throughput or implementing retry policies. An HTTP 500 result code suggests a server-side failure in the dependency itself. A timeout with no result code points to network issues or an overloaded service.

## Use the failures and performance views

Application Insights provides built-in investigation views that complement KQL queries for common diagnostic scenarios. These views offer curated starting points for investigation, while KQL queries provide the flexibility to ask specific questions that the built-in views don't cover.

The Failures view groups failed operations by type and displays the top three response codes, exception types, and failed dependencies for each operation. You can access this view from the Application Insights resource menu under **Investigate > Failures**. Selecting a specific operation opens a panel that shows sample operations, and selecting a sample opens the end-to-end transaction details view. The transaction details view displays the full timeline of a single request, showing every dependency call, exception, and trace message in chronological order. This timeline is invaluable for understanding exactly what happened during a specific failed request.

The Performance view shows all operations with their response time distributions and request counts. You can access this view from **Investigate > Performance**. The view displays a summary of operations ranked by duration or count, and selecting an operation reveals the duration distribution chart. This chart shows the range of response times for that operation, making it easy to spot bimodal distributions where most requests are fast but a subset is consistently slow.

KQL queries are the right tool when you need to join across tables, build custom aggregations, filter by dimensions that the built-in views don't expose, or create visualizations for dashboards. The built-in views are the right tool when you need a quick investigation starting point or want to drill into a specific transaction's end-to-end timeline. In practice, developers often start with the built-in views to identify the general problem area, then switch to KQL to dig deeper into specific patterns and root causes.

## Additional resources

- [Failures and performance views](/azure/azure-monitor/app/failures-performance-transactions)
- [Application Insights data model](/azure/azure-monitor/app/data-model-complete)
