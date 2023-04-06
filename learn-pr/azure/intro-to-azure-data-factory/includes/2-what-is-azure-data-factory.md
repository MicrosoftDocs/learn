Let's start with an overview of Azure Data Factory. This should help you determine whether it's a good choice for organizing your data to create business insights.

Azure Data Factory is a cloud-based ETL and data-integration service that helps you to create data-driven workflows to:

- Orchestrate data movement.
- Transform data at scale.

> [!NOTE]
> *Data-driven workflows* are also known as pipelines.

By using Azure Data Factory, you can reorganize raw data into meaningful data stores and data lakes. This allows you to make better business decisions.

## What is data analytics?

Data analytics is the process of gathering raw data and examining it to draw conclusions from it. This can be difficult if the data is in multiple locations, such as hosted databases and on-premises locations.

> [!TIP]
> *Raw data* is data that's been collected from a source and hasn't been processed. It's sometimes referred to as *unorganized data*.

Azure provides several technologies that you can implement to help with your organization's data analytics. These include:

- Azure Synapse Analytics
- Azure Blob Storage
- Azure Data Lake Storage
- Azure Data Lake Analytics
- Azure Analysis Services
- Azure HDInsight
- Azure Databricks
- Azure Machine Learning

You can use some or all of these services, as needed, to analyze your organization's data. However, none of these services addresses data integration. *Data integration* allows you to collect data from multiple sources, then load this combined data to a location suitable for data analysis. If necessary, you can transform the data during this process. Although you can perform these tasks manually, you could consider using Azure Data Factory.

## Azure Data Factory definition

Azure Data Factory is a cloud-based data-integration service that's designed to address the needs of two specific communities, as described in the following table:

| Community                             | Description of community needs                               |
| ------------------------------------- | ------------------------------------------------------------ |
| Big data community                    | This community relies on technologies for managing large amounts of diverse data. For them, Azure Data Factory provides a means to create and run pipelines in the cloud. These pipelines can access both cloud and on-premises data services. These pipelines typically work with technologies such as Azure Synapse Analytics, Azure Blobs, Azure Data Lake, Azure HDInsight, Azure Databricks, and Azure Machine Learning. |
| Relational data warehousing community | This community typically relies on technologies such as Microsoft SQL Server. SQL Server Integration Services (SSIS) is often used to create SSIS packages. For this community, Azure Data Factory provides the ability to run SSIS packages on Azure, thereby letting them access both cloud and on-premises data services. |

> [!NOTE]
> A *package* is similar to an Azure Data Factory pipeline. Each package defines a process to extract, load, transform, or otherwise work with data.

The main point is that Azure Data Factory is a single cloud service for data integration. It provides a single set of tools and a common management interface for all of your data integration, and supports all of your data sources, wherever they're located:

- Azure
- On-premises
- A third-party public cloud platform

## How Azure Data Factory can help with data analytics

By using Azure Data Factory, you can:

- Build complex ETL processes. These processes can transform data visually by using either data flows or compute services such as:

  - Azure HDInsight Hadoop
  - Azure Databricks
  - Azure SQL Database

- Publish this transformed data to data stores for business intelligence apps to consume.

In the following graphic, external data sources are connected to Azure Data Factory. A storage blob is used to ingest the data, while Azure Synapse Analytics is used as storage. These elements provide the orchestration. The analysis and visualization components, Azure Analysis Service, and Power BI are also connected to Azure Data Factory.

:::image type="content" source="../media/adf-overview.png" alt-text="Graphic depicting a possible architecture for using Azure Data Factory.":::

> [!TIP]
> Azure Data Factory provides more than 90 built-in, maintenance-free connectors.
