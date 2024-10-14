Microsoft Sentinel is now generally available within the Microsoft unified security operations platform in the Microsoft Defender portal. The following benefits and new or improved capabilities are available in the Defender portal with the integration of Microsoft Sentinel and Defender XDR.

## Microsoft Sentinel integration with Microsoft Defender XDR

Use one of the following methods to integrate Microsoft Sentinel with Microsoft Defender XDR services:

- Ingest Microsoft Defender XDR service data into Microsoft Sentinel and view Microsoft Sentinel data in the Azure portal. Enabled by installing the Defender XDR connector in Microsoft Sentinel.

- Integrate Microsoft Sentinel and Defender XDR into a single, unified security operations platform in the Microsoft Defender portal. In this case, view Microsoft Sentinel data directly in the Microsoft Defender portal with the rest of your Defender incidents, alerts, vulnerabilities, and other security data. Enabled by installing the Defender XDR connector in Microsoft Sentinel and then onboarding Microsoft Sentinel to the unified operations platform in the Defender portal.

Select the appropriate tab to see what the Microsoft Sentinel integration with Defender XDR looks like depending on which integration method you use.

## [Azure portal](#tab/azure-portal)

The following illustration shows how Microsoft's XDR solution seamlessly integrates with Microsoft Sentinel.

:::image type="content" source="../media/sentinel-xdr.png" alt-text="Diagram of the unified security operations platform for Microsoft Sentinel in Azure and in Microsoft Defender XDR." lightbox="../media/sentinel-xdr.png" border="false":::

In this diagram:

- Insights from signals across your entire organization feed into Microsoft Defender XDR and Microsoft Defender for Cloud.
- Microsoft Defender XDR and Microsoft Defender for Cloud send SIEM log data through Microsoft Sentinel connectors.
- SecOps teams can then analyze and respond to threats identified in Microsoft Sentinel and Microsoft Defender XDR.
- Microsoft Sentinel provides support for multicloud environments and integrates with third-party apps and partners.

## [Defender portal](#tab/defender-portal)

The following illustration shows how Microsoft's XDR solution seamlessly integrates with Microsoft Sentinel with the unified security operations platform.

:::image type="content" source="../media/sentinel-unified-siem-xdr.png" alt-text="Diagram of the unified security operations platform for Microsoft Sentinel in Azure and in Microsoft Defender XDR." lightbox="../media/sentinel-unified-siem-xdr.png" border="false":::

In this diagram:

- Insights from signals across your entire organization feed into Microsoft Defender XDR and Microsoft Defender for Cloud.
- Microsoft Sentinel provides support for multicloud environments and integrates with third-party apps and partners.
- Microsoft Sentinel data is ingested together with your organization's data into the Microsoft Defender portal.
- SecOps teams can then analyze and respond to threats identified by Microsoft Sentinel and Microsoft Defender XDR in the Microsoft Defender portal.

## Streamlined Operations

By integrating your security solutions, you can streamline your operations and reduce the complexity of managing and switching between multiple tools. The integration not only saves time but also reduces the risk of errors that can occur when switching between different systems.

## Advanced hunting

Query from a single portal across different data sets to make hunting more efficient and remove the need for context-switching. Use Copilot for Security to help generate your Kusto Query Language (KQL) hunting queries. View and query all data including data from Microsoft security services and Microsoft Sentinel. Use all your existing Microsoft Sentinel workspace content, including queries and functions.

## Attack disruption

Deploy automatic attack disruption for SAP with both the unified security operations platform and the Microsoft Sentinel solution for SAP applications. For example, contain compromised assets by locking suspicious SAP users in a financial process manipulation attack.

## Unified entities

Entity pages for devices, users, IP addresses, and Azure resources in the Defender portal display information from Microsoft Sentinel and Defender data sources. These entity pages give you an expanded context for your investigations of incidents and alerts in the Defender portal.

## Unified incident management

Manage and investigate security incidents in a single location and from a single queue in the Defender portal. Use Copilot for Security to summarize, respond, and report. Incidents include:

- Data from the breadth of sources
- AI analytics tools of security information and event management (SIEM)
- Context and mitigation tools offered by extended detection and response (XDR)
