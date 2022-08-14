<!-- 1. Scenario sub-task --------------------------------------------------------------------------------

    Goal: Describe the part of the scenario covered in this exercise.

    Heading: none

    Example: "Recall that in the chocolate-manufacturer example, there would be a separate storage account for the private business data. There were two key requirements for this account: geographically-redundant storage because the data is business-critical and at least one location close to the main factory."

    Recommended: image that summarizes the entire scenario with a highlight of the area implemented in this exercise
-->
TODO: add your scenario sub-task
TODO: add your scenario image

<!-- 2. Task performed in the exercise ---------------------------------------------------------------------

    Goal: State concisely what they'll implement here; that is, describe the end-state after completion

    Heading: a separate heading is optional; you can combine this with the scenario sub-task into a single paragraph

    Example: "Here, you will create a storage account with settings appropriate to hold this mission-critical business data."

    Optional: a video that shows the end-state
-->
TODO: describe the end-state

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

## Identify recently active machines
<!-- Introduction paragraph -->
1. <!-- Step 1 -->
1. <!-- Step 2 -->
1. <!-- Step n -->

Scenario 1A: Identify machines that haven't sent a heartbeat in the past five minutes but did send one the past 48 hours (in other words, recently active machines).
    
Note: We use `max_TimeGenerated` to correlate the last heartbeat of the machine that stopped reporting with machine logs or other environmental events that occurred around the same time. Correlating these logs can help in analyzing the reason the machined stopped sending data.

AgentType can be Azure Monitor 

Direct Agent is Log Analytics Agent

Active in last 48 hours, inactive in the last 5 minutes.
Machines write to heartbeat table each minute.




```kusto
Heartbeat // The table we’re analyzing
| where TimeGenerated >ago(48h) // Time range for the query
| summarize max(TimeGenerated) by Computer,AgentType=Category, OSType
| where max_TimeGenerated < ago(5m)
| extend AgentType= iif(AgentType == "Direct Agent" and OSType =="Windows", "MMA", AgentType)
| extend AgentType= iif(AgentType == "Direct Agent" and OSType =="Linux", "OMS", AgentType)
| order by max_TimeGenerated asc
| project-reorder max_TimeGenerated,Computer,AgentType,OSType
```

## List computers that sent a heartbeat in the past 10 minutes by their agent version, OSType and AgentType
<!-- Introduction paragraph -->
1. <!-- Step 1 -->
1. <!-- Step 2 -->
1. <!-- Step n -->

List computers that sent a heartbeat in the past 10 minutes by their agent version, OSType and AgentType:

```kusto    
Heartbeat 
| where TimeGenerated>ago(10m) // The table we’re analyzing
| project-rename AgentType=Category // Time range for the query
| extend AgentType= iif(AgentType == "Direct Agent" and OSType =="Windows", "MMA", AgentType)
| extend AgentType= iif(AgentType == "Direct Agent" and OSType =="Linux", "OMS", AgentType)
| summarize ComputersList=make_set(Computer) by Version, OSType,AgentType
| order by AgentType desc
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
