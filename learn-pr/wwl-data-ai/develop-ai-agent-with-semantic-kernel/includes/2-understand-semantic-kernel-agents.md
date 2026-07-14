::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=6426cc77-4f94-475e-b305-dc51c2af68ea]

> [!TIP]
> See the **Text and images** tab for more details!

::: zone-end

::: zone pivot="text"

The **Microsoft Agent Framework** is the next generation of both Semantic Kernel and AutoGen, built by the same engineering teams. It combines AutoGen's intuitive agent abstractions with Semantic Kernel's enterprise-grade features—including session-based state management, type safety, execution filters, and telemetry.

The framework introduces graph-based workflows to give developers explicit control over multi-agent execution paths. Every agent is derived from a unified `Agent` base class, giving you a consistent interface regardless of which underlying model provider you use.

## Architecture and key features

Rather than requiring you to manually wire together separate libraries for memory, tool integration, and model access, the Microsoft Agent Framework bundles these components into a set of composable building blocks. You can use them individually or combine them as your solution grows in complexity.

| Feature | Description |
|---|---|
| **Model clients** | A single, unified interface to connect with multiple AI providers |
| **Agent session** | Native state management for persistent conversation context across multi-turn interactions |
| **Context providers** | Plug-and-play memory components that surface relevant information to agents dynamically |
| **Function tools** | Custom functions automatically registered with agents, with schema generation handled by the framework |
| **MCP clients** | Built-in support for the Model Context Protocol, enabling dynamic tool discovery at runtime |
| **Middleware** | Hooks to intercept, log, or modify agent actions before and after execution |
| **Workflow orchestration** | Graph-based workflows for managing sequential, concurrent, group chat, and agent handoff patterns |

## What agents can do

Because all agents share the same `Agent` base class, you get a consistent set of capabilities regardless of which provider powers your agent. This means you can focus on your application logic rather than adapting to provider-specific APIs.

Out of the box, every agent in the framework supports:

- **Function calling**—automatically invoke registered tools to interact with external APIs and services
- **Multi-turn conversations**—maintain chat history either locally or via service-provided history management
- **Structured outputs**—generate type-safe, schema-validated responses
- **Streaming responses**—receive results incrementally as they're generated
- **Service-provided tools**—use built-in capabilities such as code execution, file search, and web search where supported by the provider


## Using the Microsoft Agent Framework with AI Foundry

The Microsoft Agent Framework is designed to work seamlessly with your Azure AI Foundry projects. It provides a consistent interface for connecting to Foundry, managing agent sessions, and integrating with tools and services.

By authenticating with your Azure credentials, you can connect to your Foundry project and create agents that use the capabilities of the Foundry Agent Service. These capabilities include persistent chat history, dynamic tool discovery, and integration with Azure services.

### Why Foundry is the recommended provider

A key differentiator of the Foundry Agent Service is its support for **service-side chat history**. With service-side history, the agent session persists across turns automatically—you don't need to manage conversation state yourself. Service-side history makes Foundry the recommended provider for production scenarios where maintaining context is critical.

## Provider matrix

One of the practical benefits of the Agent Framework's common interface is provider flexibility. As models improve or your requirements change, you can switch the underlying inference service without rewriting your agent logic—only the client configuration changes.

The framework supports the following providers:

| Provider | Service chat history |
|---|---|
| Foundry Agent Service | Yes |
| Azure OpenAI Responses | Yes |
| OpenAI Responses | Yes |
| Azure OpenAI Chat Completion | No |
| OpenAI Chat Completion | No |
| Anthropic Claude | No |
| Amazon Bedrock | No |
| GitHub Copilot | No |
| Ollama (OpenAI-compatible) | No |

This module focuses on the **Foundry Agent Service** provider, which offers enterprise-grade capabilities including persistent chat history, Model Context Protocol (MCP) tool support, and integration with Azure services.

::: zone-end

