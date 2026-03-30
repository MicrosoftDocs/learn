Microsoft Foundry provides flexibility for developing generative AI chat applications. Before you start development, it's important to understand the options that are available, and how to decide which of them to use. Some considerations for developing an application include:

- **Endpoints**: Microsoft Foundry projects provide two endpoints that you can use to connect to and consume project assets, such as model deployments, from client applications. Each project has both a *Project endpoint* and an *Azure OpenAI endpoint*.
- **Client SDK**: Depending on the endpoint you select, you can choose to use the *Microsoft Foundry SDK* or the *OpenAI SDK* to develop a generative AI chat application. Both SDKs support an OpenAI API compatible client object that can submit prompts to models, but there are some differences in the specific functionality available in each SDK.
- **Authentication**: Depending on the endpoint and SDK you choose to use, there are multiple ways a client application can be authenticated by Foundry in order to be granted access to assets. In general, production applications should use *Microsoft Entra ID* authentication, which requires the application to be running in the context of a specific identity; but in some scenarios you can also use *key-based* or *token-based* authentication.
- **Chat API**: The OpenAI client API supports two chat APIs: *ChatCompletions* and *Responses*. While the *Responses* API is recommended for most new development projects, the *ChatCompletions* API is well-established and compatible across many generative AI models and platforms.

Let's start by considering the available endpoints, client SDKs, and authentication methods - we'll explore the Responses and ChatCompletions APIs later.

## Using the Foundry SDK with the project endpoint

The Microsoft Foundry SDK provides programmatic access to resources in your projects through a REST API and language-specific client libraries; including:

- [Azure AI Projects for Python](https://pypi.org/project/azure-ai-projects?azure-portal=true)
- [Azure AI Projects for Microsoft .NET](https://www.nuget.org/packages/Azure.AI.Projects?azure-portal=true)
- [Azure AI Projects for JavaScript](https://www.npmjs.com/package/@azure/ai-projects?azure-portal=true)

> [!NOTE]
> This module uses Python code examples for common tasks. You can refer to the language-specific SDK documentation for equivalent code in your preferred language. Each SDK is developed and maintained independently, so some functionality may be at different stages of implementation.

### Installing the SDK

To use the Azure AI Projects library in Python, install the **azure-ai-projects** package from PyPI along with supporting packages:

```bash
pip install azure-ai-projects azure-identity openai
```

> [!NOTE]
> When using the Foundry SDK to develop a chat application, you also need to import the OpenAI SDK package - the chat client functionality in the Foundry SDK is derived from the OpenAI SDK.

### Connecting to the project endpoint

Each Foundry project has a unique endpoint that you can find on the project's **Overview** page in the Foundry portal at [https://ai.azure.com](https://ai.azure.com?azure-portal=true).

The project endpoint follows this format:

```
https://{resource-name}.services.ai.azure.com/api/projects/<project-name>
```

Use this endpoint to create an **AIProjectClient** object:

```python
from azure.identity import DefaultAzureCredential
from azure.ai.projects import AIProjectClient

project_endpoint = "https://{resource-name}.services.ai.azure.com/api/projects/<project-name>"
project_client = AIProjectClient(
    credential=DefaultAzureCredential(),
    endpoint=project_endpoint
)
```

> [!NOTE]
> The code uses default Azure credentials to authenticate. To enable this authentication, you need to install the **azure-identity** package (shown in the installation command earlier).

> [!TIP]
> To access the project successfully, the code must run in an authenticated Azure session. For example, you can use the Azure CLI `az login` command to sign in before running the code.

The project client (`AIProjectClient`) provides access to Foundry-native operations that don't have OpenAI equivalents. Use the project client to:

- Retrieve resource connections
- Access project configuration
- Enable tracing
- Manage datasets and indexes

### Creating a chat client

To chat with a model in your Foundry project, you need an OpenAI-compatible client object. You can use the **get_openai_client()** method of the project client to get one, like this:

```python
openai_client = project_client.get_openai_client(api_version="2024-10-21")
```

You can then use this chat client object to submit prompts to models and return responses.

## Using the OpenAI SDK with the Azure OpenAI endpoint

The OpenAI SDK is the official client library for calling the OpenAI API. It handles HTTP requests, authentication, retries, and response parsing. The SDK works with OpenAI-hosted models, Azure OpenAI deployments, and Foundry models using the same patterns.

### Installing the SDK

To use the OpenAI library in Python, install the **openai** package from PyPI along with supporting packages:

```bash
pip install openai azure-identity
```

> [!NOTE]
> The *azure-identity* package is required if you intend to use token-based authentication to connect to the endpoint using Microsoft Entra ID credentials.

### Connecting to the Azure OpenAI endpoint

Each Foundry project includes an Azure OpenAI endpoint that you can find on the project's **Overview** page in the Foundry portal at [https://ai.azure.com](https://ai.azure.com?azure-portal=true).

The Azure OpenAI endpoint follows this format:

```
https://{resource-name}.openai.azure.com/openai/v1
```

Create an OpenAI client with your endpoint and Azure credentials:

```python
from openai import OpenAI
from azure.identity import DefaultAzureCredential, get_bearer_token_provider

token_provider = get_bearer_token_provider(
    DefaultAzureCredential(), "https://ai.azure.com/.default"
)

openai_client = OpenAI(  
  base_url = "https://{resource-name}.openai.azure.com/openai/v1/",  
  api_key=token_provider,
)
```

In addition to Microsoft Entra ID (recommended), you can authenticate using an API key or environment variables.

**API key authentication:**

```python
import os
from openai import OpenAI

openai_client = OpenAI(
    api_key=os.getenv("AZURE_OPENAI_API_KEY"),
    base_url="https://{resource-name}.openai.azure.com/openai/v1/"
)
```

> [!IMPORTANT]
> Use API keys with caution. Store them securely in Azure Key Vault and never include them directly in your code.

**Environment variables:**

If you set `OPENAI_BASE_URL` and `OPENAI_API_KEY` environment variables, the client uses them automatically:

```python
from openai import OpenAI

openai_client = OpenAI()  # Uses environment variables
```

Regardless of how you choose to authenticate, the **OpenAI** client handles model inference operations. Use it for:

- Generating responses with the Responses API
- Chat completions and image generation
- Accessing Foundry direct models (non-Azure OpenAI models)

**Using an *AzureOpenAI* client object**

You should generally use the **OpenAI** client object to chat with models through the Azure OpenAI v1 endpoint. However, you also have the option to create an **AzureOpenAI** client object if you need to use functionality from a specific version of the Azure OpenAI API. To create an **AzureOpenAI** client object, you must specify the API version and the Azure endpoint, like this:

```python
import os
from openai import AzureOpenAI
    
openai_client = AzureOpenAI(
    azure_endpoint = "https://{resource-name}.openai.azure.com"
    api_key=os.getenv("AZURE_OPENAI_KEY"),  
    api_version="2024-10-21",
)
```

## Choosing between the Foundry SDK and OpenAI SDK

Microsoft Foundry supports two approaches for building AI applications. Each serves different purposes, and understanding when to use each one helps you build the right solution.

### When to use the Foundry SDK

Use the Foundry SDK when your application needs Foundry-specific capabilities:

- **Foundry Agent Service** for building and managing AI agents
- **Tool invocation and approval** workflows
- **Cloud evaluations** for testing and validating AI responses
- **Tracing and observability** for monitoring application behavior
- **Foundry direct models** (non-Azure OpenAI models available through the model catalog)
- **Project metadata, connections, and governance** features

Microsoft recommends the Foundry SDK when building apps with agents, evaluations, or Foundry-specific features.

### When to use the OpenAI SDK

Use the OpenAI SDK when you need maximum compatibility with the OpenAI API:

- **Full OpenAI API compatibility** for existing code and tooling
- **Portability** between OpenAI and Azure OpenAI deployments
- **Chat Completions, Responses, and Images** APIs
- **Minimal dependency** on Foundry-specific concepts

The OpenAI SDK is ideal for model inference workloads where you want existing OpenAI code to work with minimal changes. However, this approach doesn't provide Foundry-specific features like agents or evaluations.

Microsoft Foundry gives you flexibility in how you build AI applications. Use the Foundry SDK with `AIProjectClient` when you need project-level features like agents, evaluations, tracing, and connections. Use the OpenAI SDK when you need straightforward model inference with maximum OpenAI compatibility. Both SDKs work with your Foundry project endpoint, so you can combine them as needed in your applications. You can also use both SDKs together in the same application—the Foundry SDK for project features and the OpenAI SDK for model inference.
