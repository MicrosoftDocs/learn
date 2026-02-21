Kusto Query Language (KQL) is the primary tool developers use to retrieve and analyze telemetry data stored in Azure Monitor logs. Whether you're investigating a spike in errors across your document processing pipeline or measuring how long the classification service takes to respond, KQL provides the operators and functions to extract the answers from your telemetry. This unit introduces the KQL fundamentals you need to start querying Application Insights log data effectively.

> [!NOTE]
> All code examples in this module use KQL queries against Application Insights log tables. The Azure Monitor query experience is updated regularly, and the recommendation is to visit the [Azure Monitor logs documentation](/azure/azure-monitor/logs/log-query-overview) for the most up-to-date information.

## Understand KQL and Azure Monitor logs

KQL is the query language used across Azure Monitor, Log Analytics, and Azure Data Explorer to retrieve and analyze log data. KQL follows a pipe model where queries start with a table name and flow through a sequence of operators separated by the pipe (`|`) character. Each operator takes the output of the previous step, transforms it, and passes the result to the next operator. This approach makes queries readable from top to bottom, with each line representing a distinct step in the data processing pipeline.

Developers write KQL queries in the Log Analytics query editor. You can access the editor from the Azure Monitor menu in the Azure portal, from a specific Application Insights resource, or from any Log Analytics workspace. The editor provides IntelliSense autocompletion, syntax highlighting, and a results pane that displays query output as tables or charts.

Query scoping determines which tables and column names your queries use. When you open logs from an Application Insights resource, the query scope targets that resource's data using the Application Insights table names like `requests`, `exceptions`, and `dependencies`. When you query from a Log Analytics workspace directly, you use the workspace table names like `AppRequests`, `AppExceptions`, and `AppDependencies`. The examples in this module use the Application Insights table names because that's the most common starting point for application developers investigating their own telemetry.

## Explore the Application Insights table structure

Application Insights organizes telemetry into specialized tables, each storing a different category of data collected from your instrumented application. Understanding these tables is essential for knowing where to look when you need specific information. Whether you're searching for failed HTTP requests, slow database calls, or unhandled exceptions, the answer lives in one of these core tables.

The following tables store the telemetry data most relevant to application developers:

- **`requests`:** Stores incoming HTTP requests with details like duration, response code, and success status. Each row represents one request handled by your application.
- **`dependencies`:** Captures outbound calls from your application to databases, HTTP endpoints, Azure services, and other microservices. For AI applications, these calls often include requests to model inference endpoints and vector databases.
- **`exceptions`:** Records errors and exceptions with stack traces and severity levels. Both handled and unhandled exceptions appear in this table.
- **`traces`:** Contains application log messages from frameworks like ILogger, log4j, or Serilog. Each log statement your application writes appears as a row in this table.
- **`customEvents`:** Stores custom business events that developers explicitly track in their code, such as "document classified" or "moderation flagged."
- **`customMetrics`:** Holds custom numeric measurements that developers track, such as queue depth or model inference confidence scores.
- **`performanceCounters`:** Contains system-level metrics like CPU usage, memory consumption, and I/O rates.

All tables share common columns that provide context for every telemetry item. The `timestamp` column records when the event occurred. The `operation_Id` column links all telemetry items from a single distributed trace, making it possible to follow a request as it moves through multiple services. The `cloud_RoleName` column identifies which service generated the telemetry, which is critical for multi-service architectures. The `customDimensions` column contains a dynamic property bag of key-value pairs that developers add to enrich telemetry with application-specific context. The `itemCount` column indicates how many actual events a single sampled record represents, which matters when Application Insights sampling is active.

## Filter and select data with core operators

The most common KQL task is filtering a table down to the rows you care about and selecting the columns you want to see. KQL provides several core operators for this purpose, and most queries you write start with one or more filtering steps followed by a column selection step.

The `where` operator filters rows based on conditions. You can use comparison operators like `==`, `!=`, `>`, and `<` for exact matches and numeric comparisons. For string matching, KQL offers several options with different performance characteristics. The `has` operator checks whether a term appears in a string and uses the column's term index for fast lookups. The `contains` operator checks for substring matches but doesn't use term indexing, making it slower on large datasets. The `startswith` operator matches the beginning of a string. You can combine multiple conditions with the `and` and `or` logical operators.

The `project` operator selects specific columns to include in the output. Using `project` reduces the width of your results and focuses attention on the data that matters for your analysis. You can also rename columns and create calculated columns within a `project` step.

The `take` operator returns an arbitrary set of N rows from the table, which is useful for quickly inspecting the shape of your data. The `top` operator returns the first N rows sorted by a specified column, which is more useful when you need the highest or lowest values. The following query filters for failed requests from the last hour, selects key columns, and returns the 20 slowest failures:

```kusto
requests
| where timestamp > ago(1h)
| where success == false
| project timestamp, name, resultCode, duration, cloud_RoleName
| top 20 by duration desc
```

This query starts with the `requests` table, filters to the last hour using the `ago()` function, narrows to only failed requests, selects five columns, and returns the top 20 results sorted by duration in descending order. Each line performs one clear transformation, making the query easy to read and modify.

## Aggregate and summarize data

Filtering shows you individual records, but understanding trends and patterns requires aggregation. The `summarize` operator groups rows and applies aggregation functions to produce summary statistics. Each unique combination of values in the `by` clause produces one output row in the results.

KQL provides several aggregation functions that work within `summarize`. The `count()` function returns the number of rows in each group. The `avg()`, `sum()`, `min()`, and `max()` functions calculate statistics on numeric columns. The `dcount()` function estimates the count of distinct values using a probabilistic algorithm, which is useful for questions like "how many unique users experienced this error." For exact distinct counts on small datasets, use `count_distinct()`, though it's more resource-intensive at scale. The `percentile()` function calculates a specific percentile value, which is essential for latency analysis where average values can mask outlier behavior. For example, `percentile(duration, 95)` returns the response time below which 95 percent of requests fall.

The `bin()` function groups continuous values like timestamps into fixed-size intervals. Using `bin(timestamp, 1h)` rounds each timestamp down to the nearest hour, creating consistent time buckets for trend analysis. Without `bin()`, each unique millisecond timestamp would create its own group, making aggregation meaningless for time series data.

The following query counts requests and calculates average duration per hour, grouped by service name:

```kusto
requests
| where timestamp > ago(24h)
| summarize requestCount = count(), avgDuration = avg(duration)
    by bin(timestamp, 1h), cloud_RoleName
```

Each row in the output represents one hour of data for one service. This pattern is the foundation for most trend analysis queries, and you can adjust the time window and bin size to match the granularity you need.

## Visualize query results with the render operator

KQL includes the `render` operator for specifying chart types directly in your queries. Adding a `render` step as the final operator in a query tells Log Analytics to display the results as a chart instead of a table. This approach is useful for quickly visualizing trends, distributions, and comparisons without leaving the query editor.

The most common chart types for telemetry data include `timechart`, `barchart`, `piechart`, `columnchart`, and `areachart`. The `timechart` type requires a datetime column and one or more numeric columns, and it's the most frequently used visualization for telemetry because it shows how values change over time. The `barchart` and `columnchart` types work well for comparing values across categories, such as error counts by service. The `piechart` type shows proportional distributions, such as the share of requests handled by each service.

The following query renders a time chart showing request counts by service over the last 24 hours:

```kusto
requests
| where timestamp > ago(24h)
| summarize requestCount = count() by bin(timestamp, 1h), cloud_RoleName
| render timechart
```

Log Analytics displays this query as a line chart with one line per `cloud_RoleName` value and time on the horizontal axis. You can switch between chart types in the results pane without modifying the query, but including `render` in the query itself ensures the visualization is preserved when you pin the results to a dashboard or share the query with team members.

## Additional resources

- [KQL overview](/azure/azure-monitor/logs/log-query-overview)
- [Get started with log queries](/azure/azure-monitor/logs/get-started-queries)
- [Application Insights data model](/azure/azure-monitor/app/data-model-complete)
