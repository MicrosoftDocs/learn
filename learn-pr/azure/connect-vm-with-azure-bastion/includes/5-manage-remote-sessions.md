
In this unit, you'll learn how to manage remote sessions by enabling diagnostic logs and monitoring remote sessions.

## Configure diagnostic settings to generate audit logs
 
Azure Bastion can log information about remote user sessions. Review the logs to see who connected to which workloads, at what time, from where, and other relevant logging information. 

To generate these logs, you must configure diagnostic settings on Azure Bastion. It can take several hours for the logs to stream to a storage account. The following sections show you how to configure Azure Bastion diagnostic settings so you can try this in your own subscription later.

### Enable diagnostics for Azure Bastion

In the Azure Bastion resource, you add diagnostic settings under **Monitoring**. You need a storage account to stream the logs to. If you don't already have a storage account, create one before you try these steps in your own subscription.

1. In the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true), search for or select **Bastions**.
1. Select the Azure Bastion resource.
1. Under **Monitoring**, select **Diagnostics settings**.
1. Select **Add diagnostic setting**.

   :::image type="content" source="../media/5-bastion-diagnostics-settings.png" alt-text="Screenshot that shows the Add diagnostic settings link within the Diagnostics settings page.":::
1. Enter a name for **Diagnostic setting name**.
1. Under **log**, select **BastionAuditLogs**.
1. Under **Destination details**, select **Send to Log Analytics** and **Archive to storage account**.
1. The location, subscription, and a storage account are autopopulated. Make sure the storage account is in the same region as the Azure Bastion resource.

   :::image type="content" source="../media/5-bastion-add-diagnostic-setting.png" alt-text="Screenshot that shows the Diagnostics setting page filled out.":::
1. Select **Save**.
1. After the save is complete, close the page.

### View diagnostic logs

The diagnostic logs take several hours to appear in your storage account. Find them in the storage account under **Containers**.

:::image type="content" source="../media/5-storage-container.png" alt-text="Screenshot of a storage account with a container called insights-logs-bastionauditlogs.":::

Drill down through the resource hierarchy folders to get to the Azure Bastion host file.

:::image type="content" source="../media/5-insights-folders.png" alt-text="Screenshot of the insights logs for Azure Bastion that shows the folder location level is at the Azure Bastion host resource.":::

Continue to drill down through the year (y=), month (m=), day (d=), hour (h=), and minute (m=) folders to the find diagnostics log data for a specific the time period.  

:::image type="content" source="../media/5-insights-log-json-file.png" alt-text="Screenshot of the insights logs for Azure Bastion that shows the J S O N file for a specific time period.":::

Download the .json file to view the session details. When you open the file, it will look something like the following example. In the example, you can see information like the operation type, user name, and client IP address.

   ```json
   { 
   "time":"2020-10-22T23:26:00.697Z",
   "resourceId":"/SUBSCRIPTIONS/<subscripionID>/RESOURCEGROUPS/MYBASTION/PROVIDERS/MICROSOFT.NETWORK/BASTIONHOSTS/MYBASTION-BASTION",
   "operationName":"Microsoft.Network/BastionHost/connect",
   "category":"BastionAuditLogs",
   "level":"Informational",
   "location":"westus2",
   "properties":{ 
      "userName":"<username>",
      "userAgent":"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.90 Safari/537.36",
      "clientIpAddress":"131.107.159.86",
      "clientPort":24039,
      "protocol":"ssh",
      "targetResourceId":"/SUBSCRIPTIONS/<subscripionID>/RESOURCEGROUPS/MYBASTION/PROVIDERS/MICROSOFT.COMPUTE/VIRTUALMACHINES/LINUX-KEY",
      "subscriptionId":"<subscripionID>",
      "message":"Successfully Connected.",
      "resourceType":"VM",
      "targetVMIPAddress":"172.16.1.5",
      "tunnelId":"<tunnelID>"
   },
   "FluentdIngestTimestamp":"2020-10-22T23:26:00.0000000Z",
   "Region":"westus2",
   "CustomerSubscriptionId":"<subscripionID>"
   }
   ```

## Manage current remote sessions

Azure Bastion session monitoring lets you view which users are connected to which virtual machines. It shows the IP that the user connected from, how long they've been connected, and when they connected. You can select an ongoing session and force-disconnect the session to disconnect the user from the session.

:::image type="content" source="../media/5-delete-remote-session.png" alt-text="Screenshot of the Azure Bastion sessions page with the delete option selected for one of the two sessions.":::

You'll walk through how to manage remote sessions in the next unit.