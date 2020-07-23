A dataset is a named view of data that simply points or references the data you want to use in your activities as inputs and outputs. Datasets identify data within different data stores, such as tables, files, folders, and documents. For example, an Azure Blob dataset specifies the blob container and folder in Blob storage from which the activity should read the data.

A dataset in Data Factory can be defined as an object within the Copy Data Activity or in JSON format as follows:

```JSON
{
    "name": "<name of dataset>",
    "properties": {
        "type": "<type of dataset: AzureBlob, AzureSql etc...>",
        "linkedServiceName": {
                "referenceName": "<name of linked service>",
                "type": "LinkedServiceReference",
        },
        "structure": [
            {
                "name": "<Name of the column>",
                "type": "<Name of the type>"
            }
        ],
        "typeProperties": {
            "<type specific property>": "<value>",
            "<type specific property 2>": "<value 2>",
        }
    }
}
```

The following table describes properties in the above JSON:

| Property        | Description           | Required  |
| ------------- |-------------| -----|
| name    | Name of the dataset. |Yes |
| type     | Type of the dataset. Specify one of the types supported by Data Factory (for example: AzureBlob, AzureSqlTable).   |   Yes |
| structure | Schema of the dataset.     |    No |
| typeProperties | The type properties are different for each type (for example: Azure Blob, Azure SQL table).   |    Yes|

## Example of a Dataset

### Azure SQL Database

The following example creates a dataset named "AzureBlobOutput" that defines a dataset in Azure Blob Store, in a container named datacontainer and a folder named partitioneddata which will contain a text document.

```JSON
{
    "name": "AzureBlobOutput",
  "properties": {
    "published": false,
    "type": "AzureBlob",
    "linkedServiceName": "AzureStorageLinkedService",
    "typeProperties": {
      "folderPath": "datacontainer/partitioneddata",
      "format": {
        "type": "TextFormat",
        "columnDelimiter": ","
      }
    }
  }
}

```
