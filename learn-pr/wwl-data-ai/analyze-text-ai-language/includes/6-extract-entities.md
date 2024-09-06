
Named Entity Recognition identifies entities that are mentioned in the text. Entities are grouped into categories and subcategories, for example:

- Person
- Location
- DateTime
- Organization
- Address
- Email
- URL

> [!NOTE]
> For a full list of categories, see the [documentation](/azure/ai-services/language-service/named-entity-recognition/concepts/named-entity-categories?tabs=ga-api).

Input for entity recognition is similar to input for other Azure AI Language API functions:

```JSON
{
  "kind": "EntityRecognition",
  "parameters": {
    "modelVersion": "latest"
  },
  "analysisInput": {
    "documents": [
      {
        "id": "1",
        "language": "en",
        "text": "Joe went to London on Saturday"
      }
    ]
  }
}
```

The response includes a list of categorized entities found in each document:

```JSON
{
    "kind": "EntityRecognitionResults",
     "results": {
          "documents":[
              {
                  "entities":[
                  {
                    "text":"Joe",
                    "category":"Person",
                    "offset":0,
                    "length":3,
                    "confidenceScore":0.62
                  },
                  {
                    "text":"London",
                    "category":"Location",
                    "subcategory":"GPE",
                    "offset":12,
                    "length":6,
                    "confidenceScore":0.88
                  },
                  {
                    "text":"Saturday",
                    "category":"DateTime",
                    "subcategory":"Date",
                    "offset":22,
                    "length":8,
                    "confidenceScore":0.8
                  }
                ],
                "id":"1",
                "warnings":[]
              }
          ],
          "errors":[],
          "modelVersion":"2021-01-15"
    }
}
```

To learn more about entities see the [Build a conversational language understanding model](/training/modules/build-language-understanding-model/) module.
