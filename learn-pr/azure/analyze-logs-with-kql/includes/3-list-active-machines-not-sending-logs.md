Here, you'll write KQL queries to retrieve and transform data from the `Heartbeat` table to obtain insights about the status of machines in your environment.  

## 1. Set goals

Your first log analysis goal is to ensure you're getting data about all active virtual machines in your network. You want to identify machines that stop sending data to ensure you have full visibility of all active virtual machines.

To determine which machines have stopped sending data, you need information about:

- All machines that have recently logged data, but haven't logged data as expected in the past few minutes.
- For deeper analysis, it's useful to know which virtual machine agent is running on each machine.

## 2. Assess logs

Azure Monitor uses Azure Monitor Agent to collect data about activities and operating system processes running inside virtual machines. 

> [!NOTE] 
> Some of the older machines in your environment still use the legacy Log Analytics Windows and Linux agents, which Azure Monitor is deprecating. 

Azure Monitor Agent and Log Analytics Agent send virtual machine health data to the `Heartbeat` table once a minute.

Let's run a simple `take 10` query on the `Heartbeat` table to see the type of data each one of its columns holds:

<a href="https://ms.portal.azure.com#@72f988bf-86f1-41af-91ab-2d7cd011db47/blade/Microsoft_Azure_Monitoring_Logs/DemoLogsBlade/resourceId/%2FDemo/source/LogsBlade.AnalyticsShareLinkToQuery/q/H4sIAAAAAAAAA%252FNITSwqSUpNLOGqUShJzE5VMDQAAFjdyScTAAAA/timespan/P1D" target="_blank">Click to run query in Log Analytics demo environment</a>

```kusto
Heartbeat
| take 10
```    

The `TimeGenerated`, `Computer`, `Category`, and `OSType` columns all have data that's relevant to our analysis.

:::image type="content" source="../media/kql-log-analytics-heartbeat-table-agent-version.png" alt-text="Screenshot that shows the results of a take 10 query on the Heartbeat table with the TimeGenerated, Computer, Category, and OSType columns highlighted." lightbox="../media/kql-log-analytics-heartbeat-table-agent-version.png":::

Now let's assess how we can use this data and which KQL operations can help extract and transform the data:

| Column | Description | Analysis goal | Related KQL operations |
| --- | --- | --- | --- |
| `TimeGenerated` | Indicates when the virtual machine generated each log. | <ul><li>Identify recently active machines.</li><li>Find the last log generated for each machine and check whether it was generated in the last few minutes.</li></ul> | <ul><li>`where TimeGenerated >ago(48h)`</li><li>`summarize max(TimeGenerated)`</li><li>`max_TimeGenerated < ago(5m)`</li></ul> For more information, see [where operator](/azure/data-explorer/kusto/query/whereoperator), [summarize operator](/azure/data-explorer/kusto/query/summarizeoperator), [ago()](/azure/data-explorer/kusto/query/agofunction), and [max() (aggregation function)](/azure/data-explorer/kusto/query/max-aggfunction). |
| `Computer` |Unique identifier of the machine. | <ul><li>Summarize results by machine.</li><li>Group machines by distinct agent versions.</li></ul>|  <ul><li>`summarize by Computer`</li><li>`summarize ComputersList=make_set(Computer)`</li></ul> For more information, see [summarize operator](/azure/data-explorer/kusto/query/summarizeoperator) and [make_set() (aggregation function)](/azure/data-explorer/kusto/query/makeset-aggfunction). | 
| `Category` |The agent type: <ul><li>`Azure Monitor Agent` or </li><li>`Direct Agent`, which represents the Log Analytics agents. The Log Analytics agent for Windows is also called MMA. The Log Analytics agent for Linux is also called OMS.</li></ul> | Identify the agent running on the machine. | To simplify the results and facilitate further analysis, such as filtering: <ul><li>Rename the column to `AgentType` (`AgentType=Category`)</li><li> Change the `Direct Agent` value to `MMA` for Windows machines (`AgentType= iif(AgentType == "Direct Agent" and OSType =="Windows", "MMA", AgentType)`.</li><li> Change the `Direct Agent` value to `OMS` for Linux machines (`AgentType= iif(AgentType == "Direct Agent" and OSType =="Linux", "OMS", AgentType`).</li></ul> For more information, see [iff()](/azure/data-explorer/kusto/query/ifffunction) and [== (equals) operator](/azure/data-explorer/kusto/query/equals-cs-operator).|
| `OSType` | The type of operating system running on the virtual machine. | Identify agent type for Log Analytics agents, which are different for Windows and Linux. | `summarize by... OSType`<br/>For more information, see [summarize operator](/azure/data-explorer/kusto/query/summarizeoperator). |
| `Version` | The version number of the agent monitoring the virtual machine. | Identify the agent version on each machine. | Rename the column to `AgentVersion` (`AgentVersion=Version`). |

## 3. Write your query

Write a query that lists the machines that have been active in the past 48 hours, but haven't logged data to the `Heartbeat` table in the last five minutes. 

1. Retrieve all logs from the past 48 hours:

    <a href="https://portal.azure.com#@ec7cb332-9a0a-4569-835a-ce7658e8444e/blade/Microsoft_Azure_Monitoring_Logs/DemoLogsBlade/resourceId/%2FDemo/source/LogsBlade.AnalyticsShareLinkToQuery/q/H4sIAAAAAAAAAz2MMQ7CMBAEe16xJUigNClS0cID8oELLLalYMP5LBSJIt%252FI93gJVoQod0azZ4raQDE0DXpPmAwjMaXymRclnoU6heg2b7w8K%252BjDnSdGqhivOIpL27bzuzWvCirREbekMP%252FLcUCIdYaMi2TuMSaX4f4nqyQekg1tB5%252BK5i97riXsmAAAAA%253D%253D/timespan/P1D" target="_blank">Click to run query in Log Analytics demo environment</a>

    ```kusto
    Heartbeat // The table you’re querying
    | where TimeGenerated >ago(48h) // Time range for the query - in this case, logs generated in the past 48 hours
    ```

    The result set of this query includes logs from all of the machines that sent log data in the past 48 hours. These results likely include numerous logs for each active machine.

    :::image type="content" source="../media/kql-log-analytics-heartbeat-table-48h.png" alt-text="Screenshot that shows the results of a query on the Heartbeat table for all records generated in the past 48 hours." lightbox="../media/kql-log-analytics-heartbeat-table-48h.png":::

    To understand which machines haven't recently sent logs, you only need the last log each machine sent. 
    
1. Find the last log generated by each machine and summarize by computer, agent type, and operating system:     

    <a href="https://portal.azure.com#@ec7cb332-9a0a-4569-835a-ce7658e8444e/blade/Microsoft_Azure_Monitoring_Logs/DemoLogsBlade/resourceId/%2FDemo/source/LogsBlade.AnalyticsShareLinkToQuery/q/H4sIAAAAAAAAA1WQMU7EMBBFe07xy10paJsttgEJbQEdEuQCk2RwLMWeMB4vGFFwDa7HSXCi1QpKz%252Fd%252Fb%252BwHJrWOybDboR0ZRt3EKJJ%252Fvr6V8ZpZi4%252Fu6hNvI9dB6wPfc2Ql4wG35GSzP4zbtV4jKEXHeBGFjec6ruFjPfqEnhI3mMQluAtkDRkzJcP%252BgFGypupLOQRS%252F8EI9L75592iKzhKmLOxNrirLGvLzDfHmjrR0uDxeRksaz2xqecTp9UyLRblXnT4s0LFMfUj%252BjMTFAfMKic%252F1J6P9T2BzEsEdZLtcq8BLW5YdTVrSeYFWX8MqSTj8AupJQD8YQEAAA%253D%253D/timespan/P1D" target="_blank">Click to run query in Log Analytics demo environment</a>

    ```kusto
    Heartbeat // The table you’re querying
    | where TimeGenerated >ago(48h) // Time range for the query - in this case, logs generated in the past 48 hours
    | summarize max(TimeGenerated) by Computer, AgentType=Category, OSType // Retrieves the last record generated by each computer and provides information about computer, agent type, and operating system
    ```
    You now have one log from each machine that logged data in the past 48 hours - the last log each machine sent. 

    In the `summarize` line, you've renamed the `Category` column to `AgentType`, which better describes the information you're looking at in the column as part of this analysis.

    :::image type="content" source="../media/kql-log-analytics-heartbeat-table-last-log.png" alt-text="Screenshot that shows the results of a query for the last log generated by each machine." lightbox="../media/kql-log-analytics-heartbeat-table-last-log.png":::

1. To see which machines haven't sent logs in the last five minutes, filter away all logs generated in the last five minutes:

    <a href="https://portal.azure.com#@ec7cb332-9a0a-4569-835a-ce7658e8444e/blade/Microsoft_Azure_Monitoring_Logs/DemoLogsBlade/resourceId/%2FDemo/source/LogsBlade.AnalyticsShareLinkToQuery/q/H4sIAAAAAAAAA1WQsU7EMAyGd57iH%252B%252BkoltuuAUkdANsJ0F35LYmidQkxXEOghh4DV6PJyGtThWM9u%252F%252F%252F2w%252FMIl2TIrdDq1lKHUjo8T88%252FUtjNfMUlwwV594s1wbrfN8z4GFlAfckomb%252FcFuF3uVIBQM4yUK1F7suIYLtXQJPSVuMEaTYNaQRWRMlBT7A2zMkiovZe9J3AfD0%252FvmH3eLruAY%252FZSVpcFdzdK2THxzrKqJUhqcnubGvNYjqzg%252Bc1oo40wR7qMMf1aocUy9RX%252FJBIUBk8SzG6rPhXqPJ3UxgLqYdZ1rQDMbWlnNYorTHFk%252FhlSSsl8fV494bt0vDzVKTHABAAA%253D/timespan/P1D" target="_blank">Click to run query in Log Analytics demo environment</a>

    ```kusto
    Heartbeat // The table you’re querying
    | where TimeGenerated >ago(48h) // Time range for the query - in this case, logs generated in the past 48 hours
    | summarize max(TimeGenerated) by Computer, AgentType=Category, OSType // Retrieves the last record generated by each computer and provides information about computer, agent type, and operating system
    | where max_TimeGenerated < ago(5m) // Filters away all records generated in the last five minutes
    ```

    The result set of this query includes the last log generated by all machines that logged data in the past 48 hours, but doesn't include logs generated in the past five minutes. In other words, any machine that logged data in the last five minutes isn't included in the result set.

    :::image type="content" source="../media/kql-log-analytics-heartbeat-table-not-sending-logs.png" alt-text="Screenshot that shows the results of a query that filters away all records generated in the last five minutes." lightbox="../media/kql-log-analytics-heartbeat-table-not-sending-logs.png":::

    You now have the data you're looking for: a list of all machines that logged data in the last 48 hours, but haven't been logging data as expected in the last five minutes. The result set consists of the set of computers you want to investigate further.

1. Manipulate the query results to present the information more clearly. 

    For example, you can organize the logs by time generated - from the oldest to the newest - to see which computers have gone the longest time without logging data. 

    The `Direct Agent` value in the AgentType column tells you that the Log Analytics Agent is running on the machine. Since the Log Analytics Agent for Windows is also called OMS and for Linux the agent is also called MMS, renaming the `Direct Agent` value to `MMA` for Windows machines and `OMS` for Linux machines simplifies the results and facilitates further analysis, such as filtering.

    <a href="https://portal.azure.com#@ec7cb332-9a0a-4569-835a-ce7658e8444e/blade/Microsoft_Azure_Monitoring_Logs/DemoLogsBlade/resourceId/%2FDemo/source/LogsBlade.AnalyticsShareLinkToQuery/q/H4sIAAAAAAAAA61Ty27bMBC89ysWPjmAglxSIIeqQOCi6aFGgNpAj8VaWksMSK5Krmyr6KG%252F0d%252Frl3RJqUpS55gTxcfOzM6OPhEG2REKXF3BtiUQ3FmCgfs%252Fv34Hgu89hcH45s1POLakB1vj6I48BRSq4T02vLy%252BaS9yuV5BQN8Q7DmAtFM5XILxujURKoxUgOUmQjOD5EuCDqPA9Q203IcIShh75zCYHwQOT8tnxBewG2DFruuFQnGrWLIdOipXetlwGAq436SDJOsLSTB0oJhZbGIJVHGon0hQNMKqhWqCBPQ1dIEPptY647Ufh2LYA%252B64l%252FldAZi4QZSryEXcJUh1DOIQhdxsnPbw7bl57yC599Zl8z4aq3gR8IgDoLWTxhd8yh3szUEhjVcRUSnoJKTkj0aAMfvlvIWyhMUHo5AyvllkrZNHZbn4anzNx7goYLFe3%252Boyl2ZxqzZNdTTwEfSAttdRB3b%252FgwuPODkHE7YaULXGv4rcz9r4KYm9X29eRWzCyWIz8lOpOgONg%252BbjfH4Yq8S34SBRxxV7q%252BuLLzMtW82SJDpPR%252F1ScE3Ygyq5DDTSnFUW5xkvJhvGaHNo0OsvMrY7ovBe82l75%252BO%252FyIziIJL8BYai7E7wAwAA/timespan/P1D" target="_blank">Click to run query in Log Analytics demo environment</a>

    ```kusto
    Heartbeat // The table you’re querying
    | where TimeGenerated >ago(48h) // Time range for the query - in this case, logs generated in the past 48 hours 
    | summarize max(TimeGenerated) by Computer,AgentType=Category, OSType // Retrieves the last record generated by each computer and provides information about computer, agent type, and operating system
    | where max_TimeGenerated < ago(5m) // Filters away all records generated in the last five minutes
    | extend AgentType= iif(AgentType == "Direct Agent" and OSType =="Windows", "MMA", AgentType) // Changes the AgentType value from "Direct Agent" to "MMA" for Windows machines
    | extend AgentType= iif(AgentType == "Direct Agent" and OSType =="Linux", "OMS", AgentType) // Changes the AgentType value from "Direct Agent" to "OMS" for Linux machines
    | order by max_TimeGenerated asc // Sorts results by max_TimeGenerated from oldest to newest
    | project-reorder max_TimeGenerated,Computer,AgentType,OSType  // Reorganizes the order of columns in the result set
    ```

    > [!TIP]
    > Use `max_TimeGenerated` to correlate the last heartbeat of the machine that stopped reporting with machine logs or other environmental events that occurred around the same time. Correlating logs in this way can help in finding the root cause of the issue you are investigating.

    :::image type="content" source="../media/kql-log-analytics-heartbeat-table-manipulate-results.png" alt-text="Screenshot that shows the results of a query that changes the AgentType values to MMA for Windows machines and to OMS for Linux machines." lightbox="../media/kql-log-analytics-heartbeat-table-manipulate-results.png":::

## Challenge: Group machines by monitoring agent and agent version

Understanding which agents and agent versions are running on your machines can help you analyze the root cause of problems and identify which machines you need to update to a new agent or new agent version.

Can you think of a couple of quick tweaks you can make to the query you developed above to get this information? 

Consider this:

- Which additional information do you need to extract from your logs? 
- Which KQL operation can you use to group machines by the agent version they're running? 

**Solution:**

1. Copy the first five lines from the query and add the `Version` column to the `summarize` line of the query to extract agent version information: 

    <a href="https://portal.azure.com#@ec7cb332-9a0a-4569-835a-ce7658e8444e/blade/Microsoft_Azure_Monitoring_Logs/DemoLogsBlade/resourceId/%2FDemo/source/LogsBlade.AnalyticsShareLinkToQuery/q/H4sIAAAAAAAAA62RsU7DMBCGd57iV6ZWCurSoUuRqiLBQFWJVjA7yTW2lNjBdtIGMfAavB5PwtmpUmDuZNl39913vkcS1mckPGYz7CXBi6wi9Kb9%252FvyyhLeWbK90efOBoyR%252B2KuaHkiTFZ4K3InSTOYLOY3lHIIVuiQcjIWX53LcQmm%252BKodcOEpRmdKhHCExSGiE85gvIE1rHbiha%252BtaWPVOqMVp8qfxFFmPtamb1pNNV8zy%252B76h5ZqDpbF9iu0uPKR4IeuU0cHvmbxV1JGL7arQzlJubPHLhbEkcon8zIbQBRprOlVwndI8WC18AIrMtH7MSyGCBHxsapqA42%252BD652nOo2YIaM7C%252FGAdPLE7xd9KHWYjFcsl0juFTv6ISeJmGEyDiavShfm6JIUyWaz4mMsjftYy7CLYdoLtBNVywuypv4P92bgxO2d2fz1uVSa3BV0n5RuT0F2u9ldRTZwomwkj6o%252F143qd9QCAAA%253D/timespan/P1D" target="_blank">Click to run query in Log Analytics demo environment</a>

    ```kusto    
    Heartbeat // The table you’re querying
    | where TimeGenerated >ago(48h) // Time range for the query - in this case, logs generated in the past 48 hours 
    | summarize max(TimeGenerated) by Computer,AgentType=Category, OSType, Version // Retrieves the last record generated by each computer and provides information about computer, agent type, operating system, and agent version 
    | extend AgentType= iif(AgentType == "Direct Agent" and OSType =="Windows", "MMA", AgentType) // Changes the AgentType value from "Direct Agent" to "MMA" for Windows machines
    | extend AgentType= iif(AgentType == "Direct Agent" and OSType =="Linux", "OMS", AgentType) // Changes the AgentType value from "Direct Agent" to "OMS" for Linux machines
    ```

    :::image type="content" source="../media/kql-log-analytics-heartbeat-table-version.png" alt-text="Screenshot that shows the results of the first five lines of the query we've built up in this exercise, with the Version column added to the Summarize line to add agent version information to the results." lightbox="../media/kql-log-analytics-heartbeat-table-version.png":::

1. Rename the `Version` column to `AgentVersion` for clarity, add another `summarize` line to find unique combinations of agent type, agent version, and operating system type, and use the KQL `make_set()` aggregate function to list all computers running each combination of agent type and agent version: 

    <a href="https://portal.azure.com#@ec7cb332-9a0a-4569-835a-ce7658e8444e/blade/Microsoft_Azure_Monitoring_Logs/DemoLogsBlade/resourceId/%2FDemo/source/LogsBlade.AnalyticsShareLinkToQuery/q/H4sIAAAAAAAAA62SwW7bMAyG73sKwqcU8NBLD714QJEB26FBgSXYjoNsMzZRS3IlKo2HHfYae709ySjJcZJhx54EkeLHn%252BL%252FGZXjGhXD7S3segRW9YAw2fDn12%252BH8BLQTWS6dz%252FhtUcJ7EjjJzToFGMLH1RnV3f3%252FU0qlxQ4ZTqEvXXA%252FVwO74GMXMlDozyWMNjOQ7dAUhJhVJ7h7h56G5wHaeiD1srRDwStjqurxjdQT7C2egyMrnwQFu%252BmEau1JDvrphKetjFQwld0nqyJ%252Br4gO8ID%252BtRuiO0cNta1F1oEi6rpoZnZoEwLo7MHaqWOjAymFUegqm3g5V0JKooATk3tGHHybeAnz6jLhMkvDrMgGRCPjBI%252Fywei%252FWq5QlVB8ZFEI%252Bc3RcLkySRZfCPT2ldflFBsNg9yLKVpH%252Bs%252B7iJPe4Ye1BBkQc7qf%252BFsMydtb2bL1zc9GfRvIPeRTDhGsU%252Bb7ZuIjZwkNpEvpZ6tczKJfyTPlVbP%252BN0jr07hZKSEnI1SzeeFvpOZosztCZyVOvRhYBBi5ARDYvjoiZpMdondXxnjygLZFf%252F3yiBqc4vIjpRhWAYEF4yJFSk%252FYkN7aq7ZfwHUeRTk2AMAAA%253D%253D/timespan/P1D" target="_blank">Click to run query in Log Analytics demo environment</a>

    ```kusto    
    Heartbeat // The table you’re querying
    | where TimeGenerated >ago(48h) // Time range for the query - in this case, logs generated in the past 48 hours 
    | summarize max(TimeGenerated) by Computer,AgentType=Category, OSType, Version // Retrieves the last record generated by each computer and provides information about computer, agent type, operating system, and agent version 
    | extend AgentType= iif(AgentType == "Direct Agent" and OSType =="Windows", "MMA", AgentType) // Changes the AgentType value from "Direct Agent" to "MMA" for Windows machines
    | extend AgentType= iif(AgentType == "Direct Agent" and OSType =="Linux", "OMS", AgentType) // Changes the AgentType value from "Direct Agent" to "OMS" for Linux machines
    | summarize ComputersList=make_set(Computer) by AgentVersion=Version, AgentType, OSType // Summarizes the result set by unique combination of agent type, agent version, and operating system, and lists the set of all machines running the specific agent version
    ```

    You now have the data you're looking for: a list of unique combinations of agent type and agent version and the set of all recently active machines that are running a specific version of each agent. 

    :::image type="content" source="../media/kql-log-analytics-heartbeat-table-make-set.png" alt-text="Screenshot that shows the results of a query that creates a list of all machines running each unique combination of agent type, agent version, and operating system." lightbox="../media/kql-log-analytics-heartbeat-table-make-set.png":::
