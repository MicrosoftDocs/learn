TODO: add your scenario sub-task
TODO: add your scenario image

Here, you'll retrieve and transform data from the `Perf` table, using KQL queries, to analyze the free space of the machines logging data to your Log Analytics workspace. 

## Assess log data based on analysis goals

As we've seen the previous exercise, the `Perf` table provides information about the performance of hardware components, operating systems, and applications.

### What are your analysis goals and what information do you need?

To analyze free space usage of machines running in your IT environment, you need information about:

    - Total space available on each machine.
    - Total space used on each machine.
    - Percentage of space used  on each machine.
### Which log data and KQL operations can you use?
 
As we saw in the previous exercise, the `CounterName` column in the `Perf` table holds holds the names of the various performance counters that Azure Monitor collects.
      
## Summarize free space statistics by computer

1. 

```kusto
Perf
| where TimeGenerated > ago(1h)
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

