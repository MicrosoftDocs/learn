Labeling, or tagging, your data correctly is an important part of the process to create a custom entity extraction model. Labels identify examples of specific entities in text used to train the model. Three things to focus on are:

- **Consistency** - Label your data the same way across all files for training. Consistency allows your model to learn without any conflicting inputs.
- **Precision** - Label your entities consistently, without unnecessary extra words. Precision ensures only the correct data is included in your extracted entity.
- **Completeness** - Label your data completely, and don't miss any entities. Completeness helps your model always recognize the entities present.

:::image type="content" source="../media/tag-entity-screenshot.png" alt-text="Screenshot of labeling an entity in Language Studio." lightbox="../media/tag-entity-screenshot.png":::

## How to label your data

Language Studio is the most straight forward method for labeling your data. Language Studio allows you to see the file, select the beginning and end of your entity, and specify which entity it is.

Each label that you identify gets saved into a file that lives in your storage account with your dataset, in an auto-generated JSON file. This file then gets used by the model to learn how to extract custom entities. It's possible to provide this file when creating your project (if you're importing the same labels from a different project, for example) however it must be in the [Accepted custom NER data formats](/azure/ai-services/language-service/custom-named-entity-recognition/concepts/data-formats).
For example:

```json

{
  "projectFileVersion": "{DATE}",
  "stringIndexType": "Utf16CodeUnit",
  "metadata": {
    "projectKind": "CustomEntityRecognition",
    "storageInputContainerName": "{CONTAINER-NAME}",
    "projectName": "{PROJECT-NAME}",
    "multilingual": false,
    "description": "Project-description",
    "language": "en-us",
    "settings": {}
  },
  "assets": {
    "projectKind": "CustomEntityRecognition",
    "entities": [
      {
        "category": "Entity1"
      },
      {
        "category": "Entity2"
      }
    ],
    "documents": [
      {
        "location": "{DOCUMENT-NAME}",
        "language": "{LANGUAGE-CODE}",
        "dataset": "{DATASET}",
        "entities": [
          {
            "regionOffset": 0,
            "regionLength": 500,
            "labels": [
              {
                "category": "Entity1",
                "offset": 25,
                "length": 10
              },
              {
                "category": "Entity2",
                "offset": 120,
                "length": 8
              }
            ]
          }
        ]
      },
      {
        "location": "{DOCUMENT-NAME}",
        "language": "{LANGUAGE-CODE}",
        "dataset": "{DATASET}",
        "entities": [
          {
            "regionOffset": 0,
            "regionLength": 100,
            "labels": [
              {
                "category": "Entity2",
                "offset": 20,
                "length": 5
              }
            ]
          }
        ]
      }
    ]
  }
}

```

| Field | Description |
|-------|-------------|
| `documents` | Array of labeled documents |
| `location` | Path to file within container connected to the project |
| `language` | Language of the file |
| `entities` | Array of present entities in the current document |
| `regionOffset` | Inclusive character position for start of text |
| `regionLength` | Length in characters of the data used in training |
| `category` |Name of entity to extract |
| `labels` | Array of labeled entities in the files |
| `offset` | Inclusive character position for start of entity |
| `length` | Length in characters of the entity |
| `dataset` | Which dataset the file is assigned to |
