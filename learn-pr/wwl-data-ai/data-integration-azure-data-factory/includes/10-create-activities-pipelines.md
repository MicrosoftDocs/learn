Activities within Azure Data Factory define the actions that are performed on the data. There are three categories:

- Data movement activities
- Data transformation activities
- Control activities

## Data movement activities

Data movement activities simply move data from one data store to another. You can use the Copy Activity to perform data movement activities, or by using JSON. There are a wide range of data stores that are supported as a source and as a sink. This list is ever increasing, and you can find the [latest information here](/azure/data-factory/concepts-pipelines-activities#data-movement-activities). 

## Data transformation activities

Data transformation activities can be performed natively within the authoring tool of Azure Data Factory using the Mapping Data Flow. Alternatively, you can call a compute resource to change or enhance data through transformation, or perform analysis of the data. These include compute technologies such as Azure Databricks, Azure Batch, Azure Functions, Azure SQL Database, Azure Machine Learning, and HDInsight. You can also run existing SQL Server Integration Services (SSIS) packages in Azure by using an Azure-SSIS integration runtime.

As this list is always evolving, you can get the [latest information here](/azure/data-factory/concepts-pipelines-activities#data-transformation-activities).

## Control activities

When graphically authoring ADF solutions, you can use the control flow within the design for orchestrating pipeline activities that include chaining activities in a sequence, branching, defining parameters at the pipeline level, and passing arguments while invoking the pipeline on-demand or from a trigger. The current capabilities include:

| Control Activity | Description |
|------------------|-------------|
| Execute Pipeline Activity  | Execute Pipeline activity allows a Data Factory pipeline to invoke another pipeline. |
| ForEachActivity  | ForEach Activity defines a repeating control flow in your pipeline. This activity is used to iterate over a collection and executes specified activities in a loop. The loop implementation of this activity is similar to Foreach looping structure in programming languages. |
| WebActivity  | Web Activity can be used to call a custom REST endpoint from a Data Factory pipeline. You can pass datasets and linked services to be consumed and accessed by the activity. |
| Lookup Activity  | Lookup Activity can be used to read or look up a record/ table name/ value from any external source. This output can further be referenced by succeeding activities. |
| Get Metadata Activity  | GetMetadata activity can be used to retrieve metadata of any data in Azure Data Factory. |
| Until Activity  | Implements Do-Until loop that's similar to Do-Until looping structure in programming languages. It executes a set of activities in a loop until the condition associated with the activity evaluates to true. You can specify a timeout value for the until activity in Data Factory. |
| If Condition Activity  | The If Condition can be used to branch based on condition that evaluates to true or false. The If Condition activity provides the same functionality that an if statement provides in programming languages. It evaluates a set of activities when the condition evaluates to true and another set of activities when the condition evaluates to false. |
| Wait Activity  | When you use a Wait activity in a pipeline, the pipeline waits for the specified period of time before continuing with execution of subsequent activities. |
| Append Variable Activity | Add a value to an existing array variable. |
| Filter Activity | Apply a filter expression to an input array. |
| Set Variable Activity | Set the value of an existing variable. |
| Validation Activity | Ensure a pipeline only continues execution if a reference dataset exists, meets a specified criteria, or a timeout is reached. |
| Webhook Activity | Call a custom REST endpoint and pass a callback URL. The pipeline waits for the callback to be invoked before proceeding to the next activity. |
| Fail Activity | Intentionally fail a pipeline with a custom error message and error code. |

You can get the [latest information here](/azure/data-factory/concepts-pipelines-activities#control-activities).

## Activities and pipelines 

## Defining activities

When using JSON notation, the activities section can have one or more activities defined within it. There are two main types of activities: Execution and Control Activities. Execution (also known as Compute) activities include data movement and data transformation activities. They have the following top-level structure:

```JSON
{
    "name": "Execution Activity Name",
    "description": "description",
    "type": "<ActivityType>",
    "typeProperties":
    {
    },
    "linkedServiceName": "MyLinkedService",
    "policy":
    {
    },
    "dependsOn":
    {
    }
}
```

The following table describes properties in the above JSON:

| Property        | Description           | Required  |
| ------------- |-------------| -----|
| name    | Name of the activity. |Yes |
| description     | Text describing what the activity is used for.   |   Yes |
| type | Defines the type of the activity.     |    Yes |
| linkedServiceName | Name of the linked service used by the activity.   |    Yes for HDInsight and Stored Procedure activities. No for most others. |
| typeProperties | Properties in the typeProperties section depend on each type of activity.      |    No |
| policy | Policies that affect the run-time behavior of the activity. This property includes timeout and retry behavior.      |    No |
| dependsOn | This property is used to define activity dependencies, and how subsequent activities depend on previous activities.      |    No |

## Defining control activities

A Control Activity in Data Factory is defined in JSON format as follows:

```JSON
{
    "name": "Control Activity Name",
    "description": "description",
    "type": "<ActivityType>",
    "typeProperties":
    {
    },
    "dependsOn":
    {
    }
}
```

The following table describes properties in the above JSON:

| Property        | Description           | Required  |
| ------------- |-------------| -----|
| name    | Name of the activity. |Yes |
| description     | Text describing what the activity is used for.   |   Yes |
| type | Defines the type of the activity.     |    Yes |
| typeProperties | Properties in the typeProperties section depend on each type of activity.      |    No |
| dependsOn | This property is used to define activity dependencies, and how subsequent activities depend on previous activities.      |    No |

## Defining pipelines

Here's how a pipeline is defined in JSON format:

```JSON
{
    "name": "PipelineName",
    "properties":
    {
        "description": "pipeline description",
        "activities":
        [
        ],
        "parameters": {
         }
    }
}
```

The following table describes properties in the above JSON:

| Property        | Description           | Required  |
| ------------- |-------------| -----|
| name    | Name of the pipeline. |Yes |
| description     | Text describing what the pipeline is used for.   |   No |
| activities | The activities section can have one or more activities defined within it.      |    Yes |
| parameters | The parameters section can have one or more parameters defined within the pipeline, making your pipeline flexible for reuse.     |    No |

## Example

The following JSON defines a pipeline named "MyFirstPipeline" that contains one activity of type HDInsightHive. The activity runs a Hive script named "partitionweblogs.hql" that's stored in the storage account referenced by the linked service "StorageLinkedService". It runs against the compute resource defined in the linked service "HDInsightOnDemandLinkedService". The activity policy attempts the activity up to three more times if it fails. To run the pipeline on a schedule, associate a trigger with it.

```JSON
{
    "name": "MyFirstPipeline",
    "properties": {
        "description": "My first Azure Data Factory pipeline",
        "activities": [
            {
                "name": "RunSampleHiveActivity",
                "description": "Run a Hive script to partition web logs",
                "type": "HDInsightHive",
                "linkedServiceName": {
                    "referenceName": "HDInsightOnDemandLinkedService",
                    "type": "LinkedServiceReference"
                },
                "typeProperties": {
                    "scriptPath": "adfgetstarted/script/partitionweblogs.hql",
                    "scriptLinkedService": {
                        "referenceName": "StorageLinkedService",
                        "type": "LinkedServiceReference"
                    },
                    "defines": {
                        "inputtable": "wasb://adfgetstarted@ctostorageaccount.blob.core.windows.net/inputdata",
                        "partitionedtable": "wasb://adfgetstarted@ctostorageaccount.blob.core.windows.net/partitioneddata"
                    }
                },
                "policy": {
                    "retry": 3
                }
            }
        ]
    }
}
```
