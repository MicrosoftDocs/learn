
In this unit, you'll learn how to manage remote sessions by enabling diagnostic logs and monitoring remote sessions.

## Configure diagnostics settings to generate audit logs
 
Bastion can log remote user sessions information. Review the logs to see who  connected to which workloads, at what time, from where, and other relevant logging information. To generate these logs, you must configure diagnostic settings on Azure Bastion. It can take several hours for the logs to stream to a storage account. So you won't be able to try this out and see the logs in the sandbox environment. The following sections show you how to configure Bastion diagnostic settings so you can try this out in your own subscription later.

### Enable diagnostics for Bastion

In the Bastion resource, you add diagnostic settings under Monitoring. You need a storage account to stream the logs to. So if you don't already have a storage account, create one before you try these steps in your own subscription.

1. In the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true), search for or select **Bastions**.
1. Select the bastion resource.
1. Under **Monitoring**, select **Diagnostics settings**.
1. Select **Add diagnostic setting**.
   :::image type="content" source="../media/6-bastion-diagnostics-settings.png" alt-text="Screenshot that shows the Add diagnostic settings link within the Diagnostics Setting page.":::
1. Enter a name for **Diagnostic setting name**.
1. Under **log**, select **BastionAuditLogs**.
1. Under **Destination details**, select **Send to Log Analytics** and **Archive to storage account**. 
1. The location, subscription, and a storage account are autopopulated. Make sure the storage account is in the same region as the Bastion resource. 
   <!--(Need to create storage acct for this step?)-->
   :::image type="content" source="../media/6-bastion-add-diagnostic-setting.png" alt-text="Screenshot that shows the  diagnostics settings page filled out.":::
1. Select **Save**.
1. After save is complete, close the page.

### View diagnostic log

The diagnostic logs take several hours to appear in your storage account. Find them in the storage account under **Containers**.

:::image type="content" source="../media/5-storage-container.png" alt-text="Screenshot of a storage account with a container called insights-logs-bastionauditlogs.":::

Click through the resource hierarchy folders to get to the Bastion host file.

:::image type="content" source="../media/5-insights-folders.png" alt-text="Screenshot of the insights logs for Bastion that shows the folder location level is at the bastion host resource.":::

Continue to click through the year 'y=', month 'm=', day 'd=', hour 'h=', and minute 'm=' folders to the find diagnostics log data for a specific the time-period.  

:::image type="content" source="../media/5-insights-log-json-file.png" alt-text="Screenshot of the insights logs for Bastion that shows the json file for a specific time period.":::

Download the json file to view the session details. When you open the file it will look something like the following example where you can see information like the operation type, user name, and client IP address.

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

Azure Bastion session monitoring lets you view which users are connected to which VMs. It shows the IP that the user connected from, how long they've been connected, and when they connected. You can select an ongoing session and force-disconnect the session to disconnect the user from the session.

<!--Add screenshots of two user sessions and selecting delete to disconnect one -->
You'll walk through how to manage remote sessions in the next unit.