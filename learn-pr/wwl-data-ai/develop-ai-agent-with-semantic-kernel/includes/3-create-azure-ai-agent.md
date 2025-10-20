**Azure AI Foundry Agent** is a specialized agent within the Microsoft Agent Framework, designed to provide enterprise-level conversational capabilities with seamless tool integration. It automatically handles tool calling, so you don't need to manually parse and invoke functions. The agent also securely manages conversation history using threads, which reduces the work of maintaining state. The Azure AI Foundry Agent supports many built-in tools, including code interpreter, file search, and web search. It also provides integration capabilities for Azure AI Search, Azure Functions, and other Azure services.

## Creating an Azure AI Foundry Agent

An Azure AI Foundry Agent includes all the core capabilities you typically need for enterprise AI applications, like function execution, planning, and memory access. This agent acts as a self-contained runtime with enterprise-level features.

To use an Azure AI Foundry Agent:
1. Create an Azure AI Foundry project.
1. Add the project connection string to your Microsoft Agent Framework application code.
1. Set up authentication credentials.
1. Create a `ChatAgent` with an `AzureAIAgentClient`.
1. Define tools and instructions for your agent.

Here's the code that shows how to create an Azure AI Foundry Agent:

```python
from agent_framework import AgentThread, ChatAgent
from agent_framework.azure import AzureAIAgentClient
from azure.identity.aio import AzureCliCredential

def get_weather(
    location: Annotated[str, Field(description="The location to get the weather for.")],
) -> str:
    """Get the weather for a given location."""
    return f"The weather in {location} is sunny with a high of 25°C."

# Create a ChatAgent with Azure AI client
async with (
    AzureCliCredential() as credential,
    ChatAgent(
        chat_client=AzureAIAgentClient(async_credential=credential),
        instructions="You are a helpful weather agent.",
        tools=get_weather,
    ) as agent,
):
    # Agent is now ready to use
```

Once your agent is created, you can create a thread to interact with your agent and get responses to your questions. For example:

```python
# Create the agent thread for ongoing conversation
thread = agent.get_new_thread()

# Ask questions and get responses
first_query = "What's the weather like in Seattle?"
print(f"User: {first_query}")
first_result = await agent.run(first_query, thread=thread)
print(f"Agent: {first_result.text}")
```

### Azure AI Foundry Agent key components

The Microsoft Agent Framework Azure AI Foundry Agent uses the following components to work:

- **AzureAIAgentClient** - manages the connection to your Azure AI Foundry project. This client lets you access the services and models associated with your project and provides enterprise-level authentication and security features.

- **ChatAgent** - the main agent class that combines the client, instructions, and tools to create a working AI agent that can handle conversations and complete tasks.

- **AgentThread** - automatically keeps track of conversation history between agents and users, and manages the conversation state. You can create new threads or reuse existing ones to maintain context across interactions.

- **Tools integration** - support for custom functions that extend agent capabilities. Functions are automatically registered and can be called by agents to connect with external APIs and services.

- **Authentication credentials** - supports Azure CLI credentials, service principal authentication, and other Azure identity options for secure access to Azure AI services.

- **Thread management** - provides flexible options for thread creation, including automatic thread creation for simple scenarios and explicit thread management for ongoing conversations.

These components work together to let you create enterprise-level agents with instructions to define their purpose and get responses from AI models while maintaining security, scalability, and conversation context for business applications.