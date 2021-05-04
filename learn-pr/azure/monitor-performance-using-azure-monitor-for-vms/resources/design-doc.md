# Title

Monitor performance of virtual machines using Azure Monitor Logs and Virtual Machine Insights.

## Role(s)

- Administrator

## Level

- Beginner

## Product(s)

- Azure Monitor Logs
- Log Analytics workspaces
- VM Insights
- Azure Monitor

## Prerequisites

- Experience using the Azure portal for accessing and creating resources.
- Knowledge of Azure virtual machine creation, administration, and maintenance.
- Basic familiarity with querying datasets to filter and extract information.

## Summary

First, you will evaluate Azure Monitor log tooling in your journey to better the monitoring environment for your company. From there, you will deploy a Log Analytics workspace. Once the Log Analytics workspace is ready, you will onboard VMs to the Log Analytics workspace and configure VM Insights. In order to understand the types of data you can extract, you will start to build familiarity with the syntax of Azure Monitor log queries inside a Log Analytics workspace using standard operators. Once you feel comfortable with the structure, you will take some of the pre-configured queries in a Log Analytics workspace and query performance of virtual machines using the Kusto Query Language.

## Learning objectives

By the end of this module you should be able to:
1. Evaluate Azure Monitor Logs and VM Insights.
1. Configure a Log Analytics workspace.
1. Build queries from heartbeat and insights tables.

## Chunk your content into subtasks

Identify the subtasks of *module title*

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- | ---- | ---- | ---- | ---- |
| Evaluate Azure Monitor Logs, VM Insights, and Log Analytics workspaces | Investigate tooling | Knowledge Check | Evaluate Azure Monitor Logs and VM Insights | Yes |
| Configure Log Analytics workspace, onboard VMs to Log Analytics and VM Insights | How-to deploy workspace | Exercise | Configure Log Analytics workspace | Yes |
| Build pre-configured and custom queries | How-to structure and build queries | Exercise | Build queries from heartbeat and insights tables | Yes |

## Outline the units

*Add more units as needed for your content*

1. **Introduction**

Imagine you're newly hired into an IT department for a large financial services firm. From an operational perspective, the IT department has been building more workloads and applications in Azure. Monitoring these workloads and applications has become difficult over time. The management team won't approve moving the on-premises monitoring environment to Azure on account of licensing costs. As part of the operations team, you'll be exploring cloud native tooling for monitoring and logging by examining Azure Monitor Logs, Log Analytics workspaces, and VM Insights.

1. **What is Azure Monitor, Azure Monitor Logs, and Log Analytics workspaces?**

    - Introduce Azure Monitor, Azure Monitor logs, and Log Analytics workspaces
        - Break down native logging in Azure for learner.
        - Resource logging is automatically sent to Azure Monitor.
        - Discuss differences between metrics and logs.
    - Plan Log Analytics workspaces deployment and highlight VM onboarding
        - Include how-to screen shot
    - Discuss different access models for Log Analytics workspaces
        - Resource-centric model
        - Workspace-centric model
        - Table level RBAC
        - Permissions model for reading and writing logs
    - Highlight vm agents, insights, and solutions.
        - Allow an ability to process log data without exposing the user to underlying queries.

    **Knowledge check**

    1. You start out by talking to individual business units about monitoring wants and needs at the start of your assignment. You determine each business unit only needs to query logs generated from their resources. Which access model would you select for your Log Analytics deployment?
    1. What does VMInsights provide access to?

1. **Exercise - Set up Log Analytics workspace and VM Insights**

    Follow these steps:

    1. Log into Azure portal
    1. At the top, select "All services." In the list of resources, type Log Analytics. As Log Analytics is typed in, the list will filter based upon input. Select Log Analytics workspaces.
    1. Provide a name for the new Log Analytics workspace. The name must be globally unique.
    1. Select a subscription, resource group, and location.
    1. Once deployed, change to a resource-centric model.
    1. Deploy 2 VMs from portal and connect to Log Analytics workspace.
    1. After both VMs are connected to Log Analytics workspace, onboard both to VM Insights. Select "Insights" on the far left and select "Enable."
    1. Once enabled, go into the "Insights" section of each VM underneath the Monitoring area. Onboarding VM Insights takes a few minutes.
    1. Once the pane opens and onboarding is finished, select "Performance."
    1. Explore the different graphs for: Logical Disk Performance, CPU Utilization, Available Memory, Logical Disk IOPS, Logical Disk MB/s, Logical Disk Latency (ms), Max Logical Disk Used %, Bytes Sent Rate, and Bytes Received Rate.
    1. Experiment with different settings. Move from "Avg", to "Min", to "Max", and so on.
    1. Take note of how easy it's to drill into Log Events on the far right-hand side of the page.  

1. **Introduction to log queries**

    - Introduce and explain concept of log queries
        - Azure Monitor Logs are based on Azure Data Explorer; log queries are written using the Kusto Query Language (KQL).
        - Showcase how to write basic queries.
        - Highlight getting started queries and schema explorer.
        - Discuss functions, structure, syntax, and showcase online resources for log queries. Link to examples (at end of module).
        - Start with table-based queries, as they're the easiest tables to use with beginning an extract of data. Then build off of search queries, filters, time range, summarize rows, and so on.
        - Show how queries can be used.

    **Knowledge check**

    1. What are Azure Monitor log queries based on?
    1. What is the easiest way to start digging into data that Azure Monitor logs contain?

1. **Exercise - Build log queries**

    Follow these steps:

    1. Open up browser and go to Log Analytics demo workspace: https://portal.loganalytics.io/demo
    1. Showcase how to comment (helpful for reusable code stored in source control).
    1. Demonstrate how learner does not have to start from scratch (schema explorer).
    1. Focus on all primary operators the learner will predominantly use to find information: search, where, take, count, summarize, extend, project, distinct, and top.
    1. Build queries off of Heartbeat and Insights tables for Azure IaaS VMs reporting to demo workspace.  

1. **Summary**

    How did you solve the problem in the initial scenario with the knowledge learned in the module?

    1. Evaluate and investigate Azure Monitor, Azure Monitor logs, Log Analytics workspaces, and VM Insights.
    1. Deploy Log Analytics workspace, onboard VMs to workspace, onboard VMs to VM Insights.
    1. Build familiarity with query language of Azure Monitor logs.
    1. Create custom queries using the heartbeat and perf tables.

## Notes

[Azure Monitor Overview](https://docs.microsoft.com/azure/azure-monitor/overview)

[Azure Monitor Terminology Changes](https://docs.microsoft.com/azure/azure-monitor/terminology)

[Sources of monitoring data for Azure Monitor](https://docs.microsoft.com/azure/azure-monitor/platform/data-sources)

[Azure Monitor data platform](https://docs.microsoft.com/azure/azure-monitor/platform/data-platform)

[Monitoring data locations in Azure Monitor](https://docs.microsoft.com/azure/azure-monitor/platform/data-locations)

[Logs in Azure Monitor](https://docs.microsoft.com/azure/azure-monitor/platform/data-platform-logs)

[Log query overview](https://docs.microsoft.com/azure/azure-monitor/log-query/log-query-overview)

[Overview of log queries in Azure Monitor](https://docs.microsoft.com/azure/azure-monitor/insights/vminsights-overview)

[What is monitored by Azure Monitor?](https://docs.microsoft.com/azure/azure-monitor/monitor-reference)

[Kusto Query Language (KQL) from Scratch](https://www.pluralsight.com/courses/kusto-query-language-kql-from-scratch)
