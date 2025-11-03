
**Extended detection and response (XDR)** is a unified security incident platform that uses AI and automation to provide organizations with a holistic, efficient way to protect against and respond to advanced cyberattacks. XDR platforms integrate detection, investigation, and response capabilities across endpoints, hybrid identities, cloud applications and workloads, email, data stores, and operational technology. They also drive efficiency across security operations (SecOps) with end‑to‑end attack chain visibility, AI-powered automation and analytics, and broad threat intelligence.

A **security information and event management (SIEM)** solution is an essential component of effective cybersecurity. SIEM solutions collect, aggregate, normalize, and analyze large volumes of data from organization‑wide applications, devices, servers, identities, and users in near real time. By consolidating this telemetry into a single, unified platform, SIEM solutions provide a comprehensive view of an organization's security posture—empowering security operations centers (SOC) to detect, investigate, hunt, and respond swiftly and effectively.

XDR and SIEM are complementary. XDR delivers deep, coordinated defense across key workloads and automatically remediating threats in those environments, while SIEM casts a wide net to collect and analyze events from any source, providing long‑term analytics, compliance visibility, and historical context. Used together in Microsoft’s unified security operations experience, XDR supplies high‑fidelity, enriched alerts and automatic attack disruption signals; Microsoft Sentinel ingests those alongside broader telemetry (350+ connectors), correlates them, and unifies incidents and entities—accelerating triage, investigation, and response. This synergy is a cornerstone of Microsoft’s unified approach.

### Microsoft Defender XDR

Microsoft Defender XDR services include the following asset protection capabilities:

|Capability  |Security product  |
|---------|---------|
|Identify, detect, and investigate threats across on-premises Active Directory and Microsoft Entra ID identities.|[Microsoft Defender for Identity](/defender-for-identity/what-is)|
|Protect against threats posed by email messages, URL links, and Office 365 collaboration tools.     |   [Microsoft Defender for Office 365](/defender-office-365/mdo-about)      |
|Monitor and protect endpoint devices. Monitor, detect, and investigate device breaches, and automatically respond to security threats.    |     [Microsoft Defender for Endpoint](/defender-endpoint/microsoft-defender-endpoint)    |
|Identify and protect operational technology (OT) and IT resources by extending Defender XDR protection to OT environments.|[Microsoft Defender for IoT](/defender-for-iot/microsoft-defender-iot)|
|Identify assets and software inventory, and assess device posture to find security vulnerabilities.|[Microsoft Defender Vulnerability Management](/defender-vulnerability-management/defender-vulnerability-management)|
|Protect and control access to SaaS cloud apps.|[Microsoft Defender for Cloud Apps](/defender-cloud-apps/what-is-defender-for-cloud-apps)|

### Microsoft Sentinel

Microsoft Sentinel is now a cloud-native SIEM **and security platform for agentic defense**. As a SIEM, Microsoft Sentinel delivers AI-driven security across multicloud and multiplatform environments, offering robust capabilities for threat detection, investigation, hunting, response, and automated attack disruption. As a platform, Microsoft Sentinel provides a foundation built on a modern data lake for deep insights, graph capabilities for contextual analysis, a hosted Model Context Protocol (MCP) server for agent-ready tooling, and developer capabilities for building and deploying solutions through the Security Store.

Key capabilities of Microsoft Sentinel include:

- **Comprehensive data collection**: Collect data at scale across users, devices, identities, applications, infrastructure, operational technology, and multiple clouds via 350+ first‑ and third‑party connectors. Centralization plus normalization enables rich correlation, summarization, and advanced analytics.
- **AI‑ready platform architecture**: The platform unifies SIEM capabilities with a modern data lake, graph reasoning, and MCP for agent workflows—standardizing access patterns and accelerating autonomous actions while keeping defenders in control.
- **Security data lake (GA)**: The [Microsoft Sentinel data lake](/azure/sentinel/datalake/sentinel-lake-overview) stores a single open‑format (Parquet) copy of security data, decouples storage from compute, mirrors analytics tier data automatically, and supports multi‑modal analytics (KQL queries, scheduled jobs, notebooks, graph and modeling) with cost‑efficient retention—up to 12 years.
- **Advanced threat detection & response**: Built‑in analytics rules, ML models, threat intelligence enrichment, automatic attack disruption signals (via Defender XDR integration), playbooks, and proactive KQL hunting deliver high‑fidelity detections and faster containment.
- **SOC efficiency & investigation tools**: Unified incidents, entity pages, investigation graph, hunting notebooks, summarization via Security Copilot, and noise reduction through intelligent alert grouping streamline analyst workflows.
- **Developer & solution ecosystem**: Content Hub and Security Store support packaging of connectors, analytic rules, hunting queries, playbooks, notebooks, and agents for rapid deployment and extensibility.

Microsoft Sentinel on its own correlates events across a wide array of systems. When connected with Microsoft Defender XDR, the integration (within unified security operations in the Defender portal) enables shared data, unified incidents & entities, AI summarization, automatic attack disruption context, and enriched investigation paths.

#### Microsoft Sentinel platform components

- **Microsoft Sentinel data lake**: Microsoft Sentinel data lake is a fully managed, cloud-native data lake purpose-built for security operations. It unifies, retains, and analyzes security data at scale - providing the foundation for advanced analytics, AI-driven insights, and agentic defense.
- **Microsoft Sentinel graph (Preview)**: Microsoft Sentinel graph provides unified graph analytics capability by modeling and analyzing complex relationships across assets, identities, activities, and threat intelligence. It enables Microsoft Defenders and AI agents to reason over interconnected data, offering deeper insights and faster response to cyber threats.
- **Microsoft Sentinel MCP server (Preview)**: Microsoft Sentinel Model Control Protocol (MCP) server provides a unified, hosted interface that enables security teams to interact with security data using natural language and build intelligent security agents - without infrastructure setup or custom connectors. This integration simplifies data exploration and automation, making AI-driven security operations more accessible and effective.
- **Microsoft Sentinel developer experience**: Microsoft Sentinel offers extensive capabilities for partners to create impactful solutions they can publish through the Microsoft Security Store or the Microsoft Sentinel SIEM Content Hub. Building on top of Microsoft Sentinel lets you support new scenarios using a wide range of security data, processing capabilities, and AI experiences, without the need for new pipelines, compute engines, or storage infrastructure.

#### Unified investigation & agentic operations

Sentinel’s evolution into a SIEM and platform enables agentic defense: transforming raw telemetry into a security graph, standardizing access for AI agents, and coordinating autonomous actions while preserving human oversight of strategy and high‑impact investigations.

### Unified security operations in the Microsoft Defender portal

The Microsoft Defender portal provides unified security operations that integrate solutions for:

- Security information and event management (SIEM)
- Security orchestration, automation, and response (SOAR)
- Extended detection and response (XDR)
- Posture and exposure management
- Cloud security, threat intelligence, and generative AI

To cover all those capabilities, the Defender portal combines services including Microsoft Defender XDR, Microsoft Sentinel, [Microsoft Security Exposure Management](/security-exposure-management/microsoft-security-exposure-management), and [Microsoft Security Copilot](/copilot/security/microsoft-security-copilot) in one place. Integrating additional Defender services expands protection and insight across sophisticated attack scenarios. The portal provides a single location to monitor, detect, investigate, remediate, and respond to pre‑ and post‑breach cybersecurity risks.

Other services whose alerts are collected by Defender XDR include:

- [Microsoft Purview Data Loss Prevention](/microsoft-365/security/defender/investigate-dlp)
- [Microsoft Entra ID Protection](/defender-cloud-apps/aadip-integration)
- [Microsoft Purview Insider Risk Management](/defender-xdr/irm-investigate-alerts-defender)

:::image type="content" source="../media/defender-xdr-siem-portal.png" lightbox="../media/defender-xdr-siem-portal.png" alt-text="Diagram showing integrated Microsoft Defender XDR and Microsoft Sentinel experience in the unified Defender portal.":::