Azure Sentinel integrates with Microsoft Graph Security API data sources to enable monitoring, alerting, and hunting using your threat intelligence. Use this connector to send threat indicators to Azure Sentinel from your Threat Intelligence Platform (TIP), such as Threat Connect, Palo Alto Networks MindMeld, MISP, or other integrated applications. Threat indicators can include IP addresses, domains, URLs, and file hashes.

### Connect Azure Sentinel to your threat intelligence platform

1. Register an application in Azure Active Directory to get an application ID, application secret, and Azure Active Directory tenant ID. You need these values for when you configure your integrated TIP product or app that uses direct integration with Microsoft Graph Security tiIndicators API.

1. Configure API permissions for the registered application: Add the Microsoft Graph Application permission **ThreatIndicators.ReadWrite.OwnedBy** to your registered application.

1. Ask your Azure Active Directory tenant administrator to grant admin consent to the registered application for your organization. From the Azure portal: **Azure Active Directory > App registrations > <app name> > View API Permissions > Grant admin consent for <tenant name>**.

1. Configure your TIP product or app that uses direct integration with Microsoft Graph Security tiIndicators API to send indicators to Azure Sentinel by specifying the following:

	- The values for the registered application's ID, secret, and tenant ID.

	- For the target product, specify Azure Sentinel.

	- For the action, specify alert.

1. In the Azure portal, navigate to **Azure Sentinel > Data connectors and then select the Threat Intelligence Platforms (Preview)** connector.

1. Select **Open connector page**, and then **Connect**.

1. To view the threat indicators imported into Azure Sentinel, navigate to **Azure Sentinel Logs > SecurityInsights, and then expand ThreatIntelligenceIndicator**.

:::image type="content" source="../media/threat-intelligence-platform-connector.png" alt-text="Threat Intelligence Platform connector page" lightbox="../media/threat-intelligence-platform-connector.png":::
