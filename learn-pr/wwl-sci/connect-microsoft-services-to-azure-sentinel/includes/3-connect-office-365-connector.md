The Microsoft 365 connector provides insight into ongoing user activities. You'll collect data like file downloads, access requests sent, changes to group events, set-mailbox, and details of the user who performed the actions.​

## Install the solution

Start by installing the Microsoft 365 solution that contains the data connector. 

1. For Microsoft Sentinel in the Azure portal, under **Content management**, select **Content hub**. <br>For Microsoft Sentinel in the Defender portal, select **Microsoft Sentinel** > **Content management** > **Content hub**.
1. Search for and select **Microsoft 365**.
1. On the right-hand side pane, select **Install**.
 
## Configure the data connector

After the solution is installed, connect the data connector.

1. In the Microsoft Sentinel left navigation menu expand **Configuration**,  and select **Data connectors**.

1. Select **Microsoft 365**.

1. Then select the **Open connector page** on the preview pane.

1. Review the *Description* and *Data types* tabs to understand the data that is ingested.

1. In the **Instructions** tab, verify that you meet the *Prerequisites*.

1. In the **Instructions** tab, under the section labeled **Configuration**, select the record types to collect and **Apply Changes**.

1. Wait until validation is complete and the button changes to **Disconnect**.

:::image type="content" source="../media/microsoft-365.png" alt-text="Screen shot of the Microsoft Defender XDR Connector page." lightbox="../media/microsoft-365.png":::

