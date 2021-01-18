Effective management of an organization’s network security perimeter requires the right combination of tools and systems. Microsoft Azure Sentinel is a scalable, cloud-native SIEM/SOAR solution that delivers intelligent security analytics and threat intelligence across the enterprise, providing a single solution for alert detection, threat visibility, proactive hunting, and threat response.

:::image type="content" source="../media/3-four-aspects-azure-sentinel.png" alt-text="Diagram showing the four aspects of Azure Sentinel: collect, detect, investigate, and respond.":::

This diagram shows the end-to-end functionality of Azure Sentinel.

- **Collect** data at cloud scale—across all users, devices, applications, and infrastructure, both on-premises and in multiple clouds.
- **Detect** previously uncovered threats and minimize false positives using analytics and unparalleled threat intelligence.
- **Investigate** threats with AI and hunt suspicious activities at scale, tapping into decades of cybersecurity work at Microsoft.
- **Respond** to incidents rapidly with built-in orchestration and automation of common security tasks.

Azure Sentinel helps enable end-to-end security operations. It starts with log ingestion and continues through to automated response to security alerts.

### Connect Sentinel to your data

Azure Sentinel comes with a number of connectors for Microsoft solutions, available out of the box and providing real-time integration, including Microsoft 365 Defender (formerly Microsoft Threat Protection) solutions, and Microsoft 365 sources, including Office 365, Azure AD, Microsoft Defender for Identity (formerly Azure ATP), and Microsoft Cloud App Security, and more.

The first thing to do is to have your data ingested into Azure Sentinel. Data connectors enable you to do just that. There are data connectors that cover all scenarios and sources, including but not limited to:

- syslog
- Windows Event Logs
- Common Event Format (CEF)
- Trusted Automated eXchange of Indicator Information (TAXII) (for threat intelligence)
- Azure
- AWS services

### Workbooks

After you connected your data sources to Azure Sentinel, you can monitor the data using the Azure Sentinel integration with Azure Monitor Workbooks, which provide a canvas for data analysis and the creating of rich visual reports within the Azure portal. Through this integration, Azure Sentinel allows you to create custom workbooks across your data, and also comes with built-in workbook templates to allow you to quickly gain insights across your data as soon as you connect a data source.

### Analytics

This is where the power of Sentinel comes into play. Using the built-in analytics alerts within the Sentinel workspace, you’ll get notified when anything suspicious occurs. There are various types of alerts, some of which you can edit to your own needs. Other alerts are built on machine-learning models that are proprietary to Microsoft.

### Managing incidents in Sentinel

An incident is created when an alert that you've enabled is triggered. You can do standard incident management tasks like changing status or assigning incidents to individuals for investigation in Azure Sentinel. Azure Sentinel also has investigation functionality, so you can visually investigate incidents by mapping entities across log data along a timeline.

### Security automation and orchestration

With Azure Sentinel, you can automate some of your security operations and make your security operations center (SOC) more productive. Azure Sentinel integrates with Azure Logic Apps, enabling you to create automated workflows, or playbooks, in response to events. This functionality could be used for incident management, enrichment, investigation, or remediation.

### Playbooks

A security playbook is a collection of procedures that can help automate and orchestrate your response, and can be run manually or set to run automatically when specific alerts are triggered. Security playbooks in Azure Sentinel are based on Azure Logic Apps, which means that you get all the power, customizability, and built-in templates of Logic Apps. Each playbook is created for the specific subscription you choose.

### Investigation

Currently in preview, Azure Sentinel deep investigation tools help you to understand the scope and find the root cause, of a potential security threat. You can choose an entity on the interactive graph to ask interesting questions for a specific entity, and drill down into that entity and its connections to get to the root cause of the threat.

### Hunting

Use Azure Sentinel's powerful hunting search-and-query tools, based on the MITRE framework, which enable you to proactively hunt for security threats across your organization’s data sources, before an alert is triggered. After you discover which hunting query provides high-value insights into possible attacks, you can also create custom detection rules based on your query, and surface those insights as alerts to your security incident responders. While hunting, you can create bookmarks for interesting events, enabling you to return to them later, share them with others, and group them with other correlating events to create a compelling incident for investigation.

### Integrated threat protection

Threat protection is a continuously evolving battle front, with cybercriminals looking for any vulnerability they can exploit to either steal, damage, or extort company data, assets, and resources. Microsoft provides a suite of tools, which provide extended detection and response (XDR) through Microsoft 365 Defender and Azure Defender.

:::image type="content" source="../media/3-defender-azure-defender.png" alt-text="Diagram showing Microsoft 365 Defender and Azure Defender.":::

Both tools seamlessly integrate with Azure Sentinel to provide a complete and thorough threat protection capability for your organization.

:::image type="content" source="../media/3-elements-threat-protection.png" alt-text="Diagram showing the three elements that make up the complete threat protection: Microsoft 365 and Azure Defender, and Azure Sentinel.":::

### Azure Sentinel video presentation

In this nine-minute video, you’ll explore many of the key features available in Azure Sentinel, including incidents, workbooks, hunting, notebooks, analytics, and playbooks.

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RE4LHLR]
