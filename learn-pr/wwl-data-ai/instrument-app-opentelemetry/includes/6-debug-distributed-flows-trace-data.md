Collecting and exporting telemetry is only valuable when you can use that data to find and fix problems. This unit covers how to use Application Insights tools and KQL queries to navigate distributed traces, identify performance bottlenecks, and diagnose issues specific to AI workloads.

## Navigate the Application Map

The Application Map provides a visual topology of all services in your distributed application, showing how they connect and where failures or latency problems occur. Each node on the map represents a cloud role, identified by the `service.name` resource attribute you configured during setup. Edges between nodes represent calls from one service to another, such as the API gateway calling the embedding service.

The Application Map displays key metrics on each node and edge, including average response time, request count, and failure rate over the selected time range. These metrics give you a rapid overview of system health without querying data manually. A node with high average duration or elevated failure rate stands out visually, making it easy to spot which service in your RAG pipeline needs attention.

You can use the map to quickly narrow your investigation. If the vector search service node shows an average response time of five seconds while all other nodes average under 500 milliseconds, you've immediately identified the service contributing the most latency. Selecting a node opens detailed metrics and lets you drill into specific requests and dependencies for that service. Selecting an edge shows the call characteristics between two services, including response time distribution and failure rates.

## Use end-to-end transaction details

The end-to-end transaction view displays a waterfall chart of all spans in a single trace, showing the timing, duration, and dependencies for each operation. This view is the primary tool for understanding what happens during a specific request and identifying exactly where time is spent.

You can navigate to the transaction view from several places in Application Insights. You can select a specific request in the Performance pane, choose a failed request in the Failures pane, or select a node on the Application Map and drill into individual transactions. Each path leads to the same detailed view of a single distributed trace.

The waterfall chart shows the root span at the top, representing the entry point of the request. Child spans nest underneath their parent spans, indented to show the hierarchical relationship. The horizontal timeline shows when each span starts and how long it takes. Sequential operations appear one after another, while parallel operations overlap in the timeline.

Reading the waterfall chart reveals the bottleneck. If the total request duration is 10 seconds and the LLM API call span takes eight seconds, the LLM call is the primary contributor to overall latency. If the embedding generation span shows consistent 200-millisecond timing but the vector search span varies between 100 milliseconds and five seconds, the vector search service has an intermittent performance issue. The visual layout makes these patterns immediately apparent.

Each span in the waterfall shows additional detail when you select it, including the operation name, duration, status code, and any custom attributes you set using `set_attribute()`. If you recorded exceptions on a span, the exception details appear in this view as well, showing the exception type, message, and stack trace alongside the span that captured the error.

## Write KQL queries to analyze trace data

Application Insights stores telemetry in Log Analytics tables that you can query using Kusto Query Language (KQL). Writing KQL queries gives you precise control over trace analysis, letting you answer specific questions about your application's behavior across time ranges, services, and operational patterns that the visual tools can't address directly.

Trace data lands in four primary tables. The `requests` table contains server spans and consumer spans. The `dependencies` table contains client, internal, and producer spans. The `traces` table contains log records. The `exceptions` table contains recorded exceptions. All tables share the `operation_Id` column, which corresponds to the OpenTelemetry trace ID and lets you correlate all telemetry items belonging to the same distributed trace.

The following query finds slow requests and summarizes them by service:

```kusto
requests
| where duration > 3000
| summarize count(), avg(duration) by cloud_RoleName
| order by avg_duration desc
```

This query returns the count and average duration of requests that took longer than three seconds, grouped by cloud role name. The results show you which services contribute the most slow requests and help you prioritize your investigation.

You can join requests with their dependencies to find slow downstream calls that contribute to overall latency:

```kusto
requests
| where duration > 5000
| join kind=inner (dependencies) on operation_Id
| project timestamp, requestName = name, requestDuration = duration,
    dependencyName = name1, dependencyDuration = duration1,
    dependencyTarget = target
| order by requestDuration desc
```

This query connects each slow request with its downstream dependency calls, showing you which outgoing calls contributed to the overall request duration. The `operation_Id` join links all spans in the same distributed trace. If you see that most slow requests have a dependency named "CallLlmApi" with durations over four seconds, you identified the downstream call causing the latency.

You can also query custom attributes stored in `customDimensions` to analyze AI-specific metrics:

```kusto
dependencies
| where name == "GenerateEmbedding"
| extend tokenCount = toint(customDimensions["embedding.token_count"]),
    model = tostring(customDimensions["embedding.model"])
| summarize avg(duration), percentile(duration, 95),
    avg(tokenCount) by model
| order by avg_duration desc
```

This query analyzes embedding generation performance by model, showing average and 95th-percentile durations alongside average token counts. Custom attributes that you set on spans using `set_attribute()` become queryable dimensions that let you segment and filter trace data in ways that are specific to your AI workload.

## Apply diagnostic patterns for AI workloads

AI applications have distinctive failure and performance patterns that differ from traditional web applications. Understanding these patterns helps you interpret trace data effectively and build monitoring that catches problems early.

**Embedding generation timeouts** occur when the embedding model API takes too long to respond or becomes unavailable. You can identify these by querying for dependency spans named after your embedding operation. You can look for spans with durations exceeding your timeout threshold or spans with error status codes. Setting an attribute like `embedding.model` on these spans helps you determine whether the issue is model-specific or affects all embedding calls.

**Vector search cold starts** manifest as high variability in vector search span durations. The first few queries after a period of inactivity might take significantly longer than subsequent queries because the search index needs to load data into memory. You can identify this pattern by looking for clusters of slow search spans that follow periods with no search activity. Querying span attributes like `search.result_count` helps you distinguish between cold starts and genuinely slow queries that return many results.

**LLM token rate limiting** shows up as dependency spans to the LLM API with HTTP 429 status codes or unusually long durations caused by retry delays. Setting attributes like `llm.prompt_tokens` and `llm.response_tokens` on your LLM call spans lets you correlate rate limiting with token usage patterns. You can also identify whether specific queries consume more tokens than expected.

**Context window overflow** occurs when the assembled prompt exceeds the LLM's maximum context window, causing the API to return an error. Adding a `llm.prompt_tokens` attribute to your prompt assembly span helps you detect when prompts approach the context limit and take corrective action.

Building proactive monitoring around these patterns improves reliability. You can:

- Set alerts in Application Insights for latency thresholds on specific operations.
- Use workbooks to create dashboards that display AI pipeline health metrics.
- Correlate trace data with custom metrics to identify trends before they affect users.

## Additional resources

- [Application Map in Application Insights](/azure/azure-monitor/app/app-map)
- [Transaction diagnostics](/azure/azure-monitor/app/transaction-search-and-diagnostics)
