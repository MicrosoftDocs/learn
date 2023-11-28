Your company protects several critical workloads using Azure Backup that needs constant monitoring. As the lead solution architect, you have been asked to ensure that the company can review and analyze the status of all protection operations being performed and receive timely alerts for any failures.

Azure Backup allows you to monitor your backup instances and backup jobs, configure alerts for any failed operations, and do historical reporting based on log data. To facilitate these analytical capabilities, Azure Backup integrates with various Azure services, such as:

- Azure Resource Graph
- Azure Monitor Alerts
- Azure Monitor Logs
- Azure Resource Health

You can use a combination of these integrations based on your monitoring and reporting requirements. To monitor operations related to backup and restore of various workloads, you can use Azure clients, such as Azure portal, Azure PowerShell, Azure CLI, and Azure REST API.

## Why is monitoring of backups  important?

As you back up more and more data to Azure, it becomes important to have easy visibility into the items you're protecting because any failures in your backups can pose business continuity risks. For this, it's important to have the right set of practices and tools to monitor your backups at scale in a manner that needs minimal manual intervention.

## Learning objectives

At the end of this module, you'll be able to:

- Learn about various scenarios for your backup instances and backup jobs
- Configure alerts for any failed backup operations
- Perform historical reporting of your backup data based on log data.

## Prerequisites

- Familiarity with the Azure Backup service. Familiarity with...
- Must have Read permission on the vaults that are used to back up data to view out-of-the-box Backup center views, such as backup jobs and backup instances.
- Must have Monitoring Contributor and Backup Contributor permissions on the required subscription to configure alerts and reports.

## Monitoring scenarios

The following table provides a summary of the different monitoring and reporting scenarios that commonly arise in enterprise backup deployments, and the different capabilities that Azure Backup provides today for each of these scenarios, along with the relevant document references.

| Scenario | Solutions available |
| --- | --- |
| Monitor backup jobs and backup instances | - **Built-in monitoring**: You can monitor backup jobs and backup instances in real time via the Backup center dashboard. <br><br> - **Customized monitoring dashboards**: Azure Backup allows you to use non-portal clients, such as PowerShell, CLI, and REST API, to query backup monitoring data for use in your custom dashboards.  In addition, you can query your backups at scale (across vaults, subscriptions, regions, and Lighthouse tenants) using Azure Resource Graph (ARG).  Backup Explorer is one sample monitoring workbook, which uses data in ARG that you can use as a reference to create your own dashboards.  |
| Monitor overall backup health  	 |   - **Resource Health**: You can monitor the health of your Recovery Services vault and Backup vaults, and troubleshoot events causing the resource health issues. You can view the health history and identify events affecting the health of your resource. You can also trigger  alerts related to the resource health events.  <br><br> - **Azure Monitor Metrics**: Azure Backup also offers the above health metrics via Azure Monitor, which provides you more granular details about the health of your backups. This also allows you to configure alerts and notifications on these metrics.  |
| Get alerted to critical backup incidents 	   |  - **Built-in alerts using Azure Monitor**: Azure Backup provides an alerting solution based on Azure Monitor for scenarios, such as deletion of backup data, disabling of soft-delete, backup failures, and restore failures. You can view and manage these alerts via Backup center. To configure notifications for these alerts (for example, emails), you can use Azure Monitor's Action rules and Action groups to route alerts to a wide range of notification channels.  <br><br> - **Azure Backup Metric Alerts using Azure Monitor (preview)**: You can write custom alert rules using Azure Monitor metrics to monitor the health of your backup items across different KPIs.  <br><br> - **Classic Alerts**: This is the older alerting solution, which you can access using the Backup Alerts tab in the Recovery Services vault blade. These alerts don't appear in Backup center. If you're using classic alerts, we recommend to start using one or more of the Azure Monitor based alert solutions (described above) as it's the forward-looking solution for alerting. <br><br> - **Custom log alerts**: If you have scenarios where an alert needs to be generated based on custom logic, you can use Log Analytics based alerts for such scenarios, provided you've configured your vaults to send diagnostics data to a Log Analytics (LA) workspace. Due to the current frequency at which data in an LA workspace is updated, this solution is typically used for scenarios where it's acceptable to have a short time difference between the occurrence of the actual incident and the generation of the alert.    |
| Analyze historical trends        |    - **Built-in reports**: You can use Backup Reports (based on Azure Monitor Logs) to analyze historical trends related to job success and backup usage, and discover optimization opportunities for your backups. You can also configure periodic emails of these reports. <br><br> - **Customized reporting dashboards**: You can also query the data in Azure Monitor Logs (LA) using the documented system functions to create your own dashboards to analyze historical information related to your backups.    |
| Audit user triggered actions on vaults	|       **Activity Logs**: You can use standard Activity Logs for your vaults to view information on various user-triggered actions, such as modification of backup policies, restoration of a backup item, and so on. You can also configure alerts on Activity Logs, or export these logs to a Log Analytics workspace for long-term retention. |


