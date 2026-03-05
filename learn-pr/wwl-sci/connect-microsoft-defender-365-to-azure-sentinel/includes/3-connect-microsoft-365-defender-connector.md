The Microsoft Defender extended detection and response (XDR) connector enables you to stream all Microsoft Defender XDR incidents, alerts, and advanced hunting events into Microsoft Sentinel. The connector keeps incidents synchronized between both portals and enriches them with alerts from Microsoft Defender XDR's component services:

- Microsoft Defender for Endpoint
- Microsoft Defender for Identity
- Microsoft Defender for Office 365
- Microsoft Defender for Cloud Apps
- Microsoft Defender for Cloud

Other services whose alerts are included:

- Microsoft Purview Data Loss Prevention
- Microsoft Entra ID Protection
- Microsoft Purview Insider Risk Management

Connecting the Microsoft Defender XDR connector is a prerequisite for configuring the Unified Security Operations Platform or unified security information and event management (SIEM) and XDR experience in Microsoft Defender XDR.

## Integration methods

There are two methods to integrate Microsoft Defender XDR with Microsoft Sentinel:

**Defender portal integration**: If you onboard Microsoft Sentinel to the Defender portal and are licensed for Defender XDR, Microsoft Sentinel is automatically connected to Defender XDR. The data connector for Defender XDR is automatically set up for you. This provides a unified security operations experience directly in the Microsoft Defender portal.

**Azure portal integration**: If you want to sync Defender XDR data to Microsoft Sentinel in the Azure portal, you must enable the Microsoft Defender XDR connector in Microsoft Sentinel.

## [Defender portal integration](#tab/defender-portal-integration)

If you onboard Microsoft Sentinel to the Defender portal and are licensed for Defender XDR, Microsoft Sentinel is automatically connected to Defender XDR. The data connector for Defender XDR is automatically set up for you, and any data connectors for the alert providers included in the Defender XDR connector are automatically disconnected. This includes:

- Microsoft Defender for Cloud Apps (alerts)
- Microsoft Defender for Endpoint
- Microsoft Defender for Identity
- Microsoft Defender for Office 365
- Microsoft Entra ID Protection

In this integration method, you view Microsoft Sentinel data directly with the rest of your Defender incidents, alerts, vulnerabilities, and other security data in the Microsoft Defender portal. Defender XDR incidents appear in the Microsoft Sentinel incidents queue with the product name Microsoft Defender XDR, and each incident contains a link back to the parallel incident in the Microsoft Defender portal.

Changes made to certain fields or attributes of a Defender XDR incident in either portal are synchronized immediately to the other, with no delay. The following fields are synchronized between the Defender portal and Microsoft Sentinel:

- Title
- Description
- ProductName
- Severity
- Custom tags
- AdditionalData
- Comments (new only)
- LastModifiedBy

## [Azure portal integration](#tab/azure-portal-integration)

If you want to sync Defender XDR data to Microsoft Sentinel in the Azure portal, you must enable the Microsoft Defender XDR connector in Microsoft Sentinel. Follow these steps:

1. Install the Microsoft Defender XDR solution for Microsoft Sentinel from the Content hub.

1. Enable the Microsoft Defender XDR data connector to collect incidents and alerts.

1. From the Microsoft Sentinel left navigation menu, expand **Configuration** and then select **Data connectors**.

1. Select the **Microsoft Defender XDR** connector.

1. Select the **Open connector page** button on the preview pane.

1. Under the *Instructions* tab, review the *Prerequisites* to confirm you have the required permissions and licenses.

1. In the *Configuration* section, select the **Connect incidents & alerts** button.

:::image type="content" source="../media/03-connect-microsoft-defender-xdr-data-connector.png" alt-text="Screen capture of the Defender XDR data connector configuration." lightbox="../media/03-connect-microsoft-defender-xdr-data-connector.png":::

> [!NOTE]
> When you enable alert and incident collection in the Defender XDR data connector, Defender XDR incidents appear in the Microsoft Sentinel incidents queue shortly after they're generated in Defender XDR. Under normal operating conditions, incidents typically appear in the Microsoft Sentinel UI and API within five minutes. Ingestion into the `securityIncident` table might take a few additional minutes.

You can also connect (user and entity behavior analytics) *UEBA entities* and *events* logs from specific products.

1. Select the **Connect entities** and **Connect events** sections.

1. For *events*, mark the checkboxes of the event types you wish to collect, and then select **Apply Changes**.

---

## Important considerations

**Microsoft incident creation rules**: To avoid creating duplicate incidents for the same alerts, the Microsoft incident creation rules setting is turned off for Defender XDR-integrated products when connecting Defender XDR. Microsoft incident creation rules aren't supported in the Defender portal because it has its own incident creation engine. To preserve alert filtering capability, configure alert tuning in the Microsoft Defender portal or use automation rules to suppress or close incidents you don't want.

> [!NOTE]
> If you uncheck the *Turn off all Microsoft incident creation rules for these products. Recommended* checkbox, you may receive duplicate incidents in the incidents queue.
