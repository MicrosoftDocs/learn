**AzureAIAgent** is a specialized agent within the Semantic Kernel framework, designed to provide advanced conversational capabilities with seamless tool integration. It automates tool calling, eliminating the need for manual parsing and invocation. The agent also securely manages conversation history using threads, reducing the overhead of maintaining state. The AzureAIAgent class supports a variety of built-in tools, including file retrieval, code execution, and data interaction via Bing, Azure AI Search, Azure Functions, and OpenAPI.

## Creating an AzureAIAgent

An AzureAIAgent object encapsulates all the core capabilities you typically use the Kernel for, like function execution, planning, and memory access. This object acts as a self-contained agent runtime.

To use an AzureAIAgent:
1. Create an Azure AI Foundry project.
1. Add the project connection string to your Semantic Kernel application code.
1. Create an AzureAIAgentSettings object.
1. Create an AzureAIAgent client.
1. Create an agent definition on the agent service provided by the client.
1. Create an agent based on the definition.

Here is the code that illustrates how to create an AzureAIAgent:

```python
from azure.identity.aio import DefaultAzureCredential
from semantic_kernel.agents import AzureAIAgent, AzureAIAgentSettings

# Create an AzureAIAgentSettings object
ai_agent_settings = AzureAIAgentSettings.create()

# Create an AzureAIAgent client
async with (@
    DefaultAzureCredential() as creds,
    AzureAIAgent.create_client(credential=creds) as client,
):
    # Create an agent definition on the agent service provided by the client
    agent_definition = await client.agents.create_agent(
        model=ai_agent_settings.model_deployment_name,
        name="<name>",
        instructions="<instructions>",
    )

    # Create the AI agent based on the agent definition
    agent = AzureAIAgent(
        client=client,
        definition=agent_definition,
    )
```

Once your agent is defined, you can create a thread to interact with your agent and invoke responses for inputs. For example:

```python
# Use the client agent service to create a thread
thread = await client.agents.create_thread()

try:
    # Create prompts
    prompt_messages = ["What are the largest semiconductor manufacturing companies?"]

    # Invoke a response from the agent
    response = await agent.get_response(messages=prompt_messages, thread_id=thread.id)

    # View the response
    print(response)
finally:
    # Clean up the thread
    await client.agents.delete_thread(thread.id)
```

### AzureAIAgent key components

The Semantic Kernel AzureAIAgent object relies on the following components to function:

- **AzureAISAgentSettings** - an object that automatically includes the Azure AI Agent settings from the environment configuration. These settings will be used by the AzureAIAgents you create.

- **AzureAIAgent client** - an object that manages the connection to your Azure AI Foundry project. This object allows you to access the services and models associated with your project. 

- **Agent service** - the AzureAIAgent client also contains an agent operations service. This service helps streamline the process of creating, managing, and running the agents for your project.

- **Agent definition** - the AzureAI Agent model created via the AzureAI Project client. This definition specifies the AI deployment model that should be used, as well as the name and instructions for the agent.

- **AzureAIAgentThread** - automatically maintains the conversation history between agents and users, as well as the state. You can add messages to a thread and use the agent to invoke a response from the LLM.

These components work together to allow you to create an agent with instructions to define its purpose and invoke responses from the AI model.