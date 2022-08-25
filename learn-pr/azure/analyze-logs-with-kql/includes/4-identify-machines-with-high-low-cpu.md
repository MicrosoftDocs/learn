To address performance issues, mitigate potential issues, and identify opportunities to operate more efficiently, you want to analyze the actual and used compute capacity in your IT environment. 
TODO: add scenario image

Here, you'll write KQL queries to retrieve and transform data from the `Perf` table to gain an understanding of which machines have reached or are nearing their total compute capacity and which machines are being underused.  

## Assess log data based on analysis goals

Windows and Linux agents send performance counters to the `Perf` table in Azure Monitor related to the performance of hardware components, operating systems, and applications.

1. What information will help you understand the compute usage of machines running in your IT environment?

    - Central processing unit (CPU) usage.
    - Information about CPU usage of machines at peak and quiet times.

1. Which data in the `Perf` table is relevant to your analysis and how will you use KQL to extract, transform, and organize the data?

     Let's run a simple a query on the `Perf` table to retrieve logs from the past 24 hours and get a sense of the table schema and the data the table holds:

    ```kusto
    Perf  // The table you’re querying
    | where TimeGenerated > ago(1d)// Filters for entries generated in the past day 
    ```

    :::image type="content" source="../media/kql-log-analytics-perf-table.png" alt-text="Screenshot showing the results of a query on the Heartbeat table with the ObjectName, CounterName, InstanceName, and CounterValue columns highlighted." lightbox="../media/kql-log-analytics-perf-table.png":::

    You can see that the `ObjectName`, `CounterName`, `InstanceName`, and `CounterValue` columns hold data that's relevant to your analysis. 

    The `ObjectName` column lists the names of all of the objects for which Azure Monitor collects data from monitored machines. The `CounterName` column holds the names of the various performance counters that Azure Monitor collects. Both of these column holds lots of values, many of which appear multiple times. To clearly see the distinct values in these columns and determine which counters are relevant to the current analysis, let's run this query:

    ```kusto
    Perf
    | distinct ObjectName,CounterName // Lists distinct combinations of ObjectName and CounterName values
    ```

    This screenshot shows the distinct combinations of `ObjectName` and `CounterName` values in the `CounterName` column in the past 24 hours:    

    :::image type="content" source="../media/kql-log-analytics-perf-table-cpu.png" alt-text="Screenshot showing the results of the distinct CounterName query on the Perf table with the Percentage Processor Time value highlighted." lightbox="../media/kql-log-analytics-perf-table-cpu.png":::

    The `% Processor Time` counter gives you an understanding of the utilization of the processor, or Central Processing Unit (CPU).

    Now let's summarize the data that's relevant to the current analysis and decide on the KQL operations we can use to advance our analysis:

    | Column | Description | Analysis goal | Related KQL operations |
    | --- | --- | --- | --- |
    | `ObjectName` | Holds the names of all of the objects for which the table holds performance data. For your analysis, you're interested in the `Processor` instance. | xxx | xxx |
    | `CounterName` | Holds the names of all of the performance counters in the table. | xxx | xxx |
    | `InstanceName` | xxx | xxx | xxx |
    | `CounterValue` | xxx | xxx | xxx |
## Identify machines with high and low CPU usage

Note that 99th percentile means that 99% of all measured values are lower than the given value.

1. Retrieve all logs generated in the past day that report on % Processor Time:
    
    ```kusto     
    Perf  // The table you’re querying
    | where TimeGenerated > ago(1d) and ObjectName == "Processor" and CounterName == "% Processor Time" and InstanceName == "_Total" // Filters for entries generated in the past day related to total processor time measurements  
    ```
    
    This query retrieves all logs related to total processor time measurements from the past day. 

1. Present the minimum, maximum, average, 90th and 99th percentile counter values for each computer: 

    ```kusto     
    Perf  // The table you’re querying
    | where TimeGenerated > ago(1d) and ObjectName == "Processor" and CounterName == "% Processor Time" and InstanceName == "_Total" // Filters for entries generated in the past day related to total processor time measurements  
    | summarize min(CounterValue), avg(CounterValue), max(CounterValue), percentiles(CounterValue, 90,99) by Computer // Presents the minimum, maximum, average, 90th and 99th percentile counter values for each computer 
    ```
    The result set of this query shows the minimum, maximum, average, 90th and 99th percentile % Processor Time counter values for each computer for which there's data in your Log Analytics workspace.

1. Filter the query results for entries where the `% Processor Time` counter value is less than 50 in the 90th and 99th percentile range:
    
    ```kusto     
    Perf  // The table you’re querying
    | where TimeGenerated > ago(1d) and ObjectName == "Processor" and CounterName == "% Processor Time" and InstanceName == "_Total" // Filters for entries generated in the past day related to total processor time measurements  
    | summarize min(CounterValue), avg(CounterValue), max(CounterValue), percentiles(CounterValue, 90,99) by Computer // Presents the minimum, maximum, average, 90th and 99th percentile counter values for each computer 
    | where percentile_CounterValue_90 > 50 and percentile_CounterValue_99 > 50 // Filters previous query results for instances where the 90th and 99th percentile counters are higher than 50
    ```

    The result set of this query consists of all computers where the top 10% and 15% of their CPU usage is below 50%.  

1. To get a better understanding of your query results, you can retrieve related information from a different table and add the data to your query results using the `join` operator. 

    For instance, you can add information from the `Heartbeat` table about the operating system running on each of the computers in your query results:
    
    ```kusto     
    Perf  // The table you’re querying
    | where TimeGenerated > ago(1d) and ObjectName == "Processor" and CounterName == "% Processor Time" and InstanceName == "_Total" // Filters for entries generated in the past day related to total processor time measurements  
    | summarize min(CounterValue), avg(CounterValue), max(CounterValue), percentiles(CounterValue, 90,99) by Computer // Presents the minimum, maximum, average, 90th and 99th percentile counter values for each computer 
    | where percentile_CounterValue_90 > 50 and percentile_CounterValue_99 > 50 // Filters previous query results for instances where the 90th and 99th percentile counters are higher than 50
    | join kind=inner (Heartbeat // Introduces data from the "Heartbeat" table to the previous query results
    | where TimeGenerated > ago(1d) // Time range for the data added from the "Heartbeat" table
    | distinct Computer, OSType) on Computer // Adds distinct combinations of computer and operating system 
    ```

    This iteration of the query adds the `Computer` and `OSType` columns from the `Heartbeat` table to the previous query results. Notice that the `Computer` column appears twice in the query results - once from the query on the `Perf` table and once from the query on the `Heartbeat` table. The `Computer` column from the `Heartbeat` table has been renamed `Computer1`, but the two tables contain identical data. Having both columns enables correlating the results from the two tables, but you can now filter away the duplicate column.
    
1. Remove the `Computer1` column from the query results: 

    ```kusto     
    Perf  // The table you’re querying
    | where TimeGenerated > ago(1d) and ObjectName == "Processor" and CounterName == "% Processor Time" and InstanceName == "_Total" // Filters for entries generated in the past day related to total processor time measurements  
    | summarize min(CounterValue), avg(CounterValue), max(CounterValue), percentiles(CounterValue, 90,99) by Computer // Presents the minimum, maximum, average, 90th and 99th percentile counter values for each computer 
    | where percentile_CounterValue_90 > 50 and percentile_CounterValue_99 > 50 // Filters previous query results for instances where the 90th and 99th percentile counters are higher than 50
    | join kind=inner (Heartbeat // Introduces data from the "Heartbeat" table to the previous query results
    | where TimeGenerated > ago(1d) // Time range for the data added from the "Heartbeat" table
    | distinct Computer, OSType) on Computer // Adds distinct combinations of computer and operating system 
    | project-away Computer1 // Removes the "Computer1" column from the query results 
    ```

<!-- 4. Validation -------------------------------------------------------------------------------------------

    Goal: Enables the learner to evaluate if they completed the exercise correctly. This feedback is critical for learning.

    Structure:
        1. H2 of "Check your work".
        2. An introductory paragraph describing how they'll validate their work at a high level.
        3. Numbered steps (if the learner needs to perform multiple steps to verify if they were successful).
        4. Video of an expert performing the exact steps of the exercise (optional).

    Example:
         "At this point, the app is scanning Twitter every minute for tweets containing the search text. To verify the app is running and working correctly, we'll look at the Runs history table."
             "1. Select Overview in the navigation menu.
              2. Select Refresh once a minute until you see a row in the Runs history table.
              ...
              6. Examine the data in the OUTPUTS section. For example, locate the text of the matching tweet."
-->

## Check your work
<!-- Introduction paragraph -->
1. <!-- Step 1 (if multiple steps are needed) -->
1. <!-- Step 2 (if multiple steps are needed) -->
1. <!-- Step n (if multiple steps are needed) -->

<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

<!-- Do not add a unit summary or references/links -->
