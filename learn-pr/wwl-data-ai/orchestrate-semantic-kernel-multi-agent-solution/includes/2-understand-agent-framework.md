The Microsoft Agent Framework is an open-source SDK that enables developers to integrate AI models into their applications. This framework provides comprehensive support for creating AI-powered agents that can work independently or collaborate with other agents to accomplish complex tasks.

## What is the Microsoft Agent Framework?

The Microsoft Agent Framework is designed to help developers build AI-powered agents that can process user inputs, make decisions, and execute tasks autonomously by leveraging large language models and traditional programming logic. The framework provides structured components for defining AI-driven workflows, enabling agents to interact with users, APIs, and external services seamlessly.

### Core concepts

The Microsoft Agent Framework provides a flexible architecture with the following key components:

- **Agents**

    Agents are intelligent, AI-driven entities capable of reasoning and executing tasks. They use large language models, tools, and conversation history to make decisions dynamically and respond to user needs.

- **Agent orchestration**

    Multiple agents can collaborate towards a common goal using different orchestration patterns. The Microsoft Agent Framework supports several orchestration patterns with a unified interface for construction and invocation, allowing you to easily switch between patterns without rewriting your agent logic.

The framework includes several core features that power agent functionality:

- **Chat clients**

    Chat clients provide abstractions for connecting to AI services from different providers under a common interface. Supported providers include Azure OpenAI, OpenAI, Anthropic, and more through the `BaseChatClient` abstraction.

- **Tools and function integration**

    **Tools** enable agents to extend their capabilities through custom functions and built-in services. Agents can automatically invoke tools to integrate with external APIs, execute code, search files, or access web information. The framework supports both custom function tools and built-in tools like Code Interpreter, File Search, and Web Search.

- **Conversation management**

    Agents can maintain conversation history across multiple interactions using `AgentThread`, allowing them to track previous interactions and adapt responses accordingly. The structured message system uses roles (USER, ASSISTANT, SYSTEM, TOOL) for persistent conversation context.

### Types of agents

The Microsoft Agent Framework supports several different types of agents from multiple providers:

- **Azure AI Foundry Agent** - a specialized agent within the Microsoft Agent Framework designed to provide enterprise-grade conversational capabilities with seamless tool integration. It automatically handles tool calling and securely manages conversation history using threads, reducing the overhead of maintaining state. Azure AI Foundry Agents support built-in tools and provide integration capabilities for Azure AI Search, Azure Functions, and other Azure services.

- **ChatAgent**: designed for general conversation and task completion interfaces. The `ChatAgent` type provides natural language processing, contextual understanding, and dialogue management with support for custom tools and instructions.

- **OpenAI Assistant Agent**: designed for advanced capabilities using OpenAI's Assistant API. This agent type supports goal-driven interactions with features like code interpretation and file search through the OpenAI platform.

- **Anthropic Agent**: provides access to Anthropic's Claude models with the framework's unified interface, supporting advanced reasoning and conversation capabilities.

## Why you should use the Microsoft Agent Framework

The Microsoft Agent Framework offers a robust platform for building intelligent, autonomous, and collaborative AI agents. The framework can integrate agents from multiple sources, including Azure AI Foundry Agent Service, and supports both multi-agent collaboration and human-agent interaction. Agents can work together to orchestrate sophisticated workflows, where each agent specializes in a specific task, such as data collection, analysis, or decision-making. The framework also facilitates human-in-the-loop processes, enabling agents to augment human decision-making by providing insights or automating repetitive tasks. The provider-agnostic design allows you to switch between different AI providers without changing your code, making it suitable for building adaptable AI systems from simple chatbots to complex enterprise solutions.