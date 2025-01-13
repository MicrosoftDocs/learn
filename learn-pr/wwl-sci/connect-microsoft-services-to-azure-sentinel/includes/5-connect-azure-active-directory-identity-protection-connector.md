Microsoft Entra ID Protection provides a consolidated view of at-risk users, risk events, and vulnerabilities, with the ability to remediate risk immediately and set policies to autoremediate future events.

## Install the solution

Start by installing the solution that contains the data connector. 

1. For Microsoft Sentinel in the Azure portal, under **Content management**, select **Content hub**. <br>For Microsoft Sentinel in the Defender portal, select **Microsoft Sentinel** > **Content management** > **Content hub**.
1. Search for and select **Microsoft Entra ID Protection**.
1. On the right-hand side pane, select **Install**.
 
## Configure the data connector

After the solution is installed, connect the data connector.

1. In the Microsoft Sentinel left navigation menu expand **Configuration**,  and select **Data connectors**.

1. Select **Microsoft Entra ID Protection**.

1. Then select the **Open connector** page on the preview pane.

1. Select **Connect** to start streaming the Microsoft Entra ID Protection alerts.

1. Select whether alerts from Microsoft Entra ID Protection automatically generate incidents by selecting **Enable**.

:::image type="content" source="../media/azure-active-directory-protocol.png" alt-text="Screen shot of the Microsoft Entra ID Protection connector page.":::

If you enable creating incidents, the default analytics rule "Create incidents based on Microsoft Entra ID Protection alerts" is enabled with default values. You can edit this analytical rule on the Analytics page.
