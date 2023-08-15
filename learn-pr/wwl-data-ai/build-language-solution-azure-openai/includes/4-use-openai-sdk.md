In addition to REST APIs covered in the previous unit, users can also access Azure OpenAI models through C# and Python SDKs. The same functionality is available through both REST and these SDKs.

> [!NOTE]
> Before interacting with the API using either SDK, you must create an Azure OpenAI resource in the Azure portal, deploy a model in that resource, and retrieve your endpoint and keys. Check out the [Getting started with Azure OpenAI Service](/training/modules/get-started-openai/) to learn how to do that.

For both SDKs covered in this unit, you need the endpoint and a key from your Azure OpenAI resource, and the name you gave for your deployed model. In the following code snippets, the following placeholders are used:

|Placeholder name | Value |
|--------------|-------|
| `YOUR_ENDPOINT_NAME` | This base endpoint is found in the **Keys & Endpoint** section in the Azure portal. It's the base endpoint of your resource, such as `https://sample.openai.azure.com/`.|
| `YOUR_API_KEY` | Keys are found in the **Keys & Endpoint** section in the Azure portal. You can use either key for your resource. |
| `YOUR_DEPLOYMENT_NAME` | This deployment name is the name provided when you deployed your model in the Azure OpenAI Studio. |

## Install libraries

First, install the client library for your preferred language. The C# SDK is a .NET adaptation of the REST APIs and built specifically for Azure OpenAI, however it can be used to connect to Azure OpenAI resources or non-Azure OpenAI endpoints. The Python SDK is built and maintained by OpenAI.

::: zone pivot="csharp"

```console
dotnet add package Azure.AI.OpenAI --prerelease
```

::: zone-end

::: zone pivot="python"

```console
pip install openai
```

::: zone-end

## Configure app to access Azure OpenAI resource

Configuration for each language varies slightly, but both require the same parameters to be set. The necessary parameters are `endpoint`, `key`, and the name of your deployment, which is called the `engine` when sending your prompt to the model.

Add the library to your app, and set the required parameters for your client.

::: zone pivot="csharp"

```csharp
// Add OpenAI library
using Azure.AI.OpenAI;

// Define parameters and initialize the client
string endpoint = "<YOUR_ENDPOINT_NAME>";
string key = "<YOUR_API_KEY>";
string deploymentName = "<YOUR_DEPLOYMENT_NAME>"; //SDK calls this "engine", but naming
                                                  // it "deploymentName" for clarity

OpenAIClient client = new OpenAIClient(new Uri(endpoint), new AzureKeyCredential(key));
```

::: zone-end

::: zone pivot="python"

```python
# Add OpenAI library
import openai

openai.api_key = '<YOUR_API_KEY>'
openai.api_base =  '<YOUR_ENDPOINT_NAME>' 
openai.api_type = 'azure' # Necessary for using the OpenAI library with Azure OpenAI
openai.api_version = '20xx-xx-xx' # Latest / target version of the API

deployment_name = '<YOUR_DEPLOYMENT_NAME>' # SDK calls this "engine", but naming
                                           # it "deployment_name" for clarity
```

::: zone-end

## Call Azure OpenAI resource

Once you've configured your connection to Azure OpenAI, send your prompt to one of the available endpoints of `Completion`, `ChatCompletion`, or `Embedding`.

::: zone pivot="csharp"

```csharp
string prompt = "What is Azure OpenAI?";

Response<Completions> completionsResponse = client.GetCompletions(deploymentName, prompt);
string completion = completionsResponse.Value.Choices[0].Text;
Console.WriteLine($"Chatbot: {completion}");
```

If using `ChatCompletion`, sending the prompt is formed differently.

```csharp
// Build completion options object
ChatCompletionsOptions chatCompletionsOptions = new ChatCompletionsOptions()
{
    Messages = 
    {
        new ChatMessage(ChatRole.System, "You are a helpful AI bot."), 
        new ChatMessage(ChatRole.User, "What is Azure OpenAI?")
    }
};

// Send request to Azure OpenAI model
ChatCompletions chatCompletionsResponse = client.GetChatCompletions(
    deploymentName, 
    chatCompletionsOptions);

ChatMessage completion = chatCompletionsResponse.Choices[0].Message;
Console.WriteLine($"Chatbot: {completion.Content}");
```

The response object contains several values, such as `total_tokens` and `finish_reason`. The completion from the response object will be similar to the following completion:

```console
"Azure OpenAI is a cloud-based artificial intelligence (AI) service that offers a range of tools and services for developing and deploying AI applications. Azure OpenAI provides a variety of services for training and deploying machine learning models, including a managed service for training and deploying deep learning models, a managed service for deploying machine learning models, and a managed service for managing and deploying machine learning models."
```

::: zone-end

::: zone pivot="python"

```python
prompt = 'What is Azure OpenAI?'
response = openai.Completion.create(engine=deployment_name, prompt=prompt)

print(response.choices[0].text)
```

If using `ChatCompletion`, sending the prompt is formed differently.

```python
response = openai.ChatCompletion.create(
    engine=deployment_name
    messages=[
        {"role": "system", "content": "You are a helpful assistant."},
        {"role": "user", "content": "What is Azure OpenAI?"}
    ]
)

print(response['choices'][0]['message']['content'])
```

The response object contains several values, such as `total_tokens` and `finish_reason`. The completion from the response object will be similar to the following completion:

```console
"Azure OpenAI is a cloud-based artificial intelligence (AI) service that offers a range of tools and services for developing and deploying AI applications. Azure OpenAI provides a variety of services for training and deploying machine learning models, including a managed service for training and deploying deep learning models, a managed service for deploying machine learning models, and a managed service for managing and deploying machine learning models."
```

::: zone-end

In both C# and Python, your `create` call can include optional parameters including `temperature` and `max_tokens`. Examples of using those parameters are included in this module's lab.
