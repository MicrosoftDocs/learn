The OoenAI *Responses* API brings together capabilities from two previously separate APIs (*ChatCompletions* and *Assistants*) in a unified experience. It provides stateful, multi-turn response generation, making it ideal for conversational AI applications. You can access the Responses API through an OpenAI-compatible client using either the Foundry SDK or the OpenAI SDK.

## Understanding the Responses API

The *Responses* API offers several advantages over traditional chat completions:

- **Stateful conversations**: Maintains conversation context across multiple turns
- **Unified experience**: Combines chat completions and Assistants API patterns
- **Foundry direct models**: Works with models hosted directly in Microsoft Foundry, not just Azure OpenAI models
- **Simple integration**: Access through the OpenAI-compatible client

> [!NOTE]
> The *Responses* API is the recommended approach for generating AI responses in Microsoft Foundry applications. It replaces the older *ChatCompletions* API for most scenarios.

## Generating a simple response

With an OpenAI-compatible client, you can generate responses using the **responses.create()** method:

```python
# Generate a response using the OpenAI-compatible client
response = openai_client.responses.create(
    model="gpt-4.1",  # Your model deployment name
    input="What is Microsoft Foundry?"
)

# Display the response
print(response.output_text)
```

The **input** parameter accepts a text string containing your prompt. The model generates a response based on this input.

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
    input="Explain machine learning in simple terms."
)

print(f"Response: {response.output_text}")
print(f"Response ID: {response.id}")
print(f"Tokens used: {response.usage.total_tokens}")
print(f"Status: {response.status}")
```

### Adding instructions

In addition to the user *input*, you can provide *instructions* (often referred to as a *system prompt*) to guide the model's behavior:

```python
response = client.responses.create(
    model="gpt-4.1",
    instructions="You are a helpful AI assistant that answers questions clearly and concisely.",
    input="Explain neural networks."
)

print(response.output_text)
```

## Controlling response generation

You can control response generation with additional parameters:

```python
response = openai_client.responses.create(
    model="gpt-4.1",
    instructions="You are a helpful AI assistant that answers questions clearly and concisely.",
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

When using the FoundrySDK or AzureOpenAI client to connect to a *project* endpoint, the Responses API works with both Azure OpenAI models and Foundry direct models (such as Microsoft Phi, DeepSeek, or other models hosted directly in Microsoft Foundry):

```python
# Using a Foundry direct model
response = openai_client.responses.create(
    model="microsoft-phi-4",  # Example Foundry direct model
    instructions="You are a helpful AI assistant that answers questions clearly and concisely.",
    input="What are the benefits of small language models?"
)

print(response.output_text)
```

## Creating conversational experiences

For more complex conversational scenarios, you can provide system instructions and build multi-turn conversations:

```python
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
```

In reality, the implementation is likely to be constructed as a loop in which a user can interactively enter messages based on each response received from the model:

```python
# Track responses
last_response_id = None

# Loop until the user wants to quit
print("Assistant: Enter a prompt (or type 'quit' to exit)")
while True:
    input_text = input('\nYou: ')
    if input_text.lower() == "quit":
        print("Assistant: Goodbye!")
        break

    # Get a response
    response = openai_client.responses.create(
                model=model_name,
                instructions="You are a helpful AI assistant that explains technology concepts clearly.",
                input=input_text,
                previous_response_id=last_response_id
    )
    assistant_text = response.output_text
    print("\nAssistant:", assistant_text)
    last_response_id = response.id 
```

The output from this example looks similar to this:

```text
Assistant: Enter a prompt (or type 'quit' to exit)

You: What is machine learning?

Assistant: Machine learning is a type of artificial intelligence (AI) that enables computers to learn from data and improve their performance over time without being explicitly programmed. It involves training algorithms on large datasets to recognize patterns, make predictions, or take actions based on those patterns. This allows machines to become more accurate and efficient in their tasks as they are exposed to more data.

You: Can you give me an example?

Assistant: Certainly! Let's look at a simple example of supervised learning—predicting house prices based on features like size, location, and number of rooms.
Imagine you want to build a machine learning model that can predict the price of a house based on various factors.
...
    { the example provided in the model response may be extensice}
...

You: quit

Assistant: Goodbye!
```

As the user enters new input in each turn, the data sent to the model includes the *Instructions* system message, the *input* from the user, and the *previous* response received from the model. In this way, the new input is grounded in the context provided by the response the model generated for the previous input.

### Alternative: Manual conversation chaining

You can manage conversations manually by building the message history yourself. This approach gives you more control over what context is included:

```python
try:
    # Start with initial message
    conversation_history = [
        {
            "type": "message",
            "role": "user",
            "content": "What is machine learning?"
        }
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

### Retrieving specific previous responses

The Responses API maintains response history, allowing you to retrieve previous responses:

```python
try:   
   
    # Retrieve a previous response
    response_id = "resp_67cb61fa3a448190bcf2c42d96f0d1a8"  # Example ID
    previous_response = openai_client.responses.retrieve(response_id)
    
    print(f"Previous response: {previous_response.output_text}")

except Exception as ex:
    print(f"Error: {ex}")
```

### Context window considerations

The **previous_response_id** parameter links responses together, maintaining conversation context across multiple API calls.

It is important to note that keeping conversation history can increase token usage. For a single run, the active context window can include:

- System instructions (instructions, safety rules)
- Your current prompt
- Conversation history (previous user + assistant messages)
- Tool schemas (functions, OpenAPI specs, MCP tools, etc.)
- Tool outputs (search results, code interpreter output, files)
- Retrieved memory or documents (from memory stores, RAG, file search)

All of these are concatenated, tokenized, and sent to the model together on every request. The SDK helps you manage state, but it does not automatically make token usage cheaper.

## Creating responsive chat apps

Responses from a model can take some time to generate depending on factors like the specific model being used, the context window size, and the size of the prompt. User's may become frustrated if the app appears to "freeze" while waiting for a response, so it's important to consider app responsiveness in your implementation.

### Streaming responses

For long responses, you can use streaming to receive output incrementally - so the user sees partially complete responses as output becomes available:

```python
stream = openai_client.responses.create(
    model="gpt-4.1",
    input="Write a short story about a robot learning to paint.",
    stream=True
)

for event in stream:
    print(event, end="", flush=True)
```

If you're tracking conversation history when streaming, you can get the response ID when the stream ends, like this:

```python
stream = openai_client.responses.create(
    model="gpt-4.1",
    input="Write a short story about a robot learning to paint.",
    stream=True
)
for event in stream:
                if event.type == "response.output_text.delta":
                    print(event.delta, end="")
                elif event.type == "response.completed":
                    response_id = event.response.id
```

### Async usage

For high-performance applications, you can use an asynchronous client that allows you to make non-blocking API calls. Asynchronous usage is ideal for long-running requests or when you want to handle multiple requests concurrently without blocking your application. To use it, import `AsyncOpenAI` instead of `OpenAI` and use `await` with each API call:

```python
import asyncio
from openai import AsyncOpenAI

client = AsyncOpenAI(
    base_url="https://<resource-name>.openai.azure.com/openai/v1/",
    api_key=token_provider,
)

async def main():
    response = await client.responses.create(
        model="gpt-4.1",
        input="Explain quantum computing briefly."
    )
    print(response.output_text)

asyncio.run(main())
```

Async streaming works the same way:

```python
async def stream_response():
    stream = await client.responses.create(
        model="gpt-4.1",
        input="Write a haiku about coding.",
        stream=True
    )
    
    async for event in stream:
        print(event, end="", flush=True)

asyncio.run(stream_response())
```

By using the *Responses* API through the Microsoft Foundry SDK, you can build sophisticated conversational AI applications that maintain context, support multiple model types, and provide a responsive user experience.
