There are many ways that developers can create AI agents, including multiple frameworks and SDKs.

> [!NOTE]
> Many of the services discussed in this module are in preview. Details are subject to change.

## Azure AI Agent Service

Azure AI Agent Service is a managed service in Azure that is designed to provide a framework for creating, managing, and using AI agents within Azure AI Foundry. The service is based on the OpenAI Assistants API but with increased choice of models, data integration, and enterprise security; enabling you to use both the OpenAI SDK and the Azure Foundry SDK to develop agentic solutions.

> [!TIP]
> For more information about Azure AI Agent Service, see the **[Azure AI Agent Service documentation](/azure/ai-services/agents/)**.

## OpenAI Assistants API

The OpenAI Assistants API provides a subset of the features in Azure AI Agent Service, and can only be used with OpenAI models. In Azure, you can use the Assistants API with the Azure OpenAI service, though in practice the Azure AI Agent Service provides greater flexibility and functionality for agent development on Azure.

> [!TIP]
> For more information about using the OpenAI Assistants API in Azure, see **[Getting started with Azure OpenAI Assistants](/azure/ai-services/openai/how-to/assistant)**.

## Semantic Kernel

Semantic Kernel is a lightweight, open-source development kit that you can use to build AI agents and orchestrate multi-agent solutions. The core Semantic Kernel SDK is designed for all kinds of generative AI development, while the *Semantic Kernel Agent Framework* is a platform specifically optimized for creating agents and implementing agentic solution patterns.

> [!TIP]
> For more information about the Semantic Kernel Agent Framework, see **[Semantic Kernel Agent Framework](/semantic-kernel/frameworks/agent/)**.

## AutoGen

AutoGen is an open-source framework for developing agents rapidly. It's useful as a research and ideation tool when experimenting with agents.

> [!TIP]
> For more information about AutoGen, see the **[AutoGen documentation](https://microsoft.github.io/autogen/stable/index.html)**.

## Microsoft Copilot Studio

Microsoft Copilot Studio provides a low-code development environment that "citizen developers" can use to quickly build and deploy agents that integrate with a Microsoft 365 ecosystem.

> [!TIP]
> For more information about Microsoft Copilot Studio, see the **[Microsoft Copilot Studio documentation](/microsoft-copilot-studio/)**.

## Microsoft 365 Agents SDK

Developers can create self-hosted agents for delivery through a wide range of channels by using the Microsoft 365 Agents SDK.

> [!TIP]
> For more information about Microsoft 365 Agents SDK, see the **[Microsoft 365 Agents SDK documentation](/microsoft-365/agents-sdk/)**.

## Microsoft 365 Copilot Chat

Business users can use the visual Copilot Studio Agent Builder tool in Microsoft 365 Copilot Chat to author basic agents for common tasks.

> [!TIP]
> For more information about authoring agents in Copilot Chat, see the **[Using agents in Microsoft 365 Copilot Chat](/copilot/agents)**.

## Choosing an agent development solution

With such a wide range of available tools and frameworks, it can be challenging to decide which ones to use. Use the following considerations to help you identify the right choices for your scenario:

- For business users with little or no software development experience, Microsoft 365 Copilot Chat provides a way to create simple agents that automate everyday tasks. This approach can empower users across an organization to benefit from AI agents with minimal impact on IT.
- If business users have sufficient technical skills to build low-code solutions using Microsoft Power Platform technologies, Copilot Studio enables them to combine those skills with their business domain knowledge and build agent solutions that extend the capabilities of Microsoft 365 Copilot or add agentic functionality to common channels like Microsoft Teams, Slack, or Messenger.
- When an organization needs more complex extensions to Microsoft 365 Copilot capabilities, professional developers can use the Microsoft 365 Agents SDK to build agents that target the same channels as Copilot Studio.
- To develop agentic solutions that use Azure back-end services with a wide choice of models, custom storage and search services, and integration with Azure AI services, professional developers should use Azure AI Agent Service in Azure AI Foundry.
- Start with Azure AI Agent Service to develop single, standalone agents. When you need to build multi-agent solutions, use Semantic Kernel to orchestrate the agents in your solution.

> [!NOTE]
> There's overlap between the capabilities of each agent development solution, and in some cases factors like existing familiarity with tools, programming language preferences, and other considerations will influence the decision.
