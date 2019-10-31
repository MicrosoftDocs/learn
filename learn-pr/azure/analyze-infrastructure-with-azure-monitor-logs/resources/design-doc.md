# Title

Analyze your Azure infrastructure with Azure Monitor logs

## Role(s)

- Solution Architect
- Administrator

## Level

- Beginner

## Product(s)

- Azure Monitor logs

## Prerequisites

- None yet identified

## Summary

Use Azure Monitor logs to extract valuable information about your infrastructure from log data.

## Learning objectives

1. Identify the features and capabilities of Azure Monitor logs
2. Create basic Azure Monitor log queries to extract information from log data

## Chunk your content into subtasks

Identify the subtasks of *Analyze your Azure infrastructure with Azure Monitor logs*

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- | ---- | ---- | ---- | ---- |
| Identify the features and capabilities of Azure Monitor logs | Show how Azure Monitor works | Knowledge check | 1 | Yes |
| Create basic Azure Monitor log queries to extract information from log data | Business need to query logs | Exercise | 2 | Yes |

1. **Introduction**

    An operations team for an enterprise would like to consolidate their log data in a single service to improve visibility across services and simplify their logging strategy. They've begun implementing Azure Monitor logs and would like to get a full understanding of how it works, and what the capabilities are to query and evaluate the log data being fed into the service.

1. **Identify the features and capabilities of Azure Monitor logs**
    - Foundational concepts of Azure Monitor
        - How Log data is collected by Azure Monitor
        - Example scenarios, plus some detail about how it fits this module's scenario
    - Metrics, copy metrics to logs to perform complex analysis with other data types using Azure - Monitor's rich query language
        - Where are the queries used and how we can use them to quickly retrieve, consolidate, and analyze collected data

    Include a knowledge check in this unit:

    - What data does Azure Monitor collect?
    - What two fundamental types of data are collected by Azure Monitor?

1. **Create basic Azure Monitor log queries to extract information from log data**
    - Look at a basic Azure Monitor log setup
        - Azure Monitor Log Analytics in the Azure portal to write Azure Monitor log queries.
    - How to write queries with the Kusto language. Describe the structure of a query.
    - Some example queries:
        - Searching for text in the RenderedDescription field
        - Searching for events in a given weeke
        - Searching for the last heartbeat from a computer IP.

1. **Exercise - Create basic Azure Monitor log queries to extract information from log data**
    In the introduction to this unit, describe how the operations team does not have enough information about the behavior of their systems to diagnose problems early. In the exercises, show how the queries can resolve this issue.

    1. Goto the following URL: https://portal.loganalytics.io/demo#/discover/query/main 

        > [!NOTE]
        > Students may also want to run queries in your own subscription under Monitor -> Logs. Include a note to say they can do this, but results depend on the resources that are in use in their subscription.

    1. Enter a basic query where it says Type your query here...
         - SecurityEvent
        | take 10
    1. Click Run and see the output of your query
    1. Try a Sort query by running the following query:
        - SecurityEvent
| top 10 by TimeGenerated
    1. Enter a query using a Filter clause and Time:
        - SecurityEvent
| where TimeGenerated > ago(30m) 
| where toint(Level) >= 10

1. **Summary**

    - Explored the types of data collected by Azure Monitor.
    - Created Azure Monitor log queries to extract information from the log data
