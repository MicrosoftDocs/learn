Custom NER is an Azure API service that looks at documents, identifies, and extracts user defined entities. This could anything from names and addresses from bank statements to knowledge mining to improve search results.

Custom NER is part of the Language service in Azure Cognitive Services.

## Language service project lifecycle

![Language service lifecycle diagram](../media/extraction-development-lifecycle.png)

Creating a entity extraction model typically follows a similar path to most Language service features:

1. **Define entities**: Understanding the data and entities you want to identify, and try to make them as clear as possible.
2. **Tag data**: Tag your existing data, specifying what text in your dataset corresponds to which entity. This step is important to do accurately and completely, as any wrong or missed tags will reduce the effectiveness of the trained model. A good variation of possible input documents is useful.
3. **Train model**: Train your model once your entities are tagged.
4. **View model**: After your model is trained, view the results of the model. This includes a score of 0 to 1 that is based on the precision and recall of the data tested.
5. **Improve model**: Improve your model by seeing which entities failed to be identified, and which entities were incorrectly extracted. Find out what data needs to be added to your model's training to improve performance.
6. **Deploy model**: Once your model performs as desired, deploy your model to make it available via the API.
7. **Extract entities**: Use your model for extracting entities. The lab covers how to use the API, and you can view the [API reference](https://aka.ms/ct-runtime-swagger) for more details.

## Considerations for data selection and refining entities

For the best performance, you will need to use both high quality data to train the model and clearly defined entity types. 

High quality data will let you spend less time refining and yield better results from your model.

- **Diversity** - use as diverse of a dataset as possible without losing the real-life distribution expected in the real data. You'll want to use sample data from as many sources as possible, each with their own formats and number of entities. It's best to have your dataset represent as many different sources as possible.
- **Distribution** - use the appropriate distribution of document types. A more diverse dataset to train your model will help your model avoid learning incorrect relationships in the data.
- **Accuracy** - use data that is as close to real world data as possible. Fake data works to start the training process, but it likely will differ from real data in ways that can cause your model to not extract correctly.

Entities need to also be carefully considered, and defined as distinctly as possible. Avoid ambiguous entities (such as two names next to eachother on a bank statement), as it will make the model struggle to differentiate. If having some ambiguous entities is required, make sure to have more examples for your model to learn from so it can understand the difference.

Keeping your entities distinct will also go a long way in helping your model's performance. For example, trying to extract something like "Contact info" that could be a phone number, social media handle, or email address would require a lot of examples to correctly teach your model. Instead, try to break them down into more specific entities such as "Phone", "Email", and "Social media" and let the model tag whichever type of contact information it finds. 

## How to extract entities

When submitting an extraction task, the API requires the JSON body to specify which task to execute. For custom NER, the task for the JSON payload is `customEntityRecognitionTasks`.

Your payload will look similar to the following:

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

The Language service does have limits on the resources as projects. 

- **Training** - at least 10 files, and not more than 100,000
- **Deployments** - 10 deployment names per project
- **APIs** 
  - **Authoring** - this is the API that creates a project, trains, and deploys your model. Limited to 10 POST and 100 GET per minute
  - **Analyze** - this is the API that does the work of actually extracting the entities; it requests a task and retrieves the results. Limited to 20 GET or POST
- **Projects** - only 1 storage account per project, 500 projects per resource, and 50 trained models per project
- **Entities** - each entity must be less than 10 words and 100 characters, up to 200 entity types, and at least 10 tagged instances per entity