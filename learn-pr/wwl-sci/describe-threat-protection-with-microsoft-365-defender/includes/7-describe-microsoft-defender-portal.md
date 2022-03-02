The Microsoft 365 Defender portal is a specialized workspace designed to meet the needs of security teams and provides actionable insights to help reduce risks and safeguard your digital estate.

Here you can view the security health of your organization, act to configure devices, users, and apps, and get alerts for suspicious activity. The Microsoft 365 Defender portal helps security admins and security operations teams manage and protect their organization.

The Microsoft 365 Defender portal home page shows many of the common cards that security teams need. The composition of cards and data depends on the user role. Because the Microsoft 365 Defender portal uses role-based access control, different roles will see cards that are more meaningful to their day-to-day jobs.

:::image type="content" source="../media/2-defender-portal-inline.png" lightbox="../media/2-defender-portal-expanded.png" alt-text="Screenshot showing the Microsoft 365 Defender portal landing page.":::

The Microsoft 365 Defender portal allows admins to tailor the navigation pane to meet daily operational needs. Admins can customize the navigation pane to show or hide functions and services based on their specific preferences. Customization is specific to the individual admin, so other admins won’t see these changes.

> [!NOTE]
> You must be assigned an appropriate role, such as Global Administrator, Security Administrator, Security Operator, or Security Reader in Azure Active Directory to access the Microsoft 365 Defender portal.

Here we describe a few of the elements from the left navigation bar in the Microsoft 365 Defender portal.

### Incidents and alerts

Incidents are a collection of correlated alerts created when a suspicious event is found. Alerts are generated from a different device, user, and mailbox entities, and can come from many different domains. These alerts are automatically aggregated by Microsoft 365 Defender. It's the grouping of these related alerts that form an incident. The incident provides a comprehensive view and context of an attack.

Security personnel can use an incident to determine where an attack started, what methods were used, and to what extent the attack has progressed within the network. They can also determine the scope of the attack, and how many users, devices, and mailboxes were affected. The severity of the attack can also be determined.

Managing incidents is critical in ensuring that threats are contained and addressed.  In Microsoft 365 Defender, you can manage incidents on devices, users accounts, and mailboxes.

Watch this four-minute video, which describes incidents and incident management.

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RE4J3mt]


#### Hunting

Proactively search for threats, malware, and malicious activity across your endpoints, Office 365 mailboxes, and more by using advanced hunting queries. These powerful queries can be used to locate and review threat indicators and entities for both known and potential threats.

### Threat analytics

Get threat intelligence from expert Microsoft security researchers. Threat Analytics helps security teams be more efficient when facing emerging threats.

:::image type="content" source="../media/threat-analytics-inline.png" lightbox="../media/threat-analytics-expanded.png" alt-text="Screenshot showing the threat analytics page.":::

### Secure Score

Microsoft Secure Score, one of the tools in the Microsoft 365 Defender portal, is a representation of a company's security posture. The higher the score, the better your protection.

Secure Score helps organizations:

- Report on the current state of their security posture.
- Improve their security posture by providing discoverability, visibility, guidance, and control.
- Compare benchmarks and establish key performance indicators (KPIs).

Currently Microsoft Secure Score supports recommendations for Microsoft 365 (including Exchange Online), Azure Active Directory, Microsoft Defender for Endpoint, Microsoft Defender for Identity, and Microsoft Defender Cloud Apps. New recommendations are being added to Secure Score all the time.

The image below shows an organization's Secure Score, a breakdown of the score by points, and the improvement actions that can boost the organization's score. Finally, it provides an indication of how well the organization's Secure Score compares to other similar organizations.

:::image type="content" source="../media/3-secure-score-overview-3-inline.png" lightbox="../media/3-secure-score-overview-3-expanded.png" alt-text="Screenshot showing the Microsoft Secure Score page.":::

#### Differences between secure score in Microsoft 365 Defender and Microsoft Defender for Cloud

There's a secure score for both Microsoft 365 Defender and Microsoft Defender for Cloud, but they're subtly different. Secure score in Microsoft Defender for Cloud is a measure of the security posture of your Azure subscriptions. Secure score in the Microsoft 365 Defender portal is a measure of the security posture of the organization across your apps, devices, and identities.

In both cases, secure score provides a list of steps you can take to improve your score. In Microsoft 365 Defender, these steps are called improvement actions. In Microsoft Defender for Cloud, scores are assessed for each subscription. The steps you can take to improve your score are called security recommendations and they're grouped into security controls.

### Learning hub

The Microsoft 365 Defender portal includes a learning hub that bubbles up official guidance from resources such as the Microsoft security blog, the Microsoft security community on YouTube, and the official documentation at docs.microsoft.com.

:::image type="content" source="../media/learning-hub-inline.png" lightbox="../media/learning-hub-expanded.png" alt-text="Screenshot showing the learning hub page.":::

### Endpoints

Microsoft Defender for Endpoints delivers preventative protection, post-breach detection, automated investigation, and response for devices in your organization.  Here you can view and manage the security of endpoints in your organization.

:::image type="content" source="../media/endpoints-inline.png" lightbox="../media/endpoints-expanded.png" alt-text="Screenshot of the endpoints threat and vulnerability dashboard.":::


### Email & collaboration

Microsoft Defender for Office 365 helps organizations secure their enterprise with a set of prevention, detection, investigation and hunting features to protect email, and Office 365 resources.

:::image type="content" source="../media/email-explorer-inline.png" lightbox="../media/email-explorer-expanded.png"alt-text="Screenshot showing the explorer page that is part of the email and collaboration section of the Microsoft 365 Defender portal.":::

### Reports

Reports are unified in Microsoft 365 Defender. Admins can start with a general security report, and branch into specific reports about endpoints, email & collaboration. The links here are dynamically generated based upon workload configuration.

:::image type="content" source="../media/4-reports-page-2-inline.png" lightbox="../media/4-reports-page-2-expanded.png"alt-text="Screenshot showing the Microsoft 365 reports page that lists the different reports available.":::

### Permissions & roles

Access to Microsoft 365 Defender is configured with Azure Active Directory global roles or by using custom roles.
