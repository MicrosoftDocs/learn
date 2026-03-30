When you build an agent in Microsoft Foundry, it runs within the Foundry Agent Service infrastructure. Publishing promotes your agent from a development asset into a managed Azure resource with a dedicated endpoint, independent identity, and governance capabilities.

## Understanding agent applications

When you publish an agent, Microsoft Foundry creates an **Agent Application** resource with:

- **Dedicated invocation URL**: A stable endpoint that remains consistent as you update agent versions
- **Agent identity**: A distinct Microsoft Entra identity separate from your development project
- **User data isolation**: Inputs and interactions from one user aren't available to other users

The Agent Application acts as a routing layer. When you publish a new agent version, traffic automatically routes to the updated deployment without changing the public endpoint.

## Publishing to Microsoft 365

The primary focus of this module is Microsoft 365 integration, which enables your agent to appear within Teams and Copilot. Publishing to Microsoft 365:

- Creates an Azure Bot Service resource that routes messages between Microsoft 365 and your agent
- Generates a Microsoft 365 publishing package for distribution
- Registers a Microsoft Entra ID application for authentication
- Makes your agent discoverable in the Teams agent store

### Direct publishing from Foundry portal

The most straightforward approach is publishing directly from the Foundry portal. The publishing wizard:

1. Creates an Azure Bot Service resource in your subscription
2. Registers a Microsoft Entra ID application
3. Generates a Microsoft 365 publishing package
4. Prepares your agent for distribution

This approach is ideal when you want to deploy quickly or keep your agent logic entirely within Foundry.

### Microsoft 365 Agents Toolkit

For complex scenarios, you can use the Microsoft 365 Agents Toolkit to create a proxy application that connects to your Foundry agent. Consider this approach when you need custom single sign-on (SSO), advanced middleware logic, or multi-environment deployment pipelines. The Agents Toolkit is covered later in this module as an optional advanced topic.

### Publish scopes

When publishing to Microsoft 365, you choose between two distribution scopes:

| Scope | Description | Best for |
|-------|-------------|----------|
| **Shared** | Available immediately without admin approval. Appears under **Your agents** in Teams. | Personal testing, small team pilots |
| **Organization** | Available to everyone in your tenant under **Built by your org**. Requires admin approval. | Production deployments |

## Other publishing channels

While this module focuses on Microsoft 365, Foundry agents can also publish to:

- **Web application preview**: Browser-based interface for demos and stakeholder testing
- **Stable API endpoint**: REST API for embedding in custom applications
- **Azure Bot Service channels**: Slack, Telegram, Twilio (SMS), Facebook, and others

These options are useful when you need to reach users outside Microsoft 365 or embed your agent in custom applications.

## Agent identity and permissions

When you publish an agent, the system creates a distinct agent identity. This matters because:

- The agent authenticates to Azure resources using its own identity
- Development-time permissions on your project identity don't transfer automatically
- Tools that access Azure services need permissions reconfigured after publishing

If your agent uses tools that connect to services like Azure AI Search, grant the published agent's identity appropriate permissions.

## Prerequisites for publishing

Before publishing an agent to Microsoft 365, ensure you have:

- **Azure AI Project Manager** role on your Foundry project
- **Azure AI User** role on the agent application scope
- An Azure subscription where you can create Azure Bot Service resources
- Permissions to register applications in Microsoft Entra ID
- A Microsoft 365 tenant that allows custom apps and bots
