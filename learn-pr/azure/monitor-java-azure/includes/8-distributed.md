In this unit, we look at Monitoring the entire solution.

# Introduction

## Log analytics

## Analyze the logs in Log Analytics

After your application is properly set up, your application console log will be streamed to Log Analytics. The structure enables efficient query in Log Analytics.

### Use Log Analytics

There are actually three ways to access your application's logs: Azure Storage, Azure Events Hub, and Log Analytics. We'll focus here on Log Analytics as it's the most common one, and as it's integrated into Azure Spring Cloud.

Log Analytics is part of Azure Monitor, which is integrated into Azure Spring Cloud for metrics monitoring.

1. In the Azure portal, in the left pane, select **Log Analytics**.
1. Select the Log Analytics workspace that you chose when you added your diagnostics settings.
1. To open the **Log Search** pane, select **Logs**.
1. In the **Tables** search box,

   * to view logs, enter a query such as:

    ```sql
    AppPlatformLogsforSpring
    | limit 50
    ```

    * to view metrics, enter a query such as:

    ```sql
    AzureMetrics
    | limit 50
    ```

1. To view the search result, select **Run**.
1. You can search the logs of the specific application or instance by setting a filter condition:

    ```sql
    AppPlatformLogsforSpring
    | where ServiceName == "YourServiceName" and AppName == "YourAppName" and InstanceName == "YourInstanceName"
    | limit 50
    ```

## Analyze the logs

Application logs provide critical information and verbose logs about your application's health, performance, and more. In the next sections are some  queries to help you understand your application's current and past states.

### Show application logs from Azure Spring Cloud

To review a list of application logs from Azure Spring Cloud, sorted by time with the most recent logs shown first, run the following query:

```sql
AppPlatformLogsforSpring
| project TimeGenerated , ServiceName , AppName , InstanceName , Log
| sort by TimeGenerated desc
```

### Show logs entries containing errors or exceptions

To review unsorted log entries that mention an error or exception, run the following query:

```sql
AppPlatformLogsforSpring
| project TimeGenerated , ServiceName , AppName , InstanceName , Log
| where Log contains "error" or Log contains "exception"
```

Use this query to find errors, or modify the query terms to find specific error codes or exceptions.

### Show the number of errors and exceptions reported by your application over the last hour

To create a pie chart that displays the number of errors and exceptions logged by your application, run the following query:

```sql
AppPlatformLogsforSpring
| where TimeGenerated > ago(1h)
| where Log contains "error" or Log contains "exception"
| summarize count_per_app = count() by AppName
| sort by count_per_app desc
| render piechart
```

# Database Monitoring

Monitoring data about your servers helps you troubleshoot and optimize for your workload. Azure Database for MySQL provides various metrics that give insight into the behavior of your server.

## Metrics

## Query Store

Query Store is a feature that keeps track of query performance over time including query runtime statistics and wait events

## Query Performance Insight

Query Performance Insight works in conjunction with Query Store to provide visualizations accessible from the Azure portal. These charts enable you to identify key queries that impact performance. Query Performance Insight is accessible in the Intelligent Performance section of your Azure Database for MySQL server's portal page.

Query Performance Insight helps you to quickly identify what your longest running queries are, how they change over time, and what waits are affecting them.

## Performance Recommendations

The Performance Recommendations feature identifies opportunities to improve workload performance. Performance Recommendations provides you with recommendations for creating new indexes that have the potential to improve the performance of your workloads. To produce index recommendations, the feature takes into consideration various database characteristics, including its schema and the workload as reported by Query Store

# OpenTelemetry

OpenTelemetry is an open source, vendor-agnostic, single distribution of libraries to provide metrics collection and distributed tracing for services.
OpenTelemetry standardizes what telemetry data looks like and is a set of APIs, SDKs, tooling, and integrations that are designed for the creation and management of telemetry data such as traces, metrics, and logs.

For new environments, OpenTelemetry is deployed as an agent on each host within an environment and configured to send telemetry data to the user’s desired back-end(s).
For legacy environments, the OpenTelemetry supports many popular open-source wire formats including Jaeger, Prometheus, and Fluent Bit.

## Integration with Azure

Once OpenTelemetry data has been exported to Azure Monitor, you can access Application Insights and distributed traces and metrics.

# UI monitoring

The next unit is a knowledge check to see what you've learned in this module.
