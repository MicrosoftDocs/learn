A dataset is a named view of data that simply points or references the data you want to use in your activities as inputs and outputs. Datasets identify data within different data stores, such as tables, files, folders, and documents. For example, an Azure Blob dataset specifies the blob container and folder in Blob storage from which the activity should read the data.

A dataset in Data Factory can be defined as an object within the Copy Data Activity, as a separate object, or in a JSON format for programmatic creation as follows:

```JSON
{
    "name": "<name of dataset>",
    "properties": {
        "type": "<type of dataset: AzureBlob, AzureSql etc...>",
        "linkedServiceName": {
                "referenceName": "<name of linked service>",
                "type": "LinkedServiceReference",
        },
        "schema": [
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

## Example of a dataset

### Azure Blob

In this procedure, you create two datasets: InputDataset and OutputDataset. These datasets are of type Binary. They refer to the Azure Storage linked service named AzureStorageLinkedService. The input dataset represents the source data in the input folder. In the input dataset definition, you specify the blob container (adftutorial), the folder (input), and the file (emp.txt) that contain the source data. The output dataset represents the data that's copied to the destination. In the output dataset definition, you specify the blob container (adftutorial), the folder (output), and the file to which the data is copied.

1. Create a JSON file named InputDataset.json in the C:\ADFv2QuickStartPSH folder, with the following content:

     ```JSON
       {
           "name": "InputDataset",
           "properties": {
               "linkedServiceName": {
                   "referenceName": "AzureStorageLinkedService",
                   "type": "LinkedServiceReference"
               },
               "annotations": [],
               "type": "Binary",
               "typeProperties": {
                   "location": {
                       "type": "AzureBlobStorageLocation",
                       "fileName": "emp.txt",
                       "folderPath": "input",
                       "container": "adftutorial"
                   }
               }
           }
       }

       ```

1. To create the dataset: InputDataset, run the Set-AzDataFactoryV2Dataset cmdlet.

    ```Powershell
    Set-AzDataFactoryV2Dataset -DataFactoryName $DataFactory.DataFactoryName `
        -ResourceGroupName $ResGrp.ResourceGroupName -Name "InputDataset" `
        -DefinitionFile ".\InputDataset.json"
    ```

    Here is the sample output:

    ```Text
    DatasetName       : InputDataset
    ResourceGroupName : <resourceGroupname>
    DataFactoryName   : <dataFactoryName>
    Structure         :
    Properties        : Microsoft.Azure.Management.DataFactory.Models.BinaryDataset
    ```

1. Repeat the steps to create the output dataset. Create a JSON file named OutputDataset.json in the C:\ADFv2QuickStartPSH folder, with the following content:

    ```JSON
    {
        "name": "OutputDataset",
        "properties": {
            "linkedServiceName": {
                "referenceName": "AzureStorageLinkedService",
                "type": "LinkedServiceReference"
            },
            "annotations": [],
            "type": "Binary",
            "typeProperties": {
                "location": {
                    "type": "AzureBlobStorageLocation",
                    "folderPath": "output",
                    "container": "adftutorial"
                }
            }
        }
    }
    ```

1. Run the Set-AzDataFactoryV2Dataset cmdlet to create the OutDataset.

    ```Powershell
    Set-AzDataFactoryV2Dataset -DataFactoryName $DataFactory.DataFactoryName `
        -ResourceGroupName $ResGrp.ResourceGroupName -Name "OutputDataset" `
        -DefinitionFile ".\OutputDataset.json"
    ```

     Here is the sample output:

    ```Text
    DatasetName       : OutputDataset
    ResourceGroupName : <resourceGroupname>
    DataFactoryName   : <dataFactoryName>
    Structure         :
    Properties        : Microsoft.Azure.Management.DataFactory.Models.BinaryDataset
    ```