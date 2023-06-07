You've seen the general structure of a KQL query. Now try running a few sample queries.

## Access demo query environments

There are several products that use KQL and offer free environments for practicing sample queries. You can copy/paste the below query examples into these environments.

### Azure Data Explorer help cluster

Azure Data Explorer offers a help cluster with different types of data preloaded. This cluster can be accessed using the Azure Data Explorer web UI.

This environment requires a Microsoft account or an Azure Active Directory user identity.

> [!div class="nextstepaction"]
> [Azure Data Explorer help cluster](https://dataexplorer.azure.com/clusters/help)

### Microsoft Sentinel and Log Analytics in Azure Monitor demo environment

Microsoft Sentinel and Log Analytics both use the demo environment that is accessed through the **Logs** blade in the Azure portal.

This environment requires an Azure subscription. Create a free [Azure account](https://azure.microsoft.com/free/).

> [!div class="nextstepaction"]
> [Log Analytics demo environment](https://portal.azure.com/#blade/Microsoft_Azure_Monitoring_Logs/DemoLogsBlade)

### Azure Resource Graph Explorer

The Azure Resource Graph Explorer is accessed through the **Resource Graph Explorer** blade in the Azure portal.

This environment requires an Azure subscription. Create a free [Azure account](https://azure.microsoft.com/free/).

> [!div class="nextstepaction"]
> [Azure Resource Graph Explorer](https://portal.azure.com/#view/HubsExtension/ArgQueryBlade/query/)

## Sample queries

### [Azure Data Explorer](#tab/azure-data-explorer)

The following query answers the question "What were the top 10 damage causing floods".

The query begins with the *StormEvents* table as the tabular input. It sorts on records for which the *EventType* column is exactly equal to *Flood*. Then the resulting list is sorted in descending order by the value in the *DamageProperty* column. Then the top 10 records are returned.

```kusto
StormEvents
| where EventType == "Flood"
| sort by DamageProperty desc
| take 10
```

### [Log Analytics](#tab/log-analytics)

```kusto
LAQueryLogs
| where TimeGenerated between (ago(24h) .. now())
| sort by ResponseDurationMs desc
| take 10
```

### [Azure Resource Graph](#tab/azure-resource-graph)

```kusto
Resources
| where type contains 'storage'
| sort by todatetime(properties.encryption.services.blob.LastEnabledTime)
| take 10
```

---

