Gain insights into Microsoft Entra ID by connecting Audit and Sign in logs to Microsoft Sentinel to gather insights around Microsoft Entra scenarios. You can learn about app usage, conditional access policies, and legacy auth relate details using our Sign-in logs. You can get information on your Self-Service Password Reset (SSPR) usage, Microsoft Entra Management activities like user, group, role, and app management in the Audit logs table.

## Install the solution

Start by installing the solution that contains the data connector. 

1. For Microsoft Sentinel in the Azure portal, under **Content management**, select **Content hub**. <br>For Microsoft Sentinel in the Defender portal, select **Microsoft Sentinel** > **Content management** > **Content hub**.
1. Search for and select **Microsoft Entra ID**.
1. On the right-hand side pane, select **Install**.
 
## Configure the data connector

After the solution is installed, connect the data connector.

1. In the Microsoft Sentinel left navigation menu expand **Configuration**,  and select **Data connectors**.

1. Select **Microsoft Entra ID**.

1. Then select the **Open connector** page on the preview pane.

1. Mark the checkboxes next to the logs you want to stream into Microsoft Sentinel, and select **Connect**.

:::image type="content" source="../media/azure-active-directory.png" alt-text="Screen shot of the Microsoft Entra connector page.":::
