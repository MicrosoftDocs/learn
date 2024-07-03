Job outputs provide the mechanism for storing the results of a Stream Analytics job. There are several output types to which you can send transformed data. Stored outputs can be used for further business analytics and data warehousing of your data.

When you design your Stream Analytics query, refer to the name of the output by using the INTO clause. You can use a single output per job, or multiple outputs per streaming job (if you need them) by providing multiple INTO clauses in the query. To create, edit, and test Stream Analytics job outputs, you can use the Azure portal, Azure PowerShell, .NET API, REST API, and Visual Studio.

## Output types

The output types supported by Azure Stream Analytics include:

- Azure Data Explorer
- Azure Functions
- Azure Synapse Analytics
- Blob storage and Azure Data Lake Gen 2
- Azure Cosmos DB
- Azure Data Lake Storage Gen 2
- Azure Event Hubs
- Kafka (preview)
- Azure Database for PostgreSQL
- Power BI
- Azure Service Bus queues
- Azure Service Bus topics
- Azure SQL Database
- Azure Table storage

The following sections briefly describe the most common use for a few of these output options.

## Blob storage and Azure Data Lake Gen2

Azure Blob storage offers a cost-effective and scalable solution for storing large amounts of unstructured data in the cloud.

Data Lake Storage Gen2 makes Azure Storage the foundation for building enterprise data lakes on Azure. Designed from the start to service multiple petabytes of information while sustaining hundreds of gigabits of throughput, Data Lake Storage Gen2 allows you to easily manage massive amounts of data. A fundamental part of Data Lake Storage Gen2 is the addition of a hierarchical namespace to Blob storage.

## Event Hubs

The Azure Event Hubs service is a highly scalable publish-subscribe event ingestor that can collect millions of events per second. When an Event Hubs resource is defined as the output for a Stream Analytics job it is often used as the input for another streaming job.

## Power BI

You can use Power BI as an output for a Stream Analytics job to provide for a rich visualization experience of analysis results. You can use this capability for operational dashboards, report generation, and metric-driven reporting.

## Table storage

Azure Table storage offers highly available, massively scalable storage, so that an application can automatically scale to meet user demand. Table storage is Microsoft’s NoSQL key/attribute store, which you can use for structured data with fewer constraints on the schema. Azure Table storage can be used to store data for persistence and efficient retrieval.

## Service Bus queues and topics

The decoupled messaging features provided by Azure Service Bus provide many advantages. For example, clients and servers can connect as needed and do their operations in an asynchronous fashion.

Service Bus queues offer a FIFO message delivery to one or more competing consumers and a one-to-one communication method from sender to receiver. Typically, messages are received and processed by the receivers in the temporal order in which they were added to the queue.

In contrast to queues, topics provide a one-to-many form of communication in a publish and subscribe pattern.

> [!NOTE]
> You can find additional information about job ouput types, properties, and characteristics here: [Outputs from Azure Stream Analytics](/azure/stream-analytics/stream-analytics-define-outputs)
