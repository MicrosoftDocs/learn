
Modern cyberattacks rarely stay within the boundaries of a single system. Attackers typically move laterally—starting with a phishing email to compromise a user's credentials, then pivoting to endpoints and cloud applications to exfiltrate data or deploy ransomware. Detecting and responding to these multistage attacks requires security tools that can share information and act together across all affected systems.

Microsoft Defender XDR (Extended Detection and Response) is a unified pre- and post-breach enterprise defense suite that natively coordinates detection, prevention, investigation, and response across endpoints, identities, email, and applications. By bringing together signals from multiple Microsoft security products into a single platform, Defender XDR gives security teams a complete, correlated view of an attack—making it possible to understand how the attack entered the environment, what it has affected, and how to stop it.

## The Microsoft Defender XDR suite

The Microsoft Defender XDR suite includes the following integrated solutions:

- **Microsoft Defender for Endpoint** - A unified endpoint platform for preventative protection, post-breach detection, automated investigation, and response for devices across the organization.
- **Microsoft Defender Vulnerability Management** - Delivers continuous asset visibility, intelligent risk-based assessments, and built-in remediation tools to help your security and IT teams prioritize and address critical vulnerabilities and misconfigurations across your organization.
- **Microsoft Defender for Office 365** - Safeguards your organization against malicious threats posed by email messages, links (URLs), and collaboration tools.
- **Microsoft Defender for Identity** - A cloud-based security solution that monitors identity signals from on-premises Active Directory and Microsoft Entra ID to identify, detect, and investigate advanced threats, compromised identities, and malicious insider actions across on-premises, cloud, and hybrid environments.
- **Microsoft Entra ID Protection** - Works alongside Defender for Identity to protect cloud identities. It uses the learnings Microsoft has acquired across organizations with Microsoft Entra ID, the consumer space with Microsoft Accounts, and in gaming with Xbox to protect your users from identity-based risks.
- **Microsoft Defender for Cloud Apps** - A comprehensive cross-SaaS solution that brings deep visibility, strong data controls, and enhanced threat protection to your cloud apps. Defender for Cloud Apps is a cloud access security broker (CASB) that helps discover and control shadow IT and protect sensitive information across SaaS and PaaS applications.
- **Microsoft Defender Threat Intelligence (Defender TI)** - A platform that aggregates and enriches critical threat information, helping security analysts with triage, incident response, threat hunting, and vulnerability management workflows. Defender TI capabilities are converging into Microsoft Defender XDR and Microsoft Sentinel for a unified experience.
- **Microsoft Security Exposure Management** - A security solution that provides a unified view of security posture across company assets and workloads spanning endpoints, cloud resources, and external attack surfaces. It enriches asset information with security context to help proactively manage attack surfaces, protect critical assets, and explore and mitigate exposure risk across your entire digital estate. Security Exposure Management is covered in detail in a later unit of this module.

## Cross-product capabilities

What makes Microsoft Defender XDR more than a collection of individual products is how the suite shares signals and takes coordinated action across all products. These cross-product capabilities provide a level of protection and visibility that individual, isolated tools can't deliver.

### Combined incidents queue

Across all products in the suite, related alerts, suspicious events, and impacted assets are automatically grouped into a single incident. The combined incidents queue helps security professionals stay focused on the full scope of an attack. Rather than chasing individual alerts from separate consoles, you can see the entire attack story in one place—from the initial entry point to the affected assets.

### Automatic response to threats

When one product in the suite detects a threat, it immediately shares that information with all other products. For example, if Microsoft Defender for Endpoint detects a malicious file on a device, it instructs Microsoft Defender for Office 365 to scan and remove that file from all email messages across the organization. The file is blocked on sight by the entire Microsoft 365 security suite without manual intervention, stopping the threat from spreading through other channels.

### Self-healing for compromised devices, user identities, and mailboxes

Microsoft Defender XDR uses AI-powered automatic actions and playbooks to remediate impacted assets back to a secure state. When an attack is contained, Defender XDR leverages automatic remediation capabilities of the suite products to ensure all impacted assets related to an incident are automatically remediated where possible, reducing the manual recovery effort for security teams.

### Automatic attack disruption

Microsoft Defender XDR uses high-fidelity signals produced across the suite to detect attacks in progress and contain them before they can spread. Automatic attack disruption correlates signals from multiple sources into a single high-confidence incident, identifies assets controlled by the attacker, and automatically takes response actions—such as isolating compromised devices, disabling compromised accounts, or containing malicious IP addresses—in real time without waiting for human action. This capability limits damage and gives security teams more time to investigate and respond.

### Cross-product threat hunting

Security teams can build custom queries across the raw data collected by all products in the suite. Microsoft Defender XDR provides query-based access to 30 days of historic raw signals and alert data across endpoint and Defender for Office 365 data, enabling analysts to proactively hunt for signs of compromise across their entire environment.

## The Microsoft Defender portal

The information and insights from the Microsoft Defender XDR suite are centralized in the Microsoft Defender portal, which delivers a unified security operations platform. The portal combines data from the Defender XDR suite with information from Microsoft Sentinel and Microsoft Defender for Cloud, giving security teams a single place to monitor, investigate, and respond to threats across identities, endpoints, email, applications, and cloud infrastructure.

## Microsoft Security Copilot integration

Microsoft Defender XDR integrates with Microsoft Security Copilot. Security Copilot brings together the power of AI and human expertise to help security teams respond to attacks faster and more effectively. With the integration, security teams can summarize incidents in natural language, receive AI-guided response recommendations, generate threat-hunting queries without needing to know a query language, and analyze suspicious files and scripts in seconds.

The integration is available through both the standalone Security Copilot portal and as an embedded experience directly in the Microsoft Defender portal. Copilot also powers autonomous AI agents that can help with specific security tasks, such as automatically triaging phishing reports and delivering customized threat intelligence briefings. These capabilities are covered in detail in a later unit of this module.

Throughout this module, you learn about each solution in the Microsoft Defender XDR suite, the Microsoft Defender portal, and the integration with Microsoft Security Copilot.

Watch this brief video that describes the benefits of Microsoft Defender XDR.

> [!VIDEO https://learn-video.azurefd.net/vod/player?id=2da38838-a10e-4412-bd93-a9adae672c92]