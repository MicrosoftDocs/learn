# Title

Guided project - Analyze logs in Azure Monitor with Kusto Query Language

## Role(s)

- data-scientist
- devops-engineer 

## Level

- intermediate

## Product(s)

- azure-monitor
- azure-portal

## Prerequisites

- A Log Analytics workspace with log data.
- Knowledge of database structures like tables, columns, and rows.
- Ability to write Kusto Query Language queries at a novice to intermediate level.

## Summary

Write log queries to find answers to operational and business questions. Use Kusto Query Language (KQL) to extract insights from logs in Azure Monitor.

  > [!NOTE]
  >  This is a **_guided project_** module where you’ll complete an end-to-end project by following step-by-step instructions.

## Learning objectives

In this module, you'll practice how to:

1. Analyze log data based on specific business and operational questions.
1. Write KQL queries to extract the data you need from logs in Azure Monitor.

## Chunk your content into subtasks

Identify the subtasks of module title.

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it? (Exercise or Knowledge check) | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- | ---- | ---- | ---- | ---- |
| Prepare: Characterize the data you need for your inquiry and compare with your log data | TODO | Knowledge check | 1 | Yes |
| Exercise 1: Analyze virtual machine agent health | TODO | Exercise | 1, 2 | Yes |
| Exercise 2: Identify machines with high and low CPU usage  | TODO | Exercise | 1, 2 | Yes |
| Exercise 3: Summarize free space statistics by computer | TODO | Exercise | 1, 2 | Yes |
| Knowledge check | TODO | Exercise | 1, 2 | Yes |
| Summary | TODO | Exercise | 1, 2 | Yes |
## Outline the units

1. Introduction

    **Scenario**
    
    You're a data scientist at a retail chain that uses Azure Monitor to monitor the machines in its retail stores. 

    The chain is expanding and, with the growing number of transactions at stores and between stores, the company has experienced some computer performance issues.

    To identify current issues and mitigate future problems with the computers running in the chain's stores.
    

1. Prepare: Characterize the data you need for your inquiry and compare with your log data
    
    To gain business or operational insights from log data, you’ll: 

    - Characterize your inquiry. 
        In this step, you'll:
        - Clearly define your questions. What type of insights do you want to gain from your inquiry?
        - Assess what data you need to have to answer these questions. What type of data can help you answer your question?
    - Assess your log data.
        In this step, you'll:
        - Examine the raw data you have in your logs. Which tables hold the data you're looking for? Is the data in one table sufficient to answer your question or do you need additional information from other tables?
        - Identify data that is relevant to your inquiry. Do you need all the data in the table, or will looking at specific fields or columns help you focus and gain insights? Which resources are within the scope of your inquiry? Do you need to look at data from all resources that send logs to the table, or just a specific subset of these resources?
    - Use KQL to extract and transform log data to address your questions.
        In this step, you'll write queries to: 
        - Extract the relevant data. 
        - Transform data by converting units of measure, changing the way you present and label data, and performing other calculations. 
    
1. Exercise: Analyze virtual machine agent health

    Scenario 1A: Identify machines that haven't sent a heartbeat in the past five minutes but did send one the past 48 hours (in other words, recently active machines).
    
    Note: We use `max_TimeGenerated` to correlate the last heartbeat of the machine that stopped reporting with machine logs or other environmental events that occurred around the same time. Correlating these logs can help in analyzing the reason the machined stopped sending data.

    ```kusto
    Heartbeat
    | where TimeGenerated >ago(48h)
    | summarize max(TimeGenerated) by Computer,AgentType=Category, OSType
    | where max_TimeGenerated < ago(5m)
    | extend AgentType= iif(AgentType == "Direct Agent" and OSType =="Windows", "MMA", AgentType)
    | extend AgentType= iif(AgentType == "Direct Agent" and OSType =="Linux", "OMS", AgentType)
    | order by max_TimeGenerated asc
    | project-reorder max_TimeGenerated,Computer,AgentType,OSType
    ```

    Scenario 1B: List computers that sent a heartbeat in the past 10 minutes by their agent version, OSType and AgentType:

    ```kusto    
    Heartbeat 
    | where TimeGenerated>ago(10m)
    | project-rename AgentType=Category
    | extend AgentType= iif(AgentType == "Direct Agent" and OSType =="Windows", "MMA", AgentType)
    | extend AgentType= iif(AgentType == "Direct Agent" and OSType =="Linux", "OMS", AgentType)
    | summarize ComputersList=make_set(Computer) by Version, OSType,AgentType
    | order by AgentType desc
    ```

1. Exercise: Identify machines with high and low CPU usage
   
    99th percentile means that this value is higher than 99% of all values are lower than 1% of all values.

    ```kusto     
    Perf
    | where TimeGenerated > ago(7d) and CounterName == "% Processor Time" and InstanceName == "_Total" and ObjectName == "Processor" 
    | summarize min(CounterValue), avg(CounterValue), max(CounterValue), p99=percentile(CounterValue, 99) by Computer 
    | where percentile_CounterValue_99 > 50
    ```

1. Exercise: Summarize free space statistics by computer 

    The Perf table with free disk space AND %

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
   
1. Knowledge check

1. Summary

    How did you solve the problem in the initial scenario with the knowledge learned in the module? 
    
    Add your summary [(Summary guidance)](/help/learn/id-guidance-module-summary-unit)

## Notes

Note any additional information that may be beneficial to this content such as links, reference material, and so on.
