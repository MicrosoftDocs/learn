Testing, deploying, and publishing agents are critical steps in moving from development to production. Microsoft Foundry provides comprehensive capabilities for validating agent behavior, deploying to your Foundry project, and publishing agents as callable endpoints that external consumers and applications can use.

## Testing strategies for agents

Thorough testing ensures your agents behave reliably across diverse scenarios before reaching users. Both the Foundry portal and Visual Studio Code extension provide playgrounds for interactive testing.

**Using the playground effectively:**

- **Happy path testing** - Verify the agent handles common, expected requests correctly.
- **Edge case testing** - Try ambiguous inputs, incomplete information, and unusual requests to reveal how agents handle uncertainty.
- **Boundary testing** - Confirm the agent respects boundaries defined in its instructions by testing out-of-scope requests.
- **Multi-turn conversation testing** - Verify the agent maintains context across multiple exchanges and builds on previous responses.
- **Tool invocation testing** - Verify agents call the right tools at the right times and incorporate results correctly.

Record test results to track improvements and catch regressions.

## Deploying agents to your project

Microsoft Foundry supports deploying agents from the portal or Visual Studio Code. Deploying saves your agent configuration to your Foundry project so you can test and iterate.

### Deploying from the Foundry portal

1. Navigate to your agent in the Foundry portal
1. Verify configuration and test results are satisfactory
1. Select **Save** from the agent's page
1. Confirm version and deployment settings

### Deploying from Visual Studio Code

1. Open your agent in the AI Toolkit
1. Select **Save to Foundry** to push configuration changes
1. For hosted agents, open the **+Build** menu in the developer tools and select **Deploy to Microsoft Foundry**
1. Select your container configuration and confirm

Both approaches keep your agent within your project workspace where team members can access and test it.

## Publishing agents to an endpoint

Publishing moves an agent from your project workspace into a managed Azure resource called an **Agent Application**. This step is what makes your agent externally callable through a stable endpoint.

### What publishing creates

When you publish an agent version, Foundry creates:

- **Agent Application** - An Azure resource with its own invocation URL, authentication policy, and Entra agent identity.
- **Deployment** - A running instance of a specific agent version inside the application, with start/stop lifecycle management.

The key difference between deploying and publishing is scope. Deploying keeps the agent within your project. Publishing creates a dedicated endpoint that external consumers can call without needing access to your Foundry project.

### Publishing from the Foundry portal

1. In the portal, select the agent version you want to publish
1. Select **Publish** to create the Agent Application and deployment

### Publishing from Visual Studio Code

1. Open the Command Palette (**Ctrl+Shift+P**) and run **Microsoft Foundry: Deploy Hosted Agent** for hosted agents
1. Select the target workspace and container configuration
1. Confirm and deploy

After publishing, the agent appears in the **Hosted Agents (Preview)** section of the AI Toolkit extension tree view.

### The Agent Application endpoint

Published agents expose a stable endpoint using the Responses API protocol:

`https://<foundry-resource-name>.services.ai.azure.com/api/projects/<project-name>/applications/<app-name>/protocols/openai/responses`

This URL stays the same even as you roll out new agent versions, so downstream consumers aren't disrupted by updates.

### Authentication and identity

Agent Applications use Microsoft Entra ID for authentication. Callers must have the **Azure AI User** role on the Agent Application resource. API key authentication isn't supported for Agent Applications.

> [!IMPORTANT]
> When you publish an agent, it receives its own dedicated Entra identity, separate from the project's shared identity. Permissions don't transfer automatically. You must reassign RBAC roles to the new agent identity for any resources the agent accesses. If you skip this step, tool calls that work during development fail with authorization errors once the agent is published.

### Verifying the endpoint

After publishing, verify the endpoint works:

1. Get an access token:

   ```azurecli
   az account get-access-token --resource https://ai.azure.com
   ```

1. Call the Agent Application endpoint:

   ```bash
   curl -X POST \
     "https://<foundry-resource-name>.services.ai.azure.com/api/projects/<project-name>/applications/<app-name>/protocols/openai/responses?api-version=2025-11-15-preview" \
     -H "Authorization: Bearer <access-token>" \
     -H "Content-Type: application/json" \
     -d '{"input":"Say hello"}'
   ```

If you receive `403 Forbidden`, confirm the caller has the **Azure AI User** role on the Agent Application resource.

### Updating published agents

To roll out a new agent version:

1. Make changes in your development environment and test thoroughly
1. In the Foundry portal, select **Publish Updates** from the Agent playground
1. The Agent Application routes 100% of traffic to the new version automatically

The endpoint URL remains unchanged, so existing integrations continue working.

## Generating integration code

The Microsoft Foundry VS Code extension generates sample integration code to connect your application to a published agent:

1. Select your deployed agent in the My Resources view
1. Select **View Code**
1. Choose your folder
1. The extension generates code for authenticating, connecting, sending messages, and processing responses

## Integration patterns

Common patterns for integrating published agents include:

- **Web applications** - Send user messages to the Responses API endpoint and display responses in your UI. Store conversation history client-side for multi-turn interactions.
- **API-driven workflows** - Call the agent endpoint from backend services triggered by events or schedules. Process responses programmatically to drive downstream actions.
- **Chatbot interfaces** - Map user sessions to conversations. Handle real-time message exchange through the endpoint.
- **Background automation** - Schedule agent calls for recurring tasks. Feed system data into agents and process outputs to update business systems.

## Production considerations

Running agents in production requires attention to several operational areas:

- **Monitoring** - Track response times, tool invocation success rates, error patterns, and token consumption using Application Insights integration.
- **Security** - Use managed identities for authentication, apply least-privilege access, and define data retention policies.
- **Cost management** - Monitor token usage, set response length limits, and implement rate limiting to prevent unexpected spikes.
- **Error handling** - Implement retry logic with exponential backoff for transient failures. Handle rate limiting with backoff strategies. Validate inputs before sending to agents.
- **Conversation management** - Agent Application endpoints currently support only the stateless Responses API. Store conversation history in your client for multi-turn experiences.
