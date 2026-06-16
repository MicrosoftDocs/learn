Each agent type has a defined ceiling for what Microsoft Purview can cover. Some agent types support DLP and sensitivity labels; others are limited to data classification. Use the coverage matrix to check what's available before you start configuring.

## Coverage by agent type

When you find an active agent, check two things before you start configuring:

- **Parent app**: The agent's parent app determines which Purview capabilities are available. Look up the parent app in the coverage matrix.
- **Compliance management**: All listed agents except Anthropic Claude support auditing, eDiscovery, retention, and Compliance Manager.

Information protection coverage, including sensitivity labels, data loss prevention (DLP), and Insider Risk Management (IRM), varies by agent type.

| AI app and agents | Information protection | Notes |
| --- | --- | --- |
| Microsoft 365 Copilot agents | Full | Sensitivity labels, DLP, IRM, communication compliance |
| Microsoft Security Copilot agents | Limited | Data classification only |
| Copilot in Fabric agents | Limited | Data classification only |
| Microsoft Copilot Studio agents | Partial | Data classification, sensitivity labels, DLP, IRM, communication compliance |
| Microsoft Facilitator agents | Limited | Data classification only |
| Channel Agent in Teams agents | Partial | Data classification, sensitivity labels, DLP |
| Entra-registered agents | Full | Sensitivity labels, DLP, IRM, communication compliance |
| Microsoft Foundry agents | Partial | Data classification, sensitivity labels, DLP, IRM |
| ChatGPT Enterprise agents | Limited | Data classification, IRM |
| Anthropic Claude (Enterprise) agents | None | DSPM and auditing are supported, but no information protection or compliance management capabilities are available. Manage exposure through Defender for Cloud Apps or network-level controls. |

If the parent app only supports data classification, no DLP configuration will cover that agent's interactions. That limitation is a coverage boundary, not a configuration gap.

A Security Copilot agent with no DLP support isn't misconfigured. It's structurally limited. When you hit a coverage boundary like this, document it, shift to detection as the primary control, and accept the residual risk.

## How Agent 365 differs from other agent types

Agent 365 is the agent runtime within Microsoft 365 Copilot that runs custom agents built by users and developers in your organization. It supports the full range of Purview capabilities, which means it's the agent type where your configuration work will be concentrated.

Agent 365 also introduces behavioral differences that affect how sensitivity labels, DLP, and encryption work in practice. These differences determine whether a policy achieves its intended outcome even after you add the agent instance to scope.

## What activates automatically

When someone creates an Agent 365 instance, these capabilities activate without any configuration:

- Auditing of agent interactions
- Data classification, which detects sensitive information in prompts and responses
- Compliance Manager assessments for AI regulations

These capabilities are already active, so you can skip them in your gap assessment.

## What requires explicit configuration

Everything else requires you to include the agent instance in policies the same way you'd include a user. If you skip this step, the capability exists but doesn't apply to the agent:

- Sensitivity labels and encryption permissions
- DLP policies
- Insider Risk Management for Agent 365
- Communication compliance
- eDiscovery sources
- Data lifecycle management and retention

The assumption that current policies automatically cover new agent instances is the most common gap. An agent can be active for months with no policy coverage, and nothing in the system alerts you to that fact. The gap persists silently until an incident reveals it.
