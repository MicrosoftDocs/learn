The Azure Monitor activity log is a platform log in Azure that provides insight into subscription-level events. The activity log includes information like when a resource is modified or a virtual machine is started. You can view the activity log in the Azure portal or retrieve entries with PowerShell and the Azure CLI. This article provides information on how to view the activity log and send it to different destinations.

For more functionality, create a diagnostic setting to send the activity log to one or more of these locations for the following reasons:<br>

 -  Send to Azure Monitor Logs for more complex querying and alerting and for longer retention, up to two years.<br>
 -  Send to Azure Event Hubs to forward outside of Azure.
 -  Send to Azure Storage for cheaper, long-term archiving.

 -  Entries in the Activity Log are system generated and can't be changed or deleted.
 -  Entries in the Activity Log are representing control plane changes like a virtual machine restart, any non related entries should be written into Azure Resource Logs.

## Retention period

Activity log events are retained in Azure for 90 days and then deleted. There's no charge for entries during this time regardless of volume. For more functionality, such as longer retention, create a diagnostic setting and route the entries to another location based on your needs. See the criteria in the preceding section.

## View the activity log

You can access the activity log from most menus in the Azure portal. The menu that you open it from determines its initial filter. If you open it from the Monitor menu, the only filter is on the subscription. If you open it from a resource's menu, the filter is set to that resource. You can always change the filter to view all other entries. Select Add Filter to add more properties to the filter.

:::image type="content" source="../media/new-view-activity-log-c436f259.png" alt-text="Screenshot showing the Azure monitor activity log.":::


## Download the activity log

Select **Download as CSV** to download the events in the current view.

:::image type="content" source="../media/new-download-activity-log-a5239d87.png" alt-text="Screenshot showing how to download the Azure monitor activity log.":::


### View change history

For some events, you can view the change history, which shows what changes happened during that event time. Select an event from the activity log you want to look at more deeply. Select the Change history tab to view any changes on the resource up to 30 minutes before and after the time of the operation.

:::image type="content" source="../media/new-change-history-event-d33cc7c2.png" alt-text="Screenshot showing how to create or update a virtual machine.":::


If any changes are associated with the event, you'll see a list of changes that you can select. Selecting a change opens the **Change history** page. This page displays the changes to the resource. In the following example, you can see that the VM changed sizes.

:::image type="content" source="../media/new-change-history-event-details-a1afa966.png" alt-text="Screenshot showing export activity logs.":::


### Other methods to retrieve activity log events

You can also access activity log events by using the following methods:

 -  Use the Get-AzLog cmdlet to retrieve the activity log from PowerShell. See Azure Monitor PowerShell samples.<br>
 -  Use az monitor activity-log to retrieve the activity log from the CLI. See Azure Monitor CLI samples.
 -  Use the Azure Monitor REST API to retrieve the activity log from a REST client.

## Send to Log Analytics workspace

Send the activity log to a Log Analytics workspace to enable the Azure Monitor Logs feature, where you:

 -  Correlate activity log data with other monitoring data collected by Azure Monitor.<br>
 -  Consolidate log entries from multiple Azure subscriptions and tenants into one location for analysis together.
 -  Use log queries to perform complex analysis and gain deep insights on activity log entries.
 -  Use log alerts with Activity entries for more complex alerting logic.
 -  Store activity log entries for longer than the activity log retention period.
 -  Incur no data ingestion or retention charges for activity log data stored in a Log Analytics workspace.
 -  The default retention period in Log Analytics is 90 days.

Select Export Activity Logs to send the activity log to a Log Analytics workspace.

:::image type="content" source="../media/new-diagnostic-settings-export-b803e310.png" alt-text="Screenshot showing how to export activity logs to send to a Log Analytics workspace.":::


You can send the activity log from any single subscription to up to five workspaces.

Activity log data in a Log Analytics workspace is stored in a table called AzureActivity that you can retrieve with a log query in Log Analytics. The structure of this table varies depending on the category of the log entry.

For example, to view a count of activity log records for each category, use the following query:

| Kusto                                                 |
| ----------------------------------------------------- |
| `AzureActivity``| summarize count() by CategoryValue` |

To retrieve all records in the administrative category, use the following query:

| Kusto                                                      |
| ---------------------------------------------------------- |
| `AzureActivity``| where CategoryValue == "Administrative"` |

*In some scenarios, it's possible that values in fields of AzureActivity might have different casings from otherwise equivalent values. Take care when querying data in AzureActivity to use case-insensitive operators for string comparisons, or use a scalar function to force a field to a uniform casing before any comparisons. For example, use the tolower() function on a field to force it to always be lowercase or the =~ operator when performing a string comparison.*

## Send to Azure Storage

Send the activity log to an Azure Storage account if you want to retain your log data longer than 90 days for audit, static analysis, or back up. If you're required to retain your events for 90 days or less, you don't need to set up archival to a storage account. Activity log events are retained in the Azure platform for 90 days.

When you send the activity log to Azure, a storage container is created in the storage account as soon as an event occurs. The blobs in the container use the following naming convention:

| `insights-activity-logs/resourceId=/SUBSCRIPTIONS/{subscription ID}/y={four-digit numeric year}/m={two-digit numeric month}/d={two-digit numeric day}/h={two-digit 24-hour clock hour}/m=00/PT1H.json` |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |

For example, a particular blob might have a name similar to:

| `insights-logs-networksecuritygrouprulecounter/resourceId=/SUBSCRIPTIONS/00000000-0000-0000-0000-000000000000/y=2020/m=06/d=08/h=18/m=00/PT1H.json` |
| --------------------------------------------------------------------------------------------------------------------------------------------------- |

Each PT1H.json blob contains a JSON object with events from log files that were received during the hour specified in the blob URL. During the present hour, events are appended to the PT1H.json file as they are received, regardless of when they were generated. The minute value in the URL, m=00 is always 00 as blobs are created on a per hour basis.

Each event is stored in the PT1H.json file with the following format. This format uses a common top-level schema but is otherwise unique for each category, as described in Activity log schema.

| JavaScript Object Notation                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `{ "time": "2020-06-12T13:07:46.766Z", "resourceId": "/SUBSCRIPTIONS/00000000-0000-0000-0000-000000000000/RESOURCEGROUPS/MY-RESOURCE-GROUP/PROVIDERS/MICROSOFT.COMPUTE/VIRTUALMACHINES/MV-VM-01", "correlationId": "0f0cb6b4-804b-4129-b893-70aeeb63997e", "operationName": "Microsoft.Resourcehealth/healthevent/Updated/action", "level": "Information", "resultType": "Updated", "category": "ResourceHealth", "properties": {"eventCategory":"ResourceHealth","eventProperties":{"title":"This virtual machine is starting as requested by an authorized user or process. It will be online shortly.","details":"VirtualMachineStartInitiatedByControlPlane","currentHealthStatus":"Unknown","previousHealthStatus":"Unknown","type":"Downtime","cause":"UserInitiated"}}}` |
