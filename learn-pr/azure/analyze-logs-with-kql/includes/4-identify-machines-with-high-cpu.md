Here, you'll write KQL queries to retrieve and transform data from the `Perf` table to gain an understanding of which machines have reached or are nearing their total compute capacity, and which machines are being underused.  

## 1. Set goals

To address performance issues, mitigate potential issues, and identify opportunities to operate more efficiently, you want to analyze the central processing unit (CPU) usage of virtual machines in your IT environment. 

To identify CPU-related performance issues and opportunities to become more efficient, you need information about:

- CPU usage trends of each active machine.
- CPU usage of machines at peak and quiet times.

## 2. Assess logs

Windows and Linux agents send performance counters of hardware components, operating systems, and applications running on monitored machines to the `Perf` table in Azure Monitor.

Let's run a simple query on the `Perf` table to retrieve logs from the past 24 hours and get a sense of the table schema and the data the table holds:

<a href="https://portal.azure.com#@ec7cb332-9a0a-4569-835a-ce7658e8444e/blade/Microsoft_Azure_Monitoring_Logs/DemoLogsBlade/resourceId/%2FDemo/source/LogsBlade.AnalyticsShareLinkToQuery/q/H4sIAAAAAAAAAz2MMQ6CQBBFe0%252FxS62IF7DEloILjNnPMgnu4uwQswmF1%252FB6ngRsaF%252Feex1tAJoG%252FUi4PCai5uX3%252BRrxWmhVUzyteI%252FcQa9P3plo4gy4QWI%252BX8Pln7c6Oa1gyAYmN2VBPFRN8P0%252FS3EEqRsDot9DdQAAAA%253D%253D" target="_blank">Click to run query in Log Analytics demo environment</a>

```kusto
Perf  // The table you’re querying
| where TimeGenerated > ago(1d) // Filters for entries generated in the past day 
```
:::image type="content" source="../media/kql-log-analytics-perf-table.png" alt-text="Screenshot that shows the results of a query on the Perf table with the ObjectName, CounterName, InstanceName, and CounterValue columns highlighted." lightbox="../media/kql-log-analytics-perf-table.png":::

You can see that the `TimeGenerated`, `Computer`, `ObjectName`, `CounterName`, `InstanceName`, and `CounterValue` columns hold data that's relevant to our analysis. 

The `ObjectName` column lists the names of all of the objects for which Azure Monitor collects data from monitored machines. The `CounterName` column holds the names of the various performance counters that Azure Monitor collects. Both of these columns hold lots of values, many of which appear multiple times. To clearly see the distinct values in these columns and determine which counters are relevant to the current analysis, let's run this query:

<a href="https://portal.azure.com#@ec7cb332-9a0a-4569-835a-ce7658e8444e/blade/Microsoft_Azure_Monitoring_Logs/DemoLogsBlade/resourceId/%2FDemo/source/LogsBlade.AnalyticsShareLinkToQuery/q/H4sIAAAAAAAAAwtILUpT0NdXCMlIVShJTMpJVajML33UMLMoVaGwNLWoMjMvnatGISWzuCQzL7lEwT8pKzW5xC8xN1XHOb80ryS1CMQGGeADVFKMUJicn5uUmZdYkpmfV6yQn4akUSExL0UBWXNZYk5pajEAsZPuookAAAA%253D/timespan/P1D" target="_blank">Click to run query in Log Analytics demo environment</a>

```kusto
Perf // The table you’re querying
| distinct ObjectName,CounterName // Lists distinct combinations of ObjectName and CounterName values
```

This screenshot shows the distinct combinations of `ObjectName` and `CounterName` values in the `CounterName` column in the past 24 hours:    

:::image type="content" source="../media/kql-log-analytics-perf-table-cpu.png" alt-text="Screenshot that shows the results of the distinct CounterName query on the Perf table with the Percentage Processor Time value highlighted." lightbox="../media/kql-log-analytics-perf-table-cpu.png":::

The `% Processor Time` counter gives you an understanding of the utilization of the processor, or Central Processing Unit (CPU). This is information you need!

Let's assess how we can use this data, and which KQL operations can help extract and transform the data:

| Column | Description | Analysis goal | Related KQL operations |
| --- | --- | --- | --- |
| `TimeGenerated` | Indicates when the virtual machine generated each log. | Define the time scope of the analysis. | `where TimeGenerated > ago(1d)` <br/>For more information, see [ago()](/azure/data-explorer/kusto/query/agofunction), [where operator](/azure/data-explorer/kusto/query/whereoperator), and [Numerical operators](/azure/data-explorer/kusto/query/numoperators). |
| `Computer` | Computer from which the event was collected. | Associate CPU usage with a specific computer. | `summarize... by Computer` <br/>For more information, see [summarize operator](/azure/data-explorer/kusto/query/summarizeoperator).|
| `ObjectName` | Holds the names of all of the objects for which the table holds performance data.  | Monitor the performance of the processor. | `where ObjectName == "Processor"` <br/>For more information, see [== (equals) operator](/azure/data-explorer/kusto/query/equals-cs-operator).|
| `CounterName` | Holds the names of all of the performance counters in the table. | Monitor the `% Processor Time` performance counter. | `where CounterName == "% Processor Time"` <br/>For more information, see [where operator](/azure/data-explorer/kusto/query/whereoperator) and [== (equals) operator](/azure/data-explorer/kusto/query/equals-cs-operator). |
| `InstanceName` | Lists the monitored instances of the monitored object. | Monitor all processor cores. | `where InstanceName == "_Total"` <br/>For more information, see [where operator](/azure/data-explorer/kusto/query/whereoperator) and [== (equals) operator](/azure/data-explorer/kusto/query/equals-cs-operator). |
| `CounterValue` | The measurement collected for the counter.  | Retrieve performance measurements for the `% Processor Time` performance counter. | `summarize min(CounterValue), avg(CounterValue), max(CounterValue), percentiles(CounterValue, 90,99)` <br/>For more information, see [summarize operator](/azure/data-explorer/kusto/query/summarizeoperator), and the [min()](/azure/data-explorer/kusto/query/min-aggfunction), [max()](/azure/data-explorer/kusto/query/max-aggfunction), [avg()](/azure/data-explorer/kusto/query/avg-aggfunction), and [percentiles()](/azure/data-explorer/kusto/query/percentiles-aggfunction) aggregation functions. |
## 3. Write your query

Write a query that summarizes the average, minimum and maximum CPU usage of all machines over the past day. 

1. Retrieve all logs generated in the past day that reported the `% Processor Time` performance counter:
    
    <a href="https://portal.azure.com#@ec7cb332-9a0a-4569-835a-ce7658e8444e/blade/Microsoft_Azure_Monitoring_Logs/DemoLogsBlade/resourceId/%2FDemo/source/LogsBlade.AnalyticsShareLinkToQuery/q/H4sIAAAAAAAAAz2PsWrDQBBE%252B3zFIDA4lfEHOE0gIU2sQr1ZSyPpgnQn760wAhf5Df%252BevyRnBQ62mp19M1tSW2C3Q9UTJueBWML8%252BL0rcZmpi%252FPdyw3Xnkmo3MhPeqoYG7xBurDdN68Q3%252BB4%252FmFt3zIShwOKUkPNGIMW6%252FY9zN6oeb1BNqzUf9eXjya%252BZradqmAyFM9%252BH25IgIg2XdCbOkZ0uYvzsPTAJNHQyALlsOoW0iQEphxnKQ4jJc7KMZHiH5uG0UEDAQAA" target="_blank">Click to run query in Log Analytics demo environment.</a>    

    ```kusto     
    Perf  // The table you’re querying
    | where TimeGenerated > ago(1d) and ObjectName == "Processor" and CounterName == "% Processor Time" and InstanceName == "_Total" // Filters for entries generated in the past day related to total processor time measurements  
    ```
    
    This query retrieves all logs related to total processor time measurements from the past day. 

    :::image type="content" source="../media/kql-log-analytics-perf-table-1d.png" alt-text="Screenshot that shows the results of a query for all logs generated in the past day that reported the Percentage Processor Time performance counter." lightbox="../media/kql-log-analytics-perf-table-1d.png":::

1. Find the minimum, maximum and average counter values, and calculate the 90th and 99th percentile counter values for each computer: 
    
    <a href="https://portal.azure.com#@ec7cb332-9a0a-4569-835a-ce7658e8444e/blade/Microsoft_Azure_Monitoring_Logs/DemoLogsBlade/resourceId/%2FDemo/source/LogsBlade.AnalyticsShareLinkToQuery/q/H4sIAAAAAAAAA11QTUvDQBC9%252ByseBaGFQvWYQ70IihftoXiVaTJNtmR34%252BxuNeLBv%252BHf85c42ZSIhT0M782%252Bj9mw7IHVCtuGEWnXMnqffr6%252BhfGaWHrj6otPvDWswNZYvmfHQpEr3IBqP7%252BuFiBX4Wl34DI%252BkmWs15htxJccgpdZZm99cpFloi8xLWTVcevBhUiu5GntZesjtbMh351pVSBgrz%252FYRTEcUE9ZjEPUAh2FiIp6CLcZj16fSqCb7KLawTKFJGxVKQBaMCRrScyHUsbNT3GfqU28WIKO9Tlk6f0c6lhK1TMth3%252FUEsXVsigW2PV6B9slJYZGG%252BGQ%252FYfk6mpssll4HOio3er8Ozb5PEWhw58LytEEx8HldBkqG8VHk1%252F0z6uS3AEAAA%253D%253D" target="_blank">Click to run query in Log Analytics demo environment</a>    

    ```kusto     
    Perf  // The table you’re querying
    | where TimeGenerated > ago(1d) and ObjectName == "Processor" and CounterName == "% Processor Time" and InstanceName == "_Total" // Filters for entries generated in the past day related to total processor time measurements  
    | summarize min(CounterValue), avg(CounterValue), max(CounterValue), percentiles(CounterValue, 90,99) by Computer // Presents the minimum, maximum, average, 90th and 99th percentile counter values for each computer 
    ```
    The result set of this query shows the minimum, maximum, average, 90th and 99th percentile `% Processor Time` counter values for each computer for which there's data in your Log Analytics workspace.

    :::image type="content" source="../media/kql-log-analytics-perf-table-min-avg-max-percentiles.png" alt-text="Screenshot that shows the minimum, maximum, average, 90th and 99th percentile results of the query on the Perf table." lightbox="../media/kql-log-analytics-perf-table-min-avg-max-percentiles.png":::

1. Filter the query results for entries where the `% Processor Time` counter value is higher than 80 in the 90th and 99th percentile range:
    
    <a href="https://portal.azure.com#@ec7cb332-9a0a-4569-835a-ce7658e8444e/blade/Microsoft_Azure_Monitoring_Logs/DemoLogsBlade/resourceId/%2FDemo/source/LogsBlade.AnalyticsShareLinkToQuery/q/H4sIAAAAAAAAA4VSzUrDQBC%252B%252BxRDQWih0Hozh3oRFC%252FaQ%252FFapsk0WdmfuLMbjXjwNXw9n8TJJqS1UIQclplvvp%252BZrMnvARYL2FQEAXeaoHXx5%252BvbE7xG8q2y5cUnvFUkhY0ydE%252BWPAYq4AawdNOrYgZoC3javVAeHtEQrFYwWXuXE7Pzk9S9ddEG8mP7EkZAYu1RD5YD2pxG2HbjAupJ5%252B9OaSFg2MsE2eAVMZSjF2UhSIAaOUCBLXjSqR6cfEIB9SgXRA4MIUdPRpgYQAJyNAa9%252BpCWstPB7jPqSLM5YFOelgy%252Bn5Zq8rnwKU38pzWHbDnPshnsWtmDqaM0ukRrT5z0O%252Beiqkw0ibh%252FYCPZyjQdqrSeLJPHQQXyXgSaTmXYDOaV1AeR8XCHoe2xs222lCteLxP7WUzWY45uUHtqlIvc%252FyGybI469AbUcEIelLts%252FwVgQEFWqpQJGUArcr%252Bs8EsKmAIAAA%253D%253D" target="_blank">Click to run query in Log Analytics demo environment</a>

    ```kusto     
    Perf  // The table you’re querying
    | where TimeGenerated > ago(1d) and ObjectName == "Processor" and CounterName == "% Processor Time" and InstanceName == "_Total" // Filters for entries generated in the past day related to total processor time measurements  
    | summarize min(CounterValue), avg(CounterValue), max(CounterValue), percentiles(CounterValue, 90,99) by Computer // Presents the minimum, maximum, average, 90th and 99th percentile counter values for each computer 
    | where percentile_CounterValue_90 > 80 and percentile_CounterValue_99 > 80 // Filters previous query results for instances where the 90th and 99th percentile counters are higher than 80
    ```

    The result set of this query consists of all computers for which the top 10% and 15% `% Processor Time` values are over 80.  

    :::image type="content" source="../media/kql-log-analytics-perf-table-percentiles-over-80.png" alt-text="Screenshot that shows the results of a query that filters for entries where the Percentage Processor Time counter value is higher than 80 in the 90th and 99th percentile range." lightbox="../media/kql-log-analytics-perf-table-percentiles-over-80.png":::

## Challenge: Add operating system information from the Heartbeat table to the query results

You can often get a better understanding of your query results by correlating information from a different table to your query results by using the `join` operator. For more information, see [join operator](/azure/data-explorer/kusto/query/joinoperator?pivots=azuredataexplorer). 

Can you use the `join` operator to add information about the operating system running on each computer, which is available in the `Heartbeat` table, as we saw in the first exercise?

**Solution:**

1. Add information from the `Heartbeat` table about the operating system running on each of the computers in your query results:
    
    <a href="https://portal.azure.com#@ec7cb332-9a0a-4569-835a-ce7658e8444e/blade/Microsoft_Azure_Monitoring_Logs/DemoLogsBlade/resourceId/%2FDemo/source/LogsBlade.AnalyticsShareLinkToQuery/q/H4sIAAAAAAAAA4VTwYrbQAy99yuEoZBAYNNDoT6ksBTa7qUbaOg1KB7Fma1nxh1p0rr00N%252Fo7%252FVLqhkbZ3fpsuDDID3pPenJW4pHgKsr2J0IBA8dwRDS399%252FIsG3RHGwvn3xC76fSAM76%252BgDeYooZOAtYBsWr8wS0Bu4PdxRI5%252FQEWw2UG1jaIg5xKpk34XkheKcfgkzoHQdUTeeBX1DM2y%252FC4JdlfW9t502YDhqBXmJlhjaWYv1IDpAjyxgcIBIXYlL0E9bQD%252FTidKBI%252BQUyWknBtABOTmH0f7UlPWLSe4X7BItV4Dn9nHI4Y%252FHoZ5io%252F1sR%252FwgtYJ6varrJRwG3YPrkybyRNtIXPizcmW1LrnSeHzgWWdrS7WcynrqWh8XFmhGEjhnlmkz2Jw0PpHMxl2K9veV7eu1uvhmXbo%252FialHzD0P%252BkhnGxKPF6LL5tTJKMBOFvLEnGd7bgAGVOTJtlqhBejh9Vql3wV19av1ZmO9%252BgyLj4RRDoSStdzoDQSTMpNBQTjG4ApbNcOq6aDzEeTj%252BK%252FqZ487%252Fxv5ZCL6lsqMuVnhRGMU%252BjSz9jaWxfpGZudXcPt5N%252FS0hOAfnMO1MXyBq4cH61Fs8AzhePE07zH0WaX%252BmcADC7l%252FgwLHA8UDAAA%253D" target="_blank">Click to run query in Log Analytics demo environment</a>

    ```kusto     
    Perf  // The table you’re querying
    | where TimeGenerated > ago(1d) and ObjectName == "Processor" and CounterName == "% Processor Time" and InstanceName == "_Total" // Filters for entries generated in the past day related to total processor time measurements  
    | summarize min(CounterValue), avg(CounterValue), max(CounterValue), percentiles(CounterValue, 90,99) by Computer // Presents the minimum, maximum, average, 90th and 99th percentile counter values for each computer 
    | where percentile_CounterValue_90 > 80 and percentile_CounterValue_99 > 80 // Filters previous query results for instances where the 90th and 99th percentile counters are higher than 50
    | join kind=inner (Heartbeat // Introduces data from the "Heartbeat" table to the previous query results
    | where TimeGenerated > ago(1d) // Time range for the data added from the "Heartbeat" table
    | distinct Computer, OSType) on Computer // Adds distinct combinations of computer and operating system 
    ```

    This iteration of the query adds the `Computer` and `OSType` columns from the `Heartbeat` table to the previous query results. 

    :::image type="content" source="../media/kql-log-analytics-perf-table-union-heartbeat.png" alt-text="Screenshot that shows the results of a query that adds operating system information from the Heartbeat table to the previous query results." lightbox="../media/kql-log-analytics-perf-table-union-heartbeat.png":::

    The `Computer` column now appears twice in the query results - once from the query on the `Perf` table and once from the query on the `Heartbeat` table. The `Computer` column from the `Heartbeat` table has been renamed `Computer1`, but the two tables contain identical data. Having both columns enables correlating the results from the two tables, but you can now filter away the duplicate column.
    
1. Remove the `Computer1` column from the query results: 
    
    <a href="https://portal.azure.com#@ec7cb332-9a0a-4569-835a-ce7658e8444e/blade/Microsoft_Azure_Monitoring_Logs/DemoLogsBlade/resourceId/%2FDemo/source/LogsBlade.AnalyticsShareLinkToQuery/q/H4sIAAAAAAAAA4VTTWvbQBC991cMgoINLnEOhergQAm0zaUxrenVjLRjeVPtrrqz61Slh%252F6N%252Fr3%252Bks6uhBSHhIAOYj7eezPzdkv%252BAHBxAbsjQcCqJehd%252FPfnryf4Ecn32javfsP9kSSw04Y%252BkiWPgRRcATZucamWgFbBbXVHdfiMhmCzgWLrXU3Mzhc5e%252B2iDeSn9GuYCjLqUHVjOaCtaSrb71zAtkj6PuhWABgO0kE2eE0MzaRFWwgyQIccQGEPntocD04%252BgYBuogtCB4aQoycjSAwgA3I0Br3%252BJSltF6Pcb9hGWq4AT83jkMGfj0Md%252BVrwdEt8llpBuV6V5RKqXvZguiiJNNHWE2f%252BpFxYtYkmAw8%252FeJLZmtwdjnk9ZSk%252FMwvUAwmcEsu4GayPEh9JpsPNTfuHyvblWq74bp3Rn60ph5oHN%252Bg8nbSLPDhEls2xDYMAPZ6QR%252BY020sDMKBUHnUjHdKAFt6uRfqdk6t%252B11ZttJU7w%252BIToQ8VYUhabsQDTsXEpDAgHLwzma2YyorR0MkEyRxPqn7R3OltJMt4tA3lGRNY5kSlpPR5ZsFWmoO2dZguv4Lbr7u%252BoyU4e2aH90rxXC43rLTFoJ1lcIf5pmmPrksq5WUC9xzIpEOLwdMDfIP3ONvsMgF%252FIeNONNismDKFQLbR2Fn%252B2Vr%252BA9b2i3YYBAAA" target="_blank">Click to run query in Log Analytics demo environment</a>
    
    ```kusto     
    Perf  // The table you’re querying
    | where TimeGenerated > ago(1d) and ObjectName == "Processor" and CounterName == "% Processor Time" and InstanceName == "_Total" // Filters for entries generated in the past day related to total processor time measurements  
    | summarize min(CounterValue), avg(CounterValue), max(CounterValue), percentiles(CounterValue, 90,99) by Computer // Presents the minimum, maximum, average, 90th and 99th percentile counter values for each computer 
    | where percentile_CounterValue_90 > 80 and percentile_CounterValue_99 > 80 // Filters previous query results for instances where the 90th and 99th percentile counters are higher than 50
    | join kind=inner (Heartbeat // Introduces data from the "Heartbeat" table to the previous query results
    | where TimeGenerated > ago(1d) // Time range for the data added from the "Heartbeat" table
    | distinct Computer, OSType) on Computer // Adds distinct combinations of computer and operating system 
    | project-away Computer1 // Removes the "Computer1" column from the query results 
    ```

    The result set of this query lists all of the computers that reached their full CPU capacity and the operating system running on each computer, which will be helpful for further analysis.

    :::image type="content" source="../media/kql-log-analytics-perf-table-union-heartbeat-project-away.png" alt-text="Screenshot that shows the results of a query that removes the Computer 1 column from the previous query results." lightbox="../media/kql-log-analytics-perf-table-union-heartbeat-project-away.png":::