Azure OpenAI on your own data can be used in Azure AI Studio with the **Chat** playground, or by using the API.

## Token considerations and recommended settings

Since Azure OpenAI on your data includes search results on your index in the prompt, it's important to understand how that impacts your token allotment. Each call to the model includes tokens for the system message, the user prompt, conversation history, retrieved search documents, internal prompts, and the model's response.

The system message, for example, is a useful reference for instructions for the model and is included with every call. While there's no token limit for the system message, when using your own data the system message gets truncated if it exceeds 200 tokens. The response from the model is also limited when using your own data is 1500 tokens.

Due to these token limitations, it's recommended that you limit both the question length and the conversation history length in your call. [Prompt engineering techniques](/azure/cognitive-services/openai/concepts/advanced-prompt-engineering?azure-portal=true) such as breaking down the task and chain of though prompting can help the model respond more effectively.

## Using the API

Using the API with your own data, you need to specify the data source where your data is stored. With each call you need to include the `endpoint`, `key`, and `indexName` for your Cognitive Search resource.

Your request body will be similar to the following JSON.

```json
{
    "dataSources": [
        {
            "type": "AzureCognitiveSearch",
            "parameters": {
                "endpoint": "<your_search_endpoint>",
                "key": "<your_search_endpoint>",
                "indexName": "<your_search_index>"
            }
        }
    ],
    "messages":[
        {
            "role": "system", 
            "content": "You are a helpful assistant assisting users with travel recommendations."
        },
        {
            "role": "user", 
            "content": "I want to go to New York. Where should I stay?"
        }
    ]
}
```

The call when using your own data needs to be sent to a different endpoint than is used when calling a base model, which includes `extensions`. Your call will be sent to a URL similar to the following.

```http
<your_azure_openai_resource>/openai/deployments/<deployment_name>/extensions/chat/completions?api-version=2023-06-01-preview
```

The request will also need to include the `Content-Type` and `api-key`.
