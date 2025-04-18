When you've created an Azure AI Search index for your contextual data, you can use it with an OpenAI model. To ground prompts with data from your index, the Azure OpenAI SDK supports extending the request with connection details for the index. The pattern for using this approach when working with an Azure AI Foundry project is shown in the following diagram.

![Diagram of a client app using an Azure AI Search index to ground a prompt for an OpenAI model.](../media/client-app.png)

1. Use an Azure AI Foundry project client to retrieve connection details for the Azure AI Search index and an OpenAI **ChatClient** object.
1. Add the index connection information to the **ChatClient** configuration so that it can be searched for grounding data based on the user prompt.
1. Submit the grounded prompt to the Azure OpenAI model to generate a contextualized response.

The following code example shows how to implement this pattern.

::: zone pivot="python"

```python
import os
from dotenv import load_dotenv
from azure.identity import DefaultAzureCredential
from azure.ai.projects import AIProjectClient
from azure.ai.projects.models import ConnectionType
import openai

# Get configuration settings
load_dotenv()
project_connection = os.getenv("PROJECT_CONNECTION")
model_deployment = os.getenv("MODEL_DEPLOYMENT")
index_name = os.getenv("INDEX_NAME")

# Initialize the project client
projectClient = AIProjectClient.from_connection_string(
    conn_str=project_connection,
    credential=DefaultAzureCredential()
)

# Use the AI search service connection to get service details
searchConnection = projectClient.connections.get_default(
    connection_type=ConnectionType.AZURE_AI_SEARCH,
    include_credentials=True,
)
search_url = searchConnection.endpoint_url
search_key = searchConnection.key

# Get an Azure OpenAI chat client
chat_client = projectClient.inference.get_azure_openai_client(api_version="2024-10-21")

# Initialize prompt with system message
prompt = [
    {"role": "system", "content": "You are a travel assistant that provides information on travel services available from Margie's Travel."}
]

# Add a user input message to the prompt
input_text = input("Enter a travel-related question: ")
prompt.append({"role": "user", "content": input_text})

# Additional parameters to apply RAG pattern using the AI Search index
rag_params = {
    "data_sources": [
        {
            "type": "azure_search",
            "parameters": {
                "endpoint": search_url,
                "index_name": index_name,
                "authentication": {
                    "type": "api_key",
                    "key": search_key,
                }
            }
        }
    ],
}

# Submit the prompt with the index information
response = chat_client.chat.completions.create(
    model=model_deployment,
    messages=prompt,
    extra_body=rag_params
)

# Print the contextualized response
completion = response.choices[0].message.content
print(completion)
```

::: zone-end

::: zone pivot="csharp"

```csharp
using System;
using Azure;
using System.IO;
using System.Text;
using System.Collections.Generic;
using Microsoft.Extensions.Configuration;
using Azure.Identity;
using Azure.AI.Projects;
using Azure.AI.OpenAI;
using System.ClientModel;
using Azure.AI.OpenAI.Chat;
using OpenAI.Chat;

...

{
    // Get configuration settings
    IConfigurationBuilder builder = new ConfigurationBuilder().AddJsonFile("appsettings.json");
    IConfigurationRoot configuration = builder.Build();
    string project_connection = configuration["PROJECT_CONNECTION"];
    string model_deployment = configuration["MODEL_DEPLOYMENT"];
    string index_name = configuration["INDEX_NAME"];
    
    // Initialize the project client
    var projectClient = new AIProjectClient(project_connection, new DefaultAzureCredential());
    
    // Use the AI search service connection to get service details
    var connectionsClient = projectClient.GetConnectionsClient();
    ConnectionResponse searchConnection = connectionsClient.GetDefaultConnection(ConnectionType.AzureAISearch, true);
    var searchProperties = searchConnection.Properties as ConnectionPropertiesApiKeyAuth;
    string search_url = searchProperties.Target;
    string search_key = searchProperties.Credentials.Key;
    
    // Get an Azure OpenAI chat client
    ChatClient chatClient = projectClient.GetAzureOpenAIChatClient(model_deployment);
    
    // Initialize prompt with system message
    var prompt = new List<ChatMessage>()
    {
        new SystemChatMessage("You are a travel assistant that provides information on travel services available from Margie's Travel.")
    };
    
    // Add a user input message to the prompt
    Console.WriteLine("Enter a travel-related question: ");
    input_text = Console.ReadLine();
    prompt.Add(new UserChatMessage(input_text));
    
    // Additional parameters to apply RAG pattern using the AI Search index
    ChatCompletionOptions options = new();
    options.AddDataSource(new AzureSearchChatDataSource()
    {
        Endpoint = new Uri(search_url),
        IndexName = index_name,
        Authentication = DataSourceAuthentication.FromApiKey(search_key),
    });
    
    // Submit the prompt with the index information
    ChatCompletion completion = chatClient.CompleteChat(prompt, options);
    var completionText = completion.Content[0].Text;
    
    // Print the contextualized response
    Console.WriteLine(completionText);
}
```

::: zone-end
