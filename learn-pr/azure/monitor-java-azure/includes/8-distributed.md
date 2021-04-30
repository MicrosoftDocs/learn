In this unit, we look at Monitoring end-to-end monitoring applications concepts.

# Introduction

## Database

## Log analytics

## Analyze the logs in Log Analytics

After your application is properly set up, your application console log will be streamed to Log Analytics. The structure enables efficient query in Log Analytics.

### Use Log Analytics

There are actually three ways to access your application's logs: Azure Storage, Azure Events Hub, and Log Analytics. We will focus here on Log Analytics as it's the most common one, and as it's integrated into Azure Spring Cloud.

Log Analytics is part of Azure Monitor, which is well-integrated into Azure Spring Cloud and which we will also use for metrics monitoring.

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

To create a pie chart that displays the number of errors and exceptions logged by your application in the last hour, run the following query:

```sql
AppPlatformLogsforSpring
| where TimeGenerated > ago(1h)
| where Log contains "error" or Log contains "exception"
| summarize count_per_app = count() by AppName
| sort by count_per_app desc
| render piechart
```

# What is OpenTelemetry?

OpenTelemetry is an open source, vendor-agnostic, single distribution of libraries to provide metrics collection and distributed tracing for services.

# UI monitoring

The next unit is a knowledge check to see what you've learned in this module.
