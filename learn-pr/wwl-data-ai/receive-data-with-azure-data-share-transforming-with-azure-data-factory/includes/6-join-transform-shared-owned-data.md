In a scenario where you have your own data and you receive a dataset that you need to combine with your own data you might think about joining and transforming both datasets. 

In order to do so, you can use Mapping Flow in Azure Data Factory. 

Mapping data flows, is a tool within Azure Data Factory that allows you to visually design a data transformation flow with no coding required. 

Your data flows run on ADF-managed execution clusters for scaled-out data processing. 

Azure Data Factory handles all the code translation, path optimization, and execution of your data flow jobs.

The resulting data flows are executed as activities within Azure Data Factory pipelines that use scaled-out Apache Spark clusters. 

Data flow activities can be operationalized using existing Azure Data Factory scheduling, control, flow, and monitoring capabilities.

As a data engineer you most probably receive data from various resources and in first instance, you can store this data successfully in an Azure Data Lake Storage. 

Azure Data Share can be used to receive data from third parties or interdepartmental. 

In order to join and aggregate these various data sets, into the data warehouse, you can use mapping flow, which is a visually designed transformation service in Azure Data Factory. 

Data flows have the possibility to visually design different types of joins, aggregate function through an expression builder, splits, unions, look ups, schema moderators, row moderators, and sinks. 

For example, you can create an inner join of a dataset that was shared with Azure Data Share. 

In order to aggregate, you need to find a column that you’re going to use for the aggregation and calculate certain fields to write back and sink to an Azure Synapse Analytics table. 

There are more ways to join datasets, but the most common one is an Inner join. 

The different join types that are possible in the mapping data flow can be found here: join types.

