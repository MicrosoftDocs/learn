A common scenario in an AI application is to connect to a generative AI model and use *prompts* to engage in a chat-based dialog with it. You can use the Azure AI Foundry SDK to chat with models that you have deployed in your Azure AI Foundry project.

The specific libraries and code used to build a chat client depends on how the target model has been deployed in the Azure AI Foundry project. You can deploy models to the following model hosting solutions:

- **Azure AI Foundry Models**: A single endpoint for multiple models of different types, including OpenAI models and others from the Azure AI Foundry model catalog. Models are consumed through an **Azure AI Foundry** resource connection in the project (either the default **Azure AI Foundry** resource for the project or another resource connection that has been added to the project).
- **Azure OpenAI**: A single endpoint for OpenAI models hosted in Azure. Models are consumed through an **Azure OpenAI** resource connection in the project.
- **Serverless API**: A model-as-a-service solution in which each deployed model is accessed through a unique endpoint and hosted in the Azure AI Foundry project.
- **Managed compute**: A model-as-a-service solution in which each deployed model is accessed through a unique endpoint hosted in custom compute.

> [!NOTE]
> To deploy models to an Azure AI model inference endpoint, you must enable the **Deploy models to Azure AI model inference service** option in Azure AI Foundry.

In this module, we'll focus on models deployed to the **Azure AI Foundry Models** endpoint.

## Building a client app for Azure AI Foundry Models

When you have deployed models to the Azure AI model inference service, you can use the Azure AI Foundry SDK to write code that creates a **ChatCompletionsClient** object, which you can then use to chat with a deployed model. One of the benefits of using this model deployment type is that you can easily switch between deployed models by changing one parameter in your code (the model deployment name), making it a great way to test against multiple models while developing an app.

::: zone pivot="python"

The following Python code sample uses a **ChatCompletionsClient** object to chat with a model deployment named **phi-4-model**.

```python
from azure.ai.projects import AIProjectClient
from azure.identity import DefaultAzureCredential
from azure.ai.inference.models import SystemMessage, UserMessage

try:
        
    # Initialize the project client
    project_client = AIProjectClient(            
        credential=DefaultAzureCredential(),
        endpoint=project_endpoint)
        
    ## Get a chat client
    chat_client = project_client.inference.get_chat_completions_client()
    
    # Get a chat completion based on a user-provided prompt
    user_prompt = input("Enter a question:")
    
    response = chat_client.complete(
        model="phi-4-model",
        messages=[
            SystemMessage("You are a helpful AI assistant that answers questions."),
            UserMessage(user_prompt)
        ],
    )
    print(response.choices[0].message.content)

except Exception as ex:
    print(ex)
```

> [!NOTE]
> The **ChatCompletionsClient** class uses **Azure AI Inference** library. In addition to the **azure-ai-projects** and **azure-identity** packages discussed previously, the sample code shown here assumes that the **azure-ai-inference** package has been installed:
>
> `pip install azure-ai-inference`

### Using the Azure OpenAI SDK

In the Azure AI Foundry SDK for Python, the **AIProjectClient** class provides a **get_azure_openai_client()** method that you can use to create an Azure OpenAI client object. You can then use the classes and methods defined in the Azure OpenAI SDK to consume an OpenAI model deployed to Azure Foundry Models.

The following Python code sample uses the Azure AI Foundry and Azure OpenAI SDKs to chat with a model deployment named **gpt-4o-model**.

```python
from azure.identity import DefaultAzureCredential
from azure.ai.projects import AIProjectClient
from openai import AzureOpenAI


try:
    # Initialize the project client
    project_connection_string = "https://......"
    project_client = AIProjectClient(            
        credential=DefaultAzureCredential(),
        endpoint=project_endpoint)

    ## Get an Azure OpenAI chat client
    openai_client = project_client.inference.get_azure_openai_client(api_version="2024-10-21")
    
    # Get a chat completion based on a user-provided prompt
    user_prompt = input("Enter a question:")
    response = openai_client.chat.completions.create(
        model="gpt-4o-model",
        messages=[
            {"role": "system", "content": "You are a helpful AI assistant that answers questions."},
            {"role": "user", "content": user_prompt},
        ]
    )
    print(response.choices[0].message.content)

except Exception as ex:
    print(ex)
```

> [!NOTE]
> In addition to the **azure-ai-projects** and **azure-identity** packages discussed previously, the sample code shown here assumes that the **openai** package has been installed:
>
> `pip install openai`

::: zone-end

::: zone pivot="csharp"

The following C# code sample uses a **ChatCompletionsClient** object to chat with a model deployment named **phi-4-model**.

```csharp
using System;
using Azure;
using Azure.AI.Projects;
using Azure.Identity;
using Azure.AI.Inference;

namespace my_foundry_client
{
    class Program
    {
        static void Main(string[] args)
        {
            try
            {
                // Initialize the project client
                var projectEndpoint = "https://.....";
                var projectClient = new AIProjectClient(
                    new Uri(projectEndpoint),
                    new DefaultAzureCredential());
        
                // Get a chat client
                ChatCompletionsClient chatClient = projectClient.GetChatCompletionsClient();
        
                // Get a chat completion based on a user-provided prompt
                Console.WriteLine("Enter a question:");
                var user_prompt = Console.ReadLine();
        
                var requestOptions = new ChatCompletionsOptions()
                {
                    Model = "phi-4-model",
                    Messages =
                        {
                            new ChatRequestSystemMessage("You are a helpful AI assistant that answers questions."),
                            new ChatRequestUserMessage(user_prompt),
                        }
                };
                
                Response<ChatCompletions> response = chatClient.Complete(requestOptions);
                Console.WriteLine(response.Value.Content);
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
        }
    }
}
```

> [!NOTE]
> The **ChatCompletionsClient** class uses **Azure AI Inference** library. In addition to the **Azure.AI.Projects** and **Azure.Identity** packages discussed previously, the sample code shown here assumes that the **Azure.AI.Inference** package has been installed:
>
> `dotnet add package Azure.AI.Inference`

::: zone-end

