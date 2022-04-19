Tailwind Traders is serving clients with stock market information. You need a combination of batch and stream processing. The up-to-the-second data might be used to help monitor real-time where an instant decision is required to make informed split-second buy or sell decisions. Historical data is equally important for a view of trends in performance. What kind of data warehouse and data integration solution you would recommend that provides access to the streams of raw data, and the cooked business information derived from this data?

With Azure Synapse Analytics, you can ingest data from external sources and then transform and aggregate this data into a format suitable for analytics processing.

In this unit we will explore the high-level architecture and component parts of Azure Synapse Analytics and how to get started using Azure Synapse Analytics for data integration.

:::image type="content" source="../media/azure-synapse.png" alt-text="Diagram showing Azure Synapse architecture.":::


Azure Synapse Analytics leverages a massively parallel processing (MPP) architecture. This architecture includes a control node and a pool of compute nodes. 

The Control node is the brain of the architecture. It's the front end that interacts with all applications. The Compute nodes provide the computational power. The data to be processed is distributed evenly across the nodes. You submit queries in the form of Transact-SQL statements, and Azure Synapse Analytics runs them. Azure Synapse Analytics uses a technology named [PolyBase](/sql/relational-databases/polybase/polybase-guide) that enables you to retrieve and query data from relational and non-relational sources. You can save the data read in as SQL tables within the Synapse Analytics service.

## Components of Azure Synapse Analytics

:::image type="content" source="../media/azure-synapse-analytics-overview.png" alt-text="Diagram showing an overview of Azure Synapse capabilities.":::



Azure Synapse Analytics is composed of the following elements:

- **Synapse SQL pool**: Synapse SQL offers both serverless and dedicated resource models to work with using node-based architecture. For predictable performance and cost, you can create dedicated SQL pools, for unplanned or ad hoc workloads, you can use the always-available, serverless SQL endpoint.

- **Synapse Spark pool**: This is a cluster of servers running Apache Spark to process data. You write your data processing logic using one of the four supported languages: Python, Scala, SQL, and C# (via .NET for Apache Spark). Apache Spark for Azure Synapse integrates Apache Spark-the open source big data engine used for data preparation, data engineering, ETL, and machine learning.

- **Synapse Pipelines**: Azure Synapse Pipelines leverages the capabilities of Azure Data Factory and is the cloud-based ETL and data integration service that allows you to create data-driven workflows for orchestrating data movement and transforming data at scale. You could include activities that transform the data as it is transferred, or you might combine data from multiple sources together.

- **Synapse Link**: This component allows you to connect to Cosmos DB. You can use it to perform near real-time analytics over the operational data stored in a Cosmos DB database.

- **Synapse Studio**: This is a web-based IDE that can be used centrally to work with all capabilities of Azure Synapse Analytics. You can use Synapse Studio to create SQL and Spark pools, define and run pipelines, and configure links to external data sources.

 

> [!Note]
> Read about [Analytics end-to-end with Azure Synapse](/azure/architecture/example-scenario/dataplate2e/data-platform-end-to-end)

[Analytics end-to-end with Azure Synapse](/azure/architecture/example-scenario/dataplate2e/data-platform-end-to-end)

## When to use Azure Synapse Analytics? 

- When you have a variety of data sources use Azure Synapse Analytics for code-free ETL and data flow activities. 

- When you have a need to implement Machine Learning solutions using Apache Spark, use Azure Synapse Analytics for built-in support for AzureML.

- When you have existing data stored on a data lake and need integration with the Data Lake and additional input sources, Azure Synapse Analytics provides seamless integration between the two.

- When management needs real-time analytics, you can use features like Azure Synapse Link to analyze in real-time and offer insights.

## What kind of analytics can you do with Azure Synapse Analytics?

Following table shows the range of analytical types that Azure Synapse Analytics supports:

| **Analytics type**| **Description** |
| - | - |
| Descriptive analytics - "What is happening?"| Azure Synapse Analytics leverages the dedicated SQL pool capability that enables you to create a persisted data warehouse to perform this type of analysis. You can also make use of the serverless SQL pool to prepare data from files stored in a data lake to create a data warehouse interactively. |
| Diagnostic analytics - "Why is it happening?"| You can use the serverless SQL pool capability within Azure Synapse Analytics that enables you to interactively explore data within a data lake. Serverless SQL pools can quickly enable a user to search for additional data that may help them to understand why questions. |
| Predictive analytics - "What is likely to happen?"| Azure Synapse Analytics uses its integrated Apache Spark engine and Azure Synapse Spark pools for predictive analytics with other services such as Azure Machine Learning Services, or Azure Databricks. |
| Prescriptive analytics - "What needs to be done?"| This type of analytics uses predictive analytics real-time or near real-time data. Azure Synapse Analytics provides this capability through both Apache Spark, Azure Synapse Link, and by integrating streaming technologies such as Azure Stream Analytics. |



## When to choose Azure Data Factory over Azure Synapse Analytics
Here are some criteria that will help you decide when to pick Azure Data Factory solution over Azure Synapse Analytics. In the following table, the two solutions are compared against a set of criteria. 

| **Criteria**| **Azure Data Factory**| **Azure Synapse Analytics** |
| - | - | - |
| Data sharing| Can be shared across different data factories| No sharing of data |
| Solution templates| Provided with Azure Data Factory template gallery| Provided with Synapse Workspace Knowledge center |
| Integration Runtime cross region support| Support Cross region data flows| Does not support cross region data flows |
| Monitoring| Integrated with Azure Monitor| Diagnostic logs in Azure Monitor |
| Monitoring of Spark Jobs for Data Flow| Not supported| Supported by the Synapse Spark pools |


