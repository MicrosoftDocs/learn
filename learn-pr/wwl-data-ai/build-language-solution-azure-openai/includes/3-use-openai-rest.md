AOAI offers a REST API for interacting and generating responses that developers can use to add AI functionality to their applications. This unit covers example usage, input and output from the API.

Before interacting with the API, you must create an Azure OpenAI resource in the Azure portal, deploy 

{
    "id": "ID of your call",
    "object": "text_completion",
    "created": 1675444965,
    "model": "text-davinci-002",
    "choices": [
        {
            "text": " there lived in a little village a woman who was known as the meanest",
            "index": 0,
            "finish_reason": "length",
            "logprobs": null
        }
    ],
    "usage": {
        "completion_tokens": 16,
        "prompt_tokens": 3,
        "total_tokens": 19
    }
}

In this article, we'll show you how to use the Azure OpenAI REST API to add natural language processing (NLP) functionality to an application. We'll also provide a code example of the API response.

First, you'll need to sign up for an Azure OpenAI account and create a new resource. Then, you'll need to generate an API key and secret. Finally, you'll need to create a new application in your Azure portal.

Once you have all of that set up, you can begin making calls to the Azure OpenAI REST API. The API has a number of different endpoints, each of which offers different functionality. For our purposes, we'll be using the /text/analytics/v3.0/analyze endpoint.

This endpoint takes a JSON object as its input. The object must contain a "documents" property, which is an array of objects. Each object in the array must contain a "language" property and a "text" property. The "language" property is used to specify the language of the text. The "text" property is used to specify the actual text to be analyzed.

Here's an example of what the input JSON object might look like:

{
  "documents": [
    {
      "language": "en",
      "text": "Hello, world!"
    }
  ]
}

Once you have your input JSON object, you can make a POST request to the /text/analytics/v3.0/analyze endpoint. The request should include your API key and secret, as well as the input JSON object.

If the request is successful, you'll receive a JSON response that contains a number of properties, including an "analysisResults" property. This property contains an array of objects, each of which represents the results of the analysis for a specific document.

Each object in the "analysisResults" array will contain a "keyPhrases" property, which is an array of strings. These strings represent the key phrases that were extracted from the document.

Here's an example of what the JSON response might look like:

{
  "analysisResults": [
    {
      "keyPhrases": [
        "Hello",
        "world"
      ]
    }
  ]
}

And here's a code example of the API response:

{
  "documents": [
    {
      "language": "en",
      "id": "1",
      "text": "Hello, world!"
    }
  ],
  "errors": [],
  "modelVersion": "2020-04-01"
}