
**Extended detection and response (XDR)** is a unified security incident platform that uses AI and automation to provide organizations with a holistic, efficient way to protect against and respond to advanced cyberattacks. XDR platforms integrate detection, investigation, and response capabilities across a wide range of domains, including an organization’s endpoints, hybrid identities, cloud applications and workloads, email, and data stores. They also drive efficiency across security operations (SecOps) with advanced cyberattack chain visibility, AI-powered automation and analytics, and broad threat intelligence.

A **security information and event management (SIEM)** solution is an essential component of effective cybersecurity. SIEM solutions collect, aggregate, and analyze large volumes of data from organization-wide applications, devices, servers, and users in real time. By consolidating this vast array of data into a single, unified platform, SIEM solutions provide a comprehensive view of an organization's security posture, empowering security operation centers (SOC) to detect, investigate, and respond to security incidents swiftly and effectively.

XDR and SIEM are complementary. XDR focuses on deep, coordinated defense across key workloads, and automatically remediating threats in those environments, while SIEM casts a wide net to catch events from any source and provides long-term analytics and compliance visibility. Used together, XDR and SIEM feed into each other: an XDR can supply high-fidelity alerts and rich context to the SIEM, and the SIEM can ingest signals from XDR alongside other data, correlating everything to spot attacks and assist in investigation. This complementary relationship is a cornerstone of Microsoft’s unified approach.

### Microsoft Defender XDR

Microsoft Defender XDR services include the following asset protection capabilities:

|Capability  |Security product  |
|---------|---------|
|Identify, detect, and investigate Microsoft Entra ID threats.|[Microsoft Defender for Identity](/defender-for-identity/what-is)|
|Protect against threats posed by email messages, URL links, and Office 365 collaboration tools.     |   [Microsoft Defender for Office 365](/defender-office-365/mdo-about)      |
|Monitor and protect endpoint devices. Monitor, detect, and investigate device breaches, and automatically respond to security threats.    |     [Microsoft Defender for Endpoint](/defender-endpoint/microsoft-defender-endpoint)    |
|Identify and protect operational technology (OT) and IT resources by extending Defender XDR protection to OT environments.|[Microsoft Defender for IoT](/defender-for-iot/microsoft-defender-iot)|
|Identify assets and software inventory, and assess device posture to find security vulnerabilities.|[Microsoft Defender Vulnerability Management](/defender-vulnerability-management/defender-vulnerability-management)|
|Protect and control access to SaaS cloud apps.|[Microsoft Defender for Cloud Apps](/defender-cloud-apps/what-is-defender-for-cloud-apps)|

### Microsoft Sentinel

Microsoft Sentinel is a scalable, cloud-native SIEM that provides cost-efficient, multicloud threat protection with built-in AI, automation, threat intelligence, and a modern data lake architecture. It can ingest data from virtually any source, giving security analysts a "bird’s-eye view" across on-premises and cloud environments.

Key capabilities of Microsoft Sentinel include:

- Comprehensive data collection: Microsoft Sentinel can collect data at scale across all users, devices, applications, and infrastructure, both on-premises and in any cloud. Microsoft Sentinel can ingest data from Microsoft and third-party sources using over 350 connectors. This means an organization can funnel virtually all its security-relevant telemetry into Microsoft Sentinel’s unified log store. By centralizing disparate data sources, Microsoft Sentinel enables correlation of events across them.

- Cloud-native architecture and data lake: Traditional SIEMs often struggle with scalability and cost when handling huge data volumes. Microsoft Sentinel addresses this by using a cloud-native architecture backed by Azure’s scalability. It uses Azure Log Analytics and introduces a security data lake specifically for Microsoft Sentinel. The [Microsoft Sentinel data lake](/azure/sentinel/datalake/sentinel-lake-overview) allows organizations to store massive amounts of security data for long periods at relatively low cost, separating the concern of data retention from active analysis. Analysts can run queries on both recent hot data and archived data seamlessly. This architecture ensures that security teams don’t have to limit what data they collect due to infrastructure constraints – more data can mean better detections.

- Advanced threat detection and response: Microsoft Sentinel comes with built-in analytics rules and machine learning models to detect suspicious patterns. It also integrates threat intelligence feeds, including Microsoft’s extensive threat intelligence, to enrich alerts. When threats are detected, Microsoft Sentinel can trigger automated responses using playbooks. Analysts can also perform proactive threat hunting in Microsoft Sentinel using the powerful Kusto Query Language (KQL) across the collected data. The platform provides hunting queries and notebooks to assist analysts in investigating anomalies or hunting for signs of undetected threats.

- SOC efficiency and investigation tools: Microsoft Sentinel provides a unified workspace for SOC analysts. Analysts use Microsoft Sentinel’s investigation graph and query tools to drill down into an incident, pivoting across related data to understand root cause and impact. By using AI, Microsoft Sentinel can help reduce noise (alert fatigue) by highlighting the most relevant alerts and even coalescing them intelligently.

Microsoft Sentinel on its own will catch events from a wide array of systems, and when it’s connected with Microsoft Defender XDR, the two can share data and provide an end-to-end detection and response powerhouse. That integration happens through Microsoft’s unified security operations platform in the Microsoft Defender portal.

### Unified security operations in the Microsoft Defender portal

The Microsoft Defender portal provides unified security operations that integrate solutions for:

- Security information and event management (SIEM)
- Security orchestration, automation, and response (SOAR)
- Extended detection and response (XDR)
- Posture and exposure management
- Cloud security, threat intelligence, and generative AI

To cover all those capabilities, the Defender portal combines services like [Microsoft Defender XDR](/defender-xdr/microsoft-365-defender), [Microsoft Sentinel](/azure/sentinel/overview), [Microsoft Security Exposure Management](/security-exposure-management/microsoft-security-exposure-management), and [Microsoft Security Copilot](/copilot/security/microsoft-security-copilot) in the Microsoft Defender portal. Integrate more Microsoft Defender services to add security and provide integrated protection against sophisticated attacks. The Defender portal provides a single location to monitor, detect, investigate, remediate, and respond against pre- and post-breach cybersecurity risks and threats.

Other services whose alerts are collected by Defender XDR include:

- [Microsoft Purview Data Loss Prevention](/microsoft-365/security/defender/investigate-dlp)
- [Microsoft Entra ID Protection](/defender-cloud-apps/aadip-integration)
- [Microsoft Purview Insider Risk Management](/defender-xdr/irm-investigate-alerts-defender)

:::image type="content" source="../media/defender-xdr-siem-portal.png" lightbox="../media/defender-xdr-siem-portal.png" alt-text="An image that shows how Microsoft's XDR solution seamlessly integrates with Microsoft Sentinel in the Microsoft Defender portal.":::