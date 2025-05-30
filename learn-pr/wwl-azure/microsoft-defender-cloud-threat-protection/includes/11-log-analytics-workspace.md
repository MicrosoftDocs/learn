A Log Analytics workspace is a data store into which you can collect any type of log data from all of your Azure and non-Azure resources and applications. Workspace configuration options let you manage all of your log data in one workspace to meet the operations, analysis, and auditing needs of different personas in your organization through:

 -  Azure Monitor features, such as built-in [insights experiences](/azure/azure-monitor/insights/insights-overview), [alerts](/azure/azure-monitor/alerts/alerts-create-log-alert-rule), and [automatic actions](/azure/azure-monitor/autoscale/autoscale-overview)
 -  Other Azure services, such as [Microsoft Sentinel](/azure/sentinel/overview), [Microsoft Defender for Cloud](/azure/defender-for-cloud/defender-for-cloud-introduction), and [Logic Apps](/azure/connectors/connectors-azure-monitor-logs)
 -  Microsoft tools, such as [Power BI](/azure/azure-monitor/logs/log-powerbi) and [Excel](/azure/azure-monitor/logs/log-excel)
 -  Integration with custom and third-party applications

This article provides an overview of concepts related to Log Analytics workspaces.

> [!IMPORTANT]
> [Microsoft Sentinel](/azure/sentinel/overview) documentation uses the term *Microsoft Sentinel workspace*. This workspace is the same Log Analytics workspace described in this article, but it's enabled for Microsoft Sentinel. All data in the workspace is subject to Microsoft Sentinel pricing.

## Log tables

Each Log Analytics workspace contains multiple tables in which Azure Monitor Logs stores data you collect.

Azure Monitor Logs automatically creates tables required to store monitoring data you collect from your Azure environment. You [create custom tables](/azure/azure-monitor/logs/create-custom-table) to store data you collect from non-Azure resources and applications, based on the data model of the log data you collect and how you want to store and use the data.

Table management settings let you control access to specific tables, and manage the data model, retention, and cost of data in each table. For more information, see [Manage tables in a Log Analytics workspace](/azure/azure-monitor/logs/manage-logs-tables).

## Data retention

A Log Analytics workspace retains data in two states - interactive retention and long-term retention.

During the interactive retention period, you retrieve the data from the table through queries, and the data is available for visualizations, alerts, and other features and services, based on the table plan.

Each table in your Log Analytics workspace lets you retain data up to 12 years in low-cost, long-term retention. Retrieve specific data you need from long-term retention to interactive retention using a search job. This means that you manage your log data in one place, without moving data to external storage, and you get the full analytics capabilities of Azure Monitor on older data, when you need it.

For more information, see [Manage data retention in a Log Analytics workspace](/azure/azure-monitor/logs/data-retention-configure).

## Data access

Permission to access data in a Log Analytics workspace is defined by the [access control mode](/azure/azure-monitor/logs/manage-access#access-control-mode) setting on each workspace. You can give users explicit access to the workspace by using a [built-in or custom role](/azure/azure-monitor/roles-permissions-security). Or, you can allow access to data collected for Azure resources to users with access to those resources.

For more information, see [Manage access to log data and workspaces in Azure Monitor](/azure/azure-monitor/logs/manage-access).

## View Log Analytics workspace insights

[Log Analytics Workspace Insights](/azure/azure-monitor/logs/log-analytics-workspace-insights-overview) helps you manage and optimize your Log Analytics workspaces with a comprehensive view of your workspace usage, performance, health, ingestion, queries, and change log.

## Transform data you ingest into your Log Analytics workspace

[Data collection rules (DCRs)](/azure/azure-monitor/essentials/data-collection-rule-overview) that define data coming into Azure Monitor can include transformations that allow you to filter and transform data before it's ingested into the workspace. Since all data sources don't yet support DCRs, each workspace can have a [workspace transformation DCR](/azure/azure-monitor/essentials/data-collection-transformations#workspace-transformation-dcr).

[Transformations](/azure/azure-monitor/essentials/data-collection-transformations) in the workspace transformation DCR are defined for each table in a workspace and apply to all data sent to that table, even if sent from multiple sources. These transformations only apply to workflows that don't already use a DCR. For example, [Azure Monitor agent](/azure/azure-monitor/agents/azure-monitor-agent-overview) uses a DCR to define data collected from virtual machines. This data won't be subject to any ingestion-time transformations defined in the workspace.

For example, you might have [diagnostic settings](/azure/azure-monitor/essentials/diagnostic-settings) that send [resource logs](/azure/azure-monitor/essentials/resource-logs) for different Azure resources to your workspace. You can create a transformation for the table that collects the resource logs that filters this data for only records that you want. This method saves you the ingestion cost for records you don't need. You might also want to extract important data from certain columns and store it in other columns in the workspace to support simpler queries.

## Cost

There's no direct cost for creating or maintaining a workspace. You're charged for the data you ingest into the workspace and for data retention, based on each table's [table plan](/azure/azure-monitor/logs/data-platform-logs#table-plans).

For information on pricing, see [Azure Monitor pricing](https://azure.microsoft.com/pricing/details/monitor/). For guidance on how to reduce your costs, see [Azure Monitor best practices - Cost management](/azure/azure-monitor/best-practices-cost). If you're using your Log Analytics workspace with services other than Azure Monitor, see the documentation for those services for pricing information.

## Design a Log Analytics workspace architecture to address specific business needs

You can use a single workspace for all your data collection. However, you can also create multiple workspaces based on specific business requirements such as regulatory or compliance requirements to store data in specific locations, split billing, and resilience.
