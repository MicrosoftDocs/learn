# Title

Analyze log data by using Log Analytics in Azure Monitor

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
- Basic familiarity with SQL query language

## Summary

Assess Log Analytics and Azure Monitor. Deploy Log Analytics workspace. Enable Log Analytics extension on Azure virtual machines. Configure diagnostic settings for Azure VMs. Monitor performance of virtual machines using Log Analytics queries and create alerts. Save results of queries to a dashboard and interpret graphical representations of data extracted from queries.

## Learning objectives

1. Describe relationship between Azure Monitor and Log Analytics
1. Create Log Analytics workspace, configure with right access permissions, and decide upon resource-centric or workspace-centric model for deployment
1. Write queries, set up alerts from queries, and configure diagnostic settings for Azure virtual machines
1. Save queries to dashboards and interpret graphs of extracted data

## Chunk your content into subtasks

Identify the subtasks of *module title*

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- | ---- | ---- | ---- | ---- |
| Assess Log Analytics and Azure Monitor | Investigate tooling | Knowledge Check | Evaluate Azure Monitor and Log Analytics | Yes |
| Evaluate diagnostics settings and metrics | Investigate tooling | Knowledge Check | Develop understanding of logs and metrics | Yes |
| Deploy Log Analytics workspace | How-to deploy workspace | Exercise | Interactive deployment | Yes |
| Enable Log Analytics extension for Azure VMs | How-to enable extension | Exercise | Interactive deployment | Yes |
| Configure diagnostics settings for Azure VMs | How-to configure diagnostic settings for VMs | Exercise | Interactive configuration | Yes |
| Monitor performance of VMs using Log Analytics queries + alerts | How-to monitor using queries and alerts | Exercise | Interactive configuration | Yes |
| Save results of queries to a dashboard and interpret graphical representations of data extracted from queries | How-to save results of queries for analysis | Exercise | Interactive configuration | Yes |

## Outline the units

*Add more units as needed for your content*

1. **Introduction**

Imagine you are hired into an IT department for a large financial services firm. From an operational perspective, the IT department has been building more workloads and applications in Azure, versus building on-premises. Monitoring these workloads and applications have become difficult over time because the management team won't approve moving the on-premises monitoring environment to Azure due to licensing costs. Additionally, the environments being built in Azure are a mixture of Azure virtual machines, web applications, and Azure SQL databases. Even if the on-premises monitoring environment could be moved, it couldn't monitor PaaS resources because the solution is designed to only monitor virtual machines. As part of the operations team, you will be tasked with exploring Azure Monitor and Log Analytics as cloud native tooling for monitoring deployed Azure Resources.

1. **What is Azure Monitor and Log Analytics?**

    - Introduce both Azure Monitor and Log Analytics
        - Breakdown native logging in Azure for learner
        - Resource logging is automatically sent to Azure Monitor
    - Plan Azure Monitor Logs deployment
    - Discuss different access models for Log Analytics
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

1. **Introduction to Azure Monitor Metrics**

    - Introduce metrics
        - Focus on the difference between metrics and logs
        - Indicate data collected by Azure Monitor Metrics is stored in a time-series database, which is optimized for analyzing time-stamped data
        - Highlight multi-dimensional metrics and sources of Azure Monitor Metrics
        - Cover near real time alerting and fast detection of issues
        - Go over different ways to use metric data in Azure Monitor
    
    **Knowledge check**
    1. What are the differences between metrics and logs captured in Azure?
    1. What are the sources of Azure Monitor Metrics?

1. **Introduction to diagnostics settings**

     - Introduce diagnostics settings
        - Cover that diagnostic settings provide greater visibility into platform events that Azure resources depend on
        - Go over different types of platform logs (resource logs - previously diagnostic logs, Activity log, Azure Active Directory logs) and metrics related to detailed diagnostic settings
        - Platform logs are generated automatically, but not collected automatically unless a configuration setting is made
        - Discuss the ways to collect diagnostic settings (Log Analytics workspaces, Event hubs, or Azure Blob Storage)

    **Knowledge check**

    1. What are all the destinations you can send platform logs to for diagnostic settings of Azure resources?
    1. What do Azure Active Directory logs showcase?

1. **Exercise - Build log queries**

    Follow these steps:

    1. Open up browser and go to Log Analytics demo workspace: https://portal.loganalytics.io/demo
    1. Showcase how to comment (helpful for reusable code stored in source control).
    1. Focus on all primary operators the learner will predominantly use to find information: search, where, take, count, summarize, extend, project, distinct, and top.
    1. Build queries off of Heartbeat and Perf tables for Azure IaaS VMs reporting to demo workspace.  

1. **Exercise - Set up diagnostic settings and Insights**
    - Log into Azure portal
    - At the top, select "All services." In the list of resources, type Monitor. 
    - As Azure Monitor loads, underneath "Settings" on the left, you should see "Diagnostics settings." Select "Diagnostics settings."
    - Select a resource that shows up from the VMs you created earlier and add a diagnostic setting (example - nics).
    - Place a check mark in the box next to "AllMetrics" and a check mark in "Send to Log Analytics." Ensure you select the right subscription and Log Analytics workspace.
    - Setting up diagnostics for VMs is a bit different. When the VM is selected in the portal, on the left, move down to the "Monitoring" section. Underneath there, select "Diagnostic settings." The overview pane will open. From there, you will need to select "Enable guest-level monitoring," which requires a storage account to be created.
    - Move up to "Insights" and select "Enable."

1. **Exercise - Set up alerts for VMs**
    - Select each VM created earlier in the Learn module.
    - On the left-hand side, under "Monitoring", you'll see "Alerts." Select "Alerts."
    - Select "New Alert Rule."
    - Leave the scope each VM resource.
    - For Condition, launch the pop-out by selecting "Select condition."
    - In "Configure signal logic," type in "CPU" in the "Search by signal name" field.
    - Select "Percentage CPU."
    - Leave the "Threshold" at "Static."
    - Leave the "Operator" at "Greater than."
    - Change the "Aggregation type" to "Total."
    - Input 90 as the "Threshold value."
    - Leave the "Aggregation granularity" at 5 minutes and the "Frequency of evaluation" at "Every 1 Minute."
    - When finished, select "Done."
    - Move down to "Action group" next.
    - Select "Select action group."
    - Select "Create action group."
    - Add the "Action group name' and "Display name."
    - Select "Next: Notifications."
    - In the "Notification type," use the drop-down and select "Email/SMS message/Push/Voice."
    - Inside the pane that pops out, place a check mark on email.
    - Type in your email or a sample email.
    - Select "Ok." This action will close the pane so you can move onto the next step.
    - Select "Next: Actions."
    - Explore the drop-down items: Automation Runbook, Azure Function, ITSM, Logic App, Secure Webhook, and Webhook. These drop-down items are where you can configure more complex alerts in an automated fashion.
    - Select "Review + create."
    - Once the validation passes, select "Create."
    - Repeat similar steps for custom log query alert.

1. **Exercise - Create dashboards and analyze metric data from Azure Monitor**
    - Select the Log Analytics workspace created earlier in the module.
    - On the left-hand side, select "Logs" under "General."
    - When Logs loads, you will see a similar interface to the demo workspace from earlier in the module.
    - Use a query from the Perf table: query will take the counter % Processor Time, focus on the total count, and summarize an aggregated value by computer. The result will be rendered in a timechart.
    - Inside the Logs pane, select "Pin to dashboard."
    - Select 1 of the 2 VMs created earlier in the module.
    - Move down to the "Monitoring" section.
    - Select "Insights" and view the different charts to highlight averages, trends, and performance metrics for VM over a set period of time.

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