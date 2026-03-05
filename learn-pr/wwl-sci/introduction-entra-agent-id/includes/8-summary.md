In this module, you learned about Microsoft Entra Agent ID, a specialized identity type designed for AI agents operating in enterprise environments. You explored how agent identities differ from traditional identity types like service principals and managed identities. Then you learned agent identities address unique security and operational challenges posed by AI agents.

### What is Microsoft Entra Agent ID?

Microsoft Entra Agent ID introduces two key components:
- **Agent identities**: Special service principals that represent AI agents, using token-based authentication without passwords
- **Agent identity blueprints**: Reusable templates that create and manage multiple agent identities, providing centralized governance

The impersonation model allows blueprints to obtain tokens on behalf of agent identities, enabling flexible authentication while maintaining clear audit trails.

### How agent identities compare to other identity types

Agent identities differ from service principals and managed identities in several ways:
- **Credential management**: Agent identities rely on parent blueprint credentials rather than managing their own
- **Lifecycle**: Designed for ephemeral, rapidly created and destroyed agents rather than long-lived resources
- **Security controls**: Block high-privilege roles (Global Admin, Privileged Role Admin, User Admin), preventing excessive access
- **Scale**: Support thousands of agent instances managed through a single blueprint

### Microsoft products that use agent identities

Several Microsoft platforms automatically create agent identities:
- **Microsoft Foundry**: Shared identities for development, distinct identities when published
- **Microsoft Copilot Studio**: Automatic identity assignment when enabled at environment level
- **Microsoft Agent 365**: Each agent receives its own agent identity
- **Azure App Service/Functions** and **Microsoft Teams**: Developer-managed blueprint creation

### Managing agent identities through the admin center

The Microsoft Entra admin center provides comprehensive management capabilities:
- Navigate to **Entra ID** > **Agent ID** > **All agent identities**
- View, search, filter, and sort agent identities by various criteria
- Distinguish between agent identity objects and legacy service principal-based agents
- Take actions like enabling, disabling, and viewing detailed permissions
- View agent identity blueprints and their child agent identities

### Access requirements and permission management

Effective agent identity management requires understanding:
- **Required roles**: Agent ID Administrator, Cloud Application Administrator, or agent owner
- **Permission inheritance**: Agent identities inherit delegated permissions from blueprints
- **Publishing considerations**: RBAC permissions must be manually reassigned when publishing agents
- **Security restrictions**: High-privilege roles and certain Microsoft Graph permissions are blocked
- **Administrative model**: Separation of technical ownership and business sponsorship

### Programmatic access through Microsoft Graph

Microsoft Graph enables automation and scale:
- Query agent identities and blueprints using REST APIs
- Perform bulk operations across multiple agent identities
- Integrate agent identity management into existing governance workflows
- Automate lifecycle management, compliance reporting, and monitoring
- Retrieve metadata about agent identities, permissions, and relationships

## Meeting our scenario goals

Remember the scenario from the introduction: you're managing AI agent identities across multiple departments using various Microsoft platforms. With the knowledge from this module, you can now:

- Distinguish AI agent operations from human operations in audit logs
- Apply consistent security policies to all agents of a particular type using blueprints
- Prevent agents from gaining excessive privileges through built-in security restrictions
- Scale identity management through blueprints that create and manage thousands of agent instances
- View and manage all agent identities centrally through the Microsoft Entra admin center
- Automate agent identity operations using Microsoft Graph APIs

## Learn more

- [What is Microsoft Entra Agent ID](/entra/agent-id/identity-platform/what-is-agent-id)
- [Agent identity and blueprint concepts](/entra/agent-id/identity-platform/key-concepts)
- [View and manage agent identities](/entra/agent-id/identity-platform/agent-lists)
- [Microsoft Graph Agent ID APIs](/graph/api/resources/agentid-platform-overview)
- [Agent identity concepts in Microsoft Foundry](/azure/ai-foundry/agents/concepts/agent-identity)
