# Title

Monitor performance of virtual machines using Log Analytics and Virtual Machine Insights.

## Role(s)

- Administrator

## Level

- Beginner

## Product(s)

- Log Analytics
- VM Insights
- Azure Monitor

## Prerequisites

- Experience using the Azure portal for accessing and creating resources
- Knowledge of Azure virtual machines
- Basic familiarity with relational database query language

## Summary

Assess Log Analytics tooling. Deploy Log Analytics workspace. Onboard VMs to Log Analytics workspace and configure VM Insights. Build familiarity with syntax of Azure Monitor log queries inside Log Analytics workspace using standard operators. Query performance of virtual machines using log queries based upon the Kusto Query Language.

## Learning objectives

1. Assess Log Analytics workspaces.
1. Create Log Analytics workspace, configure with right access permissions, and decide upon resource-centric or workspace-centric model for deployment.
1. After workspace is provisioned, link 2 VMs to Log Analytics workspace and onboard both VMs to VM Insights.
1. Build familiarity with query language of Azure Monitor logs. Focus on standard operators and syntax.
1. Focus on heartbeat and perf tables. Build queries off of both tables, highlighting syntax, operators, and format of Kusto Query Language.


## Chunk your content into subtasks

Identify the subtasks of *module title*

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- | ---- | ---- | ---- | ---- |
| Assess Log Analytics workspaces | Investigate tooling | Knowledge Check | Evaluate Log Analytics | Yes |
| Deploy Log Analytics workspace, onboard VMs to Log Analytics and VM Insights | How-to deploy workspace | Exercise | Interactive deployment | Yes |
| Introduction to log queries | Investigate functionality | Knowledge Check | Learn about structure and syntax of queries | Yes |
| Build log queries | How-to structure and build queries | Exercise | Interactive configuration | Yes |

## Outline the units

*Add more units as needed for your content*

1. **Introduction**

Imagine you're newly hired into an IT department for a large financial services firm. From an operational perspective, the IT department has been building more workloads and applications in Azure. Monitoring these workloads and applications have become difficult over time. The management team won't approve moving the on-premises monitoring environment to Azure on account of licensing costs. As part of the operations team, you'll be exploring cloud native tooling for monitoring and logging by examining Log Analytics and VM Insights.

1. **What is Log Analytics and how does it differ from Azure Monitor?**

    - Introduce Azure Monitor, Azure Monitor logs, and Log Analytics
        - Breakdown native logging in Azure for learner
        - Resource logging is automatically sent to Azure Monitor
        - Discuss differences between metrics and logs 
    - Plan Log Analytics deployment
    - Discuss different access models for Log Analytics workspaces
        - Resource-centric model
        - Workload-centric model
        - Table level RBAC
        - Permissions model for reading and writing logs
    - Highlight insights and solutions
        - Allow an ability to process log data without exposing the user to underlying queries

    **Knowledge check**

    1. You start out by talking to individual business units about monitoring wants and needs at the start of your assignment. You determine each business unit only needs to query logs generated from their resources. Which access model would you select for your Log Analytics deployment?
    1. What do Insights provide access to?

1. **Exercise - Set up Log Analytics workspace**

    Follow these steps:

    1. Log into Azure portal
    1. At the top, select "All services." In the list of resources, type Log Analytics. As Log Analytics is typed in, the list will filter based upon input. Select Log Analytics workspaces.
    1. Provide a name for the new Log Analytics workspace. The name must be globally unique.
    1. Select a subscription, resource group, and location.
    1. Once deployed, change to a resource-centric model.
    1. Deploy 2 VMs from portal and connect to Log Analytics workspace.
    1. After both VMS are connected to Log Analytics workspace, onboard both to VM Insights. Select "Insights" on the far left and select "Enable."

1. **Introduction to log queries**

    - Introduce and explain concept of log queries
        - Azure Monitor Logs are based on Azure Data Explorer; log queries are written using the Kusto Query Language (KQL)
        - Showcase how to write basic queries
        - Discuss functions, structure, syntax, and showcase online resources for log queries
        - Focus on table-based queries to start, as they are the easiest to begin extracting data. Then build off of search queries, filters, time range, summarize rows, and so on.
        - Show how queries can be used.

    **Knowledge check**

    1. What are Azure Monitor log queries based on?
    1. What is the easiest way to start digging into data that Azure Monitor logs contain?

1. **Exercise - Build log queries**

    Follow these steps:

    1. Open up browser and go to Log Analytics demo workspace: https://portal.loganalytics.io/demo
    1. Showcase how to comment (helpful for reusable code stored in source control).
    1. Focus on all primary operators the learner will predominantly use to find information: search, where, take, count, summarize, extend, project, distinct, and top.
    1. Build queries off of Heartbeat and Perf tables for Azure IaaS VMs reporting to demo workspace.  

## Notes

https://docs.microsoft.com/en-us/azure/azure-monitor/overview
https://docs.microsoft.com/en-us/azure/azure-monitor/platform/data-sources
https://docs.microsoft.com/en-us/azure/azure-monitor/platform/data-platform
https://docs.microsoft.com/en-us/azure/azure-monitor/platform/data-locations
https://docs.microsoft.com/en-us/azure/azure-monitor/platform/data-platform-logs
https://docs.microsoft.com/en-us/azure/azure-monitor/log-query/log-query-overview
https://docs.microsoft.com/en-us/azure/azure-monitor/insights/vminsights-overview
https://docs.microsoft.com/en-us/azure/azure-monitor/monitor-reference