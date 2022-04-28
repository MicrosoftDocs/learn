Traditionally data was stored on premises without taking into consideration its usage and lifecycle. In the cloud, data can be stored based on access, lifecycle, and other compliance requirements. Let us learn how the concept of hot, warm, and cold data path determines how we store and compute data.

## Understand Warm Path

Let us explore a common scenario for IoT device data aggregation. The devices could be sending data while not really producing anything. This highlights a very common challenge when trying to extract insight out of IoT data: the data you are looking for is not available in the data you are getting. Therefore, we need to infer utilization by combining the data we are getting with other sources of data, and applying rules to determine of whether or not the machine is producing. In addition, these rules may change from company to company since they may have different interpretations of what “producing” is. 

The warm data path is about analyzing as the data flows through the system. We process this stream in near-real time, save it to the warm storage, and push it to the analytics clients.

The Azure platform provides many options for processing the events and one popular choice is Stream Analytics. 

Stream Analytics can execute complex analysis at scale, for example, tumbling/sliding/hopping windows, stream aggregations, and external data source joins. For even more complex processing, performance can be extended by cascading multiple instances of Event Hubs, Stream Analytics jobs, and Azure functions.

Warm storage can be implemented with various services on the Azure platform, such as Azure SQL Database and Azure Cosmos DB. 

## Understand Cold Path

The warm path is where the stream processing occurs to discover patterns over time. However, there might be a need to calculate the utilization over a period in the past, with different pivots, and aggregations and to merge those results with the warm path results to present a unified view to the user. 

The cold path includes the batch layer and the serving layers. The combination provides a long-term view of the system.

The cold path contains the long-term data store for the solution. It also contains the batch layer, which creates pre-calculated aggregate views to provide fast query responses over long periods. The technology options available for this layer on Azure platform is quite diverse.

Azure Storage is a good solution for the cold storage. Azure Storage includes Azure Blobs (objects), Azure Data Lake Storage Gen2, Azure Files, Azure Queues, and Azure Tables. The cold storage can be either Blobs, Data Lake Storage Gen2, or Azure Tables., or a combination of those.

To store massive amounts of unstructured data, such as JSON, or XML documents containing the unprocessed data received by the IoT application, Blob storage, Azure Files, or Azure Data Lake Storage Gen2 are the best options. 

Azure Data Factory is a great solution for creating the batch views on the serving layer. It is a cloud-based managed data integration service that allows you to create data-driven workflows in the cloud for orchestrating and automating data movement and data transformation. It can process and transform the data by using services such as Azure HDInsight Hadoop, Spark, and Azure Databricks. This allows you to build machine learning models and consume them with the analytics clients.

## Understand Hot Path

Hot path is typically used for processing or displaying data in real-time. It is employed for real time alerting and streaming operations are performed using this data. **A hot path** is where latency-sensitive data, results need to be ready in seconds or less and it flows for rapid consumption by analytics clients.

### When to use Hot/Warm/Cold data path

Let us analyze the requirements where you will decide upon hot, warm, or cold data path.

| **Requirement**| **Description** |
| - | -|
| When data requirements are known to change frequently <br>When processing or displaying data in real time| Use Hot data path |
| When data is rarely used. The data might be stored for compliance or legal reasons<br>Used for data that is consumed for long term analytics and batch processing| Use Cold data path |
| When you need to store or display a recent subset of data<br>Used for data that is consumed for small analytical and batch processing| Use Warm data path |
