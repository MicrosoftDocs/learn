Microsoft Foundry provides a unified approach for building AI applications by connecting to a single project endpoint. The Microsoft Foundry SDK enables developers to work with resources in a Foundry project through language-specific client libraries, making it easier to build AI apps that leverage models, connections, and other resources.

## Understanding the Microsoft Foundry SDK

The Microsoft Foundry SDK provides programmatic access to resources in your projects through a REST API and language-specific client libraries. Available SDKs include:

- [Azure AI Projects for Python](https://pypi.org/project/azure-ai-projects?azure-portal=true)
- [Azure AI Projects for Microsoft .NET](https://www.nuget.org/packages/Azure.AI.Projects?azure-portal=true)
- [Azure AI Projects for JavaScript](https://www.npmjs.com/package/@azure/ai-projects?azure-portal=true)

> [!NOTE]
> This module uses Python code examples for common tasks. You can refer to the language-specific SDK documentation for equivalent code in your preferred language. Each SDK is developed and maintained independently, so some functionality may be at different stages of implementation.

## Installing the SDK

To use the Azure AI Projects library in Python, install the **azure-ai-projects** package from PyPI along with supporting packages:

```bash
pip install azure-ai-projects azure-identity openai
```

## Two client types

The Microsoft Foundry SDK exposes two distinct client types to support different operations:

### Project client

The **project client** (`AIProjectClient`) provides access to Foundry-native operations that don't have OpenAI equivalents. Use the project client to:

- List and retrieve resource connections
- Access project properties and configuration
- Enable application tracing
- Manage datasets and indexes

### OpenAI-compatible client

The **OpenAI-compatible client** handles operations that build on OpenAI concepts and patterns. Use this client for:

- Generating responses with the Responses API
- Working with agents
- Running evaluations
- Fine-tuning models
- Accessing Foundry direct models (non-Azure-OpenAI models)

Most applications use both clients: the project client for setup and configuration, and the OpenAI-compatible client for generating AI responses.

## Connecting to a project

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

## Getting an OpenAI-compatible client

Once you have a project client, you can retrieve an OpenAI-compatible client to work with models and generate responses:

```python
from azure.identity import DefaultAzureCredential
from azure.ai.projects import AIProjectClient

# Connect to the project
project_endpoint = "https://<resource-name>.services.ai.azure.com/api/projects/<project-name>"
project_client = AIProjectClient(
    credential=DefaultAzureCredential(),
    endpoint=project_endpoint
)

# Get an OpenAI-compatible client
openai_client = project_client.get_openai_client(api_version="2024-10-21")
```

The OpenAI-compatible client provides access to the Responses API and other OpenAI-style operations, which you'll learn about in subsequent units.
