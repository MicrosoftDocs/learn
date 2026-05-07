Microsoft Entra agents can automate many identity and access management operations in your organization to help reduce manual workloads. These agents work seamlessly with Microsoft Security Copilot to automate repetitive tasks, provide suggestions, and help administrators focus on higher-value strategic work.

Microsoft Entra agents analyze your identity environment, apply best practices, and take automated actions to improve your identity and access security posture and operational efficiency. They integrate directly with Microsoft Entra services, using your organization's identity data and configuration to provide contextual, actionable insights.

> [!NOTE]
> The list of Security Copilot agents in Microsoft Entra is continually growing. This unit is designed to provide a high-level overview of a few of the Security Copilot agents in Microsoft Entra. For more information, see training that relates to Microsoft Entra.

### What are Microsoft Entra agents?

Microsoft Entra agents are AI-powered tools that operate in your organization's identity environment to automate and optimize identity and access management tasks. The agents are grounded in the concepts and tasks for a specific product area, like Conditional Access. These agents can:

- **Automate routine tasks**: Handle time-consuming, repetitive identity and access management operations.
- **Provide suggestions**: Analyze your environment and suggest improvements based on Microsoft best practices and Zero Trust principles.
- **Operate autonomously**: Run on schedules or triggers to continuously monitor and optimize your identity infrastructure.
- **Integrate seamlessly**: Work within your organization's existing Microsoft Entra workflows.
- **Learn and adapt**: Improve suggestions over time, based on your environment and feedback.

Each agent analyzes your current environment within the boundaries of its capabilities. If the agent identifies a gap, opportunity, or potential issue, it can take action on your behalf. Each agent provides the context, reasoning, and activity history for how it came up with the suggestion. Administrators can configure the agent to run automatically or trigger the agent to run manually.

Because each agent performs a specific set of tasks, it needs a specific set of configurations to operate within the boundaries of that task. The administrator also needs certain Microsoft Entra roles to set up and manage the agent. Key configuration elements include:

- **Agent identity**: A unique agent identity is created when the agent is turned on.
- **Roles** — Specific Microsoft Entra built-in roles are needed to turn on, view, and interact with the agent. Not all roles can perform the same tasks with an agent.
- **Permissions**: The agent identity is granted specific read and write permissions needed to perform its tasks. These permissions can't be changed or removed.
- **Role-based access**: The administrator needs specific roles to set up, manage, and use the agent.

### Available Microsoft Entra agents

The following agents are currently available for Microsoft Entra. Due to the fast pace at which these agents are released and updated, each agent might have features at various stages of availability. Preview features are added frequently.

#### Conditional Access Optimization Agent

The Conditional Access Optimization Agent ensures comprehensive user protection by analyzing your Conditional Access policies and recommending improvements. The agent evaluates your current policy configuration against Microsoft best practices and Zero Trust principles.

The agent scans your tenant for new users, applications, and agent identities from the last 24 hours and determines if Conditional Access policies are applicable. If the agent finds unprotected users, applications, or agent identities, it provides suggested next steps, such as turning on or modifying a Conditional Access policy. You can review the suggestion, how the agent identified the solution, and what would be included in the policy. The agent doesn't make changes to existing policies unless an administrator explicitly approves the suggestion, and all new policies suggested by the agent are created in report-only mode.

Policy suggestions identified by the agent include:

- **Require MFA**: Identifies users who aren't covered by a Conditional Access policy that requires multifactor authentication.
- **Require device-based controls**: Enforces device compliance, app protection policies, and domain-joined device requirements.
- **Block legacy authentication**: Blocks user accounts from signing in with legacy authentication.
- **Block device code flow**: Checks for a policy blocking device code flow authentication.
- **Risky users**: Suggests a policy to require secure password change for high-risk users. Requires Microsoft Entra ID P2.
- **Risky sign-ins**: Suggests a policy to require multifactor authentication for high-risk sign-ins. Requires Microsoft Entra ID P2.
- **Risky agents**: Suggests a policy to block authentication for high-risk agent sign-ins. Requires Microsoft Entra ID P2.
- **Policy consolidation**: Identifies overlapping settings across policies and suggests consolidating them.
- **Deep analysis**: Analyzes policies for outlier exceptions that could lead to coverage gaps or possible lockout.

| Attribute | Description |
|-----------|-------------|
| **Identity** | A unique agent identity for authorization is created when the agent is turned on. The agent uses this identity to scan your tenant's Conditional Access policies and configurations for gaps, overlap, and misconfigurations. |
| **Licenses** | Microsoft Entra ID P1. |
| **Plugins** | Microsoft Entra. |
| **Products** | Microsoft Entra Conditional Access. |
| **Role-based access** | Security Administrator to configure the agent. Conditional Access Administrator to use the agent. |
| **Trigger** | Runs every 24 hours or triggered manually. |

#### Identity Risk Management Agent (Preview)

The Identity Risk Management Agent in Microsoft Entra ID Protection helps administrators investigate potential risks, understand their effect, and take decisive action to protect their organization's critical assets. IT administrators and security analysts often face overwhelming volumes of alerts and struggle to prioritize which risks need immediate attention.

When the agent runs, it checks for new risky users in your tenant who currently have a risk state of "At risk." If the agent identifies risky users within your defined scope, it investigates the user's risky sign-ins and risk detections, generates findings with a thorough risk summary, and recommends a remediation action. Administrators can ask the agent questions related to risky users through chat and provide custom instructions that the agent stores in its memory for future runs. Agent suggestions require manual admin approval—automatic remediation isn't supported at this time.

| Attribute | Description |
|-----------|-------------|
| **Identity** | Uses Microsoft Entra Agent ID for authorization. |
| **Licenses** | Microsoft Entra Agent ID. Microsoft Entra ID P2 is also required. |
| **Plugins** | Microsoft Entra. |
| **Products** | Security Copilot and Microsoft Entra ID Protection. |
| **Role-based access** | Security Administrator to activate and take action. Security Reader and Global Reader can view the agent and suggestions but can't take actions. |
| **Trigger** | Runs every 24 hours, triggered manually, or continuous monitoring. |

### Prerequisites for Microsoft Entra agents

All Microsoft Entra agents require available security compute units (SCUs) in your tenant. On average, each agent run consumes less than one SCU. Security Copilot requires that at least one SCU is provisioned, which is billed monthly even if no SCUs are consumed.

You also need to sign in to the Microsoft Entra admin center using the least-privileged role required for the agent you want to configure. Agents are accessed from the **Agents** section in the Microsoft Entra admin center.

### Discover agents in the Security Store

Security Store is embedded in the Microsoft Entra admin center, providing a centralized place to discover, purchase, and deploy Microsoft and partner-built agents and solutions. You can browse available agents and solutions, view details and requirements, and start the deployment process directly from the Microsoft Entra admin center.
