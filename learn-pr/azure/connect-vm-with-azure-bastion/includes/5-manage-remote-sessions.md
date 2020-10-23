
In this unit, you'll learn how to manage remote sessions by enabling diagnostic logs and monitoring remote sessions

## Configure diagnostics settings to generate audit logs
 
Bastion can log diagnostics of remote user sessions. Review the audit logs to see who  connected to which workloads, at what time, from where, and other relevant logging information. To generate these logs, you must configure diagnostic settings on Azure Bastion. It can take several hours for the logs to stream to your storage account. So you won't be able to try this out in the sandbox environment. 



## Create storage account for diagnostics

Before you can enable diagnostics for Bastion, you need to set up a storage account for the diagnostic data.

1. In the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true), search for or select **Storage accounts**.
1. In **Storage accounts**, select **Add**.
1. Use the following values for the storage account:
   
   |Box |Value  |
   |---------|---------|
   |Resource group | **<rgn>[sandbox resource group name]</rgn>**        |
   |Storage account name   | Enter a unique name  like **strgacctdiagnosticsXXXX** where you replace XXXX to make the name unique.     |
   |Location|Select the same region as your Bastion resource.|

   Accept the defaults for the rest of the values.

1. Select **Review + create** and then select **Create**.

## Enable diagnostics for Bastion

In the Bastion resource, add diagnostic settings under Monitoring by completing the following steps.

1. In the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true), search for or select **Bastions**.
1. Select the bastion resource **internalappvmVNET-bastion**.
1. Under **Monitoring**, select **Diagnostics settings**.
1. Select **Add diagnostic setting**.
   :::image type="content" source="../media/6-bastion-diagnostics-settings.png" alt-text="Screenshot that shows the Add diagnostic settings link within the Diagnostics Setting page.":::
1. For **Diagnostic setting name**, enter **bastion-diagnostic**. 
1. Under **log**, select **BastionAuditLogs**.
1. Under **Destination details**, select **Send to Log Analytics** and **Archive to storage account**. 
1. The location, subscription, and a storage account are autopopulated. Make sure the storage account is in the same region as the Bastion resource. 
   <!--(Need to create storage acct for this step?)-->
   :::image type="content" source="../media/6-bastion-add-diagnostic-setting.png" alt-text="Screenshot that shows the  diagnostics settings page filled out.":::
1. Select **Save**.
1. After save is complete, close the page.

## View diagnostic log
<!--Might need to pull this - guessing it might take days to generate-->
1. In the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true), search for or select **Storage accounts**.
1. Select the storage account you associated to the Bastion diagnostic settings. 
1. Select containers.
1. You should see **insights-logs-bastionauditlogs**.
1. Drill through files.
<!--(Give specific scenario to look for.)

When are these files generated?)-->