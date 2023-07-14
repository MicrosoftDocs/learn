
The Azure Monitor activity log is a subscription log that provides insight into subscription-level events that occur in Azure. Events can include a range of data from Azure Resource Manager operational data to updates on Azure service health events.

### Things to know about activity logs

Let's examine some details about working with activity logs in Azure Monitor.

- You can use the information in activity logs to understand the status of resource operations and other relevant properties.

- Activity logs can help you determine the "what, who, and when" for any write operation (PUT, POST, DELETE) performed on resources in your subscription.

- Activity logs are kept for 90 days.

- You can query for any range of dates in an activity log, as long as the starting date isn't more than 90 days in the past.

- You can retrieve events from your activity logs by using the Azure portal, the Azure CLI, PowerShell cmdlets, and the Azure Monitor REST API.

:::image type="content" source="../media/activity-log-7d1913ad.png" alt-text="Diagram that shows how Azure Monitor activity logs gather information from compute and non-compute resources in Azure." border="false":::

#### Business scenarios

Activity logs can help you monitor your configuration and get details for many scenarios, such as:

 _What operations happened on resources in my subscription?_

 _Who initiated the operations?_

 _When did the operations occur?_

 _What's the current status of the operations?_

 _What are the values of other properties that can help with my analysis of the resources and operations?_