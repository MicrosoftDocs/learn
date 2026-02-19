Microsoft Entra Agent ID is a specialized identity type in Microsoft Entra ID designed specifically for AI agents. It provides a standardized framework for governing, authenticating, and authorizing AI agents across Microsoft services. This framework enables agents to securely access resources, interact with users, and communicate with other systems.

An **agent identity** is a special service principal in Microsoft Entra ID that represents an identity created and managed by an agent identity blueprint. Agent identities authenticate by presenting access tokens issued to the service or platform on which the agent runs.

## Key components: Agent identities and agent identity blueprints

The Agent ID platform introduces two key components:

### Agent identity

An agent identity is the primary account used by an AI agent to authenticate to various systems. Key characteristics include:

- **Unique identifiers**: Each agent identity has an object ID and app ID (which have the same value) for authentication and authorization decisions
- **No passwords**: Agent identities don't have passwords or other direct credentials
- **Token-based authentication**: They can only authenticate by presenting an access token issued to the service or platform on which the agent runs
- **Optional agent user**: For scenarios requiring a user object, agents can have an **agent user** - a secondary account that is a user object in the tenant

### Agent identity blueprint

An agent identity blueprint serves as the reusable, governing template from which all associated agent identities are created. It corresponds to a "kind," "type," or "class" of agents. Think of it as the management object for all agent identity instances of that class.

Agent identity blueprints serve four essential purposes:

- **Type classification**: Establishes the category of agent (for example, "Sales Assistant Agent"), enabling administrators to apply policies, disable permissions, or audit agents at scale
- **Template for creation**: Defines common characteristics shared across all agent identities, including description, app roles, verified publisher, and authentication settings
- **Credential holder**: Holds OAuth credentials (client ID, secrets, certificates, or federated credentials) used to request tokens from Microsoft Entra ID
- **Container for management**: Provides a logical container where administrators can apply policies, permissions, and controls that affect all agent identities created from the blueprint

## Impersonation model

Agent identities use an impersonation model where the agent identity blueprint obtains tokens for the agent identity. How is the model different from traditional service principals access?

- The blueprint has OAuth credentials and uses them to request access tokens from Microsoft Entra ID
- The blueprint then presents that token to obtain a token for one of its agent identities
- The resulting tokens maintain the agent identity in audit logs while the blueprint orchestrates token flows

## Comparing agent identities to service principals

While agent identities are technically a special type of service principal, they have important differences:

| Aspect | Service Principal | Agent Identity |
|--------|------------------|----------------|
| **Credential management** | Manages own credentials (certificates, secrets, managed identities) | No direct credentials; relies on parent blueprint credentials |
| **Token acquisition** | Presents credentials to obtain tokens for itself | Blueprint uses impersonation to obtain tokens on its behalf |
| **Relationship model** | One-to-one with application | One-to-many (blueprint to multiple identities) |
| **Permission model** | Direct assignment or admin consent | Direct assignment + inheritance from parent blueprint |
| **Runtime authentication** | Performs direct authentication | Doesn't perform direct authentication |

## Comparing agent identities to managed identities

Managed identities are another type of identity used for Azure resources:

| Aspect | Managed Identity | Agent Identity |
|--------|-----------------|----------------|
| **Purpose** | Provides identity for Azure resources (virtual machines, App Service, etc.) | Provides identity specifically for AI agents |
| **Lifecycle** | Tied to Azure resource (system-assigned) or standalone (user-assigned) | Created dynamically for AI agents, can be short-lived |
| **Scale** | Designed for infrastructure resources | Designed to scale to thousands of ephemeral agents |
| **Credential management** | Azure automatically manages credentials | Blueprint manages credentials; agents have none |
| **Multi-instance** | One identity per resource or shared across resources | One blueprint creates many agent identities |
| **Use case** | Azure service-to-service authentication | AI agent authentication across Microsoft services |

## Security benefits of agent identities

Agent identities provide specific security benefits designed for AI agents:

- **Distinguish AI operations**: Operations performed by AI agents are clearly separated from operations performed by workforce, customer, or traditional workload identities in audit logs and monitoring
- **Right-sized access**: Enable AI agents to gain appropriate access across systems without excessive permissions
- **Prevent excessive privilege**: Block agents from accessing critical security roles and systems
- **Scale identity management**: Support large numbers of AI agents that can be quickly created and destroyed without leaving orphaned credentials

## Authentication scenarios

Agent identities support two key authentication scenarios:

### Attended (delegated access or on-behalf-of flow)

The agent operates on behalf of a human user, using delegated permissions that the user grants. The agent acts under the user's authority to access resources or APIs as that user. This scenario is common for interactive agents that respond to user prompts in a chat interface.

### Unattended (autonomous operation)

The agent acts under its own authority as a service or application identity using its app-assigned roles, RBAC, or Microsoft Graph permissions. Alternatively, it can act as an **agentic user** - an autonomous identity with user-like claims that allows the agent to authenticate and operate independently.

## High-privilege roles blocked for agents

To maintain security, Microsoft Entra Agent ID blocks certain high-privilege roles from being assigned to agent identities:

- **Global Administrator**
- **Privileged Role Administrator**
- **User Administrator**

Only lower-privileged roles can be assigned to agent identities. Custom roles also can't be assigned to agent identities, and agent identities can't be members of role-assignable groups.

## When to use agent identities versus other identity types

Use **agent identities** when:
- Building AI agents in Microsoft Copilot Studio, Microsoft Foundry, or Microsoft 365
- You need to distinguish AI agent operations from human or traditional application operations
- You require centralized governance of AI agent identities
- You need to scale identity management to many short-lived agents

Use **service principals** when:
- Building traditional applications or services
- You need a stable, long-lived application identity
- The application isn't specifically an AI agent

Use **managed identities** when:
- Providing identity to Azure resources (VMs, App Service, Functions, etc.)
- You need Azure to automatically manage credentials
- You don't need AI agent-specific governance features
