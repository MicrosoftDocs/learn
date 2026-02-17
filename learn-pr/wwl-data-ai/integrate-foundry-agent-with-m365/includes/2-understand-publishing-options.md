When you build an agent in Microsoft Foundry, it runs within the Foundry Agent Service infrastructure. Publishing your agent promotes it from a development asset into a managed Azure resource with a dedicated endpoint, independent identity, and governance capabilities. While this module focuses on Microsoft 365 integration, understanding all available publishing destinations helps you choose the right approach for your scenario.

## Understanding agent applications

When you publish an agent, Microsoft Foundry creates an **Agent Application** resource. This resource provides:

- **Dedicated invocation URL**: A stable endpoint that remains consistent as you update agent versions
- **Agent identity**: A distinct Microsoft Entra identity separate from your development project
- **Governance capabilities**: Registration in the Entra Agent Registry for discovery and management
- **User data isolation**: Inputs and interactions from one user aren't available to other users

The Agent Application acts as a routing layer that directs traffic to specific agent deployments. When you publish a new agent version, traffic automatically routes to the updated deployment without changing the public endpoint.

## Available publishing channels

Microsoft Foundry agents can publish to multiple destinations. Each channel serves different use cases and audiences.

### Microsoft 365 Copilot and Teams

The primary focus of this module, Microsoft 365 integration enables your agent to appear within Teams and Copilot. Publishing to M365:

- Creates an Azure Bot Service resource that routes messages between M365 and your agent
- Generates a Microsoft 365 publishing package for distribution
- Registers a Microsoft Entra ID application for authentication
- Makes your agent discoverable in the Teams agent store

This channel is ideal when your users already work in Microsoft 365 and you want to bring AI capabilities directly into their existing workflow.

### Web application preview

The web application preview provides a browser-based interface for demonstrating and testing your agent with stakeholders. This channel:

- Requires no client installation
- Provides instant sharing via URL
- Works well for demos and user acceptance testing
- Allows non-technical stakeholders to evaluate your agent

Use the web preview when you need to showcase your agent before committing to a production deployment.

### Stable API endpoint

Every published agent exposes a stable REST API endpoint that enables programmatic access. The endpoint uses an OpenAI-compatible protocol, making it familiar to developers. This channel is useful when you want to:

- Embed your agent in existing applications
- Build custom client experiences
- Integrate with automation workflows
- Create scheduled or batch interactions with your agent

The stable endpoint URL follows this pattern:

`https://{accountName}.services.ai.azure.com/api/projects/{projectName}/applications/{applicationName}/protocols/openai`

### Custom applications

For deeper integration, you can embed your agent into existing applications using the stable endpoint and SDK integration. This approach provides:

- Full control over the user interface
- Integration with existing authentication systems
- Custom conversation management
- Branded experiences that match your application

Custom application integration works well for software vendors who want to add AI capabilities to their products.

### Azure Bot Service channels

Through Azure Bot Service, your agent can connect to additional messaging platforms beyond Microsoft 365:

| Channel | Description |
|---------|-------------|
| **Slack** | Reach users in Slack workspaces |
| **Telegram** | Connect through the Telegram messaging platform |
| **Twilio** | Enable SMS-based interactions |
| **Facebook** | Integrate with Facebook Messenger |
| **Line** | Connect to the Line messaging platform |
| **GroupMe** | Enable group chat interactions |
| **Direct Line Speech** | Support voice-based interactions |
| **Email** | Enable email-based conversations |

These channels require additional configuration through the Azure Bot Service after publishing your agent. Each channel has specific connection requirements and may need platform-specific credentials or app registrations.

## How publishing works

The publishing process transforms your development agent into a production-ready service. Understanding this process helps you troubleshoot issues and plan deployments effectively.

When you publish from the Foundry portal:

1. **Agent Application creation**: The system creates an Agent Application resource with a dedicated URL
2. **Identity provisioning**: A distinct agent identity is created, separate from your project identity
3. **Deployment creation**: A deployment is created that references your specific agent version
4. **Channel configuration**: For M365 publishing, Azure Bot Service and Entra ID app registration are created automatically

After initial publishing, you can update your agent and publish new versions. The stable endpoint remains consistent, so downstream consumers don't need to change their integrations.

## Publishing approaches for Microsoft 365

This module focuses on Microsoft 365 integration, which offers two main approaches for publishing Foundry agents.

### Direct publishing from Foundry portal

The most straightforward approach is publishing directly from the Foundry portal. This option handles all the infrastructure setup automatically and requires minimal configuration. The publishing wizard:

1. Creates an Azure Bot Service resource in your subscription
2. Registers a Microsoft Entra ID application
3. Generates a Microsoft 365 publishing package
4. Prepares your agent for distribution

This approach is ideal when you want to deploy quickly, test your agent in Teams or Copilot, or keep your agent logic entirely within Foundry.

### Microsoft 365 Agents Toolkit

For complex scenarios, you can use the Microsoft 365 Agents Toolkit to create a proxy application that connects to your Foundry agent. This approach provides more control but requires additional development effort.

The Agents Toolkit is covered in more detail later in this module as an optional advanced topic. Consider this approach when you need custom single sign-on (SSO), advanced middleware logic, multi-environment deployment pipelines, or detailed debugging capabilities.

### Comparing the approaches

| Feature | Direct publishing | Agents Toolkit |
|---------|-------------------|----------------|
| Setup complexity | Low | Higher |
| Bot Service provisioning | Automatic | Manual or automated |
| Best for | Rapid deployment, testing | Custom logic, managed infrastructure |
| Code required | None | Proxy application code |

For most scenarios, direct publishing provides everything you need.

## Publish scopes for Microsoft 365

When publishing to Microsoft 365, you choose between two distribution scopes:

### Shared scope

Shared scope makes your agent available immediately without administrative approval. The agent appears under **Your agents** in the Teams agent store. Use this scope for personal testing, sharing with a small team via direct link, or pilot programs before broader rollout.

### Organization scope

Organization scope makes your agent available to everyone in your Microsoft 365 tenant under **Built by your org** in the agent store. This scope requires administrative approval in the Microsoft 365 admin center and compliance with your organization's app policies. Use this scope for production deployments intended for broad organizational use.

## Agent identity and permissions

When you publish an agent, the system creates a distinct agent identity separate from your development project identity. This distinction is important because:

- The agent authenticates to Azure resources using its own identity
- Role-based access control (RBAC) permissions must be assigned to the published agent identity
- Tools that access Azure resources need permissions reconfigured after publishing

If your agent uses tools that connect to Azure services like Azure AI Search or Azure Cosmos DB, grant the published agent's identity appropriate permissions. Development-time permissions on your project identity don't transfer automatically.

## Choosing the right channel

Consider these factors when selecting a publishing channel:

| If you need... | Consider... |
|----------------|-------------|
| Integration with existing Teams/Copilot workflow | Microsoft 365 Copilot and Teams |
| Quick demos for stakeholders | Web application preview |
| Embedding in custom applications | Stable API endpoint |
| Reaching users on third-party platforms | Azure Bot Service channels |
| Full branding control | Custom application integration |

For enterprise scenarios where users already work in Microsoft 365, Teams and Copilot integration typically provides the best user experience. The remaining units in this module focus on this primary scenario while acknowledging that the same agent can be published to other channels as needed.

## Prerequisites for publishing

Before publishing an agent, ensure you have:

- **Azure AI Project Manager** role on your Foundry project (to publish agents)
- **Azure AI User** role on the agent application scope (to invoke published agents)
- An Azure subscription where you can create Azure Bot Service resources
- Permissions to register applications in Microsoft Entra ID
- The **Microsoft.BotService** resource provider registered in your subscription

For Microsoft 365 publishing specifically, your tenant also needs to allow custom apps and bots for users to access your published agent.
