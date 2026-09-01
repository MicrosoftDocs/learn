In the previous unit, you explored where security risks can emerge throughout an AI agent workflow. Reducing those risks begins by defining what an AI agent is, what it can access, and how it is allowed to operate.

Identity and governance provide the foundation for securing AI agents. Together, they help organizations establish trust, control access, and ensure agents operate within approved boundaries.

## Identity and governance at a glance

Identity and governance work together to establish trust and control access for AI agents.

| Security control | Why it matters |
| --- | --- |
| **Identity** | Establish who or what the AI agent is. |
| **Access control** | Define what data, tools, and services the agent can use. |
| **Governance** | Apply organizational rules and policies that guide agent behavior. |
| **Monitoring and auditing** | Track agent activity and support accountability. |

Identity establishes who an AI agent is and what resources it can access. Governance defines the policies and rules that determine how the agent is allowed to use those resources.

Together, these controls help ensure AI agents perform only the tasks they're authorized to complete.

## Assign identity to AI agents

Like users, applications, and services, AI agents require a defined identity before they can securely access organizational resources. Depending on the implementation, this identity might be a managed identity or service principal that allows the agent to authenticate to approved resources.

The following diagram illustrates how an agent can operate with its own identity while interacting with users and applications.

:::image type="content" source="../media/agent-identity.svg" alt-text="Diagram that shows an AI agent identity interacting with user and application identities through Microsoft Entra.":::

Organizations commonly use identity platforms to authenticate users, applications, and AI agents while applying consistent access controls. For example, Microsoft Entra helps organizations manage identities and access across people, applications, and increasingly AI-enabled workloads.

An agent's identity determines how it is authenticated, what resources it can access, and which actions it is authorized to perform. A defined identity also allows organizations to understand which actions an agent performs, helping improve visibility and accountability.

For example, a meeting assistant might use its own managed identity to access approved customer records while remaining restricted from unrelated systems such as payroll or finance.

Microsoft Entra helps establish trusted identities for AI agents by authenticating access to organizational resources. Windows complements these identity controls by helping enforce platform security and runtime protections as AI agents run on Windows devices.

## Scenario: Assigning the right permissions

The meeting assistant needs access to customer documents, Outlook, and Microsoft Teams to complete its assigned tasks.

It doesn't need access to payroll records, financial systems, or administrative settings.

By assigning a defined identity and appropriate permissions, organizations help ensure the agent can complete its work without accessing unrelated resources.

Imagine two AI agents in the same organization:

- One summarizes meeting notes and creates follow-up emails.
- Another manages customer support requests and updates service records.

Although both use AI, they require different identities because they access different data, interact with different systems, and perform different tasks.

By clearly defining identity, organizations can ensure that each agent operates with the appropriate level of access. Without a clearly defined identity, an AI agent could receive broader access than intended, increasing the risk of exposing sensitive data or performing unauthorized actions.

## Apply least privilege access

After an identity is established, organizations determine what the agent is allowed to access.

This approach, known as **least privilege**, grants only the permissions required to complete a task. Limiting access helps reduce the impact of unintended actions and prevents agents from accessing unnecessary data or systems.

For example, an agent that prepares customer meeting materials might need:

- Read access to CRM records.
- Read access to relevant documents.
- Permission to draft an email in Outlook.

It doesn't require full administrative access to every business application.

> [!IMPORTANT]
> Grant AI agents only the minimum required permissions needed to complete their assigned tasks.
>
> Applying the principle of least privilege helps reduce the impact of unintended actions and limits unnecessary access to data and systems.

## Enforce policy-based controls

Identity and permissions define what an AI agent *can* access. Governance defines *how* the agent is expected to behave.

Organizations can apply policies to:

- Define which actions agents are allowed to perform.
- Restrict access to sensitive data or systems.
- Require approval before sending emails to external recipients or completing other sensitive tasks.
- Control how agents interact with external tools and services.

Policies provide consistent guardrails that help AI agents operate safely, even when completing complex or multi-step workflows.

Windows includes centralized management experiences, such as AI components in Windows Settings, that help organizations review installed AI capabilities and manage available agent features alongside other security and device management tools.

The following example illustrates how AI-related settings and agent controls can be managed through a dedicated configuration experience.

:::image type="content" source="../media/agent-settings-control.png" alt-text="Screenshot of Windows AI component settings used to manage agent features and AI-related capabilities.":::

## Monitor and audit agent activity

Security doesn't end after an AI agent is deployed.

Organizations also need visibility into how agents behave over time. Monitoring and auditing capabilities help organizations:

- Track agent activity across workflows.
- Identify unexpected or unusual behavior.
- Investigate security events.
- Support compliance with organizational policies and regulatory requirements.

Continuous monitoring helps organizations maintain visibility into AI agent activity and respond quickly when unexpected behavior occurs, such as repeated failed authentication attempts, access to unexpected resources, or unusual sequences of actions.

## Bringing identity and governance together

Identity and governance establish who an AI agent is, what it can access, and how it is expected to behave.

Together, these controls help organizations:

- Verify an agent's identity before it accesses resources.
- Limit access to only the data, tools, and services required.
- Apply organizational policies that guide agent behavior.
- Monitor agent activity to support visibility, auditing, and compliance.

These foundational controls help organizations reduce risk while enabling AI agents to operate securely.

Even with these controls in place, organizations also need safeguards that protect AI agents while they're running. Runtime protection and containment provide an additional layer of defense by helping isolate agent execution and reducing the impact of unexpected behavior.