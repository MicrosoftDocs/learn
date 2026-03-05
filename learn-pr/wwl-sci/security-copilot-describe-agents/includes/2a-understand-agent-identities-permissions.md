Agents in Microsoft Security Copilot need an identity to authenticate and access resources when they run. The identity determines what data the agent can access and what actions it can perform.

### Types of agent identities

During agent setup, you choose from two identity types.

#### Agent identities (Microsoft Entra Agent ID)

An agent identity is a dedicated identity created specifically for an AI agent using the Microsoft Entra Agent ID capability. These identities provide unique identification and authentication for AI agents and help address key security challenges:

- Distinguishing AI agent operations from those of workforce, customer, or workload identities.
- Granting agents right-sized access across systems.
- Preventing agents from gaining access to the most critical security roles.
- Scaling identity management for agents that might be rapidly created and retired.

When you create an agent identity, you grant it only the specific permissions needed. Organizations can create agent identities in bulk, apply consistent policies, and retire agents without leaving orphaned credentials behind.

> [!NOTE]
> Currently, the option to create an agent identity is only available for Microsoft-built agents.

#### Existing user account

This option lets the agent use an existing user's credentials. The agent inherits that user's access and permissions while active, meaning it can access the same data and services as the connected account.

### How agent identities differ from other identity types

- **Versus application identities** - Application identities (service principals) in Microsoft Entra ID are designed for long-lived services with stable ownership. Agents are often created dynamically and may exist only briefly. Agent identities are built for this scale and ephemerality, reducing the operational complexity of managing short-lived autonomous systems.
- **Versus human user identities** - Human identities are tied to authentication mechanisms like passwords, multifactor authentication, and passkeys, and have associated data like mailboxes and organizational hierarchy. Agent identities represent software systems, not human beings, and don't use human authentication mechanisms.

### What agent identities enable

An AI agent can use its identity to:

- **Access web services**—Request access tokens from Microsoft Entra to call Microsoft Graph, organization-built services, or non-Microsoft APIs.
- **Autonomous access**—Act independently using rights assigned directly to the agent identity, including Microsoft Graph permissions, Azure role-based access control (RBAC) roles, and Microsoft Entra directory roles.
- **Delegated access**—Act on behalf of a human user, using rights the user controls and delegates.
- **Authenticate incoming messages**—Accept and validate requests from other clients, users, or agents using Microsoft Entra access tokens.

### Permissions for agents

Permissions define the authorization level an agent is given during configuration, enabling it to access specific information or carry out its tasks. These might include reading data from solutions like Microsoft Defender External Attack Surface Management or Microsoft Threat Intelligence.

When an agent identity is created, the required permissions are assigned automatically. For example, the Conditional Access Optimization Agent receives permissions like `Policy.Read.All`, `User.Read.All`, and `RoleManagement.Read.Directory`.

### Role-based access control and agents

RBAC determines who can view and manage agent outputs in Security Copilot. The Security Copilot platform defines two roles:

- **Security Copilot owner**—Set up agents, manage settings, assign permissions, and perform all platform tasks. Build, test, and publish agents at workspace scope.
- **Security Copilot contributor**—Run agents, create sessions, and interact with agent outputs. Build, test, and publish agents at user scope.

These roles are managed within Security Copilot and are separate from Microsoft Entra ID roles. They control platform access only and don't grant access to security data by themselves. The data an agent can access is still governed by the user's existing Microsoft Entra and Azure RBAC roles—Security Copilot never exceeds the access a user already has.

### Partner agent permissions

Setting up a partner-built agent that accesses Microsoft product data (such as Microsoft Intune, Microsoft Entra, Microsoft Sentinel, or Microsoft Defender) requires a Global Administrator to approve the required permissions. After approval, Security Copilot owners and contributors can complete the agent setup. Agents that don't access Microsoft product data don't require this approval.
