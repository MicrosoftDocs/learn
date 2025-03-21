Semantic Kernel is an open-source SDK that enables developers to integrate AI models into their applications. Part of that SDK is the *Semantic Kernel Agents Framework*, enabling the creation of agents using the same features that exist in the core Semantic Kernel framework.

## What is the Semantic Kernel Agent Framework?

The Semantic Kernel Agent Framework is a framework designed to help developers build AI-powered agents. These agents can process user inputs, make decisions, and execute tasks autonomously by leveraging large language models and traditional programming logic. The framework provides structured components for defining AI-driven workflows, enabling agents to interact with users, APIs, and external services.

### Core Concepts

The Agent Framework in Semantic Kernel provides architecture on top of existing Semantic Kernel resources, including:

- **Agents**

    Agents are intelligent, AI-driven entities capable of reasoning and executing tasks. They use language models, functions, and memory to make decisions dynamically.

- **Agent Collaboration**

    Agents can collaborate together through an **agent group chat**, which enables multiple agents to join the same chat, even of different agent types. Agent group chats determine which agent should respond and how to determine if the conversation is finished.

The features that power Semantic Kernel are also still available within the Agent Framework, including:

- **Kernel**

    The kernel is the central component of the Semantic Kernel. The kernel acts as the execution engine, managing AI interactions, function orchestration, and memory.

- **Tools and Plugins**

    **Plugins** align with existing Semantic Kernel features, enabling agents to dynamically interact with external services or execute complex tasks through function calling.  Within the Agent Framework, **tools** are available to provide extra functionality to your agents, such as file searching or code interpreter, similar to tool usage in Azure AI Agent service. Agents use tools and plugins to perform specific tasks.

- **History**

    Agents can maintain chat history across multiple interactions, allowing them to track previous interactions and adapt responses accordingly. The conversation history is always accessible by the agents, either as a whole or for a specific agent's chat history.

### Types of Agents

The Semantic Kernel Agent Framework supports several different types of agents, including:

- **Azure AI Agent** - a specialized agent within the Semantic Kernel Agent Framework. The `AsureAIAgent` type is designed to provide advanced conversational capabilities with seamless tool integration. It automates tool calling and securely manages conversation history using threads, reducing the overhead of maintaining state. The `AzureAIAgent` also supports a variety of built-in tools, including file retrieval, code execution, and data interaction via Bing, Azure AI Search, Azure Functions, and OpenAPI.

- **Chat Completion Agent**: designed for chat completion and conversation interfaces. The `ChatCompletionAgent` type mirrors the features and patterns in the underlying AI Service to support natural language processing, contextual understanding, and dialogue management.

- **OpenAI Assistant Agent**: designed for more advanced capabilities and multi-step tasks. The `OpenAIAssistantAgent` type supports goal-driven interactions with additional features like code interpretation and file search.

## Why you should use the Semantic Kernel Agent Framework

The Semantic Kernel Agent Framework offers a robust platform for building intelligent, autonomous, and collaborative AI agents. The framework can integrate agents from multiple sources, including Azure AI Agent Service, and supports both multi-agent collaboration and human-agent interaction. Agents can work together to orchestrate sophisticated workflows, where each agent specializes in a specific task, such as data collection, analysis, or decision-making. The framework also facilitates human-in-the-loop processes, enabling agents to augment human decision-making by providing insights or automating repetitive tasks. This combination of autonomy, collaboration, and interactivity makes the Semantic Kernel Agent Framework an ideal choice for applications requiring dynamic, goal-oriented behavior.
