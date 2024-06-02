Stream Analytics has first-class integration with Azure data streams as inputs from the following resources:

 -  Azure IoT Hub
 -  Azure Event Hubs
 -  Azure Blob storage or Azure Data Lake Storage Gen2

These input resources can live in the same Azure subscription as your Stream Analytics job or in a different subscription.

> [!NOTE]
> Both Azure IoT Hub and Azure Event Hubs are cloud services that can ingest large amounts of data and process or store that data for business insights. The two services are similar in that they both support ingestion of data with low latency and high reliability, but they are designed for different purposes. IoT Hub was developed to address the unique requirements of connecting IoT devices to the Azure cloud while Event Hubs was designed for big data streaming. Microsoft recommends using Azure IoT Hub to connect IoT devices to Azure.

## Stream data from IoT Hub

Azure IoT Hub is a highly scalable publish-subscribe event ingestor optimized for IoT scenarios.

The default timestamp of events coming from an IoT Hub in Stream Analytics is the timestamp that the event arrived in the IoT Hub, which is `EventEnqueuedUtcTime`. To process the data as a stream using a timestamp in the event payload, you must use the `TIMESTAMP BY` keyword.

### IoT Hub consumer groups

You should configure each Stream Analytics IoT Hub input to have its own consumer group. When a job contains a self-join or when it has multiple inputs, some input might be read by more than one reader downstream. This situation impacts the number of readers in a single consumer group. To avoid exceeding the Azure IoT Hub limit of five readers per consumer group per partition, it is a best practice to designate a consumer group for each Stream Analytics job.

When you use stream data from an IoT Hub, you have access to the following metadata fields in your Stream Analytics query:


| Property                              | Description                                                                                                   |
|---------------------------------------|---------------------------------------------------------------------------------------------------------------|
| EventProcessedUtcTime                 | The date and time that the event was processed.                                                               |
| EventEnqueuedUtcTime                  | The date and time that the event was received by the IoT Hub.                                                 |
| PartitionId                           | The zero-based partition ID for the input adapter.                                                            |
| IoTHub.MessageId                      | An ID that is used to correlate two-way communication in IoT Hub.                                             |
| IoTHub.CorrelationId                  | An ID that is used in message responses and feedback in IoT Hub.                                              |
| IoTHub.ConnectionDeviceId             | The authentication ID used to send this message. This value is stamped on servicebound messages by the IoT Hub.|
| IoTHub.ConnectionDeviceGenerationId   | The generation ID of the authenticated device that was used to send this message.                             |
| IoTHub.EnqueuedTime                   | The time when the message was received by the IoT Hub.                                                        |


For example, you can write a query like the following example:

```SQL
SELECT
    EventProcessedUtcTime,
    EventEnqueuedUtcTime,
    IoTHub.ConnectionDeviceId
FROM Input

```

## Stream data from Event Hubs

Azure Event Hubs is the big data streaming service of Azure. It is designed for high throughput data streaming scenarios where customers may send billions of requests per day. Event Hubs uses a partitioned consumer model to scale out your stream and is integrated into the big data and analytics services of Azure including Databricks, Stream Analytics, ADLS, and HDInsight.

## Stream data from Blob storage or Data Lake Storage Gen2

For scenarios with large quantities of unstructured data to store in the cloud, Azure Blob storage offers a cost-effective and scalable solution. Data in Blob storage is usually considered data at rest; however, blob data can be processed as a data stream by Stream Analytics.

Log processing is a commonly used scenario for using Blob storage inputs with Stream Analytics. In this scenario, telemetry data files have been captured from a system and need to be parsed and processed to extract meaningful data.

> [!NOTE]
> You can find additional information about streaming data inputs, including detailed information about streaming input from Event Hubs and Blob storage resources, at the following location: [Stream data as input into Stream Analytics](/azure/stream-analytics/stream-analytics-define-inputs)
