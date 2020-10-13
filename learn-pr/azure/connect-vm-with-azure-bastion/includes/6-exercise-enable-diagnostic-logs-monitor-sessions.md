   Enable diagnostics: https://docs.microsoft.com/azure/bastion/diagnostic-logs

## Enable diagnostics for Bastion

1. In the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true), search for or select **Bastions**.
1. Select the bastion resource **internalappvmVNET-bastion**.
1. Under **Monitoring**, select **Diagnostics settings**.
1. Select **Add diagnostic setting**.
   :::image type="content" source="../media/6-bastion-diagnostics-settings.png" alt-text="Screenshot that shows the Add diagnostic settings link within the Diagnostics Setting page.":::
1. For **Diagnostic setting name**, enter **bastion-diagnostic**. 
1. Under **log**, select **BastionAuditLogs**.
1. Under **Destination details**, select **Send to Log Analytics** and **Archive to storage account**. 
1. The location, subscription, and a storage account are autopopulated. Make sure the storage account is in the same region as the Bastion resource. (Need to create storage acct for this step?)
   :::image type="content" source="../media/6-bastion-add-diagnostic-setting.png" alt-text="Screenshot that shows the  diagnostics settings page filled out.":::
1. Select **Save**.
1. After save is complete, close the page.

## Generate data

   1. Sign in via Bastion to get something generated? Leave connection open?

## View diagnostic log

1. In the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true), search for or select **Storage accounts**.
1. Select the storage account you associated to the Bastion diagnostic settings. 
1. Select containers.
1. You should see **insights-logs-bastionauditlogs**.
1. Drill through files.
1. (Give specific scenario to look for.)

When are these files generated?)

## Monitor remote sessions

Monitor sessions: https://docs.microsoft.com/azure/bastion/session-monitoring

1. In the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true), search for or select **Bastions**.
1. Select **Sessions**.
1. Force disconnect session?
