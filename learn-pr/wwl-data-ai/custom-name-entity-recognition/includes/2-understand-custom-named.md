Custom NER is an Azure API service that looks at documents, identifies, and extracts user defined entities. These entities could be anything from names and addresses from bank statements to knowledge mining to improve search results.

Custom NER is part of the Azure AI Language Service in Azure AI Services.

## Custom vs built-in NER

The Azure AI Language Service provides certain built-in entity recognition, to recognize things such as a person, location, organization, or URL. Built-in NER allows you to set up the service with minimal configuration, and extract entities. To call a built-in NER, create your service and call the endpoint for that NER service:

```rest
<YOUR-ENDPOINT>/text/analytics/v3.2-preview.2/entities/recognition/general
```

|Placeholder  |Value  | Example |
|---------|---------|---------|
|`<YOUR-ENDPOINT>`     | The endpoint for your API request  | `https://<your-resource>.cognitiveservices.azure.com` |

The body of that call will contain the document(s) the entities are extracted from, and the headers contain your service key.

The response from the call above contains an array of entities recognized, such as:

```json
<...>
"entities":[
    {
        "text":"Seattle",
        "category":"Location",
        "subcategory":"GPE",
        "offset":45,
        "length":7,
        "confidenceScore":0.99
    },
    {
        "text":"next week",
        "category":"DateTime",
        "subcategory":"DateRange",
        "offset":104,
        "length":9,
        "confidenceScore":0.8
    }
]
<...>
```

Examples of when to use the built-in NER include finding locations, names, or URLs in long text documents.

> [!TIP]
> A full list of recognized entity categories is available in the [NER docs](https://aka.ms/ner-categories).

Custom NER, which is the focus of the rest of this module, is available when the entities you want to extract aren't part of the built-in service or you only want to extract specific entities. You can make your custom NER model as simple or complex as is required for your app.

Examples of when you'd want custom NER include specific legal or bank data, knowledge mining to enhance catalog search, or looking for specific text for audit policies. Each one of these projects requires a specific set of entities and data it needs to extract.

## Azure AI Language Service project life cycle

![Conceptual diagram showing a project steps to define entities, tag data, train model, view model, improve model, deploy model, and extract entities.](../media/extraction-development-lifecycle.png#lightbox)

Creating an entity extraction model typically follows a similar path to most Azure AI Language Service features:

1. **Define entities**: Understanding the data and entities you want to identify, and try to make them as clear as possible. For example, defining exactly which parts of a bank statement you want to extract.
2. **Tag data**: Label, or tag, your existing data, specifying what text in your dataset corresponds to which entity. This step is important to do accurately and completely, as any wrong or missed labels will reduce the effectiveness of the trained model. A good variation of possible input documents is useful. For example, label bank name, customer name, customer address, specific loan or account terms, loan or account amount, and account number.
3. **Train model**: Train your model once your entities are labeled. Training teaches your model how to recognize the entities you label.
4. **View model**: After your model is trained, view the results of the model. This page includes a score of 0 to 1 that is based on the precision and recall of the data tested. You can see which entities worked well (such as customer name) and which entities need improvement (such as account number).
5. **Improve model**: Improve your model by seeing which entities failed to be identified, and which entities were incorrectly extracted. Find out what data needs to be added to your model's training to improve performance. This page shows you how entities failed, and which entities (such as account number) need to be differentiated from other similar entities (such as loan amount).
6. **Deploy model**: Once your model performs as desired, deploy your model to make it available via the API. In our example, you can send to requests to the model when it's deployed to extract bank statement entities.
7. **Extract entities**: Use your model for extracting entities. The lab covers how to use the API, and you can view the [API reference](https://aka.ms/ct-runtime-swagger) for more details.

## Considerations for data selection and refining entities

For the best performance, you'll need to use both high quality data to train the model and clearly defined entity types.

High quality data will let you spend less time refining and yield better results from your model.

- **Diversity** - use as diverse of a dataset as possible without losing the real-life distribution expected in the real data. You'll want to use sample data from as many sources as possible, each with their own formats and number of entities. It's best to have your dataset represent as many different sources as possible.
- **Distribution** - use the appropriate distribution of document types. A more diverse dataset to train your model will help your model avoid learning incorrect relationships in the data.
- **Accuracy** - use data that is as close to real world data as possible. Fake data works to start the training process, but it likely will differ from real data in ways that can cause your model to not extract correctly.

Entities need to also be carefully considered, and defined as distinctly as possible. Avoid ambiguous entities (such as two names next to each other on a bank statement), as it will make the model struggle to differentiate. If having some ambiguous entities is required, make sure to have more examples for your model to learn from so it can understand the difference.

Keeping your entities distinct will also go a long way in helping your model's performance. For example, trying to extract something like "Contact info" that could be a phone number, social media handle, or email address would require several examples to correctly teach your model. Instead, try to break them down into more specific entities such as "Phone", "Email", and "Social media" and let the model label whichever type of contact information it finds.

## How to extract entities

To submit an extraction task, the API requires the JSON body to specify which task to execute. For custom NER, the task for the JSON payload is `customEntityRecognitionTasks`.

Your payload will look similar to the following JSON:

```json
{
    "displayName": "string",
    "analysisInput": {
        "documents": [
            {
                "id": "doc1", 
                "text": "string"
            },
            {
                "id": "doc2",
                "text": "string"
            }
        ]
    },
    "tasks": {
        "customEntityRecognitionTasks": [      
            {
                "parameters": {
                      "project-name": "myProject",
                      "deployment-name": "myDeployment"
                }
            }
        ]
    }
}
```

## Project limits

The Azure AI Language Service enforces the following restrictions:

- **Training** - at least 10 files, and not more than 100,000
- **Deployments** - 10 deployment names per project
- **APIs**
  - **Authoring** - this API creates a project, trains, and deploys your model. Limited to 10 POST and 100 GET per minute
  - **Analyze** - this API does the work of actually extracting the entities; it requests a task and retrieves the results. Limited to 20 GET or POST
- **Projects** - only 1 storage account per project, 500 projects per resource, and 50 trained models per project
- **Entities** - each entity must be fewer than 10 words and 100 characters, up to 200 entity types, and at least 10 tagged instances per entity
