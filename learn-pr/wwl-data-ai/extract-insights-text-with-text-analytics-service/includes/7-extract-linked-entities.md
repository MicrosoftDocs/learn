In some cases, the same name might be applicable to more than one entity. For example, does an instance of the word "Venus" refer to the planet or the goddess from mythology?

Entity linking can be used to disambiguate entities of the same name by referencing an article in a knowledge base. Wikipedia provides the knowledge base for the Text Analytics service.
Specific article links are determined based on entity context within the text.

For example, "I saw Venus shining in the sky" is associated with the link [https://en.wikipedia.org/wiki/Venus](https://en.wikipedia.org/wiki/Venus); while "Venus, the goddess of beauty" is associated with [https://en.wikipedia.org/wiki/Venus_(mythology)](https://en.wikipedia.org/wiki/Venus_(mythology)).

As with all Azure AI Language service functions, you can submit one or more documents for analysis:

```JSON
{
  "documents": [
    {
      "language": "en",
      "id": "1",
      "text": "I saw Venus shining in the sky"
    }
  ]
}
```

The response includes the entities identified in the text along with links to associated articles:

```JSON
{
  "documents":
    [
      {
        "id":"1",
        "entities":[
          {
            "name":"Venus",
            "matches":[
              {
                "text":"Venus",
                "offset":6,
                "length":5,
                "confidenceScore":0.01
              }
            ],
            "language":"en",
            "id":"Venus",
            "url":"https://en.wikipedia.org/wiki/Venus",
            "dataSource":"Wikipedia"
          }
        ],
        "warnings":[]
      }
    ],
  "errors":[],
  "modelVersion":"2020-02-01"
}
```