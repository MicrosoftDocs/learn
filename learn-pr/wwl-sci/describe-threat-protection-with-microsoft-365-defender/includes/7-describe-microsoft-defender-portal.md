
A unified security operations platform is a fully integrated toolset for security teams to prevent, detect, investigate, and respond to threats across their entire environment. For Microsoft, this means delivering the best of SIEM, XDR, posture management, and threat intelligence with advanced generative AI as a single platform.

Through the Microsoft Defender portal, Microsoft delivers on the promise of a unified security operations platform so you can view the security health of your organization. The Microsoft Defender portal combines protection, detection, investigation, and response to threats across your entire organization and all its components, in a central place.

To access the portal, you must be assigned an appropriate role such as Global Reader or Administrator, Security Reader or Administrator, or Security Operator in Microsoft Entra ID to access the Microsoft Defender portal.  

The Defender portal emphasizes quick access to information, simpler layouts, and bringing related information together for easier use.

:::image type="content" source="../media/defender-xdr-portal-home.png" lightbox="../media/defender-xdr-portal-home.png" alt-text="A screenshot of the Microsoft Defender portal home page.":::

The Microsoft Defender portal home page shows many of the common cards that security teams need. The composition of cards and data depends on the user role. Because the Microsoft Defender portal uses role-based access control, different roles see cards that are more meaningful to their day-to-day jobs.

The Microsoft Defender portal allows you to tailor the navigation pane to meet daily operational needs. You can customize the navigation pane to show or hide functions and services based on their specific preferences. Customization is specific to you, so other admins won’t see these changes.

The left navigation pane provides easy access to the suite of Microsoft Defender XDR services. You also get access to Microsoft Sentinel and many other capabilities  The sections that follow provide a brief description of the capabilities accessible from the left navigation bar in the Microsoft Defender portal.

### Exposure management

Microsoft Security Exposure Management is a security solution that provides a unified view of security posture across company assets and workloads. Security Exposure Management enriches asset information with security context that helps you to proactively manage attack surfaces, protect critical assets, and explore and mitigate exposure risk.

With Security Exposure Management you can discover and monitor assets, get rich security insights, investigate specific risk areas with security initiatives, and track metrics across the organization to improve security posture.

For more information, see to the unit "Describe Microsoft Security Exposure Management."

# [Exposure management](#tab/exposure-management)
:::image type="content" source="../media/exposure-management-menu.png" lightbox="../media/exposure-management-menu.png" alt-text="A screenshot of the Microsoft Defender portal left navigation pane, showing Exposure management.":::

# [Overview](#tab/overview)
:::image type="content" source="../media/exposure-management-attack-surface-dashboard.png" lightbox="../media/exposure-management-attack-surface-dashboard.png" alt-text="A screenshot of the Exposure Management overview in the Microsoft Defender portal.":::

# [Attack surface](#tab/attack-surface)
:::image type="content" source="../media/exposure-management-attack-path-with-map.png" lightbox="../media/exposure-management-attack-path-with-map.png" alt-text="A screenshot of an attack path under Exposure Management.":::

# [Insights](#tab/insights)
:::image type="content" source="../media/exposure-management-initiatives.png" lightbox="../media/exposure-management-initiatives.png" alt-text="A screenshot of the initiatives page in Exposure Management.":::

# [Secure score](#tab/secure-score)
:::image type="content" source="../media/exposure-management-secure-score-v2.png" lightbox="../media/exposure-management-secure-score-v2.png" alt-text="A screenshot of the secure score page in Exposure Management.":::

# [Data connectors](#tab/data-connectors)
:::image type="content" source="../media/data-connectors.png" lightbox="../media/data-connectors.png" alt-text="A screenshot of the data-connectors page in Exposure Management.":::

---

### Investigation & response

The investigation and response tab includes access to incidents and alerts, hunting, actions & submissions, and a partner catalog.

:::image type="content" source="../media/investigation-response-v2.png" alt-text="A screenshot of the Microsoft Defender portal showing the selections available for investigation and response. They're incidents and alerts, hunting, actions and submissions, and partner catalog.":::

#### Incidents and alerts

An incident in the Microsoft Defender portal is a collection of related alerts, assets, investigations, and evidence to give you a comprehensive look into the entire breadth of an attack. It serves as a case file that your SOC can use to investigate that attack and manage, implement, and document the response to it. Because the Microsoft Defender portal is built upon a unified security operations platform, you get a view of all incidents including incidents generated from the suite of Microsoft Defender XDR solutions, Microsoft Sentinel, and other solutions.

Within an incident, you analyze the alerts that affect your network, understand what they mean, and collate the evidence so that you can devise an effective remediation plan. The information provided for an incident includes:

- The full story of the attack, including all the alerts, assets, and remediation actions taken.
- All the alerts related to the incident.
- All the assets (devices, users, mailboxes, and apps) that have been identified to be part of or related to the incident.
- All the automated investigations triggered by the alerts in the incident.
- All the supported evidence and response.

If your organization is onboarded to Microsoft Security Copilot you can also view an incident summary, guided responses, and more.

# [Incidents](#tab/incidents)
:::image type="content" source="../media/incidents.png" lightbox="../media/incidents.png" alt-text="A screenshot of the Microsoft Defender portal incidents page.":::

# [Incident details page](#tab/incident-details)
:::image type="content" source="../media/incident-details.png" lightbox="../media/incident-details.png" alt-text="A screenshot of the incident details page for a selected incident in the Microsoft Defender portal.":::

---

#### Hunting

Advanced hunting is a query-based threat hunting tool that lets you explore up to 30 days of raw data, from Microsoft Defender XDR and Microsoft Sentinel. You can proactively inspect events in your network to locate threat indicators and entities, through hunting queries. Hunting queries can be created via the query editor, if you're familiar with Kusto Query Language (KQL), using a query builder, or through Security Copilot. For users onboarded to Microsoft Security Copilot, you can make a request or ask a question in natural language and Security Copilot generates a KQL query that corresponds to the request.

You can use the same threat hunting queries to build custom detection rules. These rules run automatically to check for and then respond to suspected breach activity, misconfigured machines, and other findings.

:::image type="content" source="../media/hunting.png" lightbox="../media/hunting.png" alt-text="A screenshot of the advanced hunting page in the Microsoft Defender portal.":::

#### Actions and submissions

The unified Action center brings together remediation actions across Microsoft Defender for Endpoint and Microsoft Defender for Office 365. It lists pending and completed remediation actions for your devices, email & collaboration content, and identities in one location.

In Microsoft 365 organizations with Exchange Online mailboxes, admins can use the Submissions page in the Microsoft Defender portal to submit messages, URLs, and attachments to Microsoft for analysis.

#### Partner catalog

The partner catalog lists supported technology partners and professional services that can help your organization enhance the detection, investigation, and threat intelligence capabilities of the platform.

### Threat intelligence

From the Threat Intelligence tab, users access Microsoft Defender Threat Intelligence. For more information, see the unit "Describe Microsoft Defender Threat Intelligence."

### Assets

The Assets tab allows you to view and manage your organization's inventory of protected and discovered assets (devices and identities).

The Device inventory shows a list of the devices in your network where alerts were generated. By default, the queue displays devices seen in the last 30 days. At a glance, you see information such as domain, risk level, OS platform, and other details for easy identification of devices most at risk.

The identity inventory provides a comprehensive view of all corporate identities, both cloud and on-premises.

# [Devices](#tab/devices)
:::image type="content" source="../media/assets-devices.png" lightbox="../media/assets-devices.png" alt-text="A screenshot of the device inventory page in the Microsoft Defender portal.":::

# [Identities](#tab/identities)
:::image type="content" source="../media/assets-identities.png" lightbox="../media/assets-identities.png" alt-text="A screenshot of the identities inventory page in the Microsoft Defender portal.":::

---

### Microsoft Sentinel

Some Microsoft Sentinel capabilities, like the unified incident queue, are accessed through the incidents and alerts page of the Defender portal, along with incidents from other Microsoft Defender services. Many other Microsoft Sentinel capabilities are available in the Microsoft Sentinel section of the Defender portal.

For more information, see the module "Describe the capabilities in Microsoft Sentinel," whose link is included in the summary and resources unit.

:::image type="content" source="../media/sentinel-node.png" lightbox="../media/sentinel-node.png" alt-text="A screenshot of the Microsoft Sentinel node on the navigation panel of the Microsoft Defender portal.":::

### Identities

The Identities node on the left navigation panel of the Microsoft Defender portal maps to functionality associated with Microsoft Defender for Identity. For more information, see the unit "Describe Microsoft Defender for Identity."

:::image type="content" source="../media/identities-node.png" lightbox="../media/identities-node.png" alt-text="A screenshot of the identities node on the left navigation panel of the Microsoft Defender portal.":::

### Endpoints

The Endpoints node on the left navigation panel of the Microsoft Defender portal maps to functionality associated with Microsoft Defender for Endpoints. For more information, see to the unit "Describe Microsoft Defender for Endpoints."

:::image type="content" source="../media/endpoints-node.png" lightbox="../media/endpoints-node.png" alt-text="A screenshot of the endpoints node on the left navigation panel of the Microsoft Defender portal.":::

### Email and collaboration

The email and collaboration node on the left navigational panel is where you find Microsoft Defender for Office 365 functionality that allows you to track and investigate threats to your users' email, track campaigns, and more. For more information, see the unit "Describe Microsoft Defender for Office 365."

:::image type="content" source="../media/email-collaboration.png" lightbox="../media/email-collaboration.png" alt-text="A screenshot of the email and collaboration node on the navigation panel of the Microsoft Defender portal.":::

### Cloud apps

The Cloud apps node on the left navigational panel is where you find Microsoft Defender for Cloud Apps functionality. For more information, see the unit "Describe Microsoft Defender for Cloud Apps."

:::image type="content" source="../media/cloud-apps-node.png" lightbox="../media/cloud-apps-node.png" alt-text="A screenshot of the cloud apps node on the navigation panel of the Microsoft Defender portal.":::

### SOC Optimization

Security operations center (SOC) teams actively look for opportunities to optimize both processes and outcomes.

SOC optimization surfaces ways you can optimize your security controls, gaining more value from Microsoft security services as time goes on.

:::image type="content" source="../media/optimization.png" lightbox="../media/optimization.png" alt-text="A screenshot of the SOC optimization page in the Microsoft Defender portal.":::

### Reports

Reports are unified in the Microsoft Defender portal. Admins can start with a general security report, and branch into specific reports about endpoints, email & collaboration, cloud apps, infrastructure, and identities. The links here are dynamically generated based upon workload configuration.

:::image type="content" source="../media/reports.png" lightbox="../media/reports.png" alt-text="A screenshot of the reports page in the Microsoft Defender portal.":::

### Learning hub

The learning hub links you Microsoft Learn where you can get access to training courses, tutorials, documentation, and other relevant material.

### System

The system option in the Defender portal includes selections to configure permissions, view service health, and general settings.
