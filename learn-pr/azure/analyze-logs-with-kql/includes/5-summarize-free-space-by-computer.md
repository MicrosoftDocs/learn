Recall that your IT team has noticed recurring issues related to  insufficient free space on virtual machines. 

Here, you'll retrieve and transform data from the `Perf` table, using KQL queries, to analyze the free space of the machines logging data to your Log Analytics workspace. 

## Assess log data based on analysis goals

As we've seen the previous exercise, the `Perf` table provides information about the performance of hardware components, operating systems, and applications.

### What are your analysis goals and what information do you need?

To analyze free space usage of machines running in your IT environment, you need information about:

- Total space available on each machine.
- Total space used on each machine.
- Percentage of space used on each machine.

In the previous exercise, we saw that the `ObjectName` column of the `Perf` table lists the names of all of the objects for which Azure Monitor collects data from monitored machines and the `CounterName` column holds the names of the various performance counters that Azure Monitor collects. We also saw that both of these columns hold lots of values, many of which appear multiple times. To clearly see the distinct values in these columns and determine which counters are relevant to the current analysis, let's run this query:


Let's assess how we can use this data and which KQL operations can help extract and transform the data:

| Column | Description | Analysis goal | Related KQL operations |
| --- | --- | --- | --- |
| `TimeGenerated` | Indicates when the virtual machine generated each log. | Define the time scope of the analysis. | `TimeGenerated > ago(1d)` <br/>For more information, see [ago()](/azure/data-explorer/kusto/query/agofunction) and [Numerical operators](/azure/data-explorer/kusto/query/numoperators). |
| `Computer` | Computer from which the event was collected. | Associate CPU usage with a specific computer. | `summarize... by Computer` <br/>For more information, see [summarize operator](/azure/data-explorer/kusto/query/summarizeoperator).|
| `ObjectName` | Holds the names of all of the objects for which the table holds performance data. For your analysis, you're interested in the `Processor` instance. | xxx | xxx |
| `CounterName` | Holds the names of all of the performance counters in the table. | xxx | xxx |
| `InstanceName` | xxx | xxx | xxx |
| `CounterValue` | xxx | xxx | xxx |

### Which log data and KQL operations can you use?
 
As we saw in the previous exercise, the `CounterName` column in the `Perf` table holds holds the names of the various performance counters that Azure Monitor collects.
      
## Summarize free space statistics by computer

1. 

```kusto
Perf
| where TimeGenerated > ago(1d)
| where ObjectName == "LogicalDisk" or // The object name used in Windows records
ObjectName == "Logical Disk" // The object name used in Linux records
| where CounterName == "Free Megabytes" or CounterName =="% Free Space" or CounterName == "% Used Space"
| where InstanceName == "_Total"
```

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
