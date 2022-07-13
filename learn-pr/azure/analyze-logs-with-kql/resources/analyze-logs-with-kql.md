# Title

Analyze logs in Azure Monitor with Kusto Query Language

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
- Familiarity with database structures like tables, columns, and rows.
- Familiarity with Kusto Query Language operators like `summarize`, `join`, and `render`, and aggregation functions like `percentile`.

## Summary

Write log queries using Kusto Query Language (KQL) to gain business and operational insights from log data in Azure Monitor.

## Learning objectives

By the end of this module, you'll be able to:

1. Define the type of data you need to help you answer a specific business or operational question.
1. Identify which tables in Azure Monitor hold the data you need.
1. Write KQL queries to extract the data you need from your logs to answer your business or operational question.

## Chunk your content into subtasks

Identify the subtasks of module title.

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it? (Exercise or Knowledge check) | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- | ---- | ---- | ---- | ---- |
| Analyzing logs in Azure Monitor | TODO | Knowledge check | 1, 2 | Yes |
| Exercise 1: Explore performance data  | TODO | Exercise | 2, 3 | Yes |
| Exercise 2: Summarize performance data by computer  | TODO | Exercise | 3 | Yes |
| Exercise 3: Add operating system information to the result set | TODO | Exercise | 3 | Yes |
| Exercise 4: Identify machines with low CPU usage | TODO | Exercise | 3 | Yes |
| Knowledge check | TODO | Exercise | 1, 2, 3 | Yes |
| Summary | TODO | Exercise | 1, 2, 3 | Yes |
## Outline the units

1. Introduction

    **Scenario**
    
    You're an IT manager at Contoso, a mid-size software development firm that uses Azure Monitor to monitor the machines on which the company develops and runs its software.
    
    You want to understand how effectively your organization is using its compute resources. Specifically, you're concerned about resources that might be under-used or over-used, in general, and at peak times. 
    
    **What will we be doing?**
    
    You'll explore the Perf to find trends and insights related to the performance of machines in your cloud environment.
    
    **What is the main goal?**
    
    By the end of this session, you'll be able to create KQL queries that provide you with insights gleaned from your log data regarding the performance of machines in your cloud environment.


1. Analyzing logs in Azure Monitor
    
    Azure Monitor lets you collect logs from all your data sources, including Azure resources and on-premises and third-party resources and applications. Each data source logs data into a set of tables. All tables have a schema, or a set of columns, each of which holds a specific data type. 

    **Characterize your inquiry**
    
    To conduct a business or operational inquiry using log data, you’ll want to consider factors like:
    
    - What type of insights do you want to gain from your inquiry?
    - What type of data can help you answer your question?
    - Which tables hold this type of data?
    - Do you need all the data in the table, or will looking at specific fields or columns help you focus and gain insights?
    - Which resources are within the scope of your inquiry? Do you need to look at data from all resources that send logs to the table, or just a specific subset of these resources? 
    - Is the raw data in the table sufficient to answer your question, or do you need to perform additional calculations using this data?
    - Do you need additional information from other tables to address your question? 
    

1. Exercise: Explore performance data


    Step 1: Look at the last 24 hours.

    Run this example query to get some initial information about what kind of performance data you're collecting:

    ```kusto
    // What data is being collected? 
    // List the collected performance counters and object types (Process, Memory, Processor). 
    Perf
    | summarize by ObjectName, CounterName
    ```
    
    This gets data about CPU usage and free space.
    
    Step 2: Set the time range of the query to the past seven days.

1. Exercise: Add operating system information to the result step

    Step 1: Look at the Heartbeat table.

    You want to get a better understanding of the computers in your result set.
    
    Look at the Heartbeat table to see what additional information might be helpful to you:

    ```kusto
    Heartbeat
    ```

    Step 2: 
    
    To include information about the operating system running on each of the computers, add the following lines to the previous query:  
    
    ```kusto
    | join kind=inner (
    Heartbeat
    | where TimeGenerated > ago(1h)
    | distinct Computer, OSType) on Computer
    ```

1. Exercise: Summarize free space by computer and instance name

    You decide to start by analyzing free space.

    ```kusto 
    Perf
    | where TimeGenerated > ago(1h)
    | where ObjectName == "LogicalDisk" or // the object name used in Windows records
    ObjectName == "Logical Disk" // the object name used in Linux records
    | where CounterName == "Free Megabytes"
    | summarize arg_max(TimeGenerated, *) by Computer, InstanceName // arg_max over TimeGenerated returns the latest record
    | project TimeGenerated, InstanceName, CounterValue, Computer, _ResourceId
    ```    

    This gets the most recent log entry related to free space and presents it by computer and instance (drive C, D, and so on).


1. Exercise: Analyze CPU usage

    Step 1:
    
    For each computer, you want to find the min, max, 99 percentile CPU usage in the past week. 
    
    ```kusto    
    Perf
    | where TimeGenerated > ago(7d) and CounterName == "% Processor Time" and InstanceName == "_Total" and ObjectName == "Processor" 
    | summarize min(CounterValue), avg(CounterValue), max(CounterValue), percentile(CounterValue, 99) by Computer 
    ```
    
    Step 2:
    
    Identify computers with high CPU usage.
    
    ```kusto
    | where percentile_CounterValue_99 > 50
    ```
    
1. Knowledge check

1. Summary

    How did you solve the problem in the initial scenario with the knowledge learned in the module? 
    
    Add your summary [(Summary guidance)](/help/learn/id-guidance-module-summary-unit)

## Notes

Note any additional information that may be beneficial to this content such as links, reference material, and so on.
