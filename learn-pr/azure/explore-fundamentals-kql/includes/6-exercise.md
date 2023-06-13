You've learned about the structure and use of different types of query statements. Now, let's use that knowledge to write some queries.

## Query with tabular expression statements

Tabular expression statements are fundamental in KQL as they allow us to filter and manipulate tabular data to retrieve desired results.

Let's go through an example. Select the relevant tab for your environment.

### [Azure Data Explorer](#tab/azure-data-explorer)

1. Start with a tabular dataset.

    > [!div class="nextstepaction"]
    > <a href="https://dataexplorer.azure.com/clusters/help/databases/Samples?query=H4sIAAAAAAAAAwsuyS/KdS1LzSspBgBJKV4XCwAAAA==" target="_blank">Run the query</a>

    ```Kusto
    StormEvents
    ```

    **Output:** The complete tabular dataset from the `StormEvents` table.

1. Apply a filter using the `where` operator to select specific events, such as "Flood" events. The `where` operator filters the tabular dataset and preserves the tabular structure.

    > [!div class="nextstepaction"]
    > <a href="https://dataexplorer.azure.com/clusters/help/databases/Samples?query=H4sIAAAAAAAAAwsuyS/KdS1LzSsp5qpRKM9ILUpVAHNDKgtSFWxtFZTccvLzU5QAOwpmISgAAAA=" target="_blank">Run the query</a>

    ```kusto
    StormEvents
    | where EventType == "Flood"
    ```

    **Output**: A tabular dataset of the "Flood" events from the `StormEvents` table.

1. Use another operator to further manipulate the tabular output.

    > [!div class="nextstepaction"]
    > <a href="https://dataexplorer.azure.com/clusters/help/databases/Samples?query=H4sIAAAAAAAAAwsuyS/KdS1LzSsp5qpRKM9ILUpVAHNDKgtSFWxtFZTccvLzU5SAksX5RSUKSZUKwSWJRSUhmbmpConFyQC0yEhVQAAAAA==" target="_blank">Run the query</a>

    ```kusto
    StormEvents
    | where EventType == "Flood"
    | sort by StartTime asc
    ```

    **Output:** A tabular dataset with the "Flood" events sorted in ascending order based on the `StartTime` column from the `StormEvents` table.

### [Azure Monitor](#tab/azure-monitor)

1. Start with a tabular dataset.

    > [!div class="nextstepaction"]
    > <a href="https://ms.portal.azure.com#@72f988bf-86f1-41af-91ab-2d7cd011db47/blade/Microsoft_Azure_Monitoring_Logs/DemoLogsBlade/resourceId/%2FDemo/source/LogsBlade.AnalyticsShareLinkToQuery/q/H4sIAAAAAAAAA%252FNxDCxNLar0yU8vBgDTZ2tdCwAAAA%253D%253D/timespan/P1D" target="_blank">Run the query</a>

    ```Kusto
    LAQueryLogs
    ```

    **Output:** The complete tabular dataset from the `LAQueryLogs` table.

1. Apply a filter using the `where` operator to select specific events, such as "Flood" events. The `where` operator filters the tabular dataset and preserves the tabular structure.

    > [!div class="nextstepaction"]
    > <a href="https://ms.portal.azure.com#@72f988bf-86f1-41af-91ab-2d7cd011db47/blade/Microsoft_Azure_Monitoring_Logs/DemoLogsBlade/resourceId/%2FDemo/source/LogsBlade.AnalyticsShareLinkToQuery/q/H4sIAAAAAAAAA%252FNxDCxNLar0yU8v5qpRKM9ILUpVCMnMTXVPzUstSixJTVFISi0pT03NU9BITM%252FXMDLJ0FTQ01PIyy%252FX0NQEAIdxuSw9AAAA" target="_blank">Run the query</a>

    ```kusto
    LAQueryLogs
    | where TimeGenerated between (ago(24h) .. now())
    ```

    **Output**: A tabular dataset of logs from the past 24 hours in the `LAQueryLogs` table.

1. Use another operator to further manipulate the tabular output.

    > [!div class="nextstepaction"]
    > <a href="https://ms.portal.azure.com#@72f988bf-86f1-41af-91ab-2d7cd011db47/blade/Microsoft_Azure_Monitoring_Logs/DemoLogsBlade/resourceId/%2FDemo/source/LogsBlade.AnalyticsShareLinkToQuery/q/H4sIAAAAAAAAAw3LOw5AQBQF0N4qbjnTKMQGJBINBbEBnxsU3pN5IxOJxXP601b9zfC0uln2Iu0MxHicbCgMU%252BSKmTGRAjdt6opy98hziCbn%252FT9MQ8T8YKBdKsb6%252Fteh0hlW2vIBt1sSz18AAAA%253D" target="_blank">Run the query</a>

    ```kusto
    LAQueryLogs
    | where TimeGenerated between (ago(24h) .. now())
    | sort by ResponseDurationMs desc
    ```

    **Output:** A tabular dataset of logs from the past 24 hours sorted in descending order based on the `ResponseDurationMs` column from the `LAQueryLogs` table.

---

You can repeat the process by applying more operators to the tabular output.
Each operator takes the tabular input, performs its operation, and produces a new tabular output.

## Introduce a variable with a let statement

Let statements allow us to define variables in Kusto queries, making them more readable and modular.

Suppose you want to investigate Flood events within a specific time window and location. You can create variables to set and manipulate these parameters without modifying the query itself.

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

### [Azure Monitor](#tab/azure-monitor)

In the following query, `start` and `end` are variables that can be assigned values according to your specific requirements. The variable is then used within the query to filter the `LAQueryLogs` table for logs from the past 48 hours.

> [!div class="nextstepaction"]
> <a href="https://ms.portal.azure.com#@72f988bf-86f1-41af-91ab-2d7cd011db47/blade/Microsoft_Azure_Monitoring_Logs/DemoLogsBlade/resourceId/%2FDemo/source/LogsBlade.AnalyticsShareLinkToQuery/q/H4sIAAAAAAAAA8tJLVEoLkksKrFNSSxJLcnMTdVQNzDTNTDUNTIwMlbXtObKAapIzUtBkzeHy%252Fs4BpamFlX65KcXc9UolGekFqUqhADVuafmpRYB9aQoJKWWlKem5ilogC1S0NMDmacJVFycD%252BQmVSoEpRYX5OcVp7qUAjVk5uf5FiukpBYnAwDIty9%252FnAAAAA%253D%253D" target="_blank">Run the query</a>

```kusto
let start=datetime('06-01-2023');
let end=datetime('06-07-2023');
LAQueryLogs
| where TimeGenerated between (start .. end)
| sort by ResponseDurationMs desc
```

---

## Translate the query into a function

Now, let's explore how to generalize functionality into a user-defined function. Query-defined functions are a type of user-defined function that work within the scope of a single query and can be reused within that query.

Select the relevant tab for your environment.

### [Azure Data Explorer](#tab/azure-data-explorer)

In the following query, we define a function called `EventsWithInjuries` with two parameters: `state` (string) and `injuryThreshold` (integer). The function filters the `StormEvents` table based on the provided state and injury threshold criteria. Finally, we call the function by passing specific arguments and print the results.

> [!div class="nextstepaction"]
> <a href="https://dataexplorer.azure.com/clusters/help/databases/Samples?query=H4sIAAAAAAAAA8tJLVFwLUvNKykOzyzJ8MzLKi3KTC1WsFXQKC5JLEm1UiguKcrMS9dRyARJVYZkFKUWZ+TnpFgBBUo0Faq5FIAguCS/KBdiCphfo1CekVqUChQHGqFga6sANgtFCmaTS2ZRanKJgjZcwDMvBSJkh24lV601F6ZTNZScHX083fyD/DwdlXQUDA00ARZ8+zbTAAAA" target="_blank">Run the query</a>

```kusto
let EventsWithInjuries = (state: string, injuryThreshold: int) {
    StormEvents
    | where State == state
    | where InjuriesDirect + InjuriesIndirect > injuryThreshold
};
EventsWithInjuries("CALIFORNIA", 10)
```

### [Azure Monitor](#tab/azure-monitor)

In the following query, we define a function called `LogsBetween` with two parameters: `start` (datetime) and `end` (datetime). The function filters the `LAQueryLogs` table based on the provided start and end time criteria. Finally, we call the function by passing specific arguments and print the results.

> [!div class="nextstepaction"]
> <a href="https://ms.portal.azure.com#@72f988bf-86f1-41af-91ab-2d7cd011db47/blade/Microsoft_Azure_Monitoring_Logs/DemoLogsBlade/resourceId/%2FDemo/source/LogsBlade.AnalyticsShareLinkToQuery/q/H4sIAAAAAAAAA8tJLVHwyU8vdkotKU9NzVOwVdAoLkksKrFSSEksSS3JzE3VUUjNS0FwNRWquRSAwMcxsDS1qBKkF8yvUSjPSC1KVQgBqnFPzUstAqpPUUiCGgsxVEFPD2SYJletNReSpRowszXUDcx0DQx1jQyMjNU1dRRQxc2h4prWACDinza1AAAA" target="_blank">Run the query</a>

```kusto
let LogsBetween = (start: datetime, end: datetime) {
    LAQueryLogs
    | where TimeGenerated between (start .. end)
};
LogsBetween(datetime('06-01-2023'), datetime('06-07-2023'));
```

---
