<!-- 1. Scenario sub-task --------------------------------------------------------------------------------

    Goal: Describe the part of the scenario covered in this exercise.

    Heading: none

    Example: "Recall that in the chocolate-manufacturer example, there would be a separate storage account for the private business data. There were two key requirements for this account: geographically-redundant storage because the data is business-critical and at least one location close to the main factory."

    Recommended: image that summarizes the entire scenario with a highlight of the area implemented in this exercise
-->
To address performance issues, mitigate potential issues, and identify opportunities to operate more efficiently, you want to analyze the actual and used compute capacity in your IT environment. 

TODO: add scenario image

<!-- 2. Task performed in the exercise ---------------------------------------------------------------------

    Goal: State concisely what they'll implement here; that is, describe the end-state after completion

    Heading: a separate heading is optional; you can combine this with the scenario sub-task into a single paragraph

    Example: "Here, you will create a storage account with settings appropriate to hold this mission-critical business data."

    Optional: a video that shows the end-state
-->
Here, you'll retrieve and transform data from the `Perf` table, using KQL queries, to understand which machines have reached or are nearing their total compute capacity and which machines are being underused.  

<!-- 3. Chunked steps -------------------------------------------------------------------------------------

    Goal: List the steps they'll do to complete the exercise.

    Structure: Break the steps into 'chunks' where each chunk has three things:
        1. A heading describing the goal of the chunk
        2. An introductory paragraph describing the goal of the chunk at a high level
        3. Numbered steps (target 7 steps or fewer in each chunk)

    Example:
        Heading:
            "Use a template for your Azure logic app"
        Introduction:
             "When you create an Azure logic app in the Azure portal, you have the option of selecting a starter template. Let's select a blank template so that we can build our logic app from scratch."
        Steps:
             "1. In the left navigation bar, select Resource groups.
              2. Select the existing Resource group [sandbox resource group name].
              3. Select the ShoeTracker logic app.
              4. Scroll down to the Templates section and select Blank Logic App."
-->
## Decide on the information you need for your analysis and examine your log data

Windows and Linux agents send performance counters to the `Perf` table in Azure Monitor. The data in the `Perf` table provides insight into the performance of hardware components, operating systems, and applications.


1. What information will help you understand the compute usage of machines running in your IT environment?

    - Central processing unit (CPU) usage.
    - Information about CPU usage of machines at peak and quiet times.
 
1. Which data in the `Perf` table is relevant to your analysis and how do you want to transform and organize this data?

    - The `ObjectName` column holds the names of all of the objects for which the table holds performance data. For your analysis, you're interested in the 'Processor' instance.
    - The `CounterName` column holds the names of all of performance counters in the table.
    - The `InstanceName` column... 
    - The `CounterValue` column...

## Identify machines with high and low CPU usage

Note that 99th percentile means that 99% of all measured values are lower than the given value.

1. 
    
    ```kusto     
    Perf  // The table you’re querying
    | where TimeGenerated > ago(1d) and ObjectName == "Processor" and CounterName == "% Processor Time" and InstanceName == "_Total" // Filters for entries generated in the past day related to total processor time measurements  
    | summarize min(CounterValue), avg(CounterValue), max(CounterValue), percentiles(CounterValue, 90,99) by Computer // Presents the minimum, maximum, average, 90th and 99th percentile counters values for each computer 
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
Optional "exercise-solution" video

<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

<!-- Do not add a unit summary or references/links -->
