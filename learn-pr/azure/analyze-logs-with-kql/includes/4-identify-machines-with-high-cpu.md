To address performance issues, mitigate potential issues, and identify opportunities to operate more efficiently, you want to analyze the  CPU usage of virtual machines in your IT environment. 

Here, you'll write KQL queries to retrieve and transform data from the `Perf` table to gain an understanding of which machines have reached or are nearing their total compute capacity and which machines are being underused.  

## Assess log data based on analysis goals

Windows and Linux agents send performance counters of hardware components, operating systems, and applications running on monitored machines to the `Perf` table in Azure Monitor.

### What are your analysis goals and what information do you need?

To analyze the compute usage of machines running in your IT environment, you need information about:

- Central processing unit (CPU) usage of each active machine.
- CPU usage of machines at peak and quiet times.

### Which log data and KQL operations can you use?

Let's run a simple a query on the `Perf` table to retrieve logs from the past 24 hours and get a sense of the table schema and the data the table holds:

```kusto
Perf  // The table you’re querying
| where TimeGenerated > ago(1d) // Filters for entries generated in the past day 
```
:::image type="content" source="../media/kql-log-analytics-perf-table.png" alt-text="Screenshot showing the results of a query on the Heartbeat table with the ObjectName, CounterName, InstanceName, and CounterValue columns highlighted." lightbox="../media/kql-log-analytics-perf-table.png":::

You can see that the `TimeGenerated`, `Computer`, `ObjectName`, `CounterName`, `InstanceName`, and `CounterValue` columns hold data that's relevant to our analysis. 

The `ObjectName` column lists the names of all of the objects for which Azure Monitor collects data from monitored machines. The `CounterName` column holds the names of the various performance counters that Azure Monitor collects. Both of these column holds lots of values, many of which appear multiple times. To clearly see the distinct values in these columns and determine which counters are relevant to the current analysis, let's run this query:

```kusto
Perf
| distinct ObjectName,CounterName // Lists distinct combinations of ObjectName and CounterName values
```

This screenshot shows the distinct combinations of `ObjectName` and `CounterName` values in the `CounterName` column in the past 24 hours:    

:::image type="content" source="../media/kql-log-analytics-perf-table-cpu.png" alt-text="Screenshot showing the results of the distinct CounterName query on the Perf table with the Percentage Processor Time value highlighted." lightbox="../media/kql-log-analytics-perf-table-cpu.png":::

The `% Processor Time` counter gives you an understanding of the utilization of the processor, or Central Processing Unit (CPU). This is information you need!

Let's assess how we can use this data and which KQL operations can help extract and transform the data:

| Column | Description | Analysis goal | Related KQL operations |
| --- | --- | --- | --- |
| `TimeGenerated` | Indicates when the virtual machine generated each log. | Define the time scope of the analysis. | `TimeGenerated > ago(1d)` <br/>For more information, see [ago()](/azure/data-explorer/kusto/query/agofunction) and [Numerical operators](/azure/data-explorer/kusto/query/numoperators). |
| `Computer` | Computer from which the event was collected. | Associate CPU usage with a specific computer. | `summarize... by Computer` <br/>For more information, see [summarize operator](/azure/data-explorer/kusto/query/summarizeoperator).|
| `ObjectName` | Holds the names of all of the objects for which the table holds performance data.  | Monitor the performance of the processor. | `ObjectName == "Processor"` <br/>For more information, see [== (equals) operator](/azure/data-explorer/kusto/query/equals-cs-operator).|
| `CounterName` | Holds the names of all of the performance counters in the table. | Monitor the `"% Processor Time"` performance counter. | `CounterName == "% Processor Time"` <br/>For more information, see [== (equals) operator](/azure/data-explorer/kusto/query/equals-cs-operator). |
| `InstanceName` | xxx | xxx | `InstanceName == "_Total"` <br/>For more information, see [== (equals) operator](/azure/data-explorer/kusto/query/equals-cs-operator). |
| `CounterValue` | The measurement collected for the counter.  | Retrieve performance measurements for `"% Processor Time"` performance counter. | `summarize min(CounterValue), avg(CounterValue), max(CounterValue), percentiles(CounterValue, 90,99)` <br/>For more information, see [summarize operator](/azure/data-explorer/kusto/query/summarizeoperator), and the [min()](/azure/data-explorer/kusto/query/min-aggfunction), [max()](/azure/data-explorer/kusto/query/max-aggfunction), [avg()](/azure/data-explorer/kusto/query/avg-aggfunction), and [percentiles()](/azure/data-explorer/kusto/query/percentiles-aggfunction) aggregation functions. |
## Identify machines with high CPU usage

Write a query that summarizes the average, minimum and maximum CPU usage of all machines over the past day. 

1. Retrieve all logs generated in the past day that reported the `% Processor Time` performance counter:
    
    ```kusto     
    Perf  // The table you’re querying
    | where TimeGenerated > ago(1d) and ObjectName == "Processor" and CounterName == "% Processor Time" and InstanceName == "_Total" // Filters for entries generated in the past day related to total processor time measurements  
    ```
    
    This query retrieves all logs related to total processor time measurements from the past day. 

1. Find the minimum, maximum and average counter values, and calculate the 90th and 99th percentile counter values for each computer: 

    ```kusto     
    Perf  // The table you’re querying
    | where TimeGenerated > ago(1d) and ObjectName == "Processor" and CounterName == "% Processor Time" and InstanceName == "_Total" // Filters for entries generated in the past day related to total processor time measurements  
    | summarize min(CounterValue), avg(CounterValue), max(CounterValue), percentiles(CounterValue, 90,99) by Computer // Presents the minimum, maximum, average, 90th and 99th percentile counter values for each computer 
    ```
    The result set of this query shows the minimum, maximum, average, 90th and 99th percentile `% Processor Time` counter values for each computer for which there's data in your Log Analytics workspace.

1. Filter the query results for entries where the `% Processor Time` counter value is higher than 80 in the 90th and 99th percentile range:
    
    ```kusto     
    Perf  // The table you’re querying
    | where TimeGenerated > ago(1d) and ObjectName == "Processor" and CounterName == "% Processor Time" and InstanceName == "_Total" // Filters for entries generated in the past day related to total processor time measurements  
    | summarize min(CounterValue), avg(CounterValue), max(CounterValue), percentiles(CounterValue, 90,99) by Computer // Presents the minimum, maximum, average, 90th and 99th percentile counter values for each computer 
    | where percentile_CounterValue_90 > 80 and percentile_CounterValue_99 > 80 // Filters previous query results for instances where the 90th and 99th percentile counters are higher than 80
    ```

    The result set of this query consists of all computers for which the top 10% and 15% `% Processor Time` values are over 80.  

## Add operating system information from the Heartbeat table to the query results

To get a better understanding of your query results, you can correlate information from a different table to your query results using the `join` operator. For more information, see [join operator](/azure/data-explorer/kusto/query/joinoperator?pivots=azuredataexplorer). 

Let's add information about the operating system running on each computer, which is available in the `Heartbeat` table, as we saw in the first exercise:

1. Add information from the `Heartbeat` table about the operating system running on each of the computers in your query results:
    
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

    The `Computer` column now appears twice in the query results - once from the query on the `Perf` table and once from the query on the `Heartbeat` table. The `Computer` column from the `Heartbeat` table has been renamed `Computer1`, but the two tables contain identical data. Having both columns enables correlating the results from the two tables, but you can now filter away the duplicate column.
    
1. Remove the `Computer1` column from the query results: 

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

    The result set of this query contains all of the computers that reached their full CPU capacity and includes information about the operating system running on each computer, which will be helpful for further analysis.
