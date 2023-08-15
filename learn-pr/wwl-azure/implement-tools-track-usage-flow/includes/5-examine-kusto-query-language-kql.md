
Kusto is the primary way to query Log Analytics. It provides both a query language and a set of control commands.

Kusto can be used directly within Azure Data Explorer.

Azure Data Studio also offers a Kusto query experience and supports the creation of Jupiter-style notebooks for Kusto queries.

See [Getting Started with Kusto Queries.](/azure/data-explorer/kusto/concepts/)

## Walkthrough

Note: This walkthrough continues the previous lesson on Azure Log Analytics, and the walkthrough started within it.

1.  Log in to the [Azure portal](https://portal.azure.com) and navigate to the log analytics workspace. From the left blade in the log analytics workspace, click Logs. It will open the Logs window, ready for you to start exploring all the data points captured into the workspace.
2.  We'll need to use the Kusto Query Language to query the logs. Run the following query to list the last heartbeat of each machine connected to the log analytics workspace.
    
    ```csharp
    // Last heartbeat of each computer
    // Show the last heartbeat sent by each computer
    Heartbeat
    | summarize arg_max(TimeGenerated, *) by Computer
    
    ```

3.  Show a list of all distinct counters being captured.
    
    ```csharp
    // What data is being collected?
    // List the collected performance counters and object types (Process, Memory, Processor.)
    Perf
    | summarize by ObjectName, CounterName
    
    ```

4.  Show a count of the data points collected in the last 24 hours. The result shows that we have 88M data points. We can query against them in near real-time to analyze and correlate insights.
    
    :::image type="content" source="../media/count-data-points-collected-eb1adb35.png" alt-text="Screenshot of a count of the data points collected in the last 24 hours. The result shows that we have 88M data points.":::
    

5.  Run the following query to generate the max CPU Utilization trend over the last 24 hours, aggregated at a granularity of 1 min. Render the data as a time chart.
    
    ```csharp
    Perf
    | where ObjectName == "Processor" and InstanceName == "_Total"
    | summarize max(CounterValue) by Computer, bin(TimeGenerated, 1m)
    | render  timechart
    
    
    ```
    
    :::image type="content" source="../media/cpu-utilization-cd08686a.png" alt-text="Screenshot of a graph with max CPU Utilization trend over the last 24 hours, aggregated at a granularity of 1 min in a time chart.":::
    

6.  Run the following query to see all the processes running on that machine contributing to the CPU Utilization. Render the data in a pie chart.
    
    ```csharp
    Perf
    | where ObjectName contains "process"
            and InstanceName !in ("_Total", "Idle")
            and CounterName == "% Processor Time"
    | summarize avg(CounterValue) by InstanceName, CounterName, bin(TimeGenerated, 1m)
    | render piechart
    
    ```
    
    :::image type="content" source="../media/run-processes-pie-chart-61e255a6.png" alt-text="Screenshot of all the processes running on that machine contributing to the CPU Utilization in a pie chart.":::
    

## There's more

This unit has introduced the basic concepts of Log Analytics and how to get started with the basics.

We've only scratched the surface of what is possible with Log Analytics.

We would encourage you to try out the advanced tutorials available for Log Analytics on [Microsoft Docs](/azure/azure-monitor/).
