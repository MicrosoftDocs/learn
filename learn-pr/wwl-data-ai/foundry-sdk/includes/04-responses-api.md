The Responses API brings together capabilities from chat completions and the Assistants API in a unified experience. It provides stateful, multi-turn response generation, making it ideal for conversational AI applications. With the Microsoft Foundry SDK, you can access the Responses API through an OpenAI-compatible client.

## Understanding the Responses API

The Responses API offers several advantages over traditional chat completions:

- **Stateful conversations**: Maintains conversation context across multiple turns
- **Unified experience**: Combines chat completions and Assistants API patterns
- **Foundry direct models**: Works with models hosted directly in Microsoft Foundry, not just Azure OpenAI models
- **Simple integration**: Access through the OpenAI-compatible client

> [!NOTE]
> The Responses API is the recommended approach for generating AI responses in Microsoft Foundry applications. It replaces the older chat completions API for most scenarios.

## Getting started with the Responses API

To use the Responses API, you first need to connect to your project and obtain an OpenAI-compatible client:

```python
from azure.identity import DefaultAzureCredential
from azure.ai.projects import AIProjectClient

# Connect to the project
project_endpoint = "https://<resource-name>.services.ai.azure.com/api/projects/<project-name>"
project_client = AIProjectClient(
    credential=DefaultAzureCredential(),
    endpoint=project_endpoint
)

# Get OpenAI-compatible client
openai_client = project_client.get_openai_client(api_version="2024-10-21")
```

## Generating a simple response

Once you have the OpenAI-compatible client, you can generate responses using the **responses.create()** method:

```python
from azure.identity import DefaultAzureCredential
from azure.ai.projects import AIProjectClient

try:
    # Connect to project
    project_endpoint = "https://<resource-name>.services.ai.azure.com/api/projects/<project-name>"
    project_client = AIProjectClient(
        credential=DefaultAzureCredential(),
        endpoint=project_endpoint
    )
    
    # Get OpenAI-compatible client
    openai_client = project_client.get_openai_client(api_version="2024-10-21")
    
    # Generate a response
    response = openai_client.responses.create(
        model="gpt-4.1",  # Your model deployment name
        input="What is Microsoft Foundry?"
    )
    
    # Display the response
    print(response.output_text)

except Exception as ex:
    print(f"Error: {ex}")
```

The **input** parameter accepts a text string containing your prompt. The model generates a response based on this input.

## Creating conversational experiences

For more complex conversational scenarios, you can provide system instructions and build multi-turn conversations:

```python
from azure.identity import DefaultAzureCredential
from azure.ai.projects import AIProjectClient

try:
    # Connect to project
    project_endpoint = "https://<resource-name>.services.ai.azure.com/api/projects/<project-name>"
    project_client = AIProjectClient(
        credential=DefaultAzureCredential(),
        endpoint=project_endpoint
    )
    
    # Get OpenAI-compatible client
    openai_client = project_client.get_openai_client(api_version="2024-10-21")
    
    # First turn in the conversation
    response1 = openai_client.responses.create(
        model="gpt-4.1",
        instructions="You are a helpful AI assistant that explains technology concepts clearly.",
        input="What is machine learning?"
    )
    
    print("Assistant:", response1.output_text)
    
    # Continue the conversation
    response2 = openai_client.responses.create(
        model="gpt-4.1",
        instructions="You are a helpful AI assistant that explains technology concepts clearly.",
        input="Can you give me an example?",
        previous_response_id=response1.id
    )
    
    print("Assistant:", response2.output_text)

except Exception as ex:
    print(f"Error: {ex}")
```

The **previous_response_id** parameter links responses together, maintaining conversation context across multiple API calls.

### Alternative: Manual conversation chaining

You can also manage conversations manually by building the message history yourself. This approach gives you more control over what context is included:

```python
from azure.identity import DefaultAzureCredential
from azure.ai.projects import AIProjectClient

try:
    # Connect to project
    project_endpoint = "https://<resource-name>.services.ai.azure.com/api/projects/<project-name>"
    project_client = AIProjectClient(
        credential=DefaultAzureCredential(),
        endpoint=project_endpoint
    )
    
    openai_client = project_client.get_openai_client(api_version="2024-10-21")
    
    # Start with initial message
    conversation_history = [
        {"type": "message", "role": "user", "content": "What is machine learning?"}
    ]
    
    # First response
    response1 = openai_client.responses.create(
        model="gpt-4.1",
        input=conversation_history
    )
    
    print("Assistant:", response1.output_text)
    
    # Add assistant response to history
    conversation_history += response1.output
    
    # Add new user message
    conversation_history.append({
        "type": "message",
        "role": "user", 
        "content": "Can you give me an example?"
    })
    
    # Second response with full history
    response2 = openai_client.responses.create(
        model="gpt-4.1",
        input=conversation_history
    )
    
    print("Assistant:", response2.output_text)

except Exception as ex:
    print(f"Error: {ex}")
```

This manual approach is useful when you need to:
- Customize which messages are included in context
- Implement conversation pruning to manage token limits
- Store and restore conversation history from a database

## Understanding response structure

A response object contains several useful properties:

- **output_text**: The generated text response
- **id**: Unique identifier for this response
- **status**: Response status (for example, "completed")
- **usage**: Token usage information (input, output, and total tokens)
- **model**: The model used to generate the response

You can access these properties to handle responses effectively:

```python
response = openai_client.responses.create(
    model="gpt-4.1",
    input="Explain neural networks briefly."
)

print(f"Response: {response.output_text}")
print(f"Response ID: {response.id}")
print(f"Tokens used: {response.usage.total_tokens}")
print(f"Status: {response.status}")
```

## Retrieving previous responses

The Responses API maintains response history, allowing you to retrieve previous responses:

```python
from azure.identity import DefaultAzureCredential
from azure.ai.projects import AIProjectClient

try:
    # Connect and get client
    project_endpoint = "https://<resource-name>.services.ai.azure.com/api/projects/<project-name>"
    project_client = AIProjectClient(
        credential=DefaultAzureCredential(),
        endpoint=project_endpoint
    )
    
    openai_client = project_client.get_openai_client(api_version="2024-10-21")
    
    # Retrieve a previous response
    response_id = "resp_67cb61fa3a448190bcf2c42d96f0d1a8"  # Example ID
    previous_response = openai_client.responses.retrieve(response_id)
    
    print(f"Previous response: {previous_response.output_text}")

except Exception as ex:
    print(f"Error: {ex}")
```

## Controlling response generation

You can control response generation with additional parameters:

```python
response = openai_client.responses.create(
    model="gpt-4.1",
    input="Write a creative story about AI.",
    temperature=0.8,  # Higher temperature for more creativity
    max_output_tokens=200  # Limit response length
)

print(response.output_text)
```

- **temperature**: Controls randomness (0.0-2.0). Higher values make output more creative and varied
- **max_output_tokens**: Limits the maximum number of tokens in the response
- **top_p**: Alternative to temperature for controlling randomness

## Working with Foundry direct models

The Responses API works with both Azure OpenAI models and Foundry direct models (such as Microsoft Phi, DeepSeek, or other models hosted directly in Microsoft Foundry):

```python
# Using a Foundry direct model
response = openai_client.responses.create(
    model="microsoft-phi-4",  # Example Foundry direct model
    input="What are the benefits of small language models?"
)

print(response.output_text)
```

By using the Responses API through the Microsoft Foundry SDK, you can build sophisticated conversational AI applications that maintain context, support multiple model types, and provide a unified development experience.
