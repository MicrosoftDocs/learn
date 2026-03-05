**Microsoft Foundry Agent** is a specialized agent within the Microsoft Agent Framework, designed to provide enterprise-level conversational capabilities with seamless tool integration. It automatically handles tool calling, so you don't need to manually parse and invoke functions. The agent also securely manages conversation history using threads, which reduces the work of maintaining state. The Microsoft Foundry Agent supports many built-in tools, including code interpreter, file search, and web search. It also provides integration capabilities for Azure AI Search, Azure Functions, and other Azure services.

## Creating an Azure AI Agent

A Microsoft Foundry Agent includes all the core capabilities you typically need for enterprise AI applications, like function execution, planning, and memory access. This agent acts as a self-contained runtime with enterprise-level features.

To use a Microsoft Foundry Agent:
1. Create a Microsoft Foundry project.
1. Add the project connection string to your Microsoft Agent Framework application code.
1. Set up authentication credentials with `AzureCliCredential`.
1. Connect to your project client with the `AzureOpenAIResponsesClient` class.
1. Create an `Agent` instance with the client, instructions, and tools you want to use.

Once your agent is created, you can create a conversation session to interact with your agent and get responses to your questions. 

### Azure AI Agent key components

The Microsoft Agent Framework Azure AI Agent uses the following components to work:

- **AzureOpenAIResponsesClient** - manages the connection to your Microsoft Foundry project. This client lets you access the services and models associated with your project and provides enterprise-level authentication and security features.

- **Agent** - the main agent class that combines the client, instructions, and tools to create a working AI agent that can handle conversations and complete tasks.

- **AgentSession** - automatically keeps track of conversation history between agents and users, and manages the conversation state. You can create new threads or reuse existing ones to maintain context across interactions.

- **Tools integration** - support for custom functions that extend agent capabilities. Functions are automatically registered and can be called by agents to connect with external APIs and services.

- **Authentication credentials** - supports Azure CLI credentials, service principal authentication, and other Azure identity options for secure access to Foundry Tools.

- **Thread management** - provides flexible options for thread creation, including automatic thread creation for simple scenarios and explicit thread management for ongoing conversations.

These components work together to let you create enterprise-level agents with instructions to define their purpose and get responses from AI models while maintaining security, scalability, and conversation context for business applications.

