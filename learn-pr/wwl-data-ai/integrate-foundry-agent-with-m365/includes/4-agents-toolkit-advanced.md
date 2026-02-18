For most scenarios, publishing directly from the Foundry portal is the simplest path to get your agents into Microsoft Teams and Microsoft 365 Copilot. However, some complex enterprise scenarios require additional control over the integration layer. The Microsoft 365 Agents Toolkit provides an alternative approach for these situations.

This unit covers the Agents Toolkit from a high level perspective. Follow the links to documentation at the end for a deeper explanation.

> [!NOTE]
> This unit covers an advanced topic. If you're getting started with Foundry agent integration, you can skip this unit and return later if you encounter scenarios that require the Agents Toolkit approach.

## When to consider the Agents Toolkit

The Microsoft 365 Agents Toolkit is a suite of development tools available as extensions for Visual Studio Code and Visual Studio. Consider using it when your agent requires custom single sign-on (SSO) configuration beyond the default Entra ID setup, or when you need to add middleware logic for custom processing, logging, or transformation between Teams and your Foundry agent.

The toolkit is also valuable for organizations that require multi-environment deployment with separate development, staging, and production configurations. It provides advanced debugging capabilities with detailed tracing beyond what the Foundry portal offers, and integrates with CI/CD pipelines through GitHub Actions or Azure DevOps.

## How the Agents Toolkit approach works

Instead of publishing directly from Foundry, you create a proxy application using the Agents Toolkit that sits between Microsoft 365 and your Foundry agent:

```
Teams/Copilot → Proxy App (Agents Toolkit) → Foundry Agent
```

This proxy application receives messages from Teams or Copilot through Azure Bot Service, processes them through any custom middleware you've configured, forwards the request to your Foundry agent, and returns the response through the same path. The proxy approach gives you control over every step of the message flow, but adds complexity to your deployment.

## Getting started with the Agents Toolkit

If you determine the Agents Toolkit is right for your scenario, here's an overview of the setup process.

Start by installing the Microsoft 365 Agents Toolkit extension from the Visual Studio Code marketplace. Once installed, open the extension panel and select **Create a New Agent/App**, then choose **Custom Engine Agent** as the project type. The wizard guides you through configuration options including your AI model source.

The project template creates scaffolding for a standalone agent. To connect to an existing Foundry agent, configure the project to call your Foundry agent's endpoint, set up authentication using the agent's credentials, and implement any middleware logic you need.

The Agents Toolkit includes the **Microsoft 365 Agents Playground**, a local testing environment that simulates Teams. Run your project in debug mode to open the playground in your browser, where you can send test messages to verify the connection works correctly. Once testing is complete, use the toolkit to provision Azure resources, deploy your proxy application, and register it in Teams.

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
