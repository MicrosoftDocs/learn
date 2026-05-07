Microsoft Security Copilot includes agents embedded in the Microsoft Defender portal to carry out various security operations (SOC) tasks, such as incident triage, investigation, threat hunting, and threat intelligence. These agents are available in the Security Store within the Microsoft Defender portal, and they integrate with Microsoft Defender to autonomously perform tasks that accelerate SOC workflows.

> [!NOTE]
> The list of Security Copilot agents in Microsoft Defender is continually growing. This unit is designed to provide a high-level overview of the Security Copilot agents in Microsoft Defender.

### Microsoft Security Copilot agents in Microsoft Defender

The following Microsoft Security Copilot agents are available in the Microsoft Defender portal. Due to the fast pace at which these agents are released and updated, each agent might have features at various stages of availability.

#### Security Alert Triage Agent

The [Security Alert Triage Agent](/defender-xdr/security-alert-triage-agent) is an autonomous agent that helps security teams triage alerts at scale. It applies AI-driven, dynamic reasoning across evidence to deliver clear verdicts for supported security workloads. By identifying which alerts represent real attacks and which are false positives, the agent enables analysts to focus on investigating real threats.

The Security Alert Triage Agent is the same agent as the Phishing Triage Agent. While initially focused on triaging user-reported phishing emails, the agent has been extended to triage a broader set of alerts, including identity and cloud alerts. Email and collaboration alert triage capabilities are generally available, while the expanded identity and cloud alert capabilities are in preview.

Key capabilities of the Security Alert Triage Agent include:

- **Autonomous triage**: Uses advanced AI tools to evaluate alerts and determine whether they represent malicious activity or false alarms, without requiring step-by-step human input.
- **Transparent rationale**: Records classification verdicts and provides supporting reasoning in natural language and visual graphs, including the evidence used to reach each conclusion.
- **Learning based on feedback**: For supported alert types, the agent can incorporate analyst feedback when explicitly provided and approved, to tune its verdict analysis. This capability is currently available for email and collaboration alerts only.

| Attribute | Description |
|-----------|-------------|
| **Identity** | Operates in the context of the user you connect to the agent. |
| **License** | Microsoft Defender for Office P2. |
| **Permissions** | Security data basics (read), Alerts (manage), Security Copilot (read), Email & collaboration metadata (read), and Email & collaboration content (read). |
| **Plugins** | Microsoft Defender XDR, Microsoft Threat Intelligence, and Security Alert Triage Agent. |
| **Products** | Security Copilot and Microsoft Defender for Office 365 Plan 2. |
| **Role-based access** | Security Administrator Microsoft Entra role is required to set up and manage the agent. Users with the same permissions as the agent can view its activity and results, and provide feedback on the agent's classification verdict. |
| **Trigger** | Runs automatically when a new alert is detected, after a user reports an email. |

#### Threat Intelligence Briefing Agent

The [Threat Intelligence Briefing Agent](/defender-xdr/threat-intel-briefing-agent-defender) generates threat intelligence briefings based on the latest threat actor activity and both internal and external vulnerability information. The agent uses dynamic automation and deep generative AI along with its wealth of threat intelligence knowledge and signals. When building the briefing, the agent dynamically chooses the next step based on the outcome of the previous step, allowing it to decide in real-time what threat intelligence to include and prioritize. The agent then translates this technical information into a digestible report that various audiences can consume. The agent is best suited for customers who turn on Microsoft Defender for Endpoint and Microsoft Defender External Attack Surface, as it relies on signals from these integrations for accurate, context-rich reports.

| Attribute | Description |
|-----------|-------------|
| **Identity** | Requires connection to an existing user account or creation of a new agent identity. |
| **License** | Not applicable. |
| **Permissions** | Required: Microsoft Defender for Endpoint, Security Reader. Optional: Exposure Management (read). |
| **Plugins** | Required: Microsoft Threat Intelligence, Microsoft Threat Intelligence agents. Optional: Microsoft Defender External Attack Surface Management. |
| **Products** | Security Copilot. |
| **Role-based access** | Security Administrator role is required to set up and manage the agent. Users with the same permissions as the agent can view the agent's activity and results. |
| **Trigger** | Runs at the time interval configured during setup, or manually. |

#### Threat Hunting Agent

The [Threat Hunting Agent](/defender-xdr/advanced-hunting-security-copilot-threat-hunting-agent) is an AI-powered conversational threat hunting agent that transforms complex data into actionable insights. Unlike traditional hunting methods that rely heavily on Kusto Query Language (KQL) expertise, the Threat Hunting Agent enables you to investigate threats using natural language from start to finish. It not only generates KQL queries but also interprets results, surfaces insights, and guides you through full hunting sessions.

Key capabilities include:

- **Natural language to natural language answer**: Ask data-related questions in natural language and receive direct conversational answers backed by KQL queries and tabular results.
- **Conversational flow**: The agent maintains context throughout your hunting session, enabling follow-up questions that build on previous ones.
- **Observations**: The agent provides natural language observations and charts (pie, timeline, or vertical bar) to simplify result analysis.
- **Insight generation**: The agent surfaces additional contextual insights from related data sources to enrich investigations, helping discover connections and patterns that might otherwise be missed.
- **Smart suggestions**: Provides dynamic follow-up questions and remediation action recommendations in the context of the investigation.

#### Dynamic Threat Detection Agent

The [Dynamic Threat Detection Agent](/defender-xdr/dynamic-threat-detection-agent) in the Defender portal is an always-on, adaptive backend service that uncovers hidden threats across Defender and Microsoft Sentinel environments. It uses AI to identify gaps and uncover false negatives by correlating alerts, events, anomalies, and threat intelligence. When the agent identifies a gap, it generates a dynamic alert with the full context in the alert details, including natural language explanations, mapped MITRE ATT&CK techniques, and tailored remediation steps.

Key benefits include:

- **Find what traditional detection rules miss**: The agent's adaptive AI-driven detection continuously investigates across Defender and Microsoft Sentinel signals to uncover false negatives and detection gaps.
- **Reduce noise and increase confidence**: Minimizes SOC noise and boosts analyst confidence with customer-validated precision and clear risk context.
- **Always on and zero-touch**: Runs in the Defender backend, automatically generating alerts into existing Defender workflows with no tuning or onboarding required.
- **Deep integration across the Microsoft security ecosystem**: Works with Security Copilot, Defender, and Microsoft Sentinel, correlating native and non-Microsoft signals to surface missed behaviors and deliver richer context across your SOC workflows.

#### Security Analyst Agent

The [Security Analyst Agent](/copilot/security/security-analyst-agent) helps security analysts quickly identify, assess, and prioritize risks. The agent performs ready-to-use or custom analyses on security data from Microsoft Defender XDR, Microsoft Sentinel Log Analytics, or Microsoft Sentinel Data Lake, providing actionable and prioritized insights, recommendations, and reports.

Key capabilities include:

- **Flexible analysis**: Perform pattern analysis, anomaly detection, clustering, risk scoring, and forecasting to uncover hidden risks.
- **Data integration**: Analyze data from Microsoft Defender XDR, Microsoft Sentinel Log Analytics, or Microsoft Sentinel Data Lake based on your instructions.
- **Interactive exploration**: Visualize data to spot anomalies and risks faster.
- **Conversation assistance**: Chat with the agent, ask follow-up questions, and perform related analyses to deepen understanding.

The Security Analyst Agent is accessible in the Advanced hunting experience in Microsoft Defender. It generates prioritized insights with full evidence for defensibility and can perform single or multistep analysis on large volumes of data.
