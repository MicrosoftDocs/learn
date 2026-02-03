**Extended detection and response (XDR)** and **security information and event management (SIEM)** are complementary solutions that together provide comprehensive threat detection and response capabilities.

**XDR** is a unified security incident platform that uses AI and automation to provide organizations with a holistic way to protect against and respond to advanced cyberattacks. XDR platforms integrate detection, investigation, and response capabilities across endpoints, identities, cloud applications, email, and operational technology.

**SIEM** solutions collect, aggregate, normalize, and analyze large volumes of data from organization-wide applications, devices, servers, and users in near real time. By consolidating telemetry into a unified platform, SIEM solutions provide a comprehensive view of an organization's security posture.

## Design guidance for detection and response

When designing detection and response solutions, consider these best practices:

- **Integrate XDR and SIEM** for comprehensive coverage—XDR provides deep, coordinated defense across key workloads while SIEM provides broad visibility and long-term analytics
- **Prioritize high-fidelity alerts** to reduce analyst fatigue and focus on genuine threats
- **Enable automatic attack disruption** to contain threats at machine speed
- **Design for unified incident management** to correlate alerts across all security tools
- **Plan for threat intelligence integration** to enrich detections with context

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

Microsoft Defender XDR automatically correlates alerts into incidents, providing end-to-end attack chain visibility and AI-powered automation for faster detection and response.

## Microsoft Sentinel as SIEM and security platform

Microsoft Sentinel is a cloud-native SIEM that delivers AI-driven security across multicloud and multiplatform environments with capabilities for threat detection, investigation, hunting, response, and automated attack disruption.

### Key capabilities

- **Comprehensive data collection** across users, devices, identities, applications, infrastructure, and operational technology via 350+ connectors
- **Advanced threat detection** with built-in analytics rules, machine learning models, and threat intelligence enrichment
- **SOC efficiency tools** including unified incidents, entity pages, investigation graph, hunting notebooks, and Security Copilot integration
- **Automatic attack disruption** signals that integrate with Microsoft Defender XDR for machine-speed response

### Platform components

- **Microsoft Sentinel data lake**: Fully managed data lake for security data retention up to 12 years
- **Content Hub**: Solutions, analytics rules, playbooks, and workbooks from Microsoft and partners
- **Security Copilot integration**: AI-powered investigation assistance and natural language queries

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
> Starting July 2025, new customers are automatically onboarded to the Defender portal. After March 31, 2027, Microsoft Sentinel will be available only in the Microsoft Defender portal.

## Design considerations for detection and response

| Factor | Consideration |
|--------|---------------|
| **Coverage** | Ensure detection across all attack surfaces—endpoints, identities, email, cloud apps, and infrastructure |
| **Alert quality** | Configure tuning to minimize false positives while maintaining comprehensive threat coverage |
| **Automation** | Enable automatic attack disruption for high-confidence threats to contain attacks at machine speed |
| **Integration** | Design for unified incident management across XDR and SIEM |
| **Threat intelligence** | Integrate threat intelligence feeds to enrich detections and provide investigation context |
| **Compliance** | Consider data residency and retention requirements when designing the solution |
