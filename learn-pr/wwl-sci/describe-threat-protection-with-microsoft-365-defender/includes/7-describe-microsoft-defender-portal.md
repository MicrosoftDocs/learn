
The Microsoft 365 Defender portal combines protection, detection, investigation, and response to devices, identities, endpoints, email & collaboration, and cloud apps, in a central place. The Microsoft 365 Defender portal = is designed to meet the needs of security teams and emphasizes quick access to information, simpler layouts. Through the Microsoft 365 Defender portal you can view the security health of your organization.

:::image type="content" source="../media/m365-portal-inline.png" lightbox="../media/m365-portal-expanded.png" alt-text="A snapshot of the Microsoft 365 Defender portal home page.":::

The Microsoft 365 Defender portal home page shows many of the common cards that security teams need. The composition of cards and data depends on the user role. Because the Microsoft 365 Defender portal uses role-based access control, different roles see cards that are more meaningful to their day-to-day jobs.

The Microsoft 365 Defender portal allows admins to tailor the navigation pane to meet daily operational needs. Admins can customize the navigation pane to show or hide functions and services based on their specific preferences. Customization is specific to the individual admin, so other admins won’t see these changes.

> [!NOTE]
> You must be assigned an appropriate role, such as Global Administrator, Security Administrator, Security Operator, or Security Reader in Microsoft Entra ID to access the Microsoft 365 Defender portal.

The left navigation pane provides security professionals easy access to the suite of Microsoft 365 Defender services, including Defender for Identity, Defender for Collaboration, Defender for Endpoints, and Defender for Cloud Apps, which were described in the previous units.  Listed below we describe a few of the other capabilities accessible from the left navigation bar in the Microsoft 365 Defender portal.

### Incidents and alerts
Microsoft 365 services and apps create alerts when they detect a suspicious or malicious event or activity. Individual alerts provide valuable clues about a completed or ongoing attack. These alerts are automatically aggregated by Microsoft 365 Defender. It's the grouping of these related alerts that form an incident. An incident in Microsoft 365 Defender is a collection of correlated alerts and associated data that make up the story of an attack. Selecting an incident name displays a summary of the incident and provides access to tabs with additional information, including:

- The full story of the attack, including all the alerts, assets, and remediation actions taken.
- All the alerts related to the incident.
- All the assets (devices, users, mailboxes, and apps) that have been identified to be part of or related to the incident.
- All the automated investigations triggered by the alerts in the incident.
- All the supported evidence and response.

### Hunting

You can build custom detection rules and hunt for specific threats in your environment. Hunting uses a query-based threat hunting tool that lets you proactively inspect events in your organization to locate threat indicators and entities. These rules can run automatically to check for, and then respond to, suspected breach activity, misconfigured machines, and other findings.

### Threat Intelligence

Threat Intelligence is the existing node to access

- Threat Analytics - Threat analytics is our in-product threat intelligence solution from expert Microsoft security researchers. It's designed to assist security teams track and respond to emerging threats. The threat analytics dashboard highlights the reports that are most relevant to your organization.
- Intel Profiles - Intel profiles is a new feature that introduces curated content organized by threat actors, their tools and known vulnerabilities
- Intel Explorer - Through Intel Explorer you access the existing Defender Threat Intelligence content described in the previous unit.

:::image type="content" source="../media/threat-analytics-inline.png" lightbox="../media/threat-analytics-expanded.png" alt-text="Screenshot showing the threat analytics page.":::

### Secure Score

Microsoft Secure Score, one of the tools in the Microsoft 365 Defender portal, is a representation of a company's security posture. The higher the score, the better your protection.  From a centralized dashboard in the Microsoft 365 Defender portal, organizations can monitor and work on the security of their Microsoft 365 identities, apps, and devices.

Secure Score provides a breakdown of the score, the improvement actions that can boost the organization's score, and how well the organization's Secure Score compares to other similar organizations.

:::image type="content" source="../media/3-secure-score-overview-3-inline.png" lightbox="../media/3-secure-score-overview-3-expanded.png" alt-text="Screenshot showing the Microsoft Secure Score page.":::

To explore Microsoft Secure Score, select the interactive guide below and follow the prompts on the screen.

[![Interactive guide](../media/5-m365-secure-score-interactive-guide.png)](https://edxinteractivepage.blob.core.windows.net/edxpages/sc-900/LP03M05-Explore-Microsoft-Secure-Score/index.html?azure-portal=true)

##### Differences between secure score in Microsoft 365 Defender and Microsoft Defender for Cloud

There's a secure score for both Microsoft 365 Defender and Microsoft Defender for Cloud, but they're subtly different. Secure score in Microsoft Defender for Cloud is a measure of the security posture of your Azure subscriptions. Secure score in the Microsoft 365 Defender portal is a measure of the security posture of the organization across your apps, devices, and identities.

### Learning hub

The Microsoft 365 Defender portal includes a learning hub that bubbles up official guidance from resources such as the Microsoft security blog, the Microsoft security community on YouTube, and the official documentation on Microsoft Learn.

### Reports

Reports are unified in Microsoft 365 Defender. Admins can start with a general security report, and branch into specific reports about endpoints, email & collaboration. The links here are dynamically generated based upon workload configuration.

### Permissions & roles

Access to Microsoft 365 Defender is configured with Microsoft Entra global roles or by using custom roles.
