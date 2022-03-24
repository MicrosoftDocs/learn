Azure Monitor is based on a [common monitoring data platform](/azure/azure-monitor/data-platform) that includes [Logs](/azure/azure-monitor/logs/data-platform-logs) and [Metrics](/azure/azure-monitor/essentials/data-platform-metrics). Collecting data into this platform allows data from multiple resources to be analyzed together using a common set of tools in Azure Monitor. Monitoring data may also be sent to other locations to support certain scenarios, and some resources may write to other locations before they can be collected into Logs or Metrics. [Azure Monitor Logs](/azure/azure-monitor/platform/data-platform-logs) can store various data types each with their own structure. You can also perform complex analysis on logs data using log queries, which cannot be used for analysis of metrics data. Azure Monitor Metrics can support near real-time scenarios, making them useful for alerting and fast detection of issues. 

This unit describes the different sources of monitoring data collected by Azure Monitor in addition to the monitoring data created by Azure resources. 

Consider Tailwind Traders Azure environment. What sources of monitoring data might they want to collect? 

## Identify data sources and access method

:::image type="content" source="../media/azure-monitor-source.png" alt-text="Sources of monitoring data for Azure Monitor.":::

Sources of monitoring data from Azure applications can be organized into tiers, the highest tiers being your application itself and the lower tiers being components of the Azure platform. The method of accessing data from each tier varies. The application tiers are summarized in the table below, and the sources of monitoring data in each tier are presented in the following sections. Visit [Monitoring data locations in Azure](/azure/azure-monitor/monitor-reference) for a description of each data location and how you can access its data.

Azure Monitor collects data automatically from a range of components. For example:

- **Application data**: Data that relates to your custom application code.

- **Operating system data**: Data from the Windows or Linux virtual machines that host your application.

- **Azure resource data**: Data that relates to the operations of an Azure resource, such as a web app or a load balancer.

- **Azure subscription data**: Data that relates to your subscription. It includes data about Azure health and availability.

- **Azure tenant data**: Data about your Azure organization-level services, such as Azure Active Directory.

:::image type="content" source="../media/data-sources.png" alt-text="This diagram shows how Azure Monitor collects data from a range of sources.":::


## Azure tenant logging solutions

Telemetry related to your Azure tenant is collected from tenant-wide services such as Azure Active Directory.

:::image type="content" source="../media/azure-monitor-tenant.png" alt-text=" Sources of monitoring data for Active Directory.":::


### Azure Active Directory audit logs

[Azure Active Directory reporting](/azure/active-directory/reports-monitoring/overview-reports) contains the history of sign-in activity and audit trail of changes made within a particular tenant.

| **Destination**| **Description**| **Reference** |
| - | - | - |
| Azure Monitor Logs| Configure Azure AD logs to be collected in Azure Monitor to analyze them with other monitoring data.| [Integrate Azure AD logs with Azure Monitor logs](/azure/active-directory/reports-monitoring/howto-integrate-activity-logs-with-log-analytics) |
| Azure Storage| Export Azure AD logs to Azure Storage for archiving.| [Tutorial: Archive Azure AD logs to an Azure storage account](/azure/active-directory/reports-monitoring/quickstart-azure-monitor-route-logs-to-storage-account) |
| Azure Event Hub| Stream Azure AD logs to other locations using Event Hub.| [Tutorial: Stream Azure Active Directory logs to an Azure Event Hub](/azure/active-directory/reports-monitoring/tutorial-azure-monitor-stream-logs-to-event-hub). |
| Azure Monitor partner integrations | Specialized integrations between Azure Monitor and other non-Microsoft monitoring platforms. Useful when you are already using one of the partners. | [Extend Azure with solutions from partners](/azure/partner-solutions/overview) |


## Operating system (guest) logging solutions 

Compute resources in Azure, in other clouds, and on-premises have a guest operating system to monitor. With the installation of one or more agents, you can gather telemetry from the guest into Azure Monitor to analyze it with the same monitoring tools as the Azure services themselves.

:::image type="content" source="../media/azure-monitor-compute.png" alt-text=" Sources of monitoring data for Azure Compute.":::

