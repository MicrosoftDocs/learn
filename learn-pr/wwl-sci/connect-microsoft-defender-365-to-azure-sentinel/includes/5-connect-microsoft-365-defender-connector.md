The Microsoft 365 Defender connector lets you stream advanced hunting logs - a type of raw event data - from Microsoft 365 Defender into Azure Sentinel.

With the integration of Microsoft Defender for Endpoint into the Microsoft 365 Defender security umbrella, you can collect your Microsoft Defender for Endpoint advanced hunting events using the Microsoft 365 Defender connector and stream them straight into new purpose-built tables in your Azure Sentinel workspace. These tables are built on the same schema that is used in the Microsoft 365 Defender portal, giving you complete access to the full set of advanced hunting logs and allowing you to do the following:

- Easily copy your existing Microsoft Defender ATP advanced hunting queries into Azure Sentinel.

- Use the raw event logs to provide more insights for your alerts, hunting, and investigation, and correlate events with data from other data sources in Azure Sentinel.

- Store the logs with increased retention, beyond Microsoft Defender for Endpoint or Microsoft 365 Defender’s default retention of 30 days. You can do so by configuring the retention of your workspace or by configuring per-table retention in Log Analytics.

:::image type="content" source="../media/microsoft-365-defender.png" alt-text="Microsoft 365 Defender connector page." lightbox="../media/microsoft-365-defender.png":::

To deploy the connector, do the following steps:

1. Select **Data connectors** page.

1. Select Microsoft Defender for Endpoint (may still be called Microsoft Defender Advanced Threat Protection).

1. Then select the Open connector page on the preview pane.

1. Mark the checkboxes of the event types you wish to collect.

1. Select **Apply Changes**

The Microsoft Defender for Endpoint collection options are as follows:

| **Events type**| **Table name**|
| :--- | :--- |
| Machine information (including OS information)| DeviceInfo|
| Network properties of machines| DeviceNetworkInfo|
| Process creation and related events| DeviceProcessEvents|
| Network connection and related events| DeviceNetworkEvents|
| File creation, modification, and other file system events| DeviceFileEvents|
| Creation and modification of registry entries| DeviceRegistryEvents|
| Sign-ins and other authentication events| DeviceLogonEvents|
| DLL loading events| DeviceImageLoadEvents|
| More events types| DeviceEvents|

