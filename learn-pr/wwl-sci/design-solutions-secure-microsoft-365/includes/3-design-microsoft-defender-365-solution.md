As a security architect, you need to evaluate how Microsoft Defender for Office 365 and Microsoft Defender for Cloud Apps protect your organization's productivity and collaboration workloads. These solutions address different but complementary attack surfaces: Defender for Office 365 focuses on email and collaboration-based threats, while Defender for Cloud Apps extends protection to SaaS applications. Both integrate into Microsoft Defender XDR (Extended Detection and Response), providing correlated signals and unified incident management across the full kill chain.

:::image type="content" source="../media/defender-xdr-integration.png" lightbox="../media/defender-xdr-integration.png" alt-text="An image that shows how Microsoft's XDR solution seamlessly integrates with Microsoft Sentinel in the Microsoft Defender portal.":::

## Evaluate Microsoft Defender for Office 365

[Microsoft Defender for Office 365](/defender-office-365/mdo-about) protects your organization against sophisticated threats in email and collaboration tools, including phishing, zero-day malware, and business email compromise (BEC). It's available in two plans that build on the built-in security features included with all cloud mailboxes.

### Plan 1: Prevention and detection

Defender for Office 365 Plan 1 provides foundational threat protection capabilities:

- **Safe Attachments**: Scans email attachments in a sandbox environment to detect zero-day malware before delivery. This protection extends to SharePoint, OneDrive, and Microsoft Teams.
- **Safe Links**: Provides time-of-click URL verification in email, Office applications, and Teams messages. URLs are checked against a list of known malicious links and detonated in real time.
- **Anti-phishing policies**: Applies impersonation protection and configurable phishing email thresholds to detect attempts to impersonate specific users or domains.
- **Real-time detections**: Provides visibility into threats detected across the email pipeline, enabling security teams to investigate and respond to active threats.

### Plan 2: Investigation, response, and automation

Defender for Office 365 Plan 2 includes all Plan 1 capabilities and adds tools for post-breach investigation and automated remediation:

- **Threat Explorer**: Replaces Real-time detections with richer investigation capabilities. Security analysts can pivot across email metadata, delivery actions, and threat signals to trace attack chains.
- **Automated Investigation and Response (AIR)**: Automatically investigates alerts and takes remediation actions, such as soft-deleting malicious emails or disabling compromised accounts, reducing the manual workload on security teams.
- **Attack simulation training**: Runs simulated phishing campaigns to measure user susceptibility and deliver targeted security awareness training. Tracks user behavior over time to measure improvement.
- **Threat Trackers**: Provides trending threat views and saved queries to monitor specific threat categories affecting your organization.
- **Advanced hunting and incident integration**: Enables KQL-based threat hunting and full incident investigation through Microsoft Defender XDR.

### Design considerations for Defender for Office 365

When you evaluate Defender for Office 365 for your organization, consider the following:

- **Plan selection**: Plan 1 is suited for organizations that need strong prevention capabilities. Plan 2 adds investigation, automation, and user training, making it appropriate for organizations with dedicated security operations teams.
- **Collaboration coverage**: Defender for Office 365 protects not only Exchange Online, but also SharePoint, OneDrive, and Teams. Verify that Safe Attachments and Safe Links are enabled across all collaboration surfaces.
- **Preset security policies**: Use preset security policies as a baseline configuration. These follow Microsoft-recommended defaults and simplify initial deployment. Customize policies as your organization's threat landscape evolves.
- **XDR integration**: Defender for Office 365 feeds alerts and signals into Microsoft Defender XDR, correlating email-based threats with endpoint, identity, and cloud app signals. This cross-domain correlation is essential for detecting multi-stage attacks.

## Evaluate Microsoft Defender for Cloud Apps

[Microsoft Defender for Cloud Apps](/defender-cloud-apps/what-is-defender-for-cloud-apps) is a cloud access security broker (CASB) that delivers full protection for SaaS applications. It provides visibility into cloud app usage, enforces real-time access controls, and protects sensitive data stored in cloud services.

### Core capabilities

Defender for Cloud Apps addresses four key areas:

- **Shadow IT discovery**: Identifies cloud applications in use across your organization by analyzing network traffic against an extensive app catalog of over 31,000 apps. Each app receives a risk score based on more than 90 risk indicators, covering security, compliance, and legal factors. This assessment helps you determine which apps to sanction, monitor, or block.

- **SaaS Security Posture Management (SSPM)**: Surfaces misconfigurations in connected SaaS apps and recommends specific actions to strengthen their security posture. SSPM data feeds directly into Microsoft Secure Score, providing a single view of security posture across both Microsoft and connected non-Microsoft apps.

- **Information protection**: Integrates with Microsoft Purview to scan files in connected SaaS apps for sensitive data. You can apply controls such as sensitivity labels, download blocks on unmanaged devices, and removal of external collaborators on confidential files.

- **App-to-app protection with app governance**: Monitors and governs OAuth-enabled apps that have permissions to access data in other apps on behalf of users. Tracks unused apps, monitors current and expired credentials, and helps maintain app hygiene across the organization.

### Conditional Access App Control

[Conditional Access App Control](/defender-cloud-apps/proxy-intro-aad) uses a reverse proxy architecture integrated with Microsoft Entra Conditional Access to monitor and control user sessions in real time. Access and session policies enable granular controls, including:

- Blocking downloads of sensitive documents on unmanaged devices.
- Requiring reauthentication when sensitive actions occur during a session.
- Protecting downloaded files by applying encryption and sensitivity labels.
- Preventing uploads of unlabeled files that contain sensitive content.
- Blocking uploads of potentially malicious files by scanning against Microsoft Threat Intelligence.
- Monitoring user sessions for compliance and logging activities for investigation.

For a security architect, Conditional Access App Control is a critical capability that bridges identity-based access decisions with real-time data protection. It extends Zero Trust principles into SaaS application sessions.

### Continuous threat protection through Microsoft Defender XDR

Defender for Cloud Apps integrates directly into Microsoft Defender XDR, correlating SaaS app signals with endpoints, identities, and email to provide full kill chain visibility. Built-in user and entity behavior analytics (UEBA) detects anomalous activities, such as impossible travel, unusual download volumes, or suspicious inbox rules. These signals contribute to unified incidents that security operations teams can investigate and remediate through a single portal.

### Design considerations for Defender for Cloud Apps

When you evaluate Defender for Cloud Apps, consider the following:

- **App discovery scope**: Deploy cloud discovery broadly to identify unsanctioned SaaS apps. Use the risk scoring to prioritize which apps need governance policies.
- **SSPM for connected apps**: Connect critical SaaS apps to enable security posture recommendations. Turn on Secure Score integration to include SaaS posture in your overall score.
- **Session control strategy**: Define which apps and user scenarios require real-time session controls through Conditional Access App Control. Focus on high-risk scenarios, such as access from unmanaged devices or guest user sessions.
- **Information protection integration**: Connect Defender for Cloud Apps with Microsoft Purview to enforce sensitivity labels and data loss prevention policies across SaaS apps.
- **OAuth app governance**: Enable app governance to monitor non-Microsoft apps with access to organizational data. Establish policies to detect overprivileged or inactive OAuth apps.

## Evaluate AI-specific threat protection

Defender for Cloud Apps plays a central role in discovering and governing generative AI applications across your organization. The cloud app catalog includes a **Generative AI** category covering more than a thousand AI apps, including ChatGPT, Google Gemini, and other large language model tools. Each app receives a risk score based on more than 90 risk factors spanning security, compliance, and legal criteria.

For security architects, the key design decisions around AI app governance include:

- **Shadow AI discovery**: Deploy cloud discovery to identify which generative AI apps employees use. Filter on the Generative AI category to see usage patterns, user counts, and traffic volumes for each app.
- **App sanctioning and blocking**: Based on risk scores and compliance requirements, sanction approved AI apps and unsanction those that don't meet your security standards. Unsanctioned apps are automatically blocked on devices onboarded to Defender for Endpoint.
- **Discovery policies for new AI apps**: Create app discovery policies that trigger alerts when new Generative AI apps appear in your environment. This ensures continuous monitoring as new AI tools enter the market.
- **Session controls for AI apps**: Apply [Conditional Access App Control](/defender-cloud-apps/proxy-intro-aad) session policies to sanctioned AI apps to monitor and restrict how data flows between your organization and these services.

Defender for Cloud Apps also provides dedicated threat detections for [Microsoft 365 Copilot](/defender-cloud-apps/release-notes#new-threat-detections-for-microsoft-copilot-for-microsoft-365). Security teams receive alerts when users interact with Copilot under suspicious conditions, such as access from risky IP addresses. These signals integrate with Microsoft Defender XDR incidents, giving your security operations team visibility into AI-related threats alongside traditional attack patterns.


