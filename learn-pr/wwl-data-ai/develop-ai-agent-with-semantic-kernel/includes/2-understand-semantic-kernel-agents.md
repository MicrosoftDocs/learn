An AI agent is a program that uses generative AI to interpret data, make decisions, and perform tasks on behalf of users or other applications. AI agents rely on large language models to perform their tasks. Unlike traditional programs, AI agents can function autonomously, handling complex workflows and automating processes without requiring continuous human oversight.

AI Agents can be developed using many different tools and platforms, including the Microsoft Agent Framework. The Microsoft Agent Framework is an open-source SDK that enables developers to easily integrate the latest AI models into their applications. This framework provides a comprehensive foundation for creating functional agents that can use natural language processing to complete tasks and collaborate with other agents.

## Microsoft Agent Framework core components

The Microsoft Agent Framework offers different components that can be used individually or combined.

- **Chat clients** - provide abstractions for connecting to AI services from different providers under a common interface. Supported providers include Azure OpenAI, OpenAI, Anthropic, and more through the `BaseChatClient` abstraction.

- **Function tools** - containers for custom functions that extend agent capabilities. Agents can automatically invoke functions to integrate with external APIs and services.

- **Built-in tools** - prebuilt capabilities including Code Interpreter for Python execution, File Search for document analysis, and Web Search for internet access.

- **Conversation management** - structured message system with roles (USER, ASSISTANT, SYSTEM, TOOL) and `AgentThread` for persistent conversation context across interactions.

- **Workflow orchestration** - supports sequential workflows, concurrent execution, group chat, and handoff patterns for complex multi-agent collaboration.

The Microsoft Agent Framework helps streamline the creation of agents and allows multiple agents to work together in conversations while including human input. The framework supports different types of agents from multiple providers, including Azure AI Foundry, Azure OpenAI, OpenAI, Microsoft Copilot Studio, and Anthropic agents.

### What is an Azure AI Foundry Agent?

Azure AI Foundry Agents provide enterprise-level capabilities using the Azure AI Foundry Agent Service. These agents offer advanced features for complex enterprise scenarios. Key benefits include:

- **Enterprise-level capabilities** – Built for Azure environments with advanced AI features including code interpreter, function tools integration, and Model Context Protocol (MCP) support.

- **Automatic tool invocation** – Agents can automatically call and execute tools, integrating seamlessly with Azure AI Search, Azure Functions, and other Azure services.

- **Thread and conversation management** – Provides built-in mechanisms for managing persistent conversation states across sessions, ensuring smooth multi-agent interactions.

- **Secure enterprise integration** – Enables secure and compliant AI agent development with Azure CLI authentication, RBAC, and customizable storage options.

When you use Azure AI Foundry Agents, you get the full power of enterprise Azure capabilities combined with the features of the Microsoft Agent Framework. These features can help you create robust AI-driven workflows that can scale efficiently across business applications.

### Agent framework core concepts

- **BaseAgent** - the foundation for all agents with consistent methods, providing a unified interface across all agent types.

- **Agent threads** - manage persistent conversation context and store conversation history across sessions using the `AgentThread` class.

- **Chat messages** - organized structure for agent communication using role-based messaging (USER, ASSISTANT, SYSTEM, TOOL) that enables smooth communication and integration.

- **Workflow orchestration** - supports sequential workflows, running multiple agents in parallel, group conversations between agents, and transferring control between specialized agents.

- **Multi-modal support** - allows agents to work with text, images, and structured outputs, including vision capabilities and type-safe response generation.

- **Function tools** - let you add custom capabilities to agents by including custom functions with automatic schema generation from Python functions.

- **Authentication methods** - supports multiple authentication methods including Azure CLI credentials, API keys, MSAL for Microsoft business authentication, and role-based access control.

This framework supports autonomous, multi-agent AI behaviors while maintaining a flexible architecture that lets you mix and match agents, tools, and workflows as needed. The design lets you switch between OpenAI, Azure OpenAI, Anthropic, and other providers without changing your code, making it easy to build AI systems—from simple chatbots to complex business solutions.