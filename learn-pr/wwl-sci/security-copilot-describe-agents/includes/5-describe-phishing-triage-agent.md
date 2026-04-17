Microsoft Security Copilot includes agents embedded in the Microsoft Defender portal to carry out various security operations (SOC) tasks, such as incident triage, investigation, threat hunting, and threat intelligence.


> [!NOTE]
> The list of Security Copilot agents in Microsoft Entra is continually growing. This unit is designed to provide a high-level overview of a few of the Security Copilot agents in Microsoft Entra. Fo more information, refer to training that relates to Microsoft Entra.

> [!NOTE]
> The list of Security Copilot agents in Microsoft Defender is continually growing. This unit is designed to provide a high-level overview of just a few of the Security Copilot agents in Microsoft Defender. For more information related to agents in Microsoft Defender and focused on SOC tasks, see [Defend against cyberthreats with Microsoft's security operations platform](/training/courses/sc-200t00).
> 
### Microsoft Security Copilot agents in Microsoft Defender

The following Microsoft Security Copilot agents are available in the Microsoft Defender portal. Due to the fast pace at which these agents are released and updated, each agent might have features at various stages of availability.

#### Phishing Triage Agent

The [Phishing Triage Agent](/defender-xdr/phishing-triage-agent) helps security operations analysts triage and classify user-submitted phishing incidents. The agent operates autonomously, provides a transparent rationale for its classification verdicts in natural language, and continuously learns and improves its accuracy based on feedback from analysts.

| Attribute | Description |
|-----------|-------------|
| **Identity** | Operates in the context of the user you connect to the agent. |
| **License** | Microsoft Defender for Endpoint P2. |
| **Permissions** | Security data basics (read), Email & collaboration content (read), Email & collaboration metadata (read), Security Copilot (read), and Alerts (manage). |
| **Plugins** | Microsoft Defender XDR, Microsoft Threat Intelligence, and Phishing Triage Agent. |
| **Products** | Security Copilot and Microsoft Defender for Office 365 Plan 2. |
| **Role-based access** | Security Administrator Microsoft Entra role is required to set up and manage the agent. Users with the same permissions as the Phishing Triage Agent can view the agent’s activity and results, and provide feedback on the agent’s classification verdict. |
| **Trigger** | Triggered when a user in your organization submits a phishing incident. |

#### Threat Intelligence Briefing Agent

The [Threat Intelligence Briefing Agent](/defender-xdr/threat-intel-briefing-agent-defender) provides security operations teams with regular, customized threat intelligence briefings. The agent autonomously gathers and synthesizes relevant threat intelligence data from various sources, delivering concise and actionable insights to help analysts stay informed about emerging threats and trends.

| Attribute | Description |
|-----------|-------------|
| **Identity** | Requires connection to an existing user account or creation of a new agent identity. |
| **License** | Not applicable. |
| **Permissions** | Required: Microsoft Defender for Endpoint, Security Reader. Optional: Exposure Management (read). |
| **Plugins** | Required: Microsoft Threat Intelligence, Microsoft Threat Intelligence agents. Optional: Microsoft Defender External Attack Surface Management. |
| **Products** | Security Copilot. |
| **Role-based access** | Security Administrator role is required to set up and manage the agent. Users with the same permissions as the Threat Intelligence Briefing Agent can view the agent’s activity and results. |
| **Trigger** | Runs at the set time interval configured during setup, or manually. |

#### Threat Hunting Agent

The [Threat Hunting Agent](/defender-xdr/advanced-hunting-security-copilot-threat-hunting-agent) enables you to investigate threats using natural language from start to finish. It not only generates Kusto Query Language (KQL) queries but also interprets results, surfaces insights, and guides you through full hunting sessions. These capabilities empower you to hunt threats faster, more accurately, and with greater confidence.

#### Dynamic Threat Detection Agent

The [Dynamic Threat Detection Agent](/defender-xdr/dynamic-threat-detection-agent) in the Defender portal is an always-on, adaptive backend service that uncovers hidden threats across Defender and Microsoft Sentinel environments. It uses AI to identify gaps and uncover false negatives by correlating alerts, events, anomalies, and threat intelligence. When the agent identifies a gap, it generates a dynamic alert with the full context in the alert details, including natural language explanations, mapped MITRE ATT&CK techniques, and tailored remediation steps.

