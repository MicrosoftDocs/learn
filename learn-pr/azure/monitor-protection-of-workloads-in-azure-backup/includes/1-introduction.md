Your company protects several of its critical workloads by using Azure Backup. Critical data protection needs constant monitoring. As the lead solution architect, you're asked to ensure that the company can review and analyze the status of all data protection operations that are being performed, and get timely alerts for any failures.

You know that the company uses Azure Backup to monitor its backup instances and backup jobs, set up alerts for failed operations, and create historical reports based on log data.

To facilitate these analytical capabilities, Azure Backup integrates with other Azure services, including:

- Azure Resource Graph
- Azure Monitor alerts
- Azure Monitor logs
- Azure Resource Health

You can use a combination of these integrations based on your monitoring and reporting requirements. To monitor operations that are related to backup and restore of various workloads, you can use Azure clients, such as the Azure portal, Azure PowerShell, the Azure CLI, and the Azure REST API.

## Why is monitoring backups important?

As you back up more and more data to Azure, it becomes important to have easy visibility into the data you're protecting. Any failures in your backups create risk for business continuity. For this reason, it's important to have the right set of practices and tools to monitor your backups at scale with minimal manual intervention.

## Monitoring scenarios

The following table provides a summary of the different monitoring and reporting scenarios that commonly arise in enterprise backup deployments, and the different capabilities that Azure Backup provides today for each of these scenarios, along with the relevant document references.

| Scenario | Solutions |
| --- | --- |
| Monitor backup jobs and backup instances | - **Built-in monitoring**: You can monitor backup jobs and backup instances in real time via the Backup center dashboard. <br><br> - **Customized monitoring dashboards**: In Azure Backup, you can use nonportal clients like PowerShell, the Azure CLI, and REST API to query backup monitoring data to use in custom dashboards. You also can query your backups at scale (across vaults, subscriptions, regions, and Lighthouse tenants) by using Azure Resource Graph. Backup Explorer is one sample monitoring workbook. Backup Explorer uses data in Azure Resource Graph that you can use as a reference to create your own dashboards.  |
| Monitor overall backup health  |   - **Resource health**: You can monitor the health of your Recovery Services vault and Backup vault, and troubleshoot events that cause resource health issues. View health history and identify events that affect the health of your resource. You also can trigger alerts that are related to resource health events.  <br><br> - **Azure Monitor metrics**: Azure Backup also offers the same health metrics via Azure Monitor. Azure Monitor gives you more granular details about the health of your backups. You can configure alerts and notifications on these metrics.  |
| Be alerted to critical backup incidents  |  - **Built-in alerts via Azure Monitor**: Azure Backup provides an alerting solution that's based on Azure Monitor for scenarios like the deletion of backup data, a scenario in which soft-delete is disabled, and backup and restore failures. You can view and manage these alerts via Backup center. You can use Azure Monitor action processing rules and action groups to route alerts to a wide range of notification channels, like to specific email addresses.  <br><br> - **Azure Backup metric alerts via Azure Monitor (preview)**: You can write custom alert rules by using Azure Monitor metrics to monitor the health of your backup items across different KPIs.  <br><br> - **Classic alerts**: Classic alerts is the earlier-version alerting solution. You can access classic alerts via the **Backup Alerts** tab in the Recovery Services vault pane. Classic alerts don't appear in Backup center. If you're using classic alerts, we recommend that you start using one or more of the Azure Monitor-based alert solutions. They are the forward-looking solutions for alerting. <br><br> - **Custom log alerts**: If you have a scenario in which an alert needs to be generated based on custom logic, you can use Log Analytics-based alerts if you configure your vaults to send diagnostics data to a Log Analytics workspace. Due to the current frequency at which data in a Log Analytics workspace is updated, this solution is typically used for a scenario in which it's acceptable to have a short time difference between the occurrence of an incident and the generation of an alert.    |
| Analyze historical trends        |    - **Built-in reports**: You can use Backup Reports, which are based on Azure Monitor logs, to analyze historical trends related to job success and backup usage. You can iscover optimization opportunities for your backups and configure periodic emails of these reports. <br><br> - **Customized reporting dashboards**: You also query the data in Azure Monitor logs by using the documented system functions to create your own dashboards to analyze historical information that's related to your backups.    |
| Audit user-triggered actions on vaults | **Activity logs**: You can use standard activity logs for your vaults to view information about various user-triggered actions, such as modification of backup policies or restoration of a backup item. You can also configure alerts on activity logs, or export these logs to a Log Analytics workspace for long-term retention. |
