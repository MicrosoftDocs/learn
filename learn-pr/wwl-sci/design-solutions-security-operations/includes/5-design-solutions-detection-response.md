**Extended detection and response (XDR)** and **security information and event management (SIEM)** are complementary solutions that together provide comprehensive threat detection and response capabilities.

**XDR** is a unified security incident platform that uses AI and automation to provide organizations with a holistic way to protect against and respond to advanced cyberattacks. XDR platforms integrate detection, investigation, and response capabilities across endpoints, identities, cloud applications, email, and operational technology.

**SIEM** solutions collect, aggregate, normalize, and analyze large volumes of data from organization-wide applications, devices, servers, and users in near real time. By consolidating telemetry into a unified platform, SIEM solutions provide a comprehensive view of an organization's security posture.

Together, XDR and SIEM cover both security data domains discussed in the previous unit: XDR provides deep detection across the productivity domain (email, identity, collaboration) while SIEM correlates data from both productivity and infrastructure domains for comprehensive threat visibility.

## Design guidance for detection and response

When designing detection and response solutions, consider these best practices:

- **Integrate XDR and SIEM** for comprehensive coverage—XDR provides deep, coordinated defense across key workloads while SIEM provides broad visibility and long-term analytics
- **Prioritize high-fidelity alerts** to reduce analyst fatigue and focus on genuine threats
- **Enable automatic attack disruption** to contain threats at machine speed
- **Design for unified incident management** to correlate alerts across all security tools
- **Plan for threat intelligence integration** to enrich detections with context
- **Leverage AI-assisted detection** to identify sophisticated threats that rule-based detection might miss

## Microsoft Defender XDR

Microsoft Defender XDR provides XDR capabilities across the Microsoft 365 environment and beyond:

| Capability | Security product |
|------------|-----------------|
| Identify, detect, and investigate identity threats | Microsoft Defender for Identity |
| Protect against email, URL, and collaboration tool threats | Microsoft Defender for Office 365 |
| Monitor and protect endpoint devices | Microsoft Defender for Endpoint |
| Protect operational technology (OT) and IT resources | Microsoft Defender for IoT |
| Identify assets and assess device security posture | Microsoft Defender Vulnerability Management |
| Protect and control access to SaaS cloud apps | Microsoft Defender for Cloud Apps |
| Detect threats across Azure, AWS, and GCP workloads | Microsoft Defender for Cloud |

Microsoft Defender XDR automatically correlates alerts into incidents, providing end-to-end attack chain visibility and AI-powered automation for faster detection and response.

## Microsoft Sentinel as SIEM and security platform

Microsoft Sentinel is a cloud-native SIEM and unified security platform for agentic defense. It has evolved beyond traditional SIEM to provide an AI-ready, data-first foundation that transforms telemetry into a security graph, standardizes access for AI agents, and coordinates autonomous actions while keeping humans in command of strategy and high-impact investigations.

As a SIEM, Microsoft Sentinel delivers AI-driven security across multicloud and multiplatform environments with capabilities for threat detection, investigation, hunting, response, and automated attack disruption. As a platform, it provides a foundation built on a modern data lake, graph capabilities for contextual analysis, and a hosted Model Context Protocol (MCP) server for agent-ready tooling.

:::image type="content" source="../media/microsoft-sentinel-overview.png" alt-text="A diagram that depicts the Microsoft Sentinel AI-first, end-to-end SIEM and security platform." lightbox="../media/microsoft-sentinel-overview.png":::

### SIEM capabilities

- **Comprehensive data collection** across users, devices, identities, applications, infrastructure, and operational technology via 350+ connectors
- **Advanced threat detection** with built-in analytics rules, machine learning models, and threat intelligence enrichment
- **SOC efficiency tools** including unified incidents, entity pages, investigation graph, hunting notebooks, and Security Copilot integration

### Core platform components

| Component | Description | Design relevance |
|-----------|-------------|------------------|
| **Microsoft Sentinel data lake** | Fully managed, cloud-native data lake that unifies, retains, and analyzes security data at scale with support for up to 12 years retention | Enables multi-modal analytics including KQL queries, graph analysis, and AI-powered notebooks on a single copy of open-format data |
| **Microsoft Sentinel graph** | Unified graph analytics that models relationships across assets, identities, activities, and threat intelligence | Enables reasoning over interconnected data to answer complex questions like attack paths from compromised entities to critical assets |
| **Microsoft Sentinel MCP server** | Hosted interface enabling natural language interaction with security data and building intelligent security agents | Accelerates agent creation and enables security teams to query data without schema knowledge or coding |
| **Content Hub** | Solutions, analytics rules, playbooks, and workbooks from Microsoft and partners | Provides pre-built detection and response content to accelerate deployment |

### Data tiering for detection and retention

Microsoft Sentinel's tiered data architecture supports both real-time detection and long-term investigation:

- **Analytics tier** - High-performance storage for real-time detection, alerting, and interactive investigation
- **Data lake tier** - Cost-efficient storage for historical analysis, behavioral baselines, and compliance retention
- **Automatic mirroring** - Data ingested into the analytics tier is automatically mirrored to the data lake tier, ensuring a unified repository

This architecture allows security architects to design solutions that balance detection latency, investigation depth, and cost optimization.

## AI-powered detection and investigation

AI and machine learning are fundamental to modern detection and response, enabling capabilities that traditional rule-based detection cannot achieve:

### Detection capabilities

| AI capability | How it helps detection |
|---------------|----------------------|
| **Behavioral analytics (UEBA)** | Establishes baseline behavior for users and entities, detecting anomalies that indicate compromised accounts or insider threats |
| **Machine learning anomaly detection** | Identifies unusual patterns in network traffic, authentication, and resource access without predefined rules |
| **Threat intelligence correlation** | Automatically matches indicators of compromise (IOCs) against incoming telemetry at scale |
| **Attack chain detection** | Correlates low-fidelity signals across multiple data sources to identify sophisticated multi-stage attacks |

### Security Copilot for SOC efficiency

Microsoft Security Copilot transforms how analysts investigate and respond to threats:

- **Incident summarization** - Automatically generates plain-language summaries of complex incidents, reducing triage time from hours to minutes
- **Guided investigation** - Suggests next investigation steps based on incident context and attack patterns
- **Natural language queries** - Enables analysts to query security data using conversational language instead of KQL
- **Script analysis** - Analyzes malicious scripts and explains their behavior in plain language
- **Report generation** - Creates investigation reports and executive summaries automatically

For security architects, designing for Security Copilot means ensuring comprehensive data collection (Copilot can only analyze data that's available in your workspace) and training SOC teams to effectively prompt the AI for investigation assistance.

## Unified security operations in the Defender portal

The Microsoft Defender portal provides unified security operations integrating:

- Security information and event management (SIEM)
- Security orchestration, automation, and response (SOAR)
- Extended detection and response (XDR)
- Posture and exposure management
- Cloud security, threat intelligence, and generative AI

The portal combines Microsoft Defender XDR, Microsoft Sentinel, Microsoft Security Exposure Management, and Microsoft Security Copilot. This provides a single location to monitor, detect, investigate, remediate, and respond to pre- and post-breach cybersecurity risks.

### Integration benefits

When Microsoft Sentinel is connected with Microsoft Defender XDR in the unified portal:

- **Shared data and unified incidents** enable seamless investigation across both platforms
- **Automatic attack disruption** signals from Defender XDR are available in Sentinel
- **AI summarization** through Security Copilot accelerates triage and investigation
- **Enriched investigation paths** combine XDR deep insights with SIEM breadth

> [!IMPORTANT]
> New customers are automatically onboarded to the unified Defender portal. After March 31, 2027, Microsoft Sentinel will be available only in the Microsoft Defender portal. Plan your security operations architecture with this unified experience in mind.

## Detection engineering considerations

As a security architect, design your detection strategy to balance coverage, quality, and maintainability:

### Analytics rule design

| Rule type | Use case | Design consideration |
|-----------|----------|---------------------|
| **Scheduled rules** | Custom detection logic using KQL queries | Run frequency vs. cost; lookback period vs. detection latency |
| **Near-real-time (NRT) rules** | Time-sensitive detections requiring sub-minute response | Limited to specific data sources; higher resource consumption |
| **Microsoft security rules** | Automatic incident creation from Defender alerts | Configure filtering to avoid duplicate incidents |
| **ML behavior analytics** | Anomaly detection without predefined thresholds | Requires sufficient baseline data; tune sensitivity over time |
| **Threat intelligence rules** | IOC matching against threat feeds | Ensure TI feeds are current and relevant to your threat landscape |

### Detection coverage strategy

- **Map detections to MITRE ATT&CK** - Use the coverage matrix in Sentinel to identify gaps across tactics and techniques
- **Layer detection types** - Combine rule-based, ML-based, and threat intelligence detections for defense in depth
- **Prioritize high-impact techniques** - Focus detection engineering on techniques most commonly used against your industry
- **Plan for detection maintenance** - Allocate ongoing effort to tune rules, reduce false positives, and adapt to evolving threats

## Design considerations for detection and response

| Factor | Consideration |
|--------|---------------|
| **Coverage** | Ensure detection across all attack surfaces—endpoints, identities, email, cloud apps, and infrastructure |
| **Alert quality** | Configure tuning to minimize false positives while maintaining comprehensive threat coverage |
| **Automation** | Enable automatic attack disruption for high-confidence threats to contain attacks at machine speed |
| **Integration** | Design for unified incident management across XDR and SIEM |
| **Threat intelligence** | Integrate threat intelligence feeds to enrich detections and provide investigation context |
| **AI enablement** | Ensure comprehensive data collection to maximize Security Copilot effectiveness |
| **Detection engineering** | Plan for ongoing rule development, tuning, and MITRE ATT&CK coverage assessment |
| **Compliance** | Consider data residency and retention requirements when designing the solution |
