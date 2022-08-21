<!-- 1. Scenario sub-task --------------------------------------------------------------------------------

    Goal: Describe the part of the scenario covered in this exercise.

    Heading: none

    Example: "Recall that in the chocolate-manufacturer example, there would be a separate storage account for the private business data. There were two key requirements for this account: geographically-redundant storage because the data is business-critical and at least one location close to the main factory."

    Recommended: image that summarizes the entire scenario with a highlight of the area implemented in this exercise
-->

Recall that one of your log analysis goals is to ensure you're getting data about all active virtual machines in your network. You want to identify machines that stop sending data, so that you can investigate and ensure have full visibility of all active virtual machines.

TODO: add scenario image

<!-- 2. Task performed in the exercise ---------------------------------------------------------------------

    Goal: State concisely what they'll implement here; that is, describe the end-state after completion

    Heading: a separate heading is optional; you can combine this with the scenario sub-task into a single paragraph

    Example: "Here, you will create a storage account with settings appropriate to hold this mission-critical business data."

    Optional: a video that shows the end-state
-->
Here, you'll run KQL queries to retrieve and transform data from the `heartbeat` table to obtain insights about the status of machines in your environment.  

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
## Set analysis goals and assess log data

Azure Monitor uses Azure Monitor Agent to monitor virtual machines. Azure Monitor Agent runs on the virtual machine and collects data about activities and operating system processes inside of the machine. However, some of the machines in your environment use the legacy Log Analytics Windows and Linux agents, which Azure Monitor is deprecating. Azure Monitor Agent and Log Analytics Agent log information about virtual machine health to the `Heartbeat` table once a minute.

1. What information do you need to determine which machines have stopped sending data?

    - All machines that have recently logged data, but have not logged data as expected in the past few minutes.
    - For further analysis, it's useful to know which virtual machine agent is running on each machine.
 
1. Which data in the `Heartbeat` table is relevant to your analysis and how do you want to transform and organize this data?
    
    This screenshot shows the result set of a simple `take 10` query on the `Heartbeat` table (the table has other columns that are not shown in the screenshot):    

    :::image type="content" source="../media/kql-log-analytics-heartbeat-table.png" alt-text="Screenshot showing the results of a take 10 query on the Heartbeat table with the TimeGenerated, Computer, Category, and OSType columns highlighted. ":::

    You can see that the columns that hold relevant data are:

    - `TimeGenerated` - Indicates when the virtual machine generated the log. 
    - `Computer` - Unique identifier of the machine.
    - `Category` - The agent type - `Azure Monitor Agent` or `Direct Agent`, which represent the Log Analytics agent. The Log Analytics agent for Windows is also called OMS. The Log Analytics Agent for Linux is also called MMS. 
    - `OSType` - The type of operating system running on the virtual machine. 
## Identify recently active machines that have stopped logging data

To identify recently active machines that have stopped logging data, write a query that lists the agents that have been active in the past 48 hours, but haven't logged data to the `Heartbeat` table in the last five minutes. 

1. Retrieve all logs from the past 48 hours:

    ```kusto
    Heartbeat // The table you’re querying
    | where TimeGenerated >ago(48h) // Time range for the query - in this case, logs generated in the past 48 hours
    ```

    The result set of this query likely includes numerous logs for each active machine.
    
1. Retrieve the last log generated by each machine and summarize by computer, agent type, and operating system:     

    ```kusto
    Heartbeat // The table you’re querying
    | where TimeGenerated >ago(48h) // Time range for the query - in this case, logs generated in the past 48 hours
    | summarize max(TimeGenerated) by Computer, AgentType=Category, OSType // Summarizes records by unique combination of computer, agent type, and operating system, and retrieves the last record generated for each combination
    ```
    
    In the `summarize` line, you've renamed the `Category` column to `AgentType`, which better describes the information you're looking at in the column for this analysis.


1. Retrieve the last log generated by a machine only if that record was generated more than five minutes ago:

    ```kusto
    Heartbeat // The table you’re querying
    | where TimeGenerated >ago(48h) // Time range for the query - in this case, logs generated in the past 48 hours
    | summarize max(TimeGenerated) by Computer, AgentType=Category, OSType // Summarizes records by unique combination of computer, agent type, and operating system, and retrieves the last record generated for each combination
    | where max_TimeGenerated < ago(5m) // Filters away all records generated in the last five minutes
    ```

    The result set of this query includes the last log generated by all machines that logged data in the past 48 hours, but doesn't include logs generated in the past five minutes. In other words, any machine that logged data in the last five minutes isn't included in the result set.

    You now have the data you're looking for: a list of all machines that logged data in the last 48 hours, but haven't been logging data as expected in the last five minutes. The result set consists of the set of computers you want to investigate further.

1. Manipulate the query results to present the information more clearly. 

    For instance, you decide to organize the logs by time generated - from the oldest to the newest - to get a sense for which computers haven't logged data the longest. 

    The `Direct Agent` value in the AgentType column tells you that the Log Analytics Agent is running on the machine. The Log Analytics Agent for Windows is also called OMS. The Log Analytics Agent for Linux is also call MMS. Renaming the `Direct Agent` value to `MMA` for Windows machines and `OMS` for Linux machines simplifies the results and facilitates further analysis, such as filtering.

    ```kusto
    Heartbeat // The table you’re querying
    | where TimeGenerated >ago(48h) // Time range for the query - in this case, logs generated in the past 48 hours 
    | summarize max(TimeGenerated) by Computer,AgentType=Category, OSType // Summarizes records by unique combination of computer, agent type, and operating system, and retrieves the last record generated for each combination
    | where max_TimeGenerated < ago(5m) // Filters away all records generated in the last five minutes
    | extend AgentType= iif(AgentType == "Direct Agent" and OSType =="Windows", "MMA", AgentType) // Changes the AgentType value from "Direct Agent" to "MMA" for Windows machines
    | extend AgentType= iif(AgentType == "Direct Agent" and OSType =="Linux", "OMS", AgentType) // Changes the AgentType value from "Direct Agent" to "OMS" for Linux machines
    | order by max_TimeGenerated asc // Sorts results by max_TimeGenerated from oldest to newest
    | project-reorder max_TimeGenerated,Computer,AgentType,OSType  // Reorganizes the order of columns in the result set
    ```

    You can use `max_TimeGenerated` to correlate the last heartbeat of the machine that stopped reporting with machine logs or other environmental events that occurred around the same time. Correlating these logs can help in analyzing the reason the machined stopped sending data.

## List the agents and agent versions running on recently active machines

Understanding which agent versions are running on your machines can be useful in analyzing the root cause of problems and helps you decide which machines you need to update to a new agent version.

1. Retrieve all logs from the past 10 minutes: 

    ```kusto    
    Heartbeat // The table you’re querying
    | where TimeGenerated >ago(10m) // Time range for the query - in this case, logs generated in the past 10 minutes
    ```

1. Rename the `Category` column name and `Direct Agent` values:
    
    ```kusto    
    Heartbeat // The table you’re querying
    | where TimeGenerated >ago(10m) // Time range for the query - in this case, logs generated in the past 10 minutes
    | project-rename AgentType=Category // Changes the name of the "Category" column to "AgentType"
    | extend AgentType= iif(AgentType == "Direct Agent" and OSType =="Windows", "MMA", AgentType) // Changes the AgentType value from "Direct Agent" to "MMA" for Windows machines
    | extend AgentType= iif(AgentType == "Direct Agent" and OSType =="Linux", "OMS", AgentType) // Changes the AgentType value from "Direct Agent" to "OMS" for Linux machines
    ```

    The result set of this query likely includes numerous logs for each active machine.
    
1. Find unique combinations of agent type, agent version, and operating system type, and list all computers running each combination of agent type and agent version: 

    ```kusto    
    Heartbeat // The table you’re querying
    | where TimeGenerated >ago(10m) // Time range for the query - in this case, logs generated in the past 10 minutes
    | project-rename AgentType=Category // Changes the name of the "Category" column to "AgentType"
    | extend AgentType= iif(AgentType == "Direct Agent" and OSType =="Windows", "MMA", AgentType) // Changes the AgentType value from "Direct Agent" to "MMA" for Windows machines
    | extend AgentType= iif(AgentType == "Direct Agent" and OSType =="Linux", "OMS", AgentType) // Changes the AgentType value from "Direct Agent" to "OMS" for Linux machines
    | summarize ComputersList=make_set(Computer) by AgentVersion=Version, AgentType, OSType // Summarizes the result set by unique combination of agent type, agent version, and operating system, and lists the set of all machines running the specific agent version
    ```

    You now have the data you're looking for: a list of unique combinations of agent type and agent version and the set of all recently active machines that are running a specific version of each agent. 

1. Transform the query results to present the information more clearly.
    
    For instance, sort the results by agent name:  

    ```kusto    
    Heartbeat // The table you’re querying
    | where TimeGenerated >ago(10m) // Time range for the query - in this case, logs generated in the past 10 minutes
    | project-rename AgentType=Category // Changes the name of the "Category" column to "AgentType"
    | extend AgentType= iif(AgentType == "Direct Agent" and OSType =="Windows", "MMA", AgentType) // Changes the AgentType value from "Direct Agent" to "MMA" for Windows machines
    | extend AgentType= iif(AgentType == "Direct Agent" and OSType =="Linux", "OMS", AgentType) // Changes the AgentType value from "Direct Agent" to "OMS" for Linux machines
    | summarize ComputersList=make_set(Computer) by AgentVersion=Version, AgentType, OSType // Summarizes the result set by unique combination of agent type, agent version, and operating system, and lists the set of all machines running the specific agent version
    | order by AgentType desc // Sorts results by agent name in descending alphabetical order
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
