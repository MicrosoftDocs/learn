You've seen the general structure of a KQL query. Now try running a few sample queries.

## Access demo query environments

Some of the products that use KQL offer free environments that you can use for practicing queries. Choose the tab below that corresponds to the query environment you want to use.

### [Azure Data Explorer](#tab/azure-data-explorer)

Azure Data Explorer offers a help cluster with different types of data preloaded. This cluster can be accessed using the Azure Data Explorer web UI.

> [!div class="nextstepaction"]
> <a href="https://dataexplorer.azure.com/clusters/help" target="_blank">Azure Data Explorer help cluster</a>

#### Prerequisites

This environment requires a Microsoft account or an Azure Active Directory user identity.

#### Run sample query

The following query answers the question, "What were the top 10 property damages caused by floods?"

> [!div class="nextstepaction"]
> <a href="https://dataexplorer.azure.com/clusters/help/databases/Samples?query=H4sIAAAAAAAAAwsuyS/KdS1LzSsp5uWqUSjPSC1KVQDzQyoLUhVsbRWU3HLy81OUQLLF+UUlCkmVCi6JuYnpqQFF+QWpRSWVCimpxckg6ZLE7FQFQwMA6xT+vFMAAAA=" target="_blank">Run the query</a>

```kusto
StormEvents
| where EventType == "Flood"
| sort by DamageProperty desc
| take 10
```

Here's a step-by-step analysis of how the query processes the data.

1. The query begins with the *StormEvents* table as the tabular input.
1. It filters on records for which the *EventType* column is exactly equal to *Flood*. 
1. Then the resulting list is sorted in descending order by the value in the *DamageProperty* column. 
1. Finally, the top 10 records are returned.

### [Azure Monitor/Microsoft Sentinel](#tab/azure-monitor)

Microsoft Sentinel and Log Analytics in Azure Monitor both use the demo environment that is accessed through the **Logs** blade in the Azure portal.

> [!div class="nextstepaction"]
> <a href="https://portal.azure.com/#blade/Microsoft_Azure_Monitoring_Logs/DemoLogsBlade" target="_blank">Log Analytics demo environment</a>

#### Prerequisites

This environment requires an Azure subscription. Create a free [Azure account](https://azure.microsoft.com/free/).

#### Run sample query

The following query answers the question, "What were the top 10 longest response duration log queries in the past day?"

> [!div class="nextstepaction"]
> <a href="https://ms.portal.azure.com#@72f988bf-86f1-41af-91ab-2d7cd011db47/blade/Microsoft_Azure_Monitoring_Logs/DemoLogsBlade/resourceId/%2FDemo/source/LogsBlade.AnalyticsShareLinkToQuery/q/H4sIAAAAAAAAAw3LQQqDMBAF0L2n%252BMtkI1p6gUKhG11UvECsH5XSmZJJCEIP3%252BzfG27PzHgOulnzQ9kZifn48EFhDIkrFqZCClzY1F2uu0fbQrQ47%252BswjQnLiYn2VTHec12HymhYaa8qUngTffcHoyTzYmkAAAA%253D" target="_blank">Run the query</a>

```kusto
LAQueryLogs
| where TimeGenerated between (ago(24h) .. now())
| sort by ResponseDurationMs desc
| take 10
```

Here's a step-by-step analysis of how the query processes the data.

1. The query begins with the *LAQueryLogs* table as the tabular input.
1. It filters on records for which the *TimeGenerated* column is between 24 hours ago and now, meaning in the past day. 
1. Then the resulting list is sorted in descending order by the value in the *ResponseDurationMs* column. 
1. Finally, the top 10 records are returned.

### [Azure Resource Graph](#tab/azure-resource-graph)

The Azure Resource Graph Explorer is accessed through the **Resource Graph Explorer** blade in the Azure portal.

> [!div class="nextstepaction"]
> <a href="https://portal.azure.com/#view/HubsExtension/ArgQueryBlade/query/" target="_blank">Azure Resource Graph Explorer</a>

#### Prerequisites

This environment requires an Azure subscription. Create a free [Azure account](https://azure.microsoft.com/free/).

#### Run sample query

The following query answers the question, "What were the top 10 most recently enabled storage resources?"

```kusto
resources
| where type contains 'storage'
| sort by todatetime(properties.encryption.services.blob.LastEnabledTime)
| take 10
```

Here's a step-by-step analysis of how the query processes the data.

1. The query begins with the *Resources* table as the tabular input.
1. It filters on records for which the *type* column contains the term *storage*. 
1. Then the resulting list is sorted in descending order by the *LastEnabledTime* value in the dynamic field called *properties*. 
1. Finally, the top 10 records are returned.
---

