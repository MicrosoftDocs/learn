
## Using a custom model

To extract form data using a custom model, use the [**analyze document**](/azure/applied-ai-services/form-recognizer/quickstarts/try-v3-rest-api#analyze-documents-and-get-results) REST API function (or equivalent SDK method) with your custom model ID (generated during model training). This function starts the form analysis and returns a result ID, which you can pass in a subsequent call to the [**get analyze results**](/azure/applied-ai-services/form-recognizer/quickstarts/try-v3-rest-api#get-analyze-results-get-request) function to retrieve the results.

The specific structure of the results depends on the fields in your forms. If you trained the model using unlabeled sample forms, the results are returned in a **pageResults** node. If you used labeled forms to train the model, the results are returned in the **documentResults** node. Both are shown below. 

```JSON
{
  "status": "succeeded",
  "createdDateTime": "2020-08-21T00:46Z",
  "lastUpdatedDateTime": "2020-08-21T00:46Z",
  "analyzeResult": {
    "version": "2.0.0",
    "readResults": [
      {
        ...
      }
    ]
    "pageResults" : [
      {
        "page": 1,
        "keyValuePairs": [
          {
            "Key": {
              "Text": "Order Date",
              ...
            },
            "Value": {
               "Text": "01/01/2021",
               ...
            },
          ...
          }
        ]
      }
    ],
    "documentResults" : [
      ...
    ]
  }
}
```


## Using a prebuilt model 

To extract form data using a prebuilt model, use the **analyze document** REST API function (or [equivalent SDK method](/azure/applied-ai-services/form-recognizer/quickstarts/try-v3-python-sdk)).

- [**Analyze Receipt**](https://westcentralus.dev.cognitive.microsoft.com/docs/services/form-recognizer-api-v2-1-preview-3/operations/AnalyzeReceiptAsync)
- [**Analyze Business Card**](https://westcentralus.dev.cognitive.microsoft.com/docs/services/form-recognizer-api-v2-1-preview-3/operations/AnalyzeBusinessCardAsync) 
- [**Analyze Invoice**](https://westcentralus.dev.cognitive.microsoft.com/docs/services/form-recognizer-api-v2-1-preview-3/operations/5ed8c9843c2794cbb1a96291) 

This function starts the form analysis and returns a result ID, which you can pass in a subsequent call to the **Get Analyze  Result** function to retrieve the results.

- [**Get Analyze Receipt Result**](https://westcentralus.dev.cognitive.microsoft.com/docs/services/form-recognizer-api-v2-1-preview-3/operations/GetAnalyzeReceiptResult)
- [**Get Analyze Business Card Result**](https://westcentralus.dev.cognitive.microsoft.com/docs/services/form-recognizer-api-v2-1-preview-3/operations/GetAnalyzeBusinessCardResult) 
- [**Get Analyze Invoice Result**](https://westcentralus.dev.cognitive.microsoft.com/docs/services/form-recognizer-api-v2-1-preview-3/operations/5ed8c9acb78c40a2533aee83) 

A successful JSON response contains **readResults** and **documentResults** nodes. 

The **readResults** node contains all of the recognized text. Text is organized by page, then by line, then by individual words.

The **documentResults** node contains the form-specific values that the model discovered. This is where you'll find useful key/value pairs like the first name, last name, company name and more.

Depending on the form analyzed, the response may also contain **pageResults**, which includes the tables extracted.

Example **Get Analyze Receipt Result** response: 

```json

{
    "status": "succeeded",
    "createdDateTime": "2021-03-29T21:12:40Z",
    "lastUpdatedDateTime": "2021-03-29T21:12:44Z",
    "analyzeResult": {
        "version": "2.1.0",
        "readResults": [
            {
                ...
                "lines": [
                    {
                        "text": "Northwind Traders",
                        "boundingBox": [
                            20,
                            17,
                            235,
                            17,
                            235,
                            44,
                            20,
                            44
                        ],
                        "words": [
                            {
                                "text": "Northwind",
                                "boundingBox": [
                                    20,
                                    17,
                                    140,
                                    17,
                                    140,
                                    45,
                                    20,
                                    45
                                ],
                                "confidence": 0.994
                            },
                            {
                                "text": "Traders",
                                "boundingBox": [
                                    148,
                                    17,
                                    234,
                                    17,
                                    234,
                                    45,
                                    147,
                                    45
                                ],
                                "confidence": 0.996
        ...,
        "documentResults": [
        {
            "docType": "prebuilt:receipt",
            "pageRange": [
                1,
                1
            ],
            "fields": {
                "Items": {
                    "type": "array",
                    "valueArray": [
                        {
                            "type": "object",
                            "valueObject": {
                                "Name": {
                                    "type": "string",
                                    "valueString": "Apple",
                                    "text": "Apple",
                                    "boundingBox": [
                                        32,
                                        267,
                                        92,
                                        267,
                                        92,
                                        291,
                                        32,
                                        291
                                    ],
                                    "page": 1,
                                    "confidence": 0.991,
                                    "elements": [
                                        "#/readResults/0/lines/4/words/1"
                                    ]
                                },
    ...
}

```

## Understanding confidence scores 

If the confidence values of the **readResults** are low, try to improve the quality of your input documents. 

You will also want to make sure that the form you are analyzing has a similar appearance to forms in the training set if the confidence values of the **pageResults** are low. If the form appearance varies, consider training more than one model, with each model focused on one form format. 

Depending on the use case, you may find that a confidence score of 80% or above is acceptable for a low-risk application. For more sensitive cases, like reading medical records or billing statements, a score of 100% is recommended.