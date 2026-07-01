::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=ccf350c2-42e4-4b99-b24b-766119c7a305]

> [!NOTE]
> See the **Text and images** tab for more details

::: zone-end

::: zone pivot="text"

After successfully testing Claude in the playground, the next step is to integrate it into your applications. Foundry provides everything you need to make API calls from your code, including pre-built code samples and authentication credentials.

## Connection information

To connect to your deployed model from client code, you'll need:

- The deployment *name* - the unique identifier for your model deployment.
- The deployment *endpoint* - the URL at which your model deployment can be accessed.
- Valid authentication credentials; which can be:
  - An *API key*, which can be used as a password that allows client applications to access the model.
  - A *Microsoft Entra ID token*, which verifies that the client application's identity has been validated by Microsoft Entra ID.

> [!CAUTION]
> Key-based authentication is convenient for testing and development, but Microsoft Entra ID authentication is recommended for production scenarios. You should treat API keys like any sensitive credential; storing them securely and avoiding hard-coding them in client code.

## Installing the SDK

When you're ready to write client code, the first step is to install the Anthropic SDK for your chosen language. For example, you can install the Python SDK by using the *pip* utility:

```bash
pip install anthropic
```

If you plan to use Microsoft Entra ID authentication, you should also install the *Azure Identity* SDK package.

```bash
pip install azure-identity
```

## Writing code to use Claude

The basic pattern to use a Claude model in Foundry consists of three main steps:

1. Connect to the deployment endpoint.
1. Submit a prompt to the model.
1. Process the model's response.

Here's a minimal example of calling Claude in Foundry:

```python
from anthropic import AnthropicFoundry

# Connect to the deployment endpoint
client = AnthropicFoundry(
    api_key=YOUR_API_KEY,
    base_url=YOUR_DEPLOYMENT_ENDPOINT
)

# Submit a prompt to the model
message = client.messages.create(
    model=YOUR_DEPLOYMENT_NAME,
    messages=[
        {"role": "user", "content": "What is the capital of France?"}
    ],
    max_tokens=1024,
)

# Process the model's response
print(message.content[0].text)
```

To use Microsoft Entra ID authentication instead of the API key, use a bearer token provider for Microsoft Foundry instead of the API key, like this:

```python
from anthropic import AnthropicFoundry
from azure.identity import DefaultAzureCredential, get_bearer_token_provider

# Get a token provider for Entra ID authentication
tokenProvider = get_bearer_token_provider(
    DefaultAzureCredential(), "https://ai.azure.com/.default"
)

# Connect to the deployment endpoint
client = AnthropicFoundry(
    azure_ad_token_provider=tokenProvider,
    base_url=YOUR_DEPLOYMENT_ENDPOINT
)

# Submit a prompt to the model
message = client.messages.create(
    model=YOUR_DEPLOYMENT_NAME,
    messages=[
        {"role": "user", "content": "What is the capital of France?"}
    ],
    max_tokens=1024,
)

# Process the model's response
print(message.content[0].text)
```

::: zone-end
