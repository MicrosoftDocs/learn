::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=411684d4-9d90-42f0-9285-6521f5095180]

> [!TIP]
> See the **Text and images** tab for more details!

::: zone-end

::: zone pivot="text"

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

1. Open your agent in the Foundry Toolkit
1. Select **Save to Foundry** to push configuration changes
1. For hosted agents, open the **+Build** menu in the developer tools and select **Deploy to Microsoft Foundry**
1. Choose a deployment method:
   - **Code (ZIP Code Deploy)** - Packages your source code and deploys directly without a container image
   - **Container (BYOI)** - Deploy using a pre-built container image from Azure Container Registry
1. Select your model and confirm

Both approaches keep your agent within your project workspace where team members can access and test it.

## Publishing agents to an endpoint

When you create an agent in Microsoft Foundry, it receives a stable endpoint, its own Entra agent identity, and an agent blueprint automatically. Publishing then refers to *distributing* the agent so that external consumers and applications — including Microsoft Teams and Microsoft 365 Copilot — can call it.

### What each agent includes

Every agent created in Foundry is provisioned with:

- **Stable endpoint** - A production-ready invocation URL that remains constant even as you update agent versions.
- **Entra agent identity** - A dedicated Microsoft Entra identity with its own RBAC scope, separate from the project's shared identity.
- **Authentication policy** - Built-in Microsoft Entra ID authentication. Callers must have the **Foundry User** role on the agent resource. API key authentication isn't supported.

> [!IMPORTANT]
> Each agent receives its own dedicated Entra identity. Permissions don't transfer automatically from the project identity. You must assign RBAC roles to the agent identity for any resources the agent accesses. If you skip this step, tool calls that work during development fail with authorization errors once the agent is published.

### Publishing to Microsoft Teams and Microsoft 365 Copilot

From the Foundry portal, you can publish agents to Microsoft Teams and Microsoft 365 Copilot with a single step — no rebuilding required. The agent moves through a unified pipeline into the applications where users already work.

### The agent endpoint

Agents expose a stable endpoint using the Responses API protocol:

`https://<foundry-resource-name>.services.ai.azure.com/api/projects/<project-name>/agents/<agent-name>/endpoint/protocols/openai/responses`

This URL stays the same even as you roll out new agent versions, so downstream consumers aren't disrupted by updates.

### Verifying the endpoint

After creating and configuring your agent, verify the endpoint works:

1. Get an access token:

   ```azurecli
   az account get-access-token --resource https://ai.azure.com
   ```

1. Call the agent endpoint:

   ```bash
   curl -X POST \
     "https://<foundry-resource-name>.services.ai.azure.com/api/projects/<project-name>/agents/<agent-name>/endpoint/protocols/openai/responses?api-version=2025-11-15-preview" \
     -H "Authorization: ******" \
     -H "Content-Type: application/json" \
     -d '{"input":"Say hello"}'
   ```

If you receive `403 Forbidden`, confirm the caller has the **Foundry User** role on the agent resource.

### Updating agents

To roll out a new agent version:

1. Make changes in your development environment and test thoroughly
1. In the Foundry portal, save the updated agent configuration
1. The endpoint routes traffic to the new version automatically

The endpoint URL remains unchanged, so existing integrations continue working.

## Generating integration code

The Foundry Toolkit for VS Code generates sample integration code to connect your application to a published agent:

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
- **Conversation management** - Agent endpoints currently support only the stateless Responses API. Store conversation history in your client for multi-turn experiences.

::: zone-end
