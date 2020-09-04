# Title

Monitor performance of virtual machines using Log Analytics.

## Role(s)

- Administrator

## Level

- Beginner

## Product(s)

- Log Analytics
- Azure Monitor

## Prerequisites

- Experience using the Azure portal for accessing and creating resources
- Knowledge of Azure virtual machines
- Basic familiarity with relational database query language

## Summary

Assess Log Analytics tooling. Deploy Log Analytics workspace. Build familiarity with Azure Monitor log queries. Query performance of virtual machines using Log Analytics log queries based upon the Kusto Query Language.

## Learning objectives

1. Assess Azure Monitor and Log Analytics workspaces
1. Create Log Analytics workspace, configure with right access permissions, and decide upon resource-centric or workspace-centric model for deployment
1. Focus on heartbeat and perf tables. Build queries off of both tables, highlighting syntax, operators, and format of Kusto Query Language.

## Chunk your content into subtasks

Identify the subtasks of *module title*

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- | ---- | ---- | ---- | ---- |
| Assess Azure Monitor & Log Analytics workspaces | Investigate tooling | Knowledge Check | Evaluate Log Analytics | Yes |
| Deploy Log Analytics workspace | How-to deploy workspace | Exercise | Develop understanding of logs and metrics | Yes |
| Introduction to log queries | Investigate tooling | Knowledge Check | Interactive deployment | Yes |
| Enable Log Analytics extension for Azure VMs | How-to enable extension | Exercise | Interactive deployment | Yes |

## Outline the units

*Add more units as needed for your content*

1. **Introduction**

Imagine you are hired into an IT department for a large financial services firm. From an operational perspective, the IT department has been building more workloads and applications in Azure, versus building on-premises. Monitoring these workloads and applications have become difficult over time because the management team won't approve moving the on-premises monitoring environment to Azure due to licensing costs. Additionally, the environments being built in Azure are a mixture of Azure virtual machines, web applications, and Azure SQL databases. Even if the on-premises monitoring environment could be moved, it couldn't monitor PaaS resources because the solution is designed to only monitor virtual machines. As part of the operations team, you will be tasked with exploring Azure Monitor and Log Analytics as cloud native tooling for monitoring deployed Azure Resources.

1. **What is Azure Monitor and Log Analytics?**

    - Introduce both Azure Monitor and Azure Monitor logs
        - Breakdown native logging in Azure for learner
        - Resource logging is automatically sent to Azure Monitor
        - Discuss differences between metrics and logs (logs travel to Log Analytic workspace after configuration)
    - Plan Log Analytics deployment
    - Discuss different access models for Log Analytics workspaces
        - Resource-centric model
        - Workload-centric model
        - Table level RBAC
        - Permissions model for reading and writing logs

    **Knowledge check**

    1. After asking individual business units about monitoring wants and needs, you determine each unit needs to be able to query logs generated from their resources only. Which access model would you select for your Log Analytics deployment?
    1. What is the relationship between Log Analytics and Azure Monitor?

1. **Exercise - Set up Log Analytics workspace**

    Follow these steps:

    1. Log into Azure portal
    1. At the top, select "All services." In the list of resources, type Log Analytics. As Log Analytics is typed in, the list will filter based upon input. Select Log Analytics workspaces.
    1. Provide a name for the new Log Analytics workspace. The name must be globally unique.
    1. Select a subscription, resource group, and location.
    1. Once deployed, change to a resource-centric model.
    1. Deploy 2 VMs from portal and connect to Log Analytics workspace.

1. **Introduction to log queries**

    - Introduce and explain concept of log queries
        - Azure Monitor Logs is based on Azure Data Explorer; log queries are written using the Kusto Query Language (KQL)
        - Discuss functions, structure, syntax, and showcase online resources for log queries
        - Focus on table-based queries, search queries, filters, time range, summarize rows, and so on.
        - Show how queries can be used: alert rules, dashboards, views, an export to Power BI, PowerShell, and by hitting the REST API directly
    - Include detailed breakdown on insights and solutions
        - Insights and solutions allow an ability to process log data without exposing the user to underlying queries
        - Each of the insights and solutions provides a quick overview into health of deployed resources in Azure

    **Knowledge check**

    1. What are Azure Monitor log queries based on?
    1. What do Insights provide access to?

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
https://docs.microsoft.com/en-us/azure/azure-monitor/platform/data-platform-metrics
https://docs.microsoft.com/en-us/azure/azure-monitor/platform/data-platform-logs
https://docs.microsoft.com/en-us/azure/azure-monitor/log-query/log-query-overview
https://docs.microsoft.com/en-us/azure/azure-monitor/insights/vminsights-overview
https://docs.microsoft.com/en-us/azure/azure-monitor/platform/alerts-overview
https://docs.microsoft.com/en-us/azure/azure-monitor/platform/alerts-metric-overview
https://docs.microsoft.com/en-us/azure/azure-monitor/platform/alerts-unified-log
https://docs.microsoft.com/en-us/azure/azure-monitor/platform/diagnostic-settings
https://docs.microsoft.com/en-us/azure/azure-monitor/monitor-reference