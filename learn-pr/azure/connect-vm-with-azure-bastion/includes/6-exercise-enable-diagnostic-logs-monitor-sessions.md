In this unit, you'll learn how to monitor current sessions and force a disconnect. 

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
