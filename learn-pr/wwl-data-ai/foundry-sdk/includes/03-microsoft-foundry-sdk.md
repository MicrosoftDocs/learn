Microsoft Foundry supports two SDKs for building AI applications: the **Foundry SDK** for project-level features like agents, evaluations, and connections, and the **OpenAI SDK** for model inference with full OpenAI API compatibility.

## Understanding the Foundry SDK

The Microsoft Foundry SDK provides programmatic access to resources in your projects through a REST API and language-specific client libraries. Available SDKs include:

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

### Foundry project client

The **project client** (`AIProjectClient`) provides access to Foundry-native operations that don't have OpenAI equivalents. Use the project client to:

- Retrieve resource connections
- Access project configuration
- Enable tracing
- Manage datasets and indexes

### Connecting to a project

Each Foundry project has a unique endpoint that you can find on the project's **Overview** page in the Foundry portal at [https://ai.azure.com](https://ai.azure.com?azure-portal=true).

The project endpoint follows this format:

```
https://<resource-name>.services.ai.azure.com/api/projects/<project-name>
```

Use this endpoint to create an **AIProjectClient** object:

```python
from azure.identity import DefaultAzureCredential
from azure.ai.projects import AIProjectClient

project_endpoint = "https://<resource-name>.services.ai.azure.com/api/projects/<project-name>"
project_client = AIProjectClient(
    credential=DefaultAzureCredential(),
    endpoint=project_endpoint
)
```

> [!NOTE]
> The code uses default Azure credentials to authenticate. To enable this authentication, you need to install the **azure-identity** package (shown in the installation command earlier).

> [!TIP]
> To access the project successfully, the code must run in an authenticated Azure session. For example, you can use the Azure CLI `az login` command to sign in before running the code.

## Understanding the OpenAI SDK

The OpenAI SDK is the official client library for calling the OpenAI API. It handles HTTP requests, authentication, retries, and response parsing. The SDK works with OpenAI-hosted models, Azure OpenAI deployments, and Foundry models using the same patterns.

### Installing the SDK

To use the OpenAI library in Python, install the **openai** package from PyPI along with supporting packages:

```bash
pip install openai azure-identity
```

### OpenAI client

The **OpenAI client** handles model inference operations. Use it for:

- Generating responses with the Responses API
- Chat completions and image generation
- Accessing Foundry direct models (non-Azure OpenAI models)

### Creating an OpenAI client

Each Foundry project includes an OpenAI endpoint that you can find on the project's **Overview** page in the Foundry portal at [https://ai.azure.com](https://ai.azure.com?azure-portal=true).

The project endpoint follows this format:
```
https://<resource-name>.openai.azure.com/openai/v1
```

Use this endpoint to create an **AIProjectClient** object:

Create an OpenAI client with your endpoint and Azure credentials:

```python
from openai import OpenAI
from azure.identity import DefaultAzureCredential, get_bearer_token_provider

token_provider = get_bearer_token_provider(
    DefaultAzureCredential(), "https://ai.azure.com/.default"
)

client = OpenAI(  
  base_url = "https://YOUR-RESOURCE-NAME.openai.azure.com/openai/v1/",  
  api_key=token_provider,
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