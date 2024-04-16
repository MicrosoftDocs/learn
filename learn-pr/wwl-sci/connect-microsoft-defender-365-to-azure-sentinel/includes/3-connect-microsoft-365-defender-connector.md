Microsoft Sentinel's Microsoft Defender XDR connector with incident integration, allows you to stream all Microsoft Defender XDR incidents and alerts into Microsoft Sentinel, and keeps the incidents synchronized between both portals. Microsoft Defender XDR incidents include all their alerts, entities, and other relevant information. They're grouped together, and are enriched by, alerts from Microsoft Defender XDR's component services, Microsoft Defender for Endpoint, Microsoft Defender for Identity, Microsoft Defender for Office 365, and Microsoft Defender for Cloud Apps.

The connector also lets you stream advanced hunting events from all of the above components into Microsoft Sentinel. This allows you to copy those Defender components' advanced hunting queries into Microsoft Sentinel, enrich Sentinel alerts with the Defender components' raw event data to provide more insights, and store the logs with increased retention in Log Analytics.


To deploy the connector, do the following steps:

1. Select **Data connectors** page.

1. Select **Microsoft Defender XDR**.

1. Then select the Open connector page on the preview pane.

1. Mark the checkboxes of the event types you wish to collect.

1. Select **Apply Changes**
