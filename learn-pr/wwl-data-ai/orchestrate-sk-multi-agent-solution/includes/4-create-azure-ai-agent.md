An `AzureAIAgent` is a specialized type of agent within the Semantic Kernel Agent Framework. This type of agent integrates Azure OpenAI services to process user inputs, make decisions, and execute tasks. These agents leverage a large language model to provide intelligent, context-aware interactions in applications. To use an `AzureAIAgent`, you must have an Azure AI Foundry Project.

## Connect to your Azure AI Foundry Project 

Before creating your agent, you must define your Azure AI Foundry Project settings in your development environment. You can do this by setting the properties in your .env file.

```
AZURE_AI_AGENT_PROJECT_CONNECTION_STRING="your-project-connection-string"
AZURE_AI_AGENT_MODEL_DEPLOYMENT_NAME="your-language-model"
```

Afterwards you can connect your Semantic Kernel project to your Azure AI service:

```python
from azure.identity.aio import DefaultAzureCredential
from semantic_kernel.agents.azure_ai import AzureAIAgent, AzureAIAgentSettings

async def main():
    ai_agent_settings = AzureAIAgentSettings.create()

    async with (
        DefaultAzureCredential() as creds,
        AzureAIAgent.create_client(credential=creds) as client,
    ):
```

TODO explain **AzureAIAgentSettings**
TODO explain **DefaultAzureCredential**
TODO explain **AzureAIAgent.create_client**

## Define your Azure AI Agent

To create an Azure AI Agent, you need to provide a definition for the agent that contains its instructions:

```python
# Define an agent on the Azure AI agent service
agent_definition = await client.agents.create_agent(
    model=ai_agent_settings.model_deployment_name,
    name="<agent-name>",
    instructions="<agent-instructions>",

)

# Create a Semantic Kernel agent based on the agent definition
agent = AzureAIAgent(
    client=client,
    definition=incident_agent_definition
)
```

## Create a chat thread

To interact with your agent, you can create a chat thread for user-agent interaction:

```python
USER_INPUTS = ["Hello", "What's your name?"]

# Create a chat thread to interact with the agent
thread = await client.agents.create_thread()

try:
    for user_input in USER_INPUTS:
        await agent.add_chat_message(thread_id=thread.id, message=user_input)
        response = await agent.get_response(thread_id=thread.id)
        print(response)
finally:
    # Delete the chat thread when finished
    await client.agents.delete_thread(thread.id)
```

## Retrieve existing agents

An existing agent can be retrieved and reused with the `agent_id`:

```python
agent = await client.agents.get_agent(agent_id="your-agent-id")
```

## Delete an agent

Agents and their associated threads can be deleted when no longer needed:

```python
await client.agents.delete_thread(thread.id)
await client.agents.delete_agent(agent.id)
```

Next, you can expand your agent by adding plugin functions to create a more robust experience.