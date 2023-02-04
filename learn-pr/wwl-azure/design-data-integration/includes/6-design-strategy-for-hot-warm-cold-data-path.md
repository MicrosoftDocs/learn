
Traditionally, data was stored on-premises. No consideration was made about how the data was to be used or its lifecycle. In the cloud, data can be stored based on access, lifecycle, and other compliance requirements. In this unit, we examine hot, warm, and cold data paths, and consider options for storing and computing the data.

### Warm data path

A warm data path supports analyzing data as it flows through the system. The data stream is processed in near real time. The data is saved to the warm storage, and pushed to the analytics clients.

- The Azure platform provides many options for processing the events, and [Azure Stream Analytics](/azure/stream-analytics/stream-analytics-introduction) is a popular choice.
- Stream Analytics can execute complex analysis at scale for tumbling, sliding, and hopping windows. The service supports running stream aggregations and joining external data sources. For complex processing, performance can be extended by cascading multiple instances of Azure Event Hubs, Stream Analytics jobs, and Azure functions.
- Warm storage can be implemented with various services on the Azure platform, such as Azure SQL Database and Azure Cosmos DB.

#### Business scenario

Let's explore a common scenario for IoT device data aggregation. The devices might send data, but not produce any results or analysis data. This situation highlights a common challenge: trying to extract insight out of IoT data. The data you're looking for isn't available in the data you receive. You need to infer utilization by combining the data you receive with other sources of data. Then, you apply rules to determine whether the machine is producing results. Also, the rules might change from company to company, when they have different expectations for analysis or results.

### Cold data path

The warm data path is where stream processing occurs to discover patterns over time. However, you might need to calculate utilization over some time period in the past. You also might require different pivots and aggregations, and need to merge these results with the warm path results to present a unified view to the user. A cold data path can help accomplish these tasks.

- A cold data path consists of a batch layer and serving layers that provide a long-term view of the system.
- The batch layer creates pre-calculated aggregate views to enable fast query responses over long periods. The Azure platform provides diverse technology options for this layer.
- The cold path includes a long-term data store for the solution, and Azure Storage is a common approach. Azure Storage includes Azure Blobs (objects), Azure Data Lake Storage Gen2, Azure Files, Azure Queues, and Azure Tables.
- Cold storage can be either Blobs, Data Lake Storage Gen2, Azure Tables, or a combination.
- To store massive amounts of unstructured data, the best options are Blob Storage, Azure Files, or Azure Data Lake Storage Gen2. Cold path storage is ideal for original messages that contain unprocessed data received by IoT applications.

#### Business scenario

Examine the scenario where you need to build machine learning models for Tailwind Traders website interactions over time. You need to automate data movement and conduct data transformations. In this scenario, Azure Data Factory is a great solution for creating the batch views on the serving layer of the cold path to fulfill these requirements. It's a cloud-based managed data integration service that allows you to create data-driven workflows in the cloud for orchestrating and automating data movement and data transformation. It can process and transform the data by using services such as Azure HDInsight Hadoop, Apache Spark, and Azure Databricks. You can build machine learning models and consume them with the analytics clients.

### Hot data path

A hot data path is typically used for processing or displaying data in real time. This path is employed for real-time alerting and streaming operations. A hot path is where latency-sensitive data results need to be ready in seconds or less, and where data flows for rapid consumption by analytics clients.

#### Business scenario

Tailwind Traders wants to implement data analysis for its customer portal. They need to collect streaming data and provide real-time alerts to administrators, customer assistants, and portal users. The hot path is ideal for this scenario. Data can be collected as it's being entered by the user or displayed to the customer. The data can be delivered in near real time to administrators for quick analysis and follow-up action.

### Compare data paths

The following table compares scenarios for the three path solutions. Review the scenarios and consider which solutions are required for Tailwind Traders.

| Scenario                                                     | Path solution      |
| ------------------------------------------------------------ | ------------------ |
| *Flexible support for data requirements that change frequently. Enable processing or displaying data in real time*. | **Hot** data path  |
| *Support data that's rarely used, such as data that's stored for compliance or legal reasons. Enable consumption of data for long term analytics and batch processing*. | **Cold** data path |
| *Store or display a recent subset of data. Enable consumption of data for small analytical and batch processing*. | **Warm** data path |
