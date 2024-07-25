Before you can work with data in Azure Databricks, you need to ingest data into the platform. Once in the platform, the cloud-based compute allows you to process large volumes of data efficiently.

There are multiple ways to ingest data into Azure Databricks, making it a versatile and powerful tool for data analysis:

### Orchestrate data pipelines with Azure Data Factory

Azure Data Factory is a robust data integration service that allows you to create data pipelines. These pipelines can ingest data from various sources into Azure Databricks, ensuring that all your data is centralized and ready for analysis.

### Ingest real-time data with Event Hubs and IoT Hubs

For real-time data ingestion, Azure Event Hubs and IoT Hubs are the most suitable choices. They enable you to stream data directly into Azure Databricks, allowing you to process and analyze data as it arrives. Real-time data ingestion and analysis is useful for scenarios like monitoring live events or tracking Internet of Things (IoT) device data.

### Ingest data directly from Azure Blob Storage and Azure Data Lake

Azure Blob Storage and Azure Data Lake Storage Gen2 are perfect for storing large amounts of unstructured data. You can easily ingest this data into Databricks using:

- **Databricks File System** (**DBFS**): A distributed file system integrated with Azure Databricks, allowing you to mount Azure Blob Storage containers and access them as if they were part of the local file system.
- **Spark APIs**: Spark APIs provide a flexible way to read and write data from Azure Blob Storage directly into Spark DataFrames, using Spark's parallel processing capabilities for efficient large-scale data processing.

DBFS offers a simpler and more integrated way to work with data in Azure Blob Storage, while Spark APIs provide greater flexibility and performance for large-scale data processing tasks. The choice between the two depends on your specific use case and requirements.

> [!Note]
> Azure Data Lake Storage Gen2 is built on top of Azure Blob Storage, combining the capabilities of both services. Azure Blob Storage is designed for storing large amounts of unstructured data, while Azure Data Lake Storage Gen2 adds features specifically for big data analytics, such as hierarchical namespace and fine-grained access control.

## Explore your ingested data in notebooks

Once your data is ingested, you can explore your data to uncover actionable insights. Azure Databricks notebooks provide a collaborative environment where you can perform analysis using PySpark, Scala, R, or SQL. These notebooks aren't just powerful but also user-friendly, making it easy to manipulate and visualize your data.

:::image type="content" source="../media/azure-databricks-notebooks.png" alt-text="Screenshot of Azure Databricks notebooks.":::

In the next section, you learn the various approaches to data exploration with Azure Databricks.
