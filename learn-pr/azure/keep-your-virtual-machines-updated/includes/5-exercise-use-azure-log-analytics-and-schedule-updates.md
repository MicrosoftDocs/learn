Recently, your department moved all of their infrastructure to Azure. There are many virtual machines (VMs) serving up web sites and email functions. You have been tasked to keep these VMs up to date with the latest patches and security releases. You decide to roll out the Update Management solution to all of the VMs in your enterprise. 

In the following exercise you will review the agent connectivity to log analytics and, learn how to schedule update deployments.

## Review Agent Connectivity to Log Analytics

Perform the following steps in the Azure portal to assess if connectivity between the agent and log analytics has taken place.

1. Sign into the [Azure portal](https://portal.azure.com?azure-portal=true).
1. Select **Virtual machines** > **MediaWebServer**.
1. On the VM **Overview** page, make note of the **Public IP Address**.
   :::image type="content" source="../media/5-public-ip-address.png" alt-text="Screenshot that highlights the public IP address that's on the VM's overview page.":::
1. On the **Overview** page, select **Connect** > **Native RDP** > **Select**.
1. Select **Download RDP file**.
1. From the browser, select **Open file** and **Connect**.
1. In **Windows security**, select **More choices** > **Use different account**.
1. In **Enter your credentials**, type the username and password that you specified when you created the virtual machine, and then select **OK**.
1. In the certificate warning dialog, select **Yes**.
1. On the remote machine, go to the Windows icon > **Control Panel**
1. In Control Panel, search for and select **Microsoft Monitoring Agent**.
1. Select the **Azure Log Analytics (OMS)** tab.
1. Observe that the agent displays the following message: **The Microsoft Monitoring Agent has successfully connected to Microsoft Operations Management Suite service.** as shown below.

   :::image type="content" source="../media/5-microsoft-monitoring-agent.png" alt-text="Screenshot that shows the Azure Log Analytics (OMS) tab with the status message." border="false":::

1. Select **OK** to close the **Microsoft Monitoring Agent Properties** window.
1. In the **All Control Panel Items** window, clear your search and select **Administrative Tools**.
1. Open the **Event Viewer**.
1. Expand **Applications and Services Logs**, and open **Operations Manager**.
1. Maximize the **Event Viewer** window.
1. In the **Operations Manager** view, select the **Event ID** column heading to sort the list by Event ID.
1. Observe Event IDs 3000 and 5002. These events indicate that the computer has registered with the Log Analytics workspace and is receiving configuration. Event ID 5002 is shown below.

   :::image type="content" source="../media/5-event-id-5002.png" alt-text="Screenshot that shows the VM has received new configuration from the service." border="false":::

1. Close the Event Viewer and all other windows that were opened.
1. Sign out of the Remote Desktop Connection application.

## Schedule Update Deployments

Here, you'll learn how to schedule updates for the virtual machine.

1. In the Azure portal, go to the VM **MediaWebServer** and select **Guest + host updates** > **Go to Update management**.
1. Select the tab **Schedule update deployment**.
1. Fill out the form using the information from the following table.

   :::image type="content" source="../media/5-configure-recurring-schedule-edited.png" alt-text="Screenshot that shows the New update deployment page and Schedule settings page with the fields filled out as described in the table." border="false":::

   |Field  |Values |
   |---------|---------|
   |Name     | Critical and security updates      |
   |Update classifications   | *Select only* Critical updates *and* Security updates       |
   |Schedule settings     |    *Click to configure*    |
   |Start     |     *Increment the time up one hour*    |
   |Recurrence    |    Recurring   |
   |Recur every   | *Configure update to occur once every week on Sunday*  |

1. Select **OK**.
1. On **New update deployment**, select **Create**.
