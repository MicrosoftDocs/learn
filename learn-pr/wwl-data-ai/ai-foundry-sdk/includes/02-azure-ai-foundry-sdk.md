Azure AI Foundry provides a REST API that you can use to work with AI Foundry projects and the resources they contain. Additionally, multiple language-specific SDKs are available, enabling developers to write code that uses resources in an Azure AI Foundry project in their preferred development language. With an Azure AI Foundry SDK, developers can create applications that connect to a project, access the resource connections and models in that project, and use them to perform AI operations, such as sending prompts to a generative AI model and processing the responses.

The core package for working with projects is the **Azure AI Projects** library, which enables you to connect to an Azure AI Foundry project and access the resources defined within it. Available language-specific packages the for Azure AI Projects library include:

- [Azure AI Projects for Python](https://pypi.org/project/azure-ai-projects?azure-portal=true)
- [Azure AI Projects for Microsoft .NET](https://www.nuget.org/packages/Azure.AI.Projects?azure-portal=true)
- [Azure AI Projects for JavaScript](https://www.npmjs.com/package/@azure/ai-projects?azure-portal=true)

> [!NOTE]
> In this module, we'll use Python code examples for common tasks that a developer may need to perform with Azure AI Foundry projects. You can refer to the other language-specific SDK documentation to find equivalent code for your preferred language. Each SDK is developed and maintained independently, so some functionality may be at different stages of implementation for each language.



To use the Azure AI Projects library in Python, you can use the **pip** package installation utility to install the **azure-ai-projects** package from PyPi:

```
pip install azure-ai-projects
```

## Using the SDK to connect to a project

The first task in most Azure AI Foundry SDK code is to connect to an Azure AI Foundry project. Each project has a unique *endpoint*, which you can find on the project's **Overview** page in the Azure AI Foundry portal.

[ ![Screenshot of the project overview page in Azure AI Foundry portal.](../media/ai-project-overview.png) ](../media/ai-project-overview.png#lightbox)

> [!NOTE]
> The project provides multiple endpoints and keys, including:
>
> - An endpoint for the project itself; which can be used to access project connections, agents, and models in the Azure AI Foundry resource.
> - An endpoint for Azure OpenAI Service APIs in the project's Azure AI Foundry resource.
> - An endpoint for Azure AI services APIs (such as Azure AI Vision and Azure AI Language) in the Azure AI Foundry resource.

You can use the project endpoint in your code to create an **AIProjectClient** object, which provides a programmatic proxy for the project, as shown in this Python example:

```python
from azure.identity import DefaultAzureCredential
from azure.ai.projects import AIProjectClient
...

project_endpoint = "https://......"
project_client = AIProjectClient(            
    credential=DefaultAzureCredential(),
    endpoint=project_endpoint)
```

> [!NOTE]
> The code uses the default Azure credentials to authenticate when accessing the project. To enable this authentication, in addition to the **azure-ai-projects** package, you need to install the **azure-identity** package:
>
> `pip install azure-identity`

> [!TIP]
> To access the project successfully, the code must be run in the context of an authenticated Azure session. For example, you could use the Azure command-line interface (CLI) `az-login`  command to sign in before running the code.
