When you've created an Azure AI Search index for your contextual data, you can use it with an OpenAI model. To ground prompts with data from your index, the Azure OpenAI SDK supports extending the request with connection details for the index. The pattern for using this approach when working with an Azure AI Foundry project is shown in the following diagram.

![Diagram of a client app using an Azure AI Search index to ground a prompt for an OpenAI model.](../media/client-app.png)

1. Use an Azure AI Foundry project client to retrieve connection details for the Azure AI Search index and an OpenAI **ChatClient** object.
1. Add the index connection information to the **ChatClient** configuration so that it can be searched for grounding data based on the user prompt.
1. Submit the grounded prompt to the Azure OpenAI model to generate a contextualized response.

The following code example shows how to implement this pattern.

::: zone pivot="python"

```python
from openai import AzureOpenAI

# Get an Azure OpenAI chat client
chat_client = AzureOpenAI(
    api_version = "2024-12-01-preview",
    azure_endpoint = open_ai_endpoint,
    api_key = open_ai_key
)

# Initialize prompt with system message
prompt = [
    {"role": "system", "content": "You are a helpful AI assistant."}
]

# Add a user input message to the prompt
input_text = input("Enter a question: ")
prompt.append({"role": "user", "content": input_text})

# Additional parameters to apply RAG pattern using the AI Search index
rag_params = {
    "data_sources": [
        {
            "type": "azure_search",
            "parameters": {
                "endpoint": search_url,
                "index_name": "index_name",
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
    model="<model_deployment_name>",
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
using Azure.AI.OpenAI;
using System.ClientModel;
using Azure.AI.OpenAI.Chat;
using OpenAI.Chat;

{
    // Get an Azure OpenAI chat client
    AzureOpenAIClient azureClient = new(
        new Uri(open_ai_endpoint),
        new AzureKeyCredential(open_ai_key));
    ChatClient chatClient = azureClient.GetChatClient(chat_model);
    
    // Initialize prompt with system message
    var prompt = new List<ChatMessage>()
    {
        new SystemChatMessage("You are a helpful AI assistant.")
    };
    
    // Add a user input message to the prompt
    Console.WriteLine("Enter a question: ");
    input_text = Console.ReadLine();
    prompt.Add(new UserChatMessage(input_text));
    
    // Additional parameters to apply RAG pattern using the AI Search index
    ChatCompletionOptions options = new();
    options.AddDataSource(
        new AzureSearchChatDataSource()
        {
            Endpoint = new Uri(search_url),
            IndexName = "index_name",
            Authentication = DataSourceAuthentication.FromApiKey(search_key),
        }
    );
    
    // Submit the prompt with the index information
    ChatCompletion completion = chatClient.CompleteChat(prompt, options);
    var completionText = completion.Content[0].Text;
    
    // Print the contextualized response
    Console.WriteLine(completionText);
}
```

::: zone-end

In this example, the search against the index is *keyword-based* - in other words, the query consists of the text in the user prompt, which is matched to text in the indexed documents. When using an index that supports it, an alternative approach is to use a *vector-based* query in which the index and the query use numeric vectors to represent text tokens. Searching with vectors enables matching based on semantic similarity as well as literal text matches.

To use a vector-based query, you can modify the specification of the Azure AI Search data source details to include an embedding model; which is then used to vectorize the query text.

::: zone pivot="python"

```python
rag_params = {
    "data_sources": [
        {
            "type": "azure_search",
            "parameters": {
                "endpoint": search_url,
                "index_name": "index_name",
                "authentication": {
                    "type": "api_key",
                    "key": search_key,
                },
                # Params for vector-based query
                "query_type": "vector",
                "embedding_dependency": {
                    "type": "deployment_name",
                    "deployment_name": "<embedding_model_deployment_name>",
                },
            }
        }
    ],
}
```

::: zone-end

::: zone pivot="csharp"

```csharp
{
    ChatCompletionOptions options = new();
    options.AddDataSource(
        new AzureSearchChatDataSource()
        {
            Endpoint = new Uri(search_url),
            IndexName = "index_name",
            Authentication = DataSourceAuthentication.FromApiKey(search_key),
            // Params for vector-based query
            QueryType = "vector",
            VectorizationSource = DataSourceVectorizer.FromDeploymentName("<embedding_model_deployment_name>"),
        },
    );
}
```

::: zone-end