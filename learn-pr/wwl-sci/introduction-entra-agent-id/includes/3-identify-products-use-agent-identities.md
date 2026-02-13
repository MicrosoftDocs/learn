Several Microsoft products and services automatically create and manage agent identities throughout the agent lifecycle. Understanding which platforms support agent identities helps you plan your AI agent deployments and identity governance strategies.

## Microsoft Foundry

**Microsoft Foundry** (formerly Azure AI Foundry) automatically creates and manages agent identities throughout the agent development lifecycle. This integration simplifies permission management while maintaining security and auditability as agents move from development to production.

### Shared project identity for development

When you create your first agent in a Foundry project, the system automatically creates:
- A **default agent identity blueprint**
- A **default agent identity** for your project

All unpublished or in-development agents within the same project share this common identity. This design simplifies permission management because unpublished agents typically require the same access patterns and permission configurations.

#### Benefits of the shared identity approach:

- **Simplified administration**: Administrators can centrally manage permissions for all in-development agents within a project
- **Reduced identity sprawl**: Using a single identity per project prevents unnecessary identity creation during early experimentation
- **Developer autonomy**: After the shared identity is configured, developers can independently build and test agents without repeatedly configuring new permissions

### Distinct agent identity for published agents

When an agent's permissions, auditability, or lifecycle requirements diverge from the project defaults, you should upgrade to a distinct identity. Publishing an agent automatically creates:
- A dedicated **agent identity blueprint**
- A dedicated **agent identity**

Both are bound to the agent application resource. This distinct identity represents the agent's system authority for accessing its own resources.

Common scenarios that require distinct identities:

- Agents ready for integration testing
- Agents prepared for production consumption
- Agents that require unique permission sets
- Agents that need independent audit trails

### Tool authentication in Microsoft Foundry

Agents in Microsoft Foundry access remote resources and tools by using agent identities for authentication. The authentication mechanism differs based on publication status:

- **Unpublished agents**: Authenticate using the shared project's agent identity
- **Published agents**: Authenticate using the unique agent identity associated with the agent application

> [!IMPORTANT]
> When you publish an agent, you must reassign RBAC permissions to the new agent identity for any resources that the agent needs to access. Permissions assigned to the shared identity don't automatically transfer.

Currently, the tools that support authentication with agent identity are:
- **Model Context Protocol (MCP)**: Use your agent's identity to authenticate with MCP servers that support agent identity authentication
- **Agent-to-Agent (A2A)**: Enable secure communication between agents using agent identities

## Azure App Service and Azure Functions

You can configure an **Azure App Service or Azure Functions app** to use the Microsoft Entra agent identity platform to securely connect to resources as an agent.

To use agent identities with App Service or Functions:

1. Create an agent identity blueprint (typically using a user-assigned managed identity as the credential)
2. Configure your app to use the blueprint for creating agent identities
3. Create agent identities at runtime when your agent app needs to perform operations
4. Assign appropriate permissions to agent identities to access Azure resources

This approach is useful for:
- **Autonomous agents**: Agents that work independently and perform actions using their own identity
- **Interactive agents**: Agents that act as delegates of users, performing actions on behalf of that user

## Microsoft Copilot Studio

Agents created in **Microsoft Copilot Studio** can be configured to automatically be assigned an agent identity. This feature is enabled at the environment level in the Power Platform admin center.

### How it works

When you enable the "Microsoft Entra Agent Identity for Copilot Studio" setting:
1. Agents created in Copilot Studio are automatically assigned an agent identity
2. When the first agent identity is created in a Power Platform environment after enabling this setting, a **Microsoft Copilot Studio agent identity blueprint** is automatically created
3. An **agent identity blueprint principal** is also created, which has privileges to create agent identities and agent users in the tenant

### Benefits

- **Automatic provisioning**: No manual identity creation required
- **Centralized management**: All Copilot Studio agent identities are visible in the Microsoft Entra admin center
- **Audit trail**: Authentication activity is logged in Microsoft Entra ID and visible in the admin center
- **Lifecycle management**: When you delete an agent from Copilot Studio, the associated agent identity is automatically removed from Microsoft Entra

## Microsoft Teams platform

For agents in the **Microsoft Teams** platform, developers manually create and configure agent identity blueprints using the **Developer Portal for Teams** web interface.

### How it works

1. Developers navigate to **Tools** > **Agent Identity Blueprint** in the Developer Portal
2. Create a new blueprint by providing a name and configuration
3. A unique **Agent Blueprint ID** is automatically generated for the blueprint
4. Configure the blueprint with agent type (Bot-based or API-based) and connection details

### Agent identity creation

Unlike the blueprint itself, actual agent identities are created later through a separate workflow:
1. Publish the agent application
2. Request admin approval in Microsoft 365 Admin Center
3. Create agent instances in Teams that use the blueprint

This manual approach gives developers control over blueprint configuration while requiring administrative oversight for actual agent identity provisioning.

## Microsoft Agent 365

**Microsoft Agent 365** gives each AI agent its own Microsoft Entra Agent ID for identity, lifecycle, and access management.

Key features:
- **Automatic identity assignment**: Each agent automatically receives its own agent identity
- **Integrated governance**: Agent identities are integrated with Microsoft Entra governance features
- **Full lifecycle management**: Identity creation, management, and deletion are handled throughout the agent lifecycle

## Summary of automatic provisioning

| Microsoft Product | Automatic Provisioning | How Agent Identities Are Used |
|------------------|------------------------|-------------------------------|
| **Microsoft Foundry** | Yes | Shared identity for unpublished agents; distinct identity when published |
| **Azure App Service/Functions** | Developer-managed | Developers create blueprints and agent identities programmatically |
| **Microsoft Copilot Studio** | Yes (when enabled) | Automatically assigned when environment setting is enabled |
| **Microsoft Teams** | Developer-managed | Developers create and manage blueprints in Developer Portal |
| **Microsoft Agent 365** | Yes | Each agent automatically receives its own identity |

## Planning considerations

When planning your agent deployments, consider:

- **Which platforms will you use?** Determine which Microsoft products host your agents
- **Identity governance requirements**: Understand how agent identities are created, managed, and governed
- **Permission management**: Plan how permissions are assigned, especially when publishing agents or moving them between environments
- **Audit and monitoring**: Ensure you have processes to monitor agent identity activity in the Microsoft Entra admin center
- **Lifecycle management**: Plan for how agent identities are created and deleted as agents are deployed and retired
