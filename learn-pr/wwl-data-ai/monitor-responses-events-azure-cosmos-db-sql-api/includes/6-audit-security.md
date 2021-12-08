There are several options we have to audit security on your Azure Cosmos DB Account.

## Activity Logs

By using audit logging and activity logs, you can monitor your account for normal and abnormal activity. You can view what operations were done on your resources, who started the operation, when the operation occurred, the status of the operation.

Activity logs, which are automatically available, contain all write operations (PUT, POST, DELETE) for your Cosmos DB resources except read operations (GET). Activity logs can be used to find an error when troubleshooting or to monitor how a user in your organization modified a resource.

To view the Activity log, on the Azure Cosmos DB account page, select **Activity log**. 

:::image type="content" source="../media/6-activity-log.png" alt-text="Diagram that shows the Azure Cosmos DB account activity log.":::

## Azure Resource Logs

Enable Azure resource logs for Cosmos DB. You can use Microsoft Defender for Cloud and Azure Policy to enable resource logs and log data collecting. These logs can be critical for investigating security incidents and doing forensic exercises.

Enable the auditing control plane under Diagnostics settings. You want to get an alert when the firewall rules for your Azure Cosmos account are modified. The alert is required to find unauthorized modifications to rules that govern the network security of your Azure Cosmos account and take quick action.

