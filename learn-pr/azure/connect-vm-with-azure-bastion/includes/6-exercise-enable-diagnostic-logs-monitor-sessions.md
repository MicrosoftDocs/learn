In this unit, you'll learn how to enable diagnostics for Bastion and view detailed session data like source IP addresses. You'll also learn how to monitor current sessions and force a disconnect. 

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

## Generate session data

Connect to your VM in two different browser windows to create two bastion sessions.

1. In the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true), select or search for **Virtual machines**.
1. Select virtual machine **internalappvm**.
1. Select **Connect** > **Bastion** > **Use Bastion**.
1. Enter the username **azureuser**.
1. Select **SSH Private Key**.
   <!--update to use file-->
1. Expand the **Advanced** section.
1. Enter the **SSH Passphrase** you used when you created the SSH key.
1. Select **Connect**.
1. Open another browser window and follow these steps again to create a second VM session.

## Monitor and disconnect a remote session

View the current bastion sessions and force a disconnect for one of the remote sessions.
 
1. In the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true), search for or select **Bastions**.
1. Select the bastion host you created **internalappvmVNET-bastion**.
1. Select **Sessions**.
1. Review the session listed.
1. Scroll to the far right to see the ellipses "**...**".
1. On the first session, select the ellipses "**...**" > **Delete**.
1. Go to the browser window for your first session. You see that it's disconnected and won't allow you to reconnect.

## View diagnostic log
<!--Might need to pull this - guessing it might take days to generate-->
1. In the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true), search for or select **Storage accounts**.
1. Select the storage account you associated to the Bastion diagnostic settings. 
1. Select containers.
1. You should see **insights-logs-bastionauditlogs**.
1. Drill through files.
<!--(Give specific scenario to look for.)

When are these files generated?)-->