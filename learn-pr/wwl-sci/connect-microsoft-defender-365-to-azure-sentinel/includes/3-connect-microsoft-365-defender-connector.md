The Microsoft Defender extended detection and response (XDR) connector, with incident integration, allows you to stream all Microsoft Defender XDR incidents and alerts into Microsoft Sentinel. The connector keeps the incidents synchronized between both portals. Microsoft Defender XDR incidents include all their alerts, entities, and other relevant information. They're grouped together, and are enriched by, alerts from Microsoft Defender XDR's component services, Microsoft Defender for Endpoint, Microsoft Defender for Identity, Microsoft Defender for Office 365, and Microsoft Defender for Cloud Apps. Connecting the Microsoft Defender XDR connector is a prerequisite for configuring the *Unified Security Operations Platform* or unified security information and event management (SIEM) and XDR experience in Microsoft Defender XDR.

The connector also lets you stream advanced hunting events from all of the above components into Microsoft Sentinel. This allows you to copy those Defender components' advanced hunting queries into Microsoft Sentinel, enrich Sentinel alerts with the Defender components' raw event data to provide more insights, and store the logs with increased retention in Log Analytics.

To deploy the connector, do the following steps:

1. From the Microsoft Sentinel left navigation menu, expand **Configuration** and then select **Data connectors**.

1. Select the **Microsoft Defender XDR** connector.

1. Select the **Open connector page** button on the preview pane.

1. Under the *Instructions* tab, review the *Prerequisites* to confirm you have the required permissions and licenses.

1. Next, in the *Configuration* section, select the **Connect incidents & alerts** button.

:::image type="content" source="../media/03-connect-microsoft-defender-xdr-data-connector.png" alt-text="Screen capture of the Defender XDR data connector configuration." lightbox="../media/03-connect-microsoft-defender-xdr-data-connector.png":::

> [!NOTE]
> If you uncheck the *Turn off all Microsoft incident creation rules for these products. Recommended* checkbox, you may may recieve duplications in the incidents queue.

You can also connect (user and entity behavior analytics) *UEBA entities* and *events* logs from specific products.

1. Select the **Connect entities** and **Connect events** sections.

1. For *events*, mark the checkboxes of the event types you wish to collect, and then select **Apply Changes**.
