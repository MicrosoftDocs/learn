
In this unit, you'll learn how to manage remote sessions by enabling diagnostic logs and monitoring remote sessions

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


1. Drill through files.
<!--(Give specific scenario to look for.)

When are these files generated?)-->