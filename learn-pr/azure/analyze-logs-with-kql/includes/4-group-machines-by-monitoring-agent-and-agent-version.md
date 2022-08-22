Understanding which agents and agent versions are running on your machines can help you analyze the root cause of problems and identify which machines you need to update to a new agent or new agent version.

Here, you'll write KQL queries to retrieve and transform data from the `heartbeat` table to list all agent and agent versions in your network and group all machines by the agent that monitors them.  

## Assess log data based on analysis goals

1. What information do you need to determine which gents and agent versions are running on your active machines?

    - All machines that have recently logged data.
    - Which virtual machine agent is running on each machine, and the agent version number.
 
1. Which data in the `Heartbeat` table is relevant to your analysis and how will you use KQL to extract, transform, and organize the data?
    
    This screenshot shows the result set of a simple `take 10` query on the `Heartbeat` table (the table has other columns that are not shown in the screenshot):    

    :::image type="content" source="../media/kql-log-analytics-heartbeat-table-agent-version.png" alt-text="Screenshot showing the results of a take 10 query on the Heartbeat table with the TimeGenerated, Computer, Category, OSType, and Version columns highlighted." lightbox="../media/kql-log-analytics-heartbeat-table.png":::

    You can see that the columns that hold relevant data are the same as in the previous exercise with the addition of the `Version` column, but the operations you'll perform are a little different:

    | Column | Description | Analysis goal | Related KQL operations |
    | --- | --- | --- | --- |
    | `TimeGenerated` | Indicates when the virtual machine generated each log. | Identify recently active machines. | <ul><li>`where TimeGenerated >ago(10m)`</li></ul> For more information, see [where operator](/azure/data-explorer/kusto/query/whereoperator) and [ago()](/azure/data-explorer/kusto/query/agofunction). |
    | `Computer` |Unique identifier of the machine. | Group machines by distinct agent version values. |  <ul><li>`ComputersList=make_set(Computer)`</li></ul> For more information, see [make_set() (aggregation function)](/azure/data-explorer/kusto/query/makeset-aggfunction). | 
    | `Category` |The agent type: <ul><li>`Azure Monitor Agent` or </li><li>`Direct Agent`, which represents the Log Analytics agents. The Log Analytics agent for Windows is also called MMA. The Log Analytics agent for Linux is also called OMS.</li></ul> | Identify the agent virtual running on the machine. Change the `Direct Agent` value to `MMA` for Windows machines and `OMS` for Linux machines to simplify the results and facilitate further analysis, such as filtering. | To simplify the results and facilitate further analysis, such as filtering: <ul><li>Rename the column to `AgentType` (`project-rename AgentType=Category`)</li><li> Change the `Direct Agent` value to `MMA` for Windows machines (`AgentType= iif(AgentType == "Direct Agent" and OSType =="Windows", "MMA", AgentType)`.</li><li> Change the `Direct Agent` value to `OMS` for Linux machines (`AgentType= iif(AgentType == "Direct Agent" and OSType =="Linux", "OMS", AgentType`).</li></ul> For more information, see [project-rename](/azure/data-explorer/kusto/query/projectrenameoperator), [iff()](/azure/data-explorer/kusto/query/ifffunction) and [== (equals) operator](/azure/data-explorer/kusto/query/equals-cs-operator).|
    | `OSType` | The type of operating system running on the virtual machine. | Identify agent type for Log Analytics agents, which are different for each OS type. |  |
    | `Version` | The version number of the agent monitoring the virtual machine. | Identify agent type for Log Analytics agents, which are different for each OS type. | Rename the column to `AgentVersion` (`AgentVersion=Version`). |

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
