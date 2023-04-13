Azure Monitor can give you insights into how well your search service is being used and performing. You can also receive alerts to proactively notify you of issues.

Here, you'll explore all the monitoring options available for Azure Cognitive Search. Then you'll learn about useful alerts you can create to manage your search solution.

## Monitor Azure Cognitive Search in Azure Monitor

When you create your Azure Cognitive Search service, without you doing any other setup, you can see your current search latency, queries per second, and the percentage of throttled queries. This data can be viewed on the **Monitoring** tab of the **Overview** page.

:::image type="content" source="../media/azure-monitor-cognitive-search.png" alt-text="A screenshot of the monitor tab in Azure Cognitive Search." lightbox="../media/azure-monitor-cognitive-search.png":::

You can also check what resources your search solution is using on the **Usage** tab.

:::image type="content" source="../media/usage-tab-cognitive-services.png" alt-text="A screenshot of the usage tab on the overview page of Azure Cognitive Search service." lightbox="../media/usage-tab-cognitive-services.png":::

This basic information is a good start to monitoring, but you can go further with some more configuration. If you're familiar with supporting other resources on the Azure platform, you'll know that Azure Monitor can be used for all your Azure resources.

In fact, you've already seen how to enable Azure Monitor in the [optimize performance](/training/modules/maintain-azure-cognitive-search-solution/03-optimize-performance-of-azure-cognitive-search-solution) unit. Follow those steps to allow Azure Monitor to use data captured in Log Analytics to see a full set of diagnostic data.

Once you have started using Log Analytics, you get access to performance and diagnostic data in these log tables:

- **AzureActivity** - Shows you tasks that have been executed like scaling the search service
- **AzureDiagnostics** - All the query and indexing operations
- **AzureMetrics** - Data used for metrics that measure the health and performance of your search service

### Use metrics to see diagnostic data visually

Creating charts is a powerful way to view how your search service is performing. Under the **Monitoring** section of your search service, select **Metrics**.

:::image type="content" source="../media/cognitive-search-metrics.png" alt-text="A screenshot of the metrics page." lightbox="../media/cognitive-search-metrics.png":::

Now select to add any of these captured metrics:

- DocumentsProcessedCount
- SearchLatency
- SearchQueriesPerSecond
- SkillExecutionCount
- ThrottledSearchQueriesPercentage

For example, you could plot search latency against the percentage of throttled queries to see if the responses to queries are affected by throttling.

### Write Kusto queries against your search solutions logs

Log Analytics allows you to write any Kusto query against captured log data. The easiest way to run these queries is by selecting **Logs** under the Monitor section. **Logs** opens Log Analytics with the quest window automatically scoped to your Azure Cognitive Search solution.

:::image type="content" source="../media/azure-diagnostic-log-analytics-query.png" alt-text="A screenshot of a Log Analytics Kusto query against the AzureDiagnostic table." lightbox="../media/azure-diagnostic-log-analytics-query.png":::


The above query lets you see a list of recent operations and how many times they happened.

```kusto
AzureDiagnostics
| summarize count() by OperationName
```

The following are useful queries to help you monitor and diagnose issues with your search solution:

:::row:::
    :::column:::
        **Query**
    :::column-end:::
    :::column:::
        **Kusto**
    :::column-end:::
:::row-end:::

<hr>

:::row:::
    :::column:::
        Long-running queries
    :::column-end:::
    :::column:::
        ```kusto
          AzureDiagnostics
          | project OperationName, resultSignature_d, DurationMs, Query_s, Documents_d, IndexName_s
          | where OperationName == "Query.Search"
          | sort by DurationMs
        ```
    :::column-end:::
:::row-end:::
:::row:::
    :::column:::
        Indexer status
    :::column-end:::
    :::column:::
        ```kusto
          AzureDiagnostics
          | project OperationName, Description_s, Documents_d, ResultType, resultSignature_d
          | where OperationName == "Indexers.Status"
        ```
    :::column-end:::
:::row-end:::
:::row:::
    :::column:::
        HTTP status codes
    :::column-end:::
    :::column:::
        ```kusto
          AzureDiagnostics
          | where TimeGenerated > ago(7d)
          | summarize count() by resultSignature_d
          | render barchart
        ```
    :::column-end:::
:::row-end:::
:::row:::
    :::column:::
        Query rates
    :::column-end:::
    :::column:::
        ```kusto
          AzureDiagnostics
          | where OperationName == "Query.Search" and TimeGenerated > ago(1d)
          | extend MinuteOfDay = substring(TimeGenerated, 0, 16) 
          | project MinuteOfDay, DurationMs, Documents_d, IndexName_s
          | summarize QPM=count(), AvgDuractionMs=avg(DurationMs), AvgDocCountReturned=avg(Documents_d)  by MinuteOfDay
          | order by MinuteOfDay desc 
          | render timechart
        ```
    :::column-end:::
:::row-end:::
:::row:::
    :::column:::
        Average Query Latency
    :::column-end:::
    :::column:::
        ```kusto
        let intervalsize = 1m; 
        let _startTime = datetime('2021-02-23 17:40');
        let _endTime = datetime('2021-02-23 18:00');
        AzureDiagnostics
        | where TimeGenerated between(['_startTime']..['_endTime']) // Time range filtering
        | summarize AverageQueryLatency = avgif(DurationMs, OperationName in ("Query.Search", "Query.Suggest", "Query.Lookup", "Query.Autocomplete"))
            by bin(TimeGenerated, intervalsize)
        | render timechart
        ```
    :::column-end:::
:::row-end:::
:::row:::
    :::column:::
        Average Queries Per Minute (QPM)
    :::column-end:::
    :::column:::
        ```kusto
        let intervalsize = 1m; 
        let _startTime = datetime('2021-02-23 17:40');
        let _endTime = datetime('2021-02-23 18:00');
        AzureDiagnostics
        | where TimeGenerated between(['_startTime'] .. ['_endTime']) // Time range filtering
        | summarize QueriesPerMinute=bin(countif(OperationName in ("Query.Search", "Query.Suggest", "Query.Lookup", "Query.Autocomplete"))/(intervalsize/1m), 0.01)
          by bin(TimeGenerated, intervalsize)
        | render timechart
        ```
    :::column-end:::
:::row-end:::
:::row:::
    :::column:::
        Indexing Operations Per Minute (OPM)
    :::column-end:::
    :::column:::
        ```kusto
        let intervalsize = 1m; 
        let _startTime = datetime('2021-02-23 17:40');
        let _endTime = datetime('2021-02-23 18:00');
        AzureDiagnostics
        | where TimeGenerated between(['_startTime'] .. ['_endTime']) // Time range filtering
        | summarize IndexingOperationsPerSecond=bin(countif(OperationName == "Indexing.Index")/ (intervalsize/1m), 0.01)
          by bin(TimeGenerated, intervalsize)
        | render timechart
        ```
    :::column-end:::
:::row-end:::

## Create alerts to be notified about common search solution issues

Alerts can let you proactively manage your search service. Here are some commonly used alerts you should consider creating:

:::image type="content" source="../media/cogntive-search-alerts.png" alt-text="A screenshot of all the metric you can create alerts for." lightbox="../media/cogntive-search-alerts.png":::

- **Search Latency** using the metric signal, you can specify what latency triggers the alert in seconds
- **Throttled search percentage** using the metric signal, you can specify the percentage
- **Delete Search Service** using the activity log signal, be notified if your search service is deleted
- **Stop Search Service** using the activity log signal, be notified if your search service is stopped which happens if your search service is scaled up or down or needs to be restarted
