Here, you'll learn about the components and interconnected systems of Azure Data Factory. You'll also learn more about how it works. This will help you determine how you can best use Azure Data Factory to meet your organization's requirements.

Azure Data Factory is a collection of interconnected systems that combine to provide an end-to-end data analytics platform. In this unit, you'll learn about the following Azure Data Factory functions:

- Connect and collect
- Transform and enrich
- Continuous integration and delivery (CI/CD) and publish
- Monitoring

You'll also learn about the key components of Azure Data Factory. These are:

- Pipelines
- Activities
- Datasets
- Linked services
- Data flows
- Integration runtimes

## Azure Data Factory functions

Azure Data Factory consists of several functions that combine to provide your data engineers with a complete data-analytics platform.

### Connect and collect

The first part of the process is to collect the required data from the appropriate data sources. These can be located in different locations, including on-premises sources and in the cloud. The data might be:

- Structured
- Unstructured
- Semi-structured

In addition, this disparate data might arrive at different speeds and intervals. With Azure Data Factory, you can use the copy activity to move data from various sources to a single centralized data store in the cloud. After you've copied the data, you use other systems to transform and analyze it.

The copy activity performs the following high-level steps:

1. Read data from source data store.
2. Perform the following tasks on the data:

   - Serialization/deserialization
   - Compression/decompression
   - Column mapping

   > [!NOTE]
   > There might be additional tasks.

3. Write data to the destination data store (known as the *sink*).

This process is summarized in the following graphic:

:::image type="content" source="../media/copy-activity-overview.png" alt-text="Graphic that depicts the preceding process.":::

### Transform and enrich

After you've successfully copied the data to a central cloud-based location, you can process and transform the data as needed. You'll use Azure Data Factory mapping data flows to achieve this. *Data flows* enable you to create data transformation graphs that run on Spark. However, you don't need to understand Spark clusters or Spark programming.

> [!TIP]
> Although not necessary, you might prefer to code your transformations manually. If so, Azure Data Factory supports external activities for running your transformations.

### CI/CD and publish

Support for CI/CD enables you to develop and deliver your ETL processes incrementally before you publish. Azure Data Factory provides for CI/CD of your data pipelines by using:

- Azure DevOps
- GitHub

> [!NOTE]
> Continuous integration means automatically testing each change made to your codebase as soon as possible. Continuous delivery follows this testing and pushes changes to a staging or production system.

After Azure Data Factory has refined the raw data, you can load the data into whichever analytics engine your business users can access from their business intelligence tools, including:

- Azure Synapse Analytics
- Azure SQL Database
- Azure Cosmos DB

### Monitor

After you've successfully built and deployed your data-integration pipeline, it's important that you can monitor your scheduled activities and pipelines. This allows you to track success and failure rates. Azure Data Factory provides support for pipeline monitoring by using one of the following:

- Azure Monitor
- API
- PowerShell
- Azure Monitor logs
- Health panels in the Azure portal

## Azure Data Factory components

Azure Data Factory is composed of the components described in the following table:

| Component            | Description                                                  |
| -------------------- | ------------------------------------------------------------ |
| Pipelines            | A logical grouping of activities that perform a specific unit of work. These activities together perform a task. The advantage of using a pipeline is that you can more easily manage the activities as a set instead of as individual items. |
| Activities           | A single processing step in a pipeline. Azure Data Factory supports three types of activity: data movement, data transformation, and control activities. |
| Datasets             | Represent data structures within your data stores. These point to (or reference) the data that you want to use in your activities as either inputs or outputs. |
| Linked services      | Define the required connection information needed for Azure Data Factory to connect to external resources, such as a data source. Azure Data Factory uses these for two purposes: to represent a **data store** or a **compute resource**. |
| Data flows           | Enable your data engineers to develop data transformation logic without needing to write code. Data flows are run as activities within Azure Data Factory pipelines that use scaled-out Apache Spark clusters. |
| Integration runtimes | Azure Data Factory uses the compute infrastructure to provide the following data integration capabilities across different network environments: data flow, data movement, activity dispatch, and SSIS package execution. In Azure Data Factory, an integration runtime provides the bridge between the activity and linked services. |

As indicated in the following graphic, these components work together to provide a complete end-to-end platform for data engineers. By using Data Factory, you can:

- Set triggers on-demand and schedule data processing based on your needs.
- Associate a pipeline with a trigger, or manually start it as and when needed.  
- Connect to linked services (such as on-premises apps and data) or Azure services via integration runtimes.
- Monitor all of your pipeline runs natively in the Azure Data Factory user experience or by using Azure Monitor.

:::image type="content" source="../media/adf-concepts.png" alt-text="Graphic that depicts the interaction of the components described in the preceding table.":::
