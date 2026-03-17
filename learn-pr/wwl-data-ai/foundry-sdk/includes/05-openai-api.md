The OpenAI SDK is the official client library for calling the OpenAI API. Use it when you want full OpenAI API compatibility and maximum portability with existing OpenAI code. The OpenAI SDK supports the Responses API for interacting with models. It also supports chat completions and image generation for Azure OpenAI endpoints.

## Installing the SDK

Install the OpenAI SDK along with Azure identity support:

```bash
pip install openai azure-identity
```

## Creating a client

Create an OpenAI client by providing your Azure OpenAI endpoint and credentials for Entra ID authentication:

```python
from openai import OpenAI
from azure.identity import DefaultAzureCredential, get_bearer_token_provider

token_provider = get_bearer_token_provider(
    DefaultAzureCredential(), "https://ai.azure.com/.default"
)

client = OpenAI(
    base_url="https://<resource-name>.openai.azure.com/openai/v1/",
    api_key=token_provider,
)
```

> [!TIP]
> Find your endpoint and API keys in the Azure portal under your resource's **Keys and Endpoint** page, or in the Microsoft Foundry portal.

### Authentication options

In addition to Microsoft Entra ID (recommended), you can authenticate using an API key or environment variables.

**API key authentication:**

```python
import os
from openai import OpenAI

client = OpenAI(
    api_key=os.getenv("AZURE_OPENAI_API_KEY"),
    base_url="https://<resource-name>.openai.azure.com/openai/v1/"
)
```

> [!IMPORTANT]
> Use API keys with caution. Store them securely in Azure Key Vault and never include them directly in your code.

**Environment variables:**

If you set `OPENAI_BASE_URL` and `OPENAI_API_KEY` environment variables, the client uses them automatically:

```python
from openai import OpenAI

client = OpenAI()  # Uses environment variables
```

## Generating responses

The Responses API is the primary way to generate AI responses. Use `responses.create()` with your model deployment name and input:

```python
response = client.responses.create(
    model="gpt-4.1",  # Your model deployment name
    input="What is the size of France in square miles?"
)

print(response.output_text)
```

### Adding instructions

Provide system instructions to guide the model's behavior:

```python
response = client.responses.create(
    model="gpt-4.1",
    instructions="You are a helpful AI assistant that answers questions clearly and concisely.",
    input="Explain machine learning in simple terms."
)

print(response.output_text)
```

### Maintaining conversation context

Link responses together using `previous_response_id` to maintain conversation context:

```python
# First turn
response1 = client.responses.create(
    model="gpt-4.1",
    instructions="You are a helpful assistant.",
    input="What is Python?"
)
print(response1.output_text)

# Continue the conversation
response2 = client.responses.create(
    model="gpt-4.1",
    instructions="You are a helpful assistant.",
    input="What are its main uses?",
    previous_response_id=response1.id
)
print(response2.output_text)
```

## Using chat completions

For compatibility with existing code, you can use the chat completions API:

```python
completion = client.chat.completions.create(
    model="gpt-4o",  # Your model deployment name
    messages=[
        {"role": "system", "content": "You are a helpful assistant."},
        {"role": "user", "content": "When was Microsoft founded?"}
    ]
)

print(completion.choices[0].message.content)
```

## Streaming responses

For long responses, use streaming to receive output incrementally:

```python
stream = client.responses.create(
    model="gpt-4.1",
    input="Write a short story about a robot learning to paint.",
    stream=True
)

for event in stream:
    print(event, end="", flush=True)
```

## Async usage

For high-performance applications, `AsyncOpenAI` is available as the asynchronous client that allows you to make non-blocking API calls. To use it, import `AsyncOpenAI` instead of `OpenAI` and use `await` with each API call:


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

## Controlling response generation

Use parameters to control how the model generates responses:

```python
response = client.responses.create(
    model="gpt-4.1",
    input="Write a creative story about AI.",
    temperature=0.8,  # Higher = more creative (0.0-2.0)
    max_output_tokens=200  # Limit response length
)

print(response.output_text)
```

## Azure OpenAI support

In some cases, you may want to support different Azure OpenAI patterns. To use this library with Azure OpenAI, use the `AzureOpenAI` class instead of the `OpenAI` class and specify the API version.

```python
# gets the API Key from environment variable AZURE_OPENAI_API_KEY
client = AzureOpenAI(
    api_version="2023-07-01-preview",
    azure_endpoint="https://example-endpoint.openai.azure.com",
)

completion = client.chat.completions.create(
    model="deployment-name",
    messages=[
        {
            "role": "user",
            "content": "How do I output all files in a directory using Python?",
        },
    ],
)
```

The OpenAI SDK provides a straightforward way to integrate AI capabilities into your applications with full compatibility across OpenAI and Azure OpenAI endpoints.
