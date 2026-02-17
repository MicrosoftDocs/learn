When you build an agent in Microsoft Foundry, it runs within the Foundry Agent Service infrastructure. To make your agent available in Microsoft Teams and Microsoft 365 Copilot, you need to publish it through a process that creates the necessary connections between your agent and Microsoft 365 services.

## How Foundry agents connect to Microsoft 365

Microsoft Foundry agents integrate with Microsoft 365 through Azure Bot Service. When you publish an agent, the system creates a bot resource that acts as the communication layer between your Foundry agent and Microsoft 365 surfaces like Teams and Copilot.

The publishing process handles several components automatically:

- **Azure Bot Service**: Routes messages between Microsoft 365 and your agent
- **Microsoft Entra ID app registration**: Provides identity and authentication for your agent
- **Agent application**: Creates a stable endpoint and identity for your published agent
- **Microsoft 365 publishing package**: Packages your agent for distribution in Teams and Copilot

This architecture means users in Teams or Copilot send messages to the Bot Service, which forwards them to your Foundry agent. The agent processes the request and returns a response through the same path.

## Publishing approaches

Microsoft provides two main approaches for publishing Foundry agents to Microsoft 365, each suited for different scenarios.

### Direct publishing from Foundry portal

The most straightforward approach is publishing directly from the Foundry portal. This option handles all the infrastructure setup automatically and requires minimal configuration. You complete a publishing wizard that:

1. Creates an Azure Bot Service resource in your subscription
2. Registers a Microsoft Entra ID application
3. Generates a Microsoft 365 publishing package
4. Prepares your agent for distribution

This approach is ideal when you want to:

- Deploy quickly without writing additional code
- Test your agent in Teams or Copilot
- Publish to your organization or a small team
- Keep your agent logic entirely within Foundry

### Microsoft 365 Agents Toolkit

For complex scenarios, you can use the Microsoft 365 Agents Toolkit to create a proxy application that connects to your Foundry agent. This approach provides more control but requires additional development effort.

The Agents Toolkit is covered in more detail later in this module as an optional advanced topic. You might consider this approach when you need:

- Custom single sign-on (SSO) implementation
- Advanced middleware or business logic between Teams and your agent
- Multi-environment deployment pipelines
- Detailed debugging and tracing capabilities

### Comparing the approaches

| Feature | Direct publishing from Foundry | Agents Toolkit |
|---------|-------------------------------|----------------|
| Setup complexity | Low - wizard-based | Higher - requires development |
| Tooling | Foundry portal | Visual Studio Code with extension |
| Bot Service provisioning | Automatic | Manual or automated via toolkit |
| Best for | Rapid deployment, testing, standard scenarios | Custom logic, SSO, managed infrastructure |
| Code required | None | Proxy application code |

For most scenarios, direct publishing from the Foundry portal provides everything you need. The Agents Toolkit becomes valuable when you have specific requirements that the standard publishing flow doesn't support.

## Publish scopes

When publishing from the Foundry portal, you choose between two distribution scopes:

### Shared scope

Shared scope makes your agent available immediately without requiring administrative approval. The agent appears under **Your agents** in the Teams agent store. This scope is ideal for:

- Personal testing during development
- Sharing with a small team via direct link
- Pilot programs before broader rollout

With shared scope, only users you share the agent link with can discover and use your agent.

### Organization scope

Organization scope makes your agent available to everyone in your Microsoft 365 tenant. The agent appears under **Built by your org** in the agent store. This scope requires:

- Administrative approval in the Microsoft 365 admin center
- Compliance with your organization's app policies

Once approved, any user in your organization can find and interact with your agent. This scope is appropriate for production deployments intended for broad organizational use.

## Agent identity and permissions

When you publish an agent, the system creates a distinct agent identity separate from your development project identity. This published agent identity is important to understand because:

- The agent authenticates to Azure resources using its own identity
- Any role-based access control (RBAC) permissions must be assigned to the published agent identity
- Tools that access Azure resources need their permissions reconfigured after publishing

If your agent uses tools that connect to Azure services like Azure AI Search or Azure Cosmos DB, you need to grant the published agent's identity the appropriate permissions. The development-time permissions on your project identity don't transfer automatically.

## Prerequisites for publishing

Before publishing an agent to Microsoft 365, ensure you have:

- **Azure AI Project Manager** role on your Foundry project (to publish agents)
- **Azure AI User** role on the agent application scope (to invoke published agents)
- An Azure subscription where you can create Azure Bot Service resources
- Permissions to register applications in Microsoft Entra ID
- The **Microsoft.BotService** resource provider registered in your subscription

Your Microsoft 365 tenant also needs to allow custom apps and bots for users to access your published agent.
