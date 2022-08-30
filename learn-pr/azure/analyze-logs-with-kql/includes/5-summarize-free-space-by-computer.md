Recall that your IT team has noticed recurring issues related to insufficient free space on virtual machines. 

Here, you'll retrieve and transform data from the `Perf` table, using KQL queries, to analyze the free space of the machines logging data to your Log Analytics workspace. 

## Assess log data based on analysis goals

As we've seen the previous exercise, the `Perf` table provides information about the performance of hardware components, operating systems, and applications.

### What are your analysis goals and what information do you need?

To analyze free space usage of machines running in your IT environment, you need information about:

- Total space available on each machine.
- Total space used on each machine.
- Percentage of space used on each machine.

### Which log data and KQL operations can you use?
 
In the previous exercise, we saw that the `Perf` table's `ObjectName` column lists the names of all of the objects being monitored and the `CounterName` column holds the names of the various performance counters that Azure Monitor collects. We also saw that both of these columns hold lots of values, many of which appear multiple times. 

Let's run a query on the `Perf` table to list distinct `ObjectName` values:

```kusto
Perf  // The table you’re querying
| distinct ObjectName // Lists distinct ObjectName values
```

The result set of this query includes all `ObjectName` values currently in the table:

:::image type="content" source="../media/kql-log-analytics-perf-table-distinct-objectname.png" alt-text="Screenshot showing the results of the Distinct ObjectName query on the Perf table with the Logical Disk and LogicalDisk as one word values highlighted." lightbox="../media/kql-log-analytics-perf-table-distinct-objectname.png":::

In our scenario, we're interested in analyzing virtual machines, so the objects we want to look at are `LogicalDisk` and `Logical Disk` (to monitor the memory in a physical machine, you'd look at the `memory` object). The reason there are two very similarly-named objects is that `LogicalDisk` is the object name in Windows records while `Logical Disk` is used in Linux records.
 

To list the distinct names of the counters Azure Monitor collects for the `LogicalDisk` and `Logical Disk` objects, run:

```kusto
Perf  // The table you’re querying  
| where ObjectName == "LogicalDisk" or // The object name used in Windows records
ObjectName == "Logical Disk" // The object name used in Linux records
| distinct CounterName // Lists distinct CounterName values
```

The result set of this query includes all performance counters collected for the the `LogicalDisk` and `Logical Disk` objects:

:::image type="content" source="../media/kql-log-analytics-perf-table-countername.png" alt-text="Screenshot showing the results of the distinct CounterName query on the Perf table with the Free Megabytes, Percentage of Free Space, and Percentage of Used Space values highlighted." lightbox="../media/kql-log-analytics-perf-table-countername.png":::

The performance counters that provide information about used and free space are `% Used Space`, `% Free Space`, and `Free Megabytes`.

Let's assess how we can use this data and which KQL operations can help extract and transform the data:

| Column | Description | Analysis goal | Related KQL operations |
| --- | --- | --- | --- |
| `TimeGenerated` | Indicates when the virtual machine generated each log. | Define the time scope of the analysis. | `where TimeGenerated > ago(1d)` <br/>For more information, see [ago()](/azure/data-explorer/kusto/query/agofunction), [where operator](/azure/data-explorer/kusto/query/whereoperator), and [Numerical operators](/azure/data-explorer/kusto/query/numoperators). |
| `Computer` | Computer from which the event was collected. | Associate CPU usage with a specific computer. | `summarize... by Computer` <br/>For more information, see [summarize operator](/azure/data-explorer/kusto/query/summarizeoperator).|
| `ObjectName` | Holds the names of all of objects for which the table holds performance data. For your analysis, you're interested in the `LogicalDisk` and `Logical Disk` objects. | Monitor the logical disks in virtual machines. | `where ObjectName == "LogicalDisk" or ObjectName == "Logical Disk"`<br/>For more information, see [where operator](/azure/data-explorer/kusto/query/whereoperator) and [== (equals) operator](/azure/data-explorer/kusto/query/equals-cs-operator).|
| `CounterName` | Holds the names of all performance counters in the table. | Monitor counters related to free and used space. | `where CounterName == "Free Megabytes" or CounterName =="% Free Space" or CounterName == "% Used Space"` <br/>For more information, see [where operator](/azure/data-explorer/kusto/query/whereoperator) and [== (equals) operator](/azure/data-explorer/kusto/query/equals-cs-operator).|
| `InstanceName` | Lists the monitored instances of the monitored object. | Monitor all drives on the virtual machine. | `InstanceName == "_Total"` <br/>For more information, see [where operator](/azure/data-explorer/kusto/query/whereoperator) and [== (equals) operator](/azure/data-explorer/kusto/query/equals-cs-operator). |
| `CounterValue` | The measurement collected for the counter.  | Retrieve performance measurements for the `% Used Space`, `% Free Space`, and `Free Megabytes` performance counters.  | `where CounterName == "Free Megabytes" or CounterName =="% Free Space" or CounterName == "% Used Space"`<br/>For more information, see [where operator](/azure/data-explorer/kusto/query/whereoperator) and [== (equals) operator](/azure/data-explorer/kusto/query/equals-cs-operator).|
      
## Summarize free space statistics by computer

1. Retrieve all logs generated in the past day that reported the `% Used Space`, `% Free Space`, and `Free Megabytes` performance counters for the `LogicalDisk` and `Logical Disk` objects:

    ```kusto
    Perf
    | where TimeGenerated > ago(1d)
    | where ObjectName == "LogicalDisk" or // The object name used in Windows records
    ObjectName == "Logical Disk" // The object name used in Linux records
    | where CounterName == "Free Megabytes" or CounterName =="% Free Space" or CounterName == "% Used Space" // Filters for the performance counters Free Megabytes, % Free Space, and % Used Space performance counters
    | where InstanceName == "_Total"  // Retrieves data related to the total usage for all drives on a virtual disk  
    ```

1. Retrieve the last counter value collected for each counter for every virtual machine: 

    ```kusto
    Perf
    | where TimeGenerated > ago(1d)
    | where ObjectName == "LogicalDisk" or // The object name used in Windows records
    ObjectName == "Logical Disk" // The object name used in Linux records
    | where CounterName == "Free Megabytes" or CounterName =="% Free Space" or CounterName == "% Used Space" // Filters for the performance counters Free Megabytes, % Free Space, and % Used Space performance counters
    | where InstanceName == "_Total"  // Retrieves data related to the total usage for all drives on a virtual disk  
    |   summarize arg_max(TimeGenerated, CounterValue) by Computer, CounterName // 
    ```

1. 

    ```kusto
    Perf
    | where TimeGenerated > ago(1d)
    | where ObjectName == "LogicalDisk" or // The object name used in Windows records
    ObjectName == "Logical Disk" // The object name used in Linux records
    | where CounterName == "Free Megabytes" or CounterName =="% Free Space" or CounterName == "% Used Space"
    | where InstanceName == "_Total"
    | summarize arg_max(TimeGenerated, CounterValue) by Computer, CounterName
    | extend CounterValue = iff(CounterName=="% Used Space", 100-CounterValue, CounterValue)
    | extend CounterName = iff(CounterName=="% Used Space", "% Free Space", CounterName)
    | extend CounterValue = iff(CounterName=="Free Megabytes", (CounterValue)*0.001, CounterValue)
    | extend CounterName= iff(CounterName=="Free Megabytes", "OverallFreeSpaceInGB", CounterName)
    | extend packed = pack(CounterName, CounterValue)
    ```

1. Create a property-bag (dictionary), called SpaceStats, of all free space statistics collected for each machine:

    ```kusto
    Perf
    | where TimeGenerated > ago(1d)
    | where ObjectName == "LogicalDisk" or // The object name used in Windows records
    ObjectName == "Logical Disk" // The object name used in Linux records
    | where CounterName == "Free Megabytes" or CounterName =="% Free Space" or CounterName == "% Used Space"
    | where InstanceName == "_Total"
    | summarize arg_max(TimeGenerated, CounterValue) by Computer, CounterName
    | extend CounterValue = iff(CounterName=="% Used Space", 100-CounterValue, CounterValue)
    | extend CounterName = iff(CounterName=="% Used Space", "% Free Space", CounterName)
    | extend CounterValue = iff(CounterName=="Free Megabytes", (CounterValue)*0.001, CounterValue)
    | extend CounterName= iff(CounterName=="Free Megabytes", "OverallFreeSpaceInGB", CounterName)
    | extend packed = pack(CounterName, CounterValue)
    | summarize SpaceStats = make_bag(packed) by Computer
    | where SpaceStats.["% Free Space"]<= 50
    ```