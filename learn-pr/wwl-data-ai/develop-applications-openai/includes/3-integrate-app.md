Azure OpenAI offers both language specific SDKs and a REST API that developers can use to add AI functionality to their applications. Generative AI capabilities in Azure OpenAI are provided through *models*. The models available in the Azure OpenAI service belong to different families, each with their own focus. To use one of these models, you need to deploy through the Azure OpenAI Service.

Once you have created an Azure OpenAI resource and deployed a model, you can configure your app.

## Available endpoints

Azure OpenAI can be accessed via a REST API or an SDK available for Python, C#, JavaScript, and more. The endpoints available for interacting with a deployed model are used differently, and certain endpoints can only use certain models. The available endpoints are:

- **Completion** - model takes an input prompt, and generates one or more predicted completions. You'll see this playground in the studio, but won't be covered in depth in this module.
- **ChatCompletion** - model takes input in the form of a chat conversation (where roles are specified with the message they send), and the next chat completion is generated.
- **Embeddings** - model takes input and returns a vector representation of that input.

For example, the input for `ChatCompletion` is a conversation with clearly defined roles for each message:

```json
{"role": "system", "content": "You are a helpful assistant, teaching people about AI."},
{"role": "user", "content": "Does Azure OpenAI support multiple languages?"},
{"role": "assistant", "content": "Yes, Azure OpenAI supports several languages, and can translate between them."},
{"role": "user", "content": "Do other Azure AI Services support translation too?"}
```

When you give the AI model a real conversation, it can generate a better response with more accurate tone, phrasing, and context. The `ChatCompletion` endpoint enables the model to have a more realistic conversation by sending the history of the chat with the next user message.

`ChatCompletion` also allows for non-chat scenarios, such as summarization or entity extraction. This can be accomplished by providing a short conversation, specifying the system information and what you want, along with the user input. For example, if you want to generate a job description, provide `ChatCompletion` with something like the following conversation input.

```json
{"role": "system", "content": "You are an assistant designed to write intriguing job descriptions."},
{"role": "user", "content": "Write a job description for the following job title: 'Business Intelligence Analyst'. It should include responsibilities, required qualifications, and highlight benefits like time off and flexible hours."}
```

> [!NOTE]
> `Completion` is available for earlier `gpt-3` generation models, while `ChatCompletion` is the only supported option for `gpt-4` models and is the preferred endpoint when using the `gpt-35-turbo` model.

## Use the Azure OpenAI REST API

Azure OpenAI offers a REST API for interacting and generating responses that developers can use to add AI functionality to their applications. This unit covers example usage, input and output from the API.

For each call to the REST API, you need the endpoint and a key from your Azure OpenAI resource, and the name you gave for your deployed model. In the following examples, the following placeholders are used:

|Placeholder name | Value |
|--------------|-------|
| `YOUR_ENDPOINT_NAME` | This base endpoint is found in the **Keys & Endpoint** section in the Azure portal. It's the base endpoint of your resource, such as `https://sample.openai.azure.com/`.|
| `YOUR_API_KEY` | Keys are found in the **Keys & Endpoint** section in the Azure portal. You can use either key for your resource. |
| `YOUR_DEPLOYMENT_NAME` | This deployment name is the name provided when you deployed your model in the Azure AI Foundry. |

### Chat completions

Once you've deployed a model in your Azure OpenAI resource, you can send a prompt to the service using a `POST` request.

```rest
curl https://YOUR_ENDPOINT_NAME.openai.azure.com/openai/deployments/YOUR_DEPLOYMENT_NAME/chat/completions?api-version=2023-03-15-preview \
  -H "Content-Type: application/json" \
  -H "api-key: YOUR_API_KEY" \
  -d '{"messages":[{"role": "system", "content": "You are a helpful assistant, teaching people about AI."},
{"role": "user", "content": "Does Azure OpenAI support multiple languages?"},
{"role": "assistant", "content": "Yes, Azure OpenAI supports several languages, and can translate between them."},
{"role": "user", "content": "Do other Azure AI Services support translation too?"}]}'
```

The response from the API will be similar to the following JSON:

```json
{
    "id": "chatcmpl-6v7mkQj980V1yBec6ETrKPRqFjNw9",
    "object": "chat.completion",
    "created": 1679001781,
    "model": "gpt-35-turbo",
    "usage": {
        "prompt_tokens": 95,
        "completion_tokens": 84,
        "total_tokens": 179
    },
    "choices": [
        {
            "message":
                {
                    "role": "assistant",
                    "content": "Yes, other Azure AI Services also support translation. Azure AI Services offer translation between multiple languages for text, documents, or custom translation through Azure AI Services Translator."
                },
            "finish_reason": "stop",
            "index": 0
        }
    ]
}
```

REST endpoints allow for specifying other optional input parameters, such as `temperature`, `max_tokens` and more. If you'd like to include any of those parameters in your request, add them to the input data with the request.

### Embeddings

Embeddings are helpful for specific formats that are easily consumed by machine learning models. To generate embeddings from the input text, `POST` a request to the `embeddings` endpoint.

```rest
curl https://YOUR_ENDPOINT_NAME.openai.azure.com/openai/deployments/YOUR_DEPLOYMENT_NAME/embeddings?api-version=2022-12-01 \
  -H "Content-Type: application/json" \
  -H "api-key: YOUR_API_KEY" \
  -d "{\"input\": \"The food was delicious and the waiter...\"}"
```

When generating embeddings, be sure to use a model in Azure OpenAI meant for embeddings. Those models start with `text-embedding` or `text-similarity`, depending on what functionality you're looking for.

The response from the API will be similar to the following JSON:

```json
{
  "object": "list",
  "data": [
    {
      "object": "embedding",
      "embedding": [
        0.0172990688066482523,
        -0.0291879814639389515,
        ....
        0.0134544348834753042,
      ],
      "index": 0
    }
  ],
  "model": "text-embedding-ada:002"
}
```

## Use Azure OpenAI with SDKs

In addition to REST APIs, users can also access Azure OpenAI models through C# and Python SDKs. The same functionality is available through both REST and these SDKs.

For both SDKs covered in this unit, you need the endpoint and a key from your Azure OpenAI resource, and the name you gave for your deployed model. In the following code snippets, the following placeholders are used:

|Placeholder name | Value |
|--------------|-------|
| `YOUR_ENDPOINT_NAME` | This base endpoint is found in the **Keys & Endpoint** section in the Azure portal. It's the base endpoint of your resource, such as `https://sample.openai.azure.com/`.|
| `YOUR_API_KEY` | Keys are found in the **Keys & Endpoint** section in the Azure portal. You can use either key for your resource. |
| `YOUR_DEPLOYMENT_NAME` | This deployment name is the name provided when you deployed your model. |

### Install libraries

First, install the client library for your preferred language. The C# SDK is a .NET adaptation of the REST APIs and built specifically for Azure OpenAI, however it can be used to connect to Azure OpenAI resources or non-Azure OpenAI endpoints. The Python SDK is built and maintained by OpenAI.

::: zone pivot="csharp"

```console
dotnet add package Azure.AI.OpenAI --version <insert preferred version>
```

::: zone-end

::: zone pivot="python"

```console
pip install openai
```

::: zone-end

### Configure app to access Azure OpenAI resource

Configuration for each language varies slightly, but both require the same parameters to be set. The necessary parameters are `endpoint`, `key`, and `deployment name`.

Add the library to your app, and set the required parameters for your client.

::: zone pivot="csharp"

```csharp
// Add Azure OpenAI packages
using Azure.AI.OpenAI;
using OpenAI.Chat;

// Define parameters and initialize the client
string endpoint = "<YOUR_ENDPOINT_NAME>";
string key = "<YOUR_API_KEY>";
string deploymentName = "<YOUR_DEPLOYMENT_NAME>"; 

AzureOpenAIClient azureClient = new AzureOpenAIClient(new Uri(endpoint), new AzureKeyCredential(key));
ChatClient chatClient = azureClient.GetChatClient(deploymentName);
```

::: zone-end

::: zone pivot="python"

```python
# Add OpenAI library
from openai import AzureOpenAI

deployment_name = '<YOUR_DEPLOYMENT_NAME>' 

# Initialize the Azure OpenAI client
client = AzureOpenAI(
        azure_endpoint = '<YOUR_ENDPOINT_NAME>', 
        api_key='<YOUR_API_KEY>',  
        api_version="20xx-xx-xx" #  Target version of the API, such as 2024-02-15-preview
        )
```

::: zone-end

### Call Azure OpenAI resource

Once you've configured your connection to Azure OpenAI, send your prompt to the model.

::: zone pivot="csharp"

```csharp
// Get chat completion
ChatCompletion completion = chatClient.CompleteChat(
    [
        new SystemChatMessage(systemMessage),
        new UserChatMessage(userMessage),
    ]);

// Print the response
Console.WriteLine($"{completion.Role}: {completion.Content[0].Text}");
```

::: zone-end

::: zone pivot="python"

```python
response = client.chat.completions.create(
    model=deployment_name,
    messages=[
        {"role": "system", "content": "You are a helpful assistant."},
        {"role": "user", "content": "What is Azure OpenAI?"}
    ]
)
generated_text = response.choices[0].message.content

# Print the response
print("Response: " + generated_text + "\n")
```

::: zone-end

The response object contains several values, such as `total_tokens` and `finish_reason`. The completion from the response object will be similar to the following completion:

```console
"Azure OpenAI is a cloud-based artificial intelligence (AI) service that offers a range of tools and services for developing and deploying AI applications. Azure OpenAI provides a variety of services for training and deploying machine learning models, including a managed service for training and deploying deep learning models, a managed service for deploying machine learning models, and a managed service for managing and deploying machine learning models."
```

In both C# and Python, your call can include optional parameters including `temperature` and `max_tokens`.
