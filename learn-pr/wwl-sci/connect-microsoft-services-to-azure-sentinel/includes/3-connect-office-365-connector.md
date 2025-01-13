The Microsoft Defender XDR connector provides insight into the suite of Microsoft Defender products including Microsoft Defender for Office 365. You'll collect data on ongoing user activities such as file downloads, access requests sent, changes to group events, set-mailbox, and details of the user who performed the actions.​

## Install the solution

Start by installing the Microsoft Defender XDR solution that contains the data connector. 

1. For Microsoft Sentinel in the Azure portal, under **Content management**, select **Content hub**. <br>For Microsoft Sentinel in the Defender portal, select **Microsoft Sentinel** > **Content management** > **Content hub**.
1. Search for and select **Microsoft Defender XDR**.
1. On the right-hand side pane, select **Install**.
 
## Configure the data connector

After the solution is installed, connect the data connector.

1. In the Microsoft Sentinel left navigation menu expand **Configuration**,  and select **Data connectors**.

1. Select **Microsoft Defender XDR**.

1. Then select the **Open connector page** on the preview pane.

1. Review the *Description* and *Data types* tabs to understand the data that is ingested.

1. In the **Instructions** tab, verify that you meet the *Prerequisites*.

1. In the **Instructions** tab, under the section labeled **Configuration**, select the **Connect incidents and alerts** button.

1. Wait until validation is complete and the button changes to **Disconnect**.

:::image type="content" source="../media/defender-xdr.png" alt-text="Screen shot of the Microsoft Defender XDR Connector page." lightbox="../media/defender-xdr.png":::

