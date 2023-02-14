
Microsoft 365 Defender natively coordinates detection, prevention, investigation, and response across endpoints, identities, email, and applications to provide integrated protection against sophisticated attacks. The Microsoft 365 Defender portal brings this functionality together into a central place that is designed to meet the needs of security teams and emphasizes quick access to information, simpler layouts. Through the Microsoft 365 Defender portal you can view the security health of your organization.

The Microsoft 365 Defender portal home page shows many of the common cards that security teams need. The composition of cards and data depends on the user role. Because the Microsoft 365 Defender portal uses role-based access control, different roles will see cards that are more meaningful to their day-to-day jobs. 

The cards fall into these categories:

- Identities- Monitor the identities in your organization and keep track of suspicious or risky behaviors.
- Data - Help track user activity that could lead to unauthorized data disclosure.
- Devices - Get up-to-date information on alerts, breach activity, and other threats on your devices.
- Apps - Gain insight into how cloud apps are being used in your organization. 

:::image type="content" source="../media/2-defender-portal-inline.png" lightbox="../media/2-defender-portal-expanded.png" alt-text="Screenshot showing the Microsoft 365 Defender portal landing page.":::

The Microsoft 365 Defender portal allows admins to tailor the navigation pane to meet daily operational needs. Admins can customize the navigation pane to show or hide functions and services based on their specific preferences. Customization is specific to the individual admin, so other admins won’t see these changes.

> [!NOTE]
> You must be assigned an appropriate role, such as Global Administrator, Security Administrator, Security Operator, or Security Reader in Azure Active Directory to access the Microsoft 365 Defender portal.

The left navigation pane provides security professionals easy access to the email and collaboration capabilities of Microsoft Defender for Office 365 and the capabilities for Microsoft Defender for Endpoint which were described in the previous units.  Listed below we describe a few of the other capabilities accessible from the left navigation bar in the Microsoft 365 Defender portal.

### Incidents and alerts
Microsoft 365 services and apps create alerts when they detect a suspicious or malicious event or activity. Individual alerts provide valuable clues about a completed or ongoing attack. These alerts are automatically aggregated by Microsoft 365 Defender. It's the grouping of these related alerts that form an incident. The incident provides a comprehensive view and context of an attack.

The incidents queue is a central location lists each incident by severity.  Selecting an incident name displays a summary of the incident and provides access to tabs with additional information, including:

- All the alerts related to the incident.
- All the users that have been identified to be part of or related to the incident.
- All the mailboxes that have been identified to be part of or related to the incident.
- All the automated investigations triggered by the alerts in the incident.
- All the supported evidence and response.

:::image type="content" source="../media/incidents-expanded.png" alt-text="Screenshot of the summary page for an incident in the Microsoft 365 Defender portal.":::

#### Hunting

Advanced hunting is a query-based threat-hunting tool that lets security professionals explore up to 30 days of raw data.  Advanced hunting queries enable security professionals to proactively search for threats, malware, and malicious activity across your endpoints, Office 365 mailboxes, and more. Threat-hunting queries can be used to build custom detection rules. These rules run automatically to check for and then respond to suspected breach activity, misconfigured machines, and other findings.

### Threat analytics

Threat analytics is our in-product threat intelligence solution from expert Microsoft security researchers. It's designed to assist security teams track and respond to emerging threats. The threat analytics dashboard highlights the reports that are most relevant to your organization. It includes the latest threats, high impact threats (threats with the most active alerts affecting your organization), and high exposure threats.

Selecting a specific threat from the dashboard provides a threat analytics report that provides more detailed information that includes detailed analyst report, impacted assets, mitigations, and much more.

:::image type="content" source="../media/threat-analytics-inline.png" lightbox="../media/threat-analytics-expanded.png" alt-text="Screenshot showing the threat analytics page.":::

### Secure Score

Microsoft Secure Score, one of the tools in the Microsoft 365 Defender portal, is a representation of a company's security posture. The higher the score, the better your protection.  From a centralized dashboard in the Microsoft 365 Defender portal, organizations can monitor and work on the security of their Microsoft 365 identities, apps, and devices.

Secure Score helps organizations:

- Report on the current state of their security posture.
- Improve their security posture by providing discoverability, visibility, guidance, and control.
- Compare benchmarks and establish key performance indicators (KPIs).

Currently Microsoft Secure Score supports recommendations for Microsoft 365 (including Exchange Online), Azure Active Directory, Microsoft Defender for Endpoint, Microsoft Defender for Identity, Microsoft Defender Cloud Apps, and Microsoft Teams. New recommendations are being added to Secure Score all the time.

The image below shows an organization's Secure Score, a breakdown of the score by points, and the improvement actions that can boost the organization's score. Finally, it provides an indication of how well the organization's Secure Score compares to other similar organizations.

:::image type="content" source="../media/3-secure-score-overview-3-inline.png" lightbox="../media/3-secure-score-overview-3-expanded.png" alt-text="Screenshot showing the Microsoft Secure Score page.":::

To explore Microsoft Secure Score, select the interactive guide below and follow the prompts on the screen.

[![Interactive guide](../media/5-m365-secure-score-interactive-guide.png)](https://edxinteractivepage.blob.core.windows.net/edxpages/sc-900/LP03M05-Explore-Microsoft-Secure-Score/index.html?azure-portal=true)

##### Differences between secure score in Microsoft 365 Defender and Microsoft Defender for Cloud

There's a secure score for both Microsoft 365 Defender and Microsoft Defender for Cloud, but they're subtly different. Secure score in Microsoft Defender for Cloud is a measure of the security posture of your Azure subscriptions. Secure score in the Microsoft 365 Defender portal is a measure of the security posture of the organization across your apps, devices, and identities.

### Learning hub

The Microsoft 365 Defender portal includes a learning hub that bubbles up official guidance from resources such as the Microsoft security blog, the Microsoft security community on YouTube, and the official documentation on Microsoft Learn.

:::image type="content" source="../media/learning-hub-inline.png" lightbox="../media/learning-hub-expanded.png" alt-text="Screenshot showing the learning hub page.":::

### Reports

Reports are unified in Microsoft 365 Defender. Admins can start with a general security report, and branch into specific reports about endpoints, email & collaboration. The links here are dynamically generated based upon workload configuration.

:::image type="content" source="../media/4-reports-page-2-inline.png" lightbox="../media/4-reports-page-2-expanded.png" alt-text="Screenshot showing the Microsoft 365 reports page that lists the different reports available.":::

### Permissions & roles

Access to Microsoft 365 Defender is configured with Azure Active Directory global roles or by using custom roles.
