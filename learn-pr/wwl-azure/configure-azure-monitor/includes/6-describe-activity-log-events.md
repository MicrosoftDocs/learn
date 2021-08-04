The Azure Activity Log is a subscription log that provides insight into subscription-level events that have occurred in Azure. This includes a range of data, from Azure Resource Manager operational data to updates on Service Health events.

With the Activity Log, you can determine the ‘what, who, and when’ for any write operations (PUT, POST, DELETE) taken on the resources in your subscription. You can also understand the status of the operation and other relevant properties. Through activity logs, you can determine:

 -  What operations were taken on the resources in your subscription?
 -  Who started the operation?
 -  When the operation occurred?
 -  The status of the operation.
 -  The values of other properties that might help you research the operation.

:::image type="content" source="../media/activity-log-7d1913ad.png" alt-text="Activity log is shown gathering information from compute and non-compute resources.":::


> [!NOTE]
> Activity logs are kept for 90 days. You can query for any range of dates, as long as the starting date isn't more than 90 days in the past. You can retrieve events from your Activity Log using the Azure portal, CLI, PowerShell cmdlets, and Azure Monitor REST API.
