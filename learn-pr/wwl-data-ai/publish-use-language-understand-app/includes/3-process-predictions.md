To consume your Azure AI Language Understanding model in a client application, you can use the REST APIs or one of the programming language-specific SDKs.

Regardless of the approach used, requests for predictions are sent to your Azure AI Language service and include the following parameters:

- **kind** - indicates which language feature you're requesting. For example, `kind` is defined as `Conversation` for conversational language understanding, or `EntityRecognition` to detect entities
- **parameters** - indicates the values for various input parameters. These parameters vary depending on the feature. For example, `projectName` and `deploymentName` are required for conversational language understanding, however only `modelVersion` is needed for language detection or entity recognition.
- **analysis input** - specifies the input documents or text strings to be analyzed by the Azure AI Language service.

## Prediction results

The prediction results consist of a hierarchy of information that your application must parse. When you use the REST interface, the results are in JSON form. SDKs present the results as an object hierarchy based on the underlying JSON.

A typical JSON response might look similar to the following:

```JSON
{
  "kind": "ConversationResult",
  "result": {
    "query": "What's the time in Edinburgh?",
    "prediction": {
      "topIntent": "GetTime",
      "projectKind": "Conversation",
      "intents": [
        {
          "category": "GetTime",
          "confidenceScore": 1
        },
        {
          "category": "GetDate",
          "confidenceScore": 0.1
        }
      ],
      "entities": [
        {
          "text": "Edinburgh",
          "category": "Location",
          "subcategory": "GPE",
          "offset": 19,
          "length": 9,
          "confidenceScore": 1.0
        }
      ]
    }
  }
}
```

The prediction results include the query utterance, the *top* (most likely) intent, other potential intents with their respective confidence score, and the entities that were detected. Each entity includes a category and subcategory (when applicable) in addition to its confidence score (for example, "Edinburgh", which was detected as a location with confidence of 1.0). The results may also include any other intents that were identified as a possible match, and details about the location of each entity in the utterance string.

>[!NOTE]
> It's important to emphasize that the Azure AI Language Understanding service enables your application to identify the *intent* of the user (in this case to find out the current time in Edinburgh). It is the responsibility of the *client application* to then perform whatever logic is necessary to fulfill the intent (so the Azure AI Language understanding model does <u>not</u> return the actual time in Edinburgh - it simply indicates to the client application that this is the information that the user wants.)
