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

<a href="https://portal.azure.com#@ec7cb332-9a0a-4569-835a-ce7658e8444e/blade/Microsoft_Azure_Monitoring_Logs/DemoLogsBlade/resourceId/%2FDemo/source/LogsBlade.AnalyticsShareLinkToQuery/q/H4sIAAAAAAAAAwtILUpT0NdXCMlIVShJTMpJVajML33UMLMoVaGwNLWoMjMvnatGISWzuCQzL7lEwT8pKzW5xC8xNxWkyQcoXIxVsiwxpzS1GAB8NbsmXQAAAA%253D%253D/timespan/P1D" target="_blank">Click to run query in Log Analytics demo environment</a>

```kusto
Perf // The table you’re querying
| distinct ObjectName // Lists distinct ObjectName values
```

The result set of this query includes all `ObjectName` values currently in the table:

:::image type="content" source="../media/kql-log-analytics-perf-table-distinct-objectname.png" alt-text="Screenshot showing the results of the Distinct ObjectName query on the Perf table with the Logical Disk and LogicalDisk as one word values highlighted." lightbox="../media/kql-log-analytics-perf-table-distinct-objectname.png":::

In our scenario, we're interested in analyzing virtual machines, so the objects we want to look at are `LogicalDisk` and `Logical Disk` (to monitor the memory in a physical machine, you'd look at the `memory` object). The reason there are two very similarly-named objects is that `LogicalDisk` is the object name in Windows records while `Logical Disk` is used in Linux records.
 

To list the distinct names of the counters Azure Monitor collects for the `LogicalDisk` and `Logical Disk` objects, run:

<a href="https://portal.azure.com#@ec7cb332-9a0a-4569-835a-ce7658e8444e/blade/Microsoft_Azure_Monitoring_Logs/DemoLogsBlade/resourceId/%2FDemo/source/LogsBlade.AnalyticsShareLinkToQuery/q/H4sIAAAAAAAAA33MMQ6CQBCF4d5TvHABTkClJVELE%252BuFHWEUd%252BPMrkhC4TW8nidxxWhFbN%252F8821JDshz7FpCMFVHGHx83h9CuESSgV0DLEb0LaVpUx2pDmtzJhQFstI3XJtuxXrK4OXr%252BKmCe2dRyYId9uys7xVCtReri3kJH%252BqPU7KLt58ywrIGdqla%252BugCySSm%252FzLtOn%252B9mi6SvgDYtn9E%252BQAAAA%253D%253D/timespan/P1D" target="_blank">Click to run query in Log Analytics demo environment</a>

```kusto
Perf // The table you’re querying  
| where ObjectName == "LogicalDisk" or // The object name used in Windows records
ObjectName == "Logical Disk" // The object name used in Linux records
| distinct CounterName // Lists distinct CounterName values
```

The result set of this query includes all performance counters collected for the the `LogicalDisk` and `Logical Disk` objects:

:::image type="content" source="../media/kql-log-analytics-perf-table-countername.png" alt-text="Screenshot showing the results of the distinct CounterName query on the Perf table with the Free Megabytes, Percentage of Free Space, and Percentage of Used Space values highlighted." lightbox="../media/kql-log-analytics-perf-table-countername.png":::

The performance counters that provide information about used and free space are `% Used Space`, `% Free Space`, and `Free Megabytes`. We have two similar counters - `% Free Space` and `% Used Space` - collected from Windows and Linux records, respectively. 

Let's assess how we can use this data and which KQL operations can help extract and transform the data:

| Column | Description | Analysis goal | Related KQL operations |
| --- | --- | --- | --- |
| `TimeGenerated` | Indicates when the virtual machine generated each log. | Define the time scope of the analysis. | `where TimeGenerated > ago(1d)` <br/>For more information, see [ago()](/azure/data-explorer/kusto/query/agofunction), [where operator](/azure/data-explorer/kusto/query/whereoperator), and [Numerical operators](/azure/data-explorer/kusto/query/numoperators). |
| `Computer` | Computer from which the event was collected. | Associate CPU usage with a specific computer. | `summarize... by Computer` <br/>For more information, see [summarize operator](/azure/data-explorer/kusto/query/summarizeoperator).|
| `ObjectName` | Holds the names of all of objects for which the table holds performance data. For your analysis, you're interested in the `LogicalDisk` and `Logical Disk` objects. | Monitor the logical disks in virtual machines. | `where ObjectName == "LogicalDisk" or ObjectName == "Logical Disk"`<br/>For more information, see [where operator](/azure/data-explorer/kusto/query/whereoperator) and [== (equals) operator](/azure/data-explorer/kusto/query/equals-cs-operator).|
| `CounterName` | Holds the names of all performance counters in the table. | Monitor counters related to free and used space. | <ul><li>`where CounterName == "Free Megabytes" or CounterName =="% Free Space" or CounterName == "% Used Space"`</li><li>`extend CounterName = iff(CounterName=="% Used Space", "% Free Space", CounterName)` </li></ul>For more information, see [where operator](/azure/data-explorer/kusto/query/whereoperator) and [== (equals) operator](/azure/data-explorer/kusto/query/equals-cs-operator).|
| `InstanceName` | Lists the monitored instances of the monitored object. | Monitor all drives on the virtual machine. | `InstanceName == "_Total"` <br/>For more information, see [where operator](/azure/data-explorer/kusto/query/whereoperator) and [== (equals) operator](/azure/data-explorer/kusto/query/equals-cs-operator). |
| `CounterValue` | The measurement collected for the counter.  | Retrieve performance measurements for the `% Used Space`, `% Free Space`, and `Free Megabytes` performance counters.  | `where CounterName == "Free Megabytes" or CounterName =="% Free Space" or CounterName == "% Used Space"`<br/>For more information, see [where operator](/azure/data-explorer/kusto/query/whereoperator) and [== (equals) operator](/azure/data-explorer/kusto/query/equals-cs-operator).|
      
## Summarize free space statistics by computer

1. Retrieve all logs generated in the past day that reported the `% Used Space`, `% Free Space`, and `Free Megabytes` performance counters for the `LogicalDisk` and `Logical Disk` objects:

    <a href="https://portal.azure.com#@ec7cb332-9a0a-4569-835a-ce7658e8444e/blade/Microsoft_Azure_Monitoring_Logs/DemoLogsBlade/resourceId/%2FDemo/source/LogsBlade.AnalyticsShareLinkToQuery/q/H4sIAAAAAAAAA32R3UoDMRCF7%252FsUhwVBoVB8gHqjVIT6g1a8lOlmuo1mkzKZbRV8eJNUlxaWXp9vvzl78sSyGv1gt2ZhLGzLt%252BxZSNngCtSE80tz0eePyw%252Bu9YFaxnSKah4aW5O7sfGzQhBMJlisGaFQ8BnrYhJZjzfrTdhFCNdBTBwNm7BXnfDMre%252B%252Best%252Fr%252BvQeWXpdTNhxj03tPxWjqXbMVKdoTAvG6p5IEcCXvPJPyA1mlmX8ohVgjW126ThgrTka0a9%252Fzji%252BPAYh2fGIG9w6B109D9156PmpK%252F0vghKrkJu88wqlrccYUgpDeLKk2ko3TSDaTNquPQl52DEZjx4ELZWtEuESXP%252FAsyG8IcBAgAA" target="_blank">Click to run query in Log Analytics demo environment</a>    

    ```kusto
    Perf
    | where TimeGenerated > ago(1d)
    | where ObjectName == "LogicalDisk" or // The object name used in Windows records
    ObjectName == "Logical Disk" // The object name used in Linux records
    | where CounterName == "Free Megabytes" or CounterName =="% Free Space" or CounterName == "% Used Space" // Filters for the performance counters Free Megabytes, % Free Space, and % Used Space performance counters
    | where InstanceName == "_Total"  // Retrieves data related to the total usage for all drives on a virtual disk  
    ```

1. Retrieve the last counter value collected for every combination of counter and computer for every virtual machine: 

    <a href="https://portal.azure.com#@ec7cb332-9a0a-4569-835a-ce7658e8444e/blade/Microsoft_Azure_Monitoring_Logs/DemoLogsBlade/resourceId/%2FDemo/source/LogsBlade.AnalyticsShareLinkToQuery/q/H4sIAAAAAAAAA32S3UoDMRCF732KQ0FoYaH4APVGqQj1B616Waab6Taan5Jkt6348E62dulC8XLnnJz5crLPHFYXP9iuOTDm2vIdOw6UWOEaVPnhlRp1%252BtPyk8v0SJYxmWAw85Uuydzq%252BDWADxiPMV8zfOuCy7Y6SpB2%252BNBO%252BW1E4NIHFS%252FOJ%252BEQ9U%252FOTLt616UcuW587RKHLm4amPHAFS33iWPL1rcMLtF6XjdU8hkdYnjLK%252F8MQjTVRvSIlZiT0G2kOB8suZJRHg5H9BcXOF1TgJzCae7ZjO5S9y6mrHRIi7lPZAbINC%252BcguaGIxQlkkJM%252B2TJt2wpG6UzqrjlJWOggs5270BodEi1OJTUDcjGWFtLQX8zKFQLS7th71cojvW8k6l5hOVeBnZTy6ToNdcjyySGYjpeDU0%252BLV%252FGyLsKbUZjKtedoR00HPYdoRVZO%252F4FivrG3KYCAAA%253D" target="_blank">Click to run query in Log Analytics demo environment</a>
    
    ```kusto
    Perf
    | where TimeGenerated > ago(1d)
    | where ObjectName == "LogicalDisk" or // The object name used in Windows records
    ObjectName == "Logical Disk" // The object name used in Linux records
    | where CounterName == "Free Megabytes" or CounterName =="% Free Space" or CounterName == "% Used Space" // Filters for the performance counters Free Megabytes, % Free Space, and % Used Space performance counters
    | where InstanceName == "_Total"  // Retrieves data related to the total usage for all drives on a virtual disk  
    | summarize arg_max(TimeGenerated, CounterValue) by Computer, CounterName // Retrieves the last counter value collected for each counter for every virtual machine
    ```

1. To facilitate analysis:

    1. Convert the `% Used Space` counter value to `% Free Space` (100% - `% Used Space` value = `% Free Space` value) and relabel `% Used Space` to `% Free Space`:   
    
        <a href="xxx" target="_blank">Click to run query in Log Analytics demo environment</a>
    
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
        ```
    
    1. Convert total `Free Megabytes` to Gigabytes (`Free Megabytes` value * 0.001 = Free Gigabytes) and relabel `Free Megabytes` to `OverallFreeSpaceInGB`:
    
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

1. Group together `CounterName, CounterValue` key-value pairs:

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


1. Create a property-bag (dictionary), called SpaceStats, of all free space statistics collected for each machine and summarize by computer and filter for machines with less than 50% free space:
    
    <a href="xxx" target="_blank">Click to run query in Log Analytics demo environment</a>

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