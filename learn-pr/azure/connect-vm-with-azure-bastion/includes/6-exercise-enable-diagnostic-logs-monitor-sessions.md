   Enable diagnostics: https://docs.microsoft.com/azure/bastion/diagnostic-logs

## Enable diagnostics for Bastion

1. In the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true), go to **Virtual machines**.
1. Search for or select **Bastions**.
1. Select the bastion resource (what's the default name that'll create it as)?
1. Under **Monitoring**, select **Diagnostics settings**.
1. Select **Add diagnostic setting**.
   :::image type="content" source="../media/6-bastion-diagnostics-settings.png" alt-text="Screenshot that shows the Add diagnostic settings link within the Diagnostics Setting page.":::
1. For **Diagnostic setting name**, enter **bastionconnection-diagnostic-setting**. 
1. Under **log**, select **BastionAuditLogs**.
1. Under **Destination details**, select **Send to Log Analytics** and **Archive to storage account**. The location, subscription, and a storage account is auto-populated.
1. Select **Save**.
1. After save is complete, close the page.

## View log


   1. Sign in via Bastion to get something generated? Leave connection open?
   1. View diagnostic log.
   
## Monitor remote sessions


   Monitor sessions: https://docs.microsoft.com/azure/bastion/session-monitoring
   1. View sessions.
   1. Sign in via Bastion and leave connection open?
   1. Force disconnect session?