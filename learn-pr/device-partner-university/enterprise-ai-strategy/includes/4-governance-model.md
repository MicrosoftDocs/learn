Once an organization understands what can change when an AI agent can act on behalf of users, it needs a consistent way to govern that activity.

There are three connected areas of agent governance:

- **Containment**: Establish boundaries around where an agent can run and how much impact its actions can have.
- **Identity**: Establish how an agent is identified, authenticated, and authorized.
- **Management**: Apply governance, visibility, and policy controls to agent activity.

Together, these areas provide a foundation for determining how an agent is identified, what it can access and do, and how its activity is governed over time.

## Containment

Before granting agents access to organizational resources, enterprises should establish containment controls that define the boundaries within which an agent operates.

Organizations can consider:

- How much isolation does the workload require?
- What level of trust should be placed in the workload?
- What could happen if the agent behaves unexpectedly?

Microsoft's approach to containment combines per-agent identity, OS-level containment through Microsoft Execution Containers (MXC), and workload isolation. Each agent is assigned its own identity, separate from the user it works for, enabling it to be governed independently. MXC is designed to provide OS-level isolation for supported agent workloads. Together with distinct agent identities and workload-specific permissions, this isolation can help establish boundaries around the resources an agent can access while it’s running. Workload isolation further constrains what the agent can access and do by ensuring it operates within a controlled environment.

Organizations can begin with tighter containment boundaries and adjust them over time as they gain confidence in how a workload operates within their environment. These controls help organizations reduce risk while still allowing agents to perform their intended tasks.

## Identity

Identity establishes how an agent is identified and what it's authorized to access.

An organization should be able to distinguish agent activity from user activity and apply appropriate permissions to the agent.

Consider:

- What systems does the agent need to access?
- What permissions are required for its assigned tasks?
- Can the agent have an identity separate from the user it works for?
- Can administrators trace activity back to the agent?

A distinct agent identity can help organizations apply access controls, support accountability, and maintain visibility into agent activity.

Microsoft Entra provides the identity foundation for AI agents. Through Microsoft Entra Agent ID in [Microsoft Agent 365](https://www.microsoft.com/microsoft-agent-365?msockid=14086aee93bb67a61bec7c3d922a6698), Microsoft's control plane for managing and governing AI agents, organizations can assign agents with unique identities that enable authentication, authorization, monitoring, governance, and auditing. This allows enterprises to:

- Manage agent identities using familiar identity controls.
- Apply role-based and conditional access policies.
- Monitor runtime activity for anomalies.
- Maintain auditable records of agent interactions and actions.

## Management

Management provides visibility, governance, and policy-based oversight for AI agents.

Organizations need ways to:

- Monitor agent activity.
- Apply security policies and governance controls.
- Determine which actions are allowed, blocked, or elevated.
- Maintain visibility into human-to-agent and agent-to-agent interactions.
- Audit agent behavior and activity over time.

Microsoft Intune and Microsoft Agent 365 help organizations manage AI agents through policy enforcement, governance controls, and operational visibility. Security policies can be used to establish guardrails for agent behavior, while governance capabilities help organizations monitor agent activity and maintain oversight. Organizations can also define rules that determine whether actions are allowed, blocked, or elevated for additional review, helping ensure agents operate within established organizational boundaries.

As agents act, operational signals can be collected to create an auditable record of activity, helping organizations understand what an agent does, when it acts, and how it interacts with users, systems, and other agents.

Management helps organizations move beyond simply deploying agents to maintaining ongoing oversight, accountability, and governance throughout the agent lifecycle.

## Bringing the three areas together

Containment, identity, and management answer different governance questions:

| Governance area | Key question |
| ---------------- | -------------- |
| **Containment** | Where can the agent operate, and how much impact can its activity have? |
| **Identity** | Who or what is the agent, and what is it authorized to access? |
| **Management** | How is the agent governed, monitored, and audited? |

These different governance areas work together to provide comprehensive oversight and management of AI agents. For example, an organization might give an agent a distinct identity, isolate its workload through containment controls, apply policies that govern its actions, and maintain visibility into its activity through centralized management tools.

The controls an organization applies should depend on the agent being governed. The next unit explores how organizations can determine the appropriate governance approach for different types of agents.
