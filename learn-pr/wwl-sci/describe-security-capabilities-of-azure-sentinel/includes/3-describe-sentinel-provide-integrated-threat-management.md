Microsoft Sentinel is a scalable, cloud-native security information and event management (SIEM) and security orchestration, automation, and response (SOAR) solution. It delivers AI-powered security analytics and threat intelligence across multicloud and multiplatform environments, providing a single solution for threat detection, investigation, proactive hunting, and response.

Microsoft Sentinel has evolved beyond a traditional SIEM. Today it serves both as a SIEM and as a security platform—providing an AI-ready, data-first foundation that transforms telemetry into actionable security insights while keeping your security team in command.

## Microsoft Sentinel as a SIEM

As a SIEM, Microsoft Sentinel gives your security team a unified view of threats across the entire enterprise. It collects and correlates signals from all users, devices, applications, and infrastructure—whether on-premises, in Azure, or in other cloud environments like Amazon Web Services (AWS) and Google Cloud Platform (GCP).

Microsoft Sentinel supports end-to-end security operations across four interconnected areas:

- **Collect** security data at cloud scale from across your entire digital estate using 350+ built-in data connectors for Microsoft services, non-Microsoft platforms, and custom sources. Data normalization translates diverse formats into a uniform view, making it easier to correlate events across sources.
- **Detect** previously undetected threats and minimize false positives using analytics rules and AI-powered detections. Rules run regularly to query collected data, generate alerts when suspicious activity is found, and group related alerts into *incidents*—case files your team can assign and investigate.
- **Investigate** threats using AI-assisted tools and proactive threat hunting to understand the full scope of an attack and find its root cause.
- **Respond** to incidents rapidly with built-in orchestration and automation that limits the impact of threats without requiring manual intervention.

Microsoft Sentinel is available in the Microsoft Defender portal, which is the recommended access point and provides a unified security operations experience.

:::image type="content" source="../media/sentinel-in-defender.png" lightbox="../media/sentinel-in-defender.png" alt-text="Screen capture of Microsoft Sentinel in the Microsoft Defender portal.":::

> [!NOTE]
> The Azure portal experience for Microsoft Sentinel will be retired on March 31, 2027. Microsoft Sentinel will be available only in the Microsoft Defender portal after that date.

## Microsoft Sentinel as a platform

Beyond its SIEM capabilities, Microsoft Sentinel provides an extensible security platform built on three core components that support advanced analytics, AI-driven operations, and developer extensibility.

### Microsoft Sentinel data lake

The Microsoft Sentinel data lake is a fully managed, cloud-native data lake purpose-built for security operations. It's the central, unified repository for all security data ingested into Microsoft Sentinel. Key capabilities include:

- **Unified storage**: Centralizes logs from Microsoft 365, Microsoft Defender, Azure, Microsoft Entra ID, Microsoft Purview, Microsoft Intune, and over 350 connectors including AWS and GCP—eliminating data silos.
- **Multi-modal analytics**: Query security data using Kusto Query Language (KQL), graph analytics, and AI-powered notebooks—all on a single copy of open-format data.
- **Cost-efficient retention**: Stores large volumes of security data at scale. Long-term retention enables investigations into persistent threats and the creation of behavioral baselines using months of historical data.

### Microsoft Sentinel graph

Microsoft Sentinel graph models and analyzes complex relationships across assets, identities, activities, and threat intelligence. Rather than searching isolated tables of data, security teams can reason over interconnected data to understand how threats move through an environment. For example, the graph can help you identify which paths an attacker could take from a compromised identity to a critical asset.

### Microsoft Sentinel MCP server

The Microsoft Sentinel model context protocol (MCP) server provides a hosted interface that lets security teams—and AI agents—interact with Microsoft Sentinel data using natural language. It removes the need for schema knowledge or custom coding, which makes AI-driven security operations more accessible and helps security teams build customized automation faster.

## Threat detection capabilities

Microsoft Sentinel uses **analytics rules** to detect threats. These rules query collected data on a regular basis and generate alerts when suspicious activity is found. Related alerts are automatically grouped into **incidents**—case files your security team can assign and investigate.

Detection in Microsoft Sentinel spans three broad approaches:

- **Rule-based detection**: Rules match patterns in your data against known threat signatures and defined conditions. Prebuilt rule templates, designed by Microsoft security experts, are available through the **Content hub** so your team doesn't have to build detection logic from scratch.
- **AI and machine learning detection**: Microsoft Sentinel uses machine learning to establish behavioral baselines and flag unusual deviations. It also uses a correlation engine called **Fusion** that automatically links low-severity signals from multiple sources into high-confidence, actionable incidents—helping surface advanced multistage attacks that individual rules might miss.
- **Threat intelligence matching**: Microsoft Sentinel integrates threat intelligence feeds that identify known malicious IP addresses, domains, and URLs. Ingested data is automatically matched against these indicators to detect activity associated with known threat actors.

Microsoft Sentinel maps detection coverage to the **MITRE ATT&CK® framework**, a global knowledge base of adversary tactics and techniques. This lets you visualize which attack techniques your current rules cover and identify gaps in your defenses.

The **Content hub** is your centralized location to discover and deploy packaged solutions. Each solution bundles multiple content types—data connectors, workbooks, analytics rules, hunting queries, and playbooks—into a single deployment for a complete end-to-end scenario.

# [MITRE ATT&ACK framework](#tab/mitre)
:::image type="content" source="../media/framework-in-defender-v3.png" lightbox="../media/framework-in-defender-v3.png" alt-text="Screen capture of the MITRE ATT&ACK framework integration with Microsoft Sentinel in the Microsoft Defender portal.":::

# [Content hub](#tab/content-hub)
:::image type="content" source="../media/content-hub.png" lightbox="../media/content-hub.png" alt-text="Screen capture of the Microsoft Sentinel content hub showing packaged solutions with analytics rules, workbooks, and playbooks.":::

---

## Threat investigation and hunting

When an analytics rule detects a threat, Microsoft Sentinel aggregates related alerts into **incidents**. An incident is a case file that brings together all relevant evidence—alerts, affected entities, timelines, and context—in one place. Your team can assign, triage, and investigate incidents directly in the Microsoft Defender portal.

:::image type="content" source="../media/unified-incidents.png" lightbox="../media/unified-incidents.png" alt-text="Screen capture of the unified incidents queue in the Microsoft Defender portal showing Microsoft Sentinel and Defender XDR incidents together.":::

For proactive threat detection, Microsoft Sentinel supports **threat hunting**. Rather than waiting for an alert, your security team can run hunting queries across your data to search for suspicious activity that hasn't triggered a rule yet. When a hunting query surfaces a significant finding, you can promote it into a custom analytics rule so it generates alerts automatically in the future.

## Threat response and mitigation

Microsoft Sentinel automates common response tasks so your team can act quickly and consistently.

**Automation rules** let you centrally manage how incidents are handled. You define conditions—such as incident severity, source, or entity type—and specify actions like assigning the incident to an analyst, adding tasks, changing its status, or triggering a playbook.

**Playbooks** are automated workflows built on Azure Logic Apps. They execute a sequence of remediation actions in response to a triggered automation rule. For example, when an incident involving a compromised account is created, a playbook can automatically disable the account, open a ticket in your IT service management system, and notify the security team—all before an analyst even opens the incident. Playbooks can also run on demand, giving analysts a one-click response option for common scenarios.

Together, automation rules and playbooks reduce the time between threat detection and mitigation, and free your security team to focus on complex investigations that require human judgment.
