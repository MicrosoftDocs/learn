::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=4c7a912c-3071-4e42-83de-5816334a4bed]

> [!NOTE]
> See the **Text and images** tab for more details

::: zone-end

::: zone pivot="text"

Congratulations! In this module, you've gone from "What is Claude?" to making working requests to Claude on Microsoft Foundry in your own Azure tenant. You now have the foundational knowledge to integrate Anthropic's powerful AI models into your applications.

Throughout this module, you learned about:

### Microsoft Foundry

- The multi-level architecture: Azure subscription → Foundry resource → Project
- Prerequisites for using Claude on Foundry, including subscription types and permissions
- How Foundry unifies models, prompting, tools, data, and agents in one platform
- The difference between the Foundry portal and developer tools (Azure CLI, VS Code)

### Claude models

- **Claude Opus** - Maximum capability for complex reasoning, sophisticated agents, and critical analysis
- **Claude Sonnet** - The workhorse that balances frontier intelligence with production speed and cost
- **Claude Haiku** - Optimized for speed and volume in classification, extraction, and routing tasks

### Deployment and testing

- How to deploy a Claude model from the model catalog
- Understanding the difference between model ID and deployment name
- Using the built-in playground to verify your deployment
- Testing Claude through your Azure endpoint with Azure billing and monitoring

### Code integration

- Getting your endpoint URL and API key from the Foundry portal
- Security best practices for credential management
- Using the `AnthropicFoundry` client to make API calls
- Writing your first request with the messages API
- Multi-language support across Python, TypeScript, C#, and Java

## Core principles to remember

As you move forward building with Claude on Foundry, keep these principles in mind:

- **Start with a practical use case**

    Don't build AI for AI's sake. Identify a real business problem or user need, then design your solution around that concrete use case. Claude excels at many tasks, but the best results come from clear, well-defined objectives.

- **Choose the right model for the job**

    Use the bottom-up approach:

    1. Start with Haiku and test with 20-30 real examples
    1. If quality meets requirements, you have optimized cost and latency
    1. If you hit a quality ceiling, step up to Sonnet, then Opus if needed

    Don't overpay for capability you don't need, but don't compromise on quality when it matters.

- **Evaluate as you go**

    Building with AI is iterative. Test your prompts, measure your results, and refine your approach. What works in the playground may need adjustment in production. Continuous evaluation helps you:

  - Maintain quality as you scale
  - Identify edge cases and failure modes
  - Optimize costs without sacrificing performance
  - Build confidence in your AI systems

Thank you for completing this module. We can't wait to see what you create!

::: zone-end

## Learn more

- [Deploy and use Claude models in Microsoft Foundry](/azure/foundry/foundry-models/how-to/use-foundry-models-claude?azure-portal=true)
- [Claude in Microsoft Foundry](https://claude.com/partners/microsoft-foundry?azure-portal=true)
