## Using the REST API 

To extract form data using a custom model, use the [**analyze document**](/azure/applied-ai-services/form-recognizer/quickstarts/try-v3-rest-api#analyze-documents-and-get-results) REST API function  with your model ID (generated during model training). This function starts the form analysis and returns a result ID, which you can pass in a subsequent call to the [**get analyze results**](/azure/applied-ai-services/form-recognizer/quickstarts/try-v3-rest-api#get-analyze-results-get-request) function to retrieve the results. 

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

## Using the SDK 

You can also call Azure Document Intelligence models by integrating our client library SDks into your workflows and applications. Supported SDK languages include: 
- [C Sharp](/azure/applied-ai-services/form-recognizer/quickstarts/try-v3-csharp-sdk)
- [Java](/azure/applied-ai-services/form-recognizer/quickstarts/try-v3-java-sdk)
- [JavaScript](/azure/applied-ai-services/form-recognizer/quickstarts/try-v3-javascript-sdk)
- [Python](/azure/applied-ai-services/form-recognizer/quickstarts/try-v3-python-sdk).
