In order to work with data factory pipelines, it is imperative to understand what a pipeline in Azure Data Factory is. 

A pipeline in Azure Data Factory represents a logical grouping of activities where the activities together perform a certain task. 

An example of a combination of activities in one pipeline can be, ingesting and cleaning log data in combination with a mapping data flow that analyzes the log data that has been cleaned. 

A pipeline enables you to manage the separate individual activities as a set, which would otherwise be managed individually. 
It enables you to deploy and schedule the activities efficiently, through the use of a single pipeline, versus managing each activity independently. 

Activities in a pipeline are referred to as actions that you perform on your data. 
An activity can take zero or more input datasets and produce one or more output datasets. 

An example of an action can be the use of a copy activity, where you copy data from an Azure SQL Database to an Azure DataLake Storage Gen2. 
To build on this example, you can use a data flow activity or an Azure Databricks Notebook activity for processing and transforming the data that was copied to your Azure Data Lake Storage Gen2 account, in order to have the data ready for business intelligence reporting solutions like in Azure Synapse Analytics. 

Since there are many activities that are possible in a pipeline in Azure Data Factory, we have grouped the activities in three categories:
* *Data movement activities*: the Copy Activity in Data Factory copies data from a source data store to a sink data store.
* *Data transformation activities*: Azure Data Factory supports transformation activities such as Data Flow, Azure Function, Spark, and others that can be added to pipelines either individually or chained with another activity.
* *Control activities*: Examples of control flow activities are 'get metadata', 'For Each', and 'Execute Pipeline'.

Activities can depend on each other. 
What we mean, is that the activity dependency defines how subsequent activities depend on previous activities. 
The dependency itself can be based on a condition of whether to continue in the execution of previous defined activities in order to complete a task. An activity that depends on one or more previous activities, can have different dependency conditions.

The four dependency conditions are:
* Succeeded
* Failed
* Skipped
* Completed

For example, if a pipeline has an Activity A, followed by an Activity B and Activity B has as a dependency condition on Activity A 'Succeeded', then Activity B will only run if Activity A has the status of succeeded. 

If you have multiple activities in a pipeline and subsequent activities are not dependent on previous activities, the activities may run in parallel. 


