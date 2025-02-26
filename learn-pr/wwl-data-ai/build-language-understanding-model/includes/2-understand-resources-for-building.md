To use the Language Understanding service to develop a NLP solution, you'll need to create a Language resource in Azure. That resource will be used for both authoring your model and processing prediction requests from client applications.

> [!TIP]
> This module's lab covers building a model for conversational language understanding. For more focused modules on custom text classification and custom named entity recognition, see the custom solution modules in the [Develop natural language solutions](/training/paths/develop-language-solutions-azure-ai?azure-portal=true) learning path.

## Build your model

For features that require a model for prediction, you'll need to build, train and deploy that model before using it to make a prediction. This building and training will teach the Azure AI Language service what to look for.

First, you'll need to create your Azure AI Language resource in the [Azure portal](https://portal.azure.com/?azure-portal=true). Then:

1. Search for **Azure AI services**.
1. Find and select **Language Service**.
1. Select **Create** under the **Language Service**.
1. Fill out the necessary details, choosing the region closest to you geographically (for best performance) and giving it a unique name.

Once that resource has been created, you'll need a key and the endpoint. You can find that on the left side under **Keys and Endpoint** of the resource overview page.

### Use Language Studio

For a more visual method of building, training, and deploying your model, you can use [Language Studio](https://aka.ms/languageStudio) to achieve each of these steps. On the main page, you can choose to create a **Conversational language understanding** project. Once the project is created, then go through the same process as above to build, train, and deploy your model.

:::image type="content" source="../media/language-studio-conversational-small.png" alt-text="Screenshot of the Language Studio home page." lightbox="../media/language-studio-conversational.png":::

The lab in this module will walk through using Language Studio to build your model. If you'd like to learn more, see the [Language Studio quickstart](/azure/ai-services/language-service/language-studio?azure-portal=true)

### Use the REST API

One way to build your model is through the REST API. The pattern would be to create your project, import data, train, deploy, then use your model.

These tasks are done asynchronously; you'll need to submit a request to the appropriate URI for each step, and then send another request to get the status of that job.

For example, if you want to deploy a model for a conversational language understanding project, you'd submit the deployment job, and then check on the deployment job status.

#### Authentication

For each call to your Azure AI Language resource, you authenticate the request by providing the following header.

|Key|Value|
|--|--|
|`Ocp-Apim-Subscription-Key`| The key to your resource |

#### Request deployment

Submit a **POST** request to the following endpoint.

```rest
{ENDPOINT}/language/authoring/analyze-conversations/projects/{PROJECT-NAME}/deployments/{DEPLOYMENT-NAME}?api-version={API-VERSION}
```

|Placeholder  |Value  | Example |
|---------|---------|---------|
|`{ENDPOINT}`     | The endpoint of your Azure AI Language resource   | `https://<your-subdomain>.cognitiveservices.azure.com` |
|`{PROJECT-NAME}`     | The name for your project. This value is case-sensitive   | `myProject` |
|`{DEPLOYMENT-NAME}`     | The name for your deployment. This value is case-sensitive   | `staging` |
|`{API-VERSION}`     | The version of the API you're calling | `2022-05-01` |

Include the following `body` with your request.

```json
{
  "trainedModelLabel": "{MODEL-NAME}",
}
```

|Placeholder  |Value  |
|---------|-----|
| `{MODEL-NAME}` | The model name that will be assigned to your deployment. This value is case-sensitive.   |

Successfully submitting your request will receive a `202` response, with a response header of `operation-location`. This header will have a URL with which to request the status, formatted like this:

```rest
{ENDPOINT}/language/authoring/analyze-conversations/projects/{PROJECT-NAME}/deployments/{DEPLOYMENT-NAME}/jobs/{JOB-ID}?api-version={API-VERSION}
```

#### Get deployment status

Submit a **GET** request to the URL from the response header above. The values will already be filled out based on the initial deployment request.

```rest
{ENDPOINT}/language/authoring/analyze-conversations/projects/{PROJECT-NAME}/deployments/{DEPLOYMENT-NAME}/jobs/{JOB-ID}?api-version={API-VERSION}
```

| Placeholder  |Value  |
|---------|---------|
|`{ENDPOINT}`     | The endpoint for authenticating your API request   |
|`{PROJECT-NAME}`     | The name for your project (case-sensitive)   |
|`{DEPLOYMENT-NAME}`     | The name for your deployment (case-sensitive) |
|`{JOB-ID}`     | The ID for locating your model's training status, found in the header value detailed above in the deployment request |
|`{API-VERSION}`     | The version of the API you're calling |

The response body will give the deployment status details. The `status` field will have the value of *succeeded* when the deployment is complete.

```json
{
    "jobId":"{JOB-ID}",
    "createdDateTime":"String",
    "lastUpdatedDateTime":"String",
    "expirationDateTime":"String",
    "status":"running"
}
```

For a full walkthrough of each step with example requests, see the [conversational understanding quickstart](/azure/ai-services/language-service/conversational-language-understanding/quickstart?pivots=rest-api&azure-portal=true#create-a-clu-project).

## Query your model

To query your model for a prediction, you can use SDKs in C# or Python, or use the REST API.

### Query using SDKs

To query your model using an SDK, you first need to create your client. Once you have your client, you then use it to call the appropriate endpoint.

```csharp
var languageClient = new TextAnalyticsClient(endpoint, credentials);
var response = languageClient.ExtractKeyPhrases(document);
```

```python
language_client = TextAnalyticsClient(
            endpoint=endpoint, 
            credential=credentials)
response = language_client.extract_key_phrases(documents = documents)[0]
```

Other language features, such as the conversational language understanding, require the request be built and sent differently.

```csharp
var data = new
{
    analysisInput = new
    {
        conversationItem = new
        {
            text = userText,
            id = "1",
            participantId = "1",
        }
    },
    parameters = new
    {
        projectName,
        deploymentName,
        // Use Utf16CodeUnit for strings in .NET.
        stringIndexType = "Utf16CodeUnit",
    },
    kind = "Conversation",
};
Response response = await client.AnalyzeConversationAsync(RequestContent.Create(data));
```

```python
result = client.analyze_conversation(
    task={
        "kind": "Conversation",
        "analysisInput": {
            "conversationItem": {
                "participantId": "1",
                "id": "1",
                "modality": "text",
                "language": "en",
                "text": query
            },
            "isLoggingEnabled": False
        },
        "parameters": {
            "projectName": cls_project,
            "deploymentName": deployment_slot,
            "verbose": True
        }
    }
)
```

### Query using the REST API

To query your model using REST, create a **POST** request to the appropriate URL with the appropriate body specified. For built in features such as language detection or sentiment analysis, you'll query the `analyze-text` endpoint.

> [!TIP]
> Remember each request needs to be authenticated with your Azure AI Language resource key in the `Ocp-Apim-Subscription-Key` header

```rest
{ENDPOINT}/language/:analyze-text?api-version={API-VERSION}
```

|Placeholder  |Value  |
|---------|---------|
|`{ENDPOINT}`     | The endpoint for authenticating your API request   |
|`{API-VERSION}`     | The version of the API you're calling  |

Within the body of that request, you must specify the `kind` parameter, which tells the service what type of language understanding you're requesting.

If you want to detect the language, for example, the JSON body would look something like the following.

```json
{
    "kind": "LanguageDetection",
    "parameters": {
        "modelVersion": "latest"
    },
    "analysisInput":{
        "documents":[
            {
                "id":"1",
                "text": "This is a document written in English."
            }
        ]
    }
}
```

Other language features, such as the conversational language understanding, require the request be routed to a different endpoint. For example, the conversational language understanding request would be sent to the following.

```rest
{ENDPOINT}/language/:analyze-conversations?api-version={API-VERSION}
```

|Placeholder  |Value  |
|---------|---------|
|`{ENDPOINT}`     | The endpoint for authenticating your API request   |
|`{API-VERSION}`     | The version of the API you're calling  |

That request would include a JSON body similar to the following.

```json
{
  "kind": "Conversation",
  "analysisInput": {
    "conversationItem": {
      "id": "1",
      "participantId": "1",
      "text": "Sample text"
    }
  },
  "parameters": {
    "projectName": "{PROJECT-NAME}",
    "deploymentName": "{DEPLOYMENT-NAME}",
    "stringIndexType": "TextElement_V8"
  }
}
```

|Placeholder  |Value  |
|---------|---------|
|`{PROJECT-NAME}`     | The name of the project where you built your model   |
|`{DEPLOYMENT-NAME}`     | The name of your deployment  |

### Sample response

The query response from an SDK will in the object returned, which varies depending on the feature (such as in `response.key_phrases` or `response.Value`). The REST API will return JSON that would be similar to the following.

```json
{
    "kind": "KeyPhraseExtractionResults",
    "results": {
        "documents": [{
            "id": "1",
            "keyPhrases": ["modern medical office", "Dr. Smith", "great staff"],
            "warnings": []
        }],
        "errors": [],
        "modelVersion": "{VERSION}"
    }
}
```

For other models like conversational language understanding, a sample response to your query would be similar to the following.

```json
{
  "kind": "ConversationResult",
  "result": {
    "query": "String",
    "prediction": {
      "topIntent": "intent1",
      "projectKind": "Conversation",
      "intents": [
        {
          "category": "intent1",
          "confidenceScore": 1
        },
        {
          "category": "intent2",
          "confidenceScore": 0
        }
      ],
      "entities": [
        {
          "category": "entity1",
          "text": "text",
          "offset": 7,
          "length": 4,
          "confidenceScore": 1
        }
      ]
    }
  }
}
```

The SDKs for both Python and C# return JSON that is very similar to the REST response.

For full documentation on features, including examples and how-to guides, see the [Azure AI Language documentation](/azure/ai-services/language-service/?azure-portal=true) documentation pages.
