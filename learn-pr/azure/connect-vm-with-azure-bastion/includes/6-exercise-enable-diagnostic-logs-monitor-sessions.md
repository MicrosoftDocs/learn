In this unit, you'll see how to monitor current sessions and force a disconnect. 

## Generate session data

Connect to your virtual machine (VM) in two different browser windows to create two Azure Bastion sessions.

1. In the [Azure portal](https://portal.azure.com/), select or search for **Virtual machines**.
1. Select the virtual machine **internalappvm**.
1. Under **Operations**, select **Bastion**.
1. Enter the username **azureuser**.
1. Select **SSH Private Key from local file**. 
1. For **Local file**, select the **internalappvm_key.ppe** file that you downloaded when you created the VM.
1. Select **Connect**.
1. Open another browser window and follow these steps again to create a second VM session.

## Monitor and disconnect a remote session

View the current Azure Bastion sessions and force a disconnect for one of the remote sessions.
 
1. In the [Azure portal](https://portal.azure.com/), search for or select **Bastions**.
1. Select the Azure Bastion host that you created, **internalappvmVNET-bastion**.
1. Select **Sessions**.

   :::image type="content" source="../media/6-bastion-sessions.png" alt-text="Screenshot of the Azure Bastion sessions page with two sessions listed." lightbox="../media/6-bastion-sessions.png":::

1. Review the listed session.
1. Scroll to the far right to see the ellipsis (**...**).

   :::image type="content" source="../media/6-bastion-sessions-ellipsis.png" alt-text="Screenshot of the Azure Bastion sessions page with the ellipsis on the far right for each session." lightbox="../media/6-bastion-sessions-ellipsis.png":::

1. On the first session, select the ellipsis (**...**) > **Delete**.
1. Go to the browser window for your first session. You see that it's disconnected and won't allow you to reconnect.
