Labeling, or tagging, your data correctly is an important part of the process to create a custom entity extraction model. Labels identify examples of specific entities in text used to train the model. Three things to focus on are:

- **Consistency** - Label your data the same way across all files for training. Consistency allows your model to learn without any conflicting inputs.
- **Precision** - Label your entities consistently, without unnecessary extra words. Precision ensures only the correct data is included in your extracted entity.
- **Completeness** - Label your data completely, and don't miss any entities. Completeness helps your model always recognize the entities present.

![Screenshot of labeling an entity in Azure AI Language Studio.](../media/ner-tag-entity-screenshot.png#lightbox)

## How to label your data

Azure AI Language Studio is the most straight forward method for labeling your data. Azure AI Language Studio allows you to see the file, select the beginning and end of your entity, and specify which entity it is.

Each label that you identify gets saved into a file that lives in your storage account with your dataset, in an auto-generated JSON file. This file then gets used by the model to learn how to extract custom entities. It's possible to provide this file when creating your project (if you're importing the same labels from a different project, for example) however it must be in the approved format.

```json
{
    "entityNames": [
        "ItemForSale",
        "Price",
        "Location"
    ],
    "documents": [
        {
            "location": "Ad 1.txt",
            "culture": "en-us",
            "entities": [
                {
                    "regionStart": 0,
                    "regionLength": 137,
                    "labels": [
                        {
                            "entity": 0,
                            "start": 0,
                            "length": 23,
                            "autoTagged": false
                        },
                        {
                            "entity": 2,
                            "start": 115,
                            "length": 10,
                            "autoTagged": false
                        },
                        {
                            "entity": 1,
                            "start": 134,
                            "length": 3,
                            "autoTagged": false
                        }
                    ]
                }
            ],
            "datasets": [
                "Train"
            ]
        },
        {
            "location": "Ad 10.txt",
            "culture": "en-us",
            "entities": [
                {
                    "regionStart": 0,
                    "regionLength": 163,
                    "labels": [
                        {
                            "entity": 0,
                            "start": 0,
                            "length": 29
                        },
                        {
                            "entity": 2,
                            "start": 33,
                            "length": 12
                        },
                        {
                            "entity": 1,
                            "start": 159,
                            "length": 4
                        }
                    ]
                }
            ],
            "datasets": [
                "Train"
            ]
        }
    ]
}
```

| Field | Description |
|-------|-------------|
| `entityNames` | Array of entities to extract |
| `documents` | Array of labeled documents |
| `location` | Path to file within container connected to the project |
| `culture` | Language of the file |
| `entities` | Array of present entities in the current document |
| `regionStart` | Inclusive character position for start of text |
| `regionLength` | Length in characters of the data used in training |
| `labels` | Array of labeled entities in the files |
| `entity` | Which entity this label references, by index in `entityNames` |
| `start` | Inclusive character position for start of entity |
| `length` | Length in characters of the entity |
| `datasets` | Which dataset the file is assigned to |
