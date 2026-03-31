Microsoft Entra agents can automate many identity and access management operations in your organization to help reduce manual workloads. These agents work seamlessly with Microsoft Security Copilot to automate repetitive tasks, provide suggestions, and help administrators focus on higher-value strategic work.

Microsoft Entra agents analyze your identity environment, apply best practices, and take automated actions to improve your identity and access security posture and operational efficiency. They integrate directly with Microsoft Entra services, using your organization’s identity data and configuration to provide contextual, actionable insights.

> [!NOTE]
> The list of Security Copilot agents in Microsoft Entra is continually growing. This unit is designed to provide a high-level overview of a few of the Security Copilot agents in Microsoft Entra. Fo more information, refer to training that relates to Microsoft Entra.

### What are Microsoft Entra agents?

Microsoft Entra agents are AI-powered tools that operate in your organization’s identity environment to automate and optimize identity and access management tasks. The agents are grounded in the concepts and tasks for a specific product area, like Conditional Access. These agents can:

- **Automate routine tasks** - Handle time-consuming, repetitive identity and access management operations.
- **Provide suggestions** - Analyze your environment and suggest improvements based on Microsoft best practices and Zero Trust principles.
- **Operate autonomously** - Run on schedules or triggers to continuously monitor and optimize your identity infrastructure.
- **Integrate seamlessly** - Work within your organization’s existing Microsoft Entra workflows.
- **Learn and adapt** - Improve suggestions over time, based on your environment and feedback.

Each agent analyzes your current environment within the boundaries of its capabilities. If the agent identifies a gap, opportunity, or potential issue, it can take action on your behalf. Each agent provides the context, reasoning, and activity history for how it came up with the suggestion. Administrators can configure the agent to run automatically or trigger the agent to run manually.

Because each agent performs a specific set of tasks, it needs a specific set of configurations to operate within the boundaries of that task. The administrator also needs certain Microsoft Entra roles to set up and manage the agent. Key configuration elements include:

- **Agent identity**: A unique agent identity is created when the agent is turned on.
- **Roles**: Specific Microsoft Entra built-in roles are needed to turn on, view, and interact with the agent. Not all roles can perform the same tasks with an agent.
- **Permissions**: The agent identity is granted specific read and write permissions needed to perform its tasks. These permissions can’t be changed or removed.

### Available Microsoft Entra agents

The following agents are currently available for Microsoft Entra. Due to the fast pace at which these agents are released and updated, each agent might have features at various stages of availability.

#### Conditional Access Optimization Agent

The [Conditional Access Optimization Agent](/entra/security-copilot/conditional-access-agent-optimization) ensures comprehensive user protection by analyzing your Conditional Access policies and recommending improvements. The agent evaluates your current policy configuration against Microsoft best practices and Zero Trust principles.

| Attribute | Description |
|-----------|-------------|
| **Identity** | A unique agent identity for authorization is created when the agent is turned on. The agent uses this identity to scan your tenant’s Conditional Access policies and configurations for gaps, overlap, and misconfigurations. |
| **Licenses** | Microsoft Entra ID P1. |
| **Plugins** | Microsoft Entra (mandatory). |
| **Products** | Microsoft Entra Conditional Access. |
| **Role-based access** | Security Administrator to configure the agent. Conditional Access Administrator to use the agent. |
| **Trigger** | Runs every 24 hours or triggered manually. |

#### Access Review Agent

The [Access Review Agent](/entra/id-governance/access-review-agent) with Microsoft Entra ID Governance empowers reviewers to make fast and accurate access decisions. It delivers insights and recommendations so reviewers can complete their work through a simple conversation, right inside Microsoft Teams.

| Attribute | Description |
|-----------|-------------|
| **Identity** | A unique agent identity for authorization is created when the agent is turned on. The agent uses this identity to scan your tenant for active access reviews, gather insights, and save its recommendations. Final decisions, submitted through the Microsoft Teams conversation, use the reviewer’s identity. |
| **Licenses** | Microsoft Entra ID Governance or Microsoft Entra Suite. |
| **Plugins** | Microsoft Entra (mandatory). |
| **Products** | ID Governance Access Reviews. |
| **Role-based access** | Both Identity Governance Administrator and Lifecycle Workflows Administrator are required to configure and use the agent. |
| **Trigger** | Runs every 24 hours or triggered manually. |

#### Identity Risk Management Agent (preview)

The [Identity Risk Management Agent](/entra/id-protection/identity-risk-management-agent-get-started) in Microsoft Entra ID Protection helps administrators investigate potential risks, learn about potential effects, and take decisive action to protect their organization's critical assets.

| Attribute | Description |
|-----------|-------------|
| **Identity** | Uses Microsoft Entra Agent ID for authorization. |
| **Licenses** | Microsoft Entra Agent ID. |
| **Plugins** | Microsoft Entra (mandatory). |
| **Products** | Security Copilot and Microsoft Entra ID Protection. |
| **Role-based access** | Security Administrator. |
| **Trigger** | Runs every 24 hours, triggered manually, or continuous monitoring. |


