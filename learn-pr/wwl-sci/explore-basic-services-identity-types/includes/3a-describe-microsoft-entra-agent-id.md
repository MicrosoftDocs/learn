As organizations deploy AI agents to automate tasks and enhance productivity, these agents need secure identities to authenticate and access resources, just like human users and traditional applications. Microsoft Entra Agent ID provides an identity and security framework designed specifically for AI agents operating in enterprise environments.

### Why AI agents need dedicated identities

AI agents differ from traditional applications in important ways. They make dynamic decisions, adapt behavior based on context, and can operate autonomously. Unlike an application that executes predetermined logic, an AI agent might analyze data, take actions, and interact with other systems or agents on its own. These characteristics create unique security challenges:

- **Expanded attack surface**. AI agents often interact with external systems, creating potential pathways for adversaries. Agents are also vulnerable to attacks like prompt injection that don't affect traditional applications.
- **Permission risks**. Agents are often provisioned with broad permissions. Without proper controls, an agent might access more data or take more actions than necessary for its intended task.
- **Agent sprawl**. Uncontrolled expansion of agents across an organization, without adequate visibility, management, or lifecycle controls, can lead to security and compliance risks. Agents created for temporary purposes may remain in production indefinitely, with permissions that are rarely reviewed.

These challenges make it important to distinguish AI agent identities from traditional user and workload identities, so organizations can apply the right level of governance.

### How Microsoft Entra Agent ID works

Microsoft Entra Agent ID is built on the Microsoft Entra ID platform and provides dedicated identity constructs for AI agents. The framework introduces two key concepts:

- **Agent identity blueprints** serve as reusable templates that define a type or class of agent. A blueprint establishes agent classification, holds the credentials used to create agent instances, and enables administrators to apply policies to all agents of that type. For example, an organization might create a blueprint for "Sales Assistant Agent" that defines what permissions all sales assistant agents receive.

- **Agent identities** are individual instances created from a blueprint. Each agent identity has a unique identifier in Microsoft Entra ID, a display name, and a sponsor, which is the human user or group accountable for the agent. Agent identities don't have their own credentials. Instead, they rely on the blueprint to acquire authentication tokens on their behalf.

This blueprint-to-identity model enables centralized management while providing the flexibility needed for diverse AI agent deployment scenarios. Administrators can apply conditional access policies, disable permissions, or audit agents at scale through blueprint-based controls.

:::image type="content" source="../media/3a-agent-id-blueprint-identity-model.png" alt-text="Diagram showing an Agent Identity Blueprint on the left connected by an arrow to three Agent Identity instances on the right, with blueprint-based governance controls listed below." lightbox="../media/3a-agent-id-blueprint-identity-model.png":::

### Authentication scenarios

Agent identities support two key authentication patterns:

- **Attended (on-behalf-of)**. The agent operates on behalf of a human user, using delegated permissions that the user grants. The agent acts under the user's authority to access resources or APIs.
- **Unattended**. The agent acts under its own authority as an autonomous identity. It uses its own assigned roles and permissions to authenticate and operate independently without a user present.

### Governance and security

Microsoft Entra Agent ID integrates with existing Microsoft Entra security capabilities to protect agent access:

- **Conditional access** enables policy-based access controls and risk-based authentication specifically for agents. Administrators can create policies that evaluate agent risk before granting access.
- **Identity protection** provides real-time risk detection and automated response for agent activities.
- **Identity governance** provides lifecycle management, including access assignment and compliance reporting for agent identities. Sponsors and owners maintain accountability throughout the agent's lifecycle.
- **Agent registry** provides centralized metadata management and secure agent discovery, helping organizations maintain visibility into all agents operating in their tenant.

Microsoft Entra ID also limits what agent identities can do. Agents are blocked from being granted many high-privilege roles or permissions, and users and administrators can't consent to powerful permissions for an agent. This design follows the principle of least privilege, minimizing the risk that an AI agent could escalate access or perform unexpected administrative actions.
