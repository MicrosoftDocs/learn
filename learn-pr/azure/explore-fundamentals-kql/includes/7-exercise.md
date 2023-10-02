You've learned about the structure and use of different types of query statements. Now, let's use that knowledge to write some queries.

## Query with tabular expression statements

Tabular expression statements are fundamental in KQL as they allow us to filter and manipulate tabular data to return desired results.

Let's go through an example. Select the relevant tab for your environment.

### [Azure Data Explorer](#tab/azure-data-explorer)

Azure Data Explorer offers a help cluster with different types of data preloaded. This cluster can be accessed using the Azure Data Explorer web UI.

> [!div class="nextstepaction"]
> <a href="https://dataexplorer.azure.com/clusters/help" target="_blank">Azure Data Explorer help cluster</a>

The following steps demonstrate how to build a query by applying operators to a starting tabular dataset. Each query is composed of tabular expression statements, some of which contain operators. Operators take a tabular input, perform an operation, and produce a new tabular output.

1. Start with a tabular dataset.

    > [!div class="nextstepaction"]
    > <a href="https://dataexplorer.azure.com/clusters/help/databases/Samples?query=H4sIAAAAAAAAAwsuyS/KdS1LzSspBgBJKV4XCwAAAA==" target="_blank">Run the query</a>

    ```Kusto
    StormEvents
    ```

    **Output:** The complete tabular dataset from the `StormEvents` table.

1. Apply a filter using the `where` operator to select specific events, such as "Flood" events. The `where` operator filters the tabular dataset and preserves the tabular structure.

    > [!div class="nextstepaction"]
    > <a href="https://dataexplorer.azure.com/clusters/help/databases/Samples?query=H4sIAAAAAAAAAwsuyS/KdS1LzSsp5qpRKM9ILUpVCC5JLElVsLVVUHLz8Q/ydHFUAgCymHm6JgAAAA==" target="_blank">Run the query</a>

    ```kusto
    StormEvents
    | where State == "FLORIDA"
    ```

    **Output**: A tabular dataset of `StormEvents` records in the state of "FLORIDA".

1. Use another operator to further manipulate the tabular output.

    > [!div class="nextstepaction"]
    > <a href="https://dataexplorer.azure.com/clusters/help/databases/Samples?query=H4sIAAAAAAAAAwsuyS/KdS1LzSsp5qpRKM9ILUpVCC5JLElVsLVVUHLz8Q/ydHFUAkoV5xeVKCRVKnjmZZUWZaYWu2QWpSaXKKSkFicDAEtNVsxEAAAA" target="_blank">Run the query</a>

    ```kusto
    StormEvents
    | where State == "FLORIDA"
    | sort by InjuriesDirect desc
    ```

    **Output:** A tabular dataset of `StormEvents` records in "FLORIDA" sorted in descending order based on the `InjuriesDirect` column.

### [Azure Monitor/Microsoft Sentinel](#tab/azure-monitor)

Microsoft Sentinel and Log Analytics in Azure Monitor both use the demo environment that is accessed through the **Logs** blade in the Azure portal.

> [!div class="nextstepaction"]
> <a href="https://portal.azure.com/#blade/Microsoft_Azure_Monitoring_Logs/DemoLogsBlade" target="_blank">Log Analytics demo environment</a>


The following steps demonstrate how to build a query by applying operators to a starting tabular dataset. Each query is composed of tabular expression statements, some of which contain operators. Operators take a tabular input, perform an operation, and produce a new tabular output.

1. Start with a tabular dataset.

    > [!div class="nextstepaction"]
    > <a href="https://ms.portal.azure.com#@72f988bf-86f1-41af-91ab-2d7cd011db47/blade/Microsoft_Azure_Monitoring_Logs/DemoLogsBlade/resourceId/%2FDemo/source/LogsBlade.AnalyticsShareLinkToQuery/q/H4sIAAAAAAAAA%252FNxDCxNLar0yU8vBgDTZ2tdCwAAAA%253D%253D/timespan/P1D" target="_blank">Run the query</a>

    ```Kusto
    LAQueryLogs
    ```

    **Output:** The complete tabular dataset from the `LAQueryLogs` table.

1. Apply a filter using the `where` operator to select specific events, such as "Flood" events. The `where` operator filters the tabular dataset and preserves the tabular structure.

    > [!div class="nextstepaction"]
    > <a href="https://ms.portal.azure.com#@72f988bf-86f1-41af-91ab-2d7cd011db47/blade/Microsoft_Azure_Monitoring_Logs/DemoLogsBlade/resourceId/%2FDemo/source/LogsBlade.AnalyticsShareLinkToQuery/q/H4sIAAAAAAAAA%252FNxDCxNLar0yU8v5qpRKM9ILUpVCEotLsjPK051zk9JVVC0VTAyMAAA0cFyMicAAAA%253D/timespan/P1D" target="_blank">Run the query</a>

    ```kusto
    LAQueryLogs
    | where ResponseCode != 200
    ```

    **Output**: A tabular dataset of `LAQueryLogs` records whose response code isn't `200`.

1. Use another operator to further manipulate the tabular output.

    > [!div class="nextstepaction"]
    > <a href="https://ms.portal.azure.com#@72f988bf-86f1-41af-91ab-2d7cd011db47/blade/Microsoft_Azure_Monitoring_Logs/DemoLogsBlade/resourceId/%2FDemo/source/LogsBlade.AnalyticsShareLinkToQuery/q/H4sIAAAAAAAAA%252FNxDCxNLar0yU8v5qpRKM9ILUpVCEotLsjPK051zk9JVVC0VTAyMADKFecXlSgkVcJlXUqLEksy8%252FN8ixVSUouTAReLBGRJAAAA/timespan/P1D" target="_blank">Run the query</a>

    ```kusto
    LAQueryLogs
    | where ResponseCode != 200
    | sort by ResponseDurationMs desc
    ```

    **Output:** A tabular dataset of `LAQueryLogs` records whose response code isn't `200` sorted in descending order based on the `ResponseDurationMs`.

### [Azure Resource Graph](#tab/azure-resource-grid)

The Azure Resource Graph Explorer is accessed through the **Resource Graph Explorer** blade in the Azure portal.

> [!div class="nextstepaction"]
> <a href="https://portal.azure.com/#view/HubsExtension/ArgQueryBlade/query/" target="_blank">Azure Resource Graph Explorer</a>

The following steps demonstrate how to build a query by applying operators to a starting tabular dataset. Each query is composed of tabular expression statements, some of which contain operators. Operators take a tabular input, perform an operation, and produce a new tabular output.

1. Start with a tabular dataset.

    ```Kusto
    resources
    ```

    **Output:** The complete tabular dataset from the `resources` table.

1. Apply a filter using the `where` operator to select specific events, such as "Flood" events. The `where` operator filters the tabular dataset and preserves the tabular structure.

    ```kusto
    resources
    | where location == "eastus"
    ```

    **Output**: A tabular dataset of `resources` in the "eastus" region.

1. Use another operator to further manipulate the tabular output.

    ```kusto
    resources
    | where location == "eastus"
    | distinct subscriptionId
    ```

    **Output:**  A tabular dataset of subscription IDs with `resources` in the "eastus" region.

---

## Introduce a variable with a let statement

Let statements allow us to define variables in KQL queries, making them more readable and modular.

Let's go through an example. Select the relevant tab for your environment.

### [Azure Data Explorer](#tab/azure-data-explorer)

In the following query, `state` and `injuryThreshold` are variables that can be assigned values according to your specific requirements. These variables are then used within the query to filter the `StormEvents` table based on the defined criteria.

> [!div class="nextstepaction"]
> <a href="https://dataexplorer.azure.com/clusters/help/databases/Samples?query=H4sIAAAAAAAAA8tJLVEoLkksSVWwVVAKcY1wDFay5soBCmbmZZUWVYZkFKUWZ+TnpAClDQ2suYJL8otyXctS80qKuWoUyjNSi1IVgiHabaHmJOalKHiCNGemFrtkFqUmlyhowwU881IgQnboFgAA54l2CokAAAA=" target="_blank">Run the query</a>

```kusto
let state = "TEXAS";
let injuryThreshold = 10;
StormEvents
| where State == state and InjuriesDirect + InjuriesIndirect > injuryThreshold
```

### [Azure Monitor/Microsoft Sentinel](#tab/azure-monitor)

In the following query, `responseCodes` is a variable of type dynamic array that contains response codes. The variable is then used within the query to filter the `LAQueryLogs` table for logs with those response codes.

> [!div class="nextstepaction"]
> <a href="https://ms.portal.azure.com#@72f988bf-86f1-41af-91ab-2d7cd011db47/blade/Microsoft_Azure_Monitoring_Logs/DemoLogsBlade/resourceId/%2FDemo/source/LogsBlade.AnalyticsShareLinkToQuery/q/H4sIAAAAAAAAA8tJLVEoSi0uyM8rTnXOT0kttk2pzEvMzUzWiDYxMNBRMLG0jNW05vJxDCxNLar0yU8v5qpRKM9ILUpVCELSppCZp6CBYo4mUF1xflGJQlIlXKVLaVFiSWZ%252Bnm%252BxAlBFMgAwPbQcfAAAAA%253D%253D/timespan/P1D" target="_blank">Run the query</a>

```kusto
let responseCodes=dynamic([400, 499]);
LAQueryLogs
| where ResponseCode in (responseCodes)
| sort by ResponseDurationMs desc
```

### [Azure Resource Graph](#tab/azure-resource-grid)

Let statements aren't supported in Azure Resource Graph.

---
