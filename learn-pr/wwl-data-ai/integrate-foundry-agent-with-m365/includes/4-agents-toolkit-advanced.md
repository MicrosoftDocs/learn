For most scenarios, publishing directly from the Foundry portal is the simplest path to get your agents into Microsoft Teams and Microsoft 365 Copilot. However, some complex enterprise scenarios require additional control over the integration layer. The Microsoft 365 Agents Toolkit provides an alternative approach for these situations.

> [!NOTE]
> This unit covers an advanced topic. If you're getting started with Foundry agent integration, you can skip this unit and return later if you encounter scenarios that require the Agents Toolkit approach.

## When to consider the Agents Toolkit

The Microsoft 365 Agents Toolkit is a suite of development tools available as extensions for Visual Studio Code and Visual Studio. Consider using it when you need:

- **Custom single sign-on (SSO)**: Your agent requires specific SSO configuration that goes beyond the default Entra ID setup
- **Middleware logic**: You need to add custom processing, logging, or transformation between Teams and your Foundry agent
- **Multi-environment deployment**: You require separate development, staging, and production configurations with controlled promotion between environments
- **Advanced debugging**: You need detailed tracing and debugging capabilities beyond what the Foundry portal provides
- **CI/CD integration**: Your organization requires automated deployment pipelines through GitHub Actions or Azure DevOps

## How the Agents Toolkit approach works

Instead of publishing directly from Foundry, you create a proxy application using the Agents Toolkit that sits between Microsoft 365 and your Foundry agent:

```
Teams/Copilot → Proxy App (Agents Toolkit) → Foundry Agent
```

This proxy application:

1. Receives messages from Teams or Copilot through Azure Bot Service
2. Processes the message through any custom middleware you've configured
3. Forwards the request to your Foundry agent
4. Returns the agent's response through the same path

The proxy approach gives you control over every step of the message flow, but adds complexity to your deployment.

## Getting started with the Agents Toolkit

If you determine the Agents Toolkit is right for your scenario, here's an overview of the setup process:

### Install the extension

1. Open Visual Studio Code.
2. Navigate to the Extensions marketplace.
3. Search for "Microsoft 365 Agents Toolkit" and install it.

### Create a custom engine agent project

1. Open the Agents Toolkit extension panel in VS Code.
2. Select **Create a New Agent/App**.
3. Choose **Custom Engine Agent** as the project type.
4. Follow the prompts to configure your project, including selecting your AI model source.

### Connect to your Foundry agent

The project template creates scaffolding for a standalone agent. To connect to an existing Foundry agent:

1. Configure the project to call your Foundry agent's endpoint.
2. Set up authentication using the Foundry agent's credentials.
3. Implement any middleware logic you need.

### Test locally

The Agents Toolkit includes the **Microsoft 365 Agents Playground**, a local testing environment that simulates Teams:

1. Run the project in debug mode.
2. The playground opens in your browser.
3. Send test messages to verify the connection to your Foundry agent.

### Deploy and publish

1. Use the toolkit to provision Azure resources.
2. Deploy your proxy application.
3. Register the application in Teams.

## Comparison summary

| Aspect | Direct Foundry publishing | Agents Toolkit proxy |
|--------|---------------------------|----------------------|
| Setup time | Minutes | Hours to days |
| Code required | None | Proxy application |
| Customization | Limited | Extensive |
| Debugging | Foundry portal | Full IDE debugging |
| Best for | Standard deployments | Complex enterprise needs |

## Learn more

For detailed guidance on the Agents Toolkit, see:

- [Microsoft 365 Agents Toolkit documentation](/microsoftteams/platform/toolkit/overview-agents-toolkit)
- [Create custom engine agents with the Agents Toolkit](/microsoft-365/agents-sdk/create-new-toolkit-project-vsc)
- [Microsoft 365 Agents SDK overview](/microsoft-365/agents-sdk/agents-sdk-overview)

The direct publishing approach covered in the previous unit handles the majority of integration scenarios. Reserve the Agents Toolkit for situations where you've identified specific requirements it addresses.
