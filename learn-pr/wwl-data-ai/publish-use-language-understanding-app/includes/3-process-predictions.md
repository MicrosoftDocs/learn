To consume your Language Understanding model in a client application, you can use the REST APIs or one of the programming language-specific SDKs.

Regardless of the approach used, requests for predictions are sent to a published slot (production or staging) and include the following parameters:

- **query** - the utterance text to be analyzed.
- **show-all-intents** - indicates whether to include all identified intents and their scores, or only the most likely intent.
- **verbose** - used to include additional metadata in the results, such as the start index and length of strings identified as entities,
- **log** used to record queries and results for use in Active Learning.

## Prediction results

The prediction results consist of a hierarchy of information that your application must parse. When using the REST interface, the results are in JSON form. SDKs present the results as an object hierarchy based on the underlying JSON.

A typical response might look similar to this:

```JSON
{
  "query": "What's the time in Edinburgh?",
  "prediction": {
    "topIntent": "GetTime",
    "intents": {
      "GetTime": {
        "score": 0.9978
      },
      ...
    },
    "entities": {
      "location": ["Edinburgh"],
      ...
    }
  }
}
```

The prediction results include the query utterance, the *top* (most likely) intent along with its confidence score, and the entities that were detected; which are provided as an object for each entity (for example **location**) with a list of the instances of that entity that were detected (for example, "Edinburgh"). Depending on the options specified in the request, the results may also include any other intents that were identified as being a possible match, and details about the location of each entity in the utterance string.

>[!NOTE]
> It's important to emphasize that the Language Understanding service enables your application to identify the *intent* of the user (in this case to find out the current time in Edinburgh). It is the responsibility of the *client application* to then perform whatever logic is necessary to fulfill the intent (so the Language understanding model does <u>not</u> return the actual time in Edinburgh - it simply indicates to the client application that this is the information that the user wants.)
