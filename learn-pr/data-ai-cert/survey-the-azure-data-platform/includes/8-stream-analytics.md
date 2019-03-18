Applications, sensors, monitoring devices, and gateways broadcast continuous event data known as data streams. Streaming data is high volume with a lighter payload than non-streaming systems. Azure Stream Analytics allows Data Engineers to process streaming data and respond to data anomalies in real-time. Business cases include Internet of Things (IoT) monitoring, web logs, remote patient monitoring, or Point of Sale (POS) systems.

![Screen of Framework of Stream Analytics](../media/8-streaming-analytics-framework.png)

## When to use it

If your organizations' challenge is to respond to data event in real-time or perform a post mortem of large batches of data in a continuous time bound stream, then Azure Stream Analytics is for your organization. The decision must be made whether your organization will be working with streaming data or batch data.

Azure Stream Analytics will ingest streaming data from applications or IoT devices and gateways into an event hub or an Internet of Things (IoT) hub in real-time. At which point the event or IoT hub will stream the data into Stream Analytics for real-time analysis.

Batch systems process groups of data stored in an Azure Blob store in a single job that executes at a pre-defined interval. Batch systems are not suitable for certain business intelligence systems where the pre-defined interval cannot be tolerated for performance reasons. For example, an autonomous vehicle cannot wait for a batch system to adjust for driving. Another example includes a fraud detection system that must prevent the financial transaction from being approved in real time.

## Ingesting Data

Data Engineers configure ingestion components of Azure Stream Analytics by configuring data inputs from first-class integration sources including Azure Event Hubs, Azure IoT Hub, or Azure Blob storage.

IoT hubs are the cloud gateway that connects IoT devices to gather data to drive business insights and automation. IoT Hub includes features that enrich the relationship between your devices and your back-end systems. Bi-directional communication capabilities mean that while you receive data from devices, you can also send commands and policies back to devices, for example, to update properties or invoke device management actions.  It can also authenticate access between the IoT device and the IoT hub.

Event hubs provide a big data streaming service of Azure. It is designed for high throughput data streaming scenarios where customers may send billions of requests per day. Event Hubs uses a partitioned consumer model to scale out your data stream and is integrated into the big data and analytics services of Azure including Databricks, Stream Analytics, ADLS, and HDInsight.  It provides authentication through a shared key.

Azure Storage can be used to stored data before being batched processed.

![Screenshot of Streaming IoT Capability Comparison](../media/8-streaming-comparison.png)

## Processing Data

Data Engineers configure Azure Stream Analytics jobs with input and output pipelines to process streaming data. Inputs are provided by event hubs, IoT hubs or Azure storage. Stream Analytics can route job output to many storage systems such as Azure Blob, Azure SQL Database, Azure Data Lake Stores, or Azure Cosmos DB.

After storing, you can run batch analytics with Azure HDInsight or send the output to another service such as event hubs for consumption or to Power BI for real-time visualization by using Power BI streaming API.

## Querying Data

To define job transformations, you use a simple, declarative Stream Analytics query language that lets you author complex temporal queries and analytics using simple SQL constructs. Stream Analytics query language is consistent with the SQL language, familiarity with SQL language is sufficient to get started with creating jobs.

## Securing Data

Security for Azure Stream Analytics is handled at the transport layer between the device and the Azure IoT Hub. Streaming data is generally discarded after the windowing operations are complete. Event hubs secure transfer of data using a shared key. If the Data Engineer chooses to store the data, security will be provided by the storage device selected.