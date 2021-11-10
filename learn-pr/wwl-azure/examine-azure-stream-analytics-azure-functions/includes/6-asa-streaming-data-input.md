Stream Analytics has first-class integration with Azure data streams as inputs from three kinds of resources:

 -  Azure Event Hubs
 -  Azure IoT Hub
 -  Azure Blob storage
 -  Azure Data Lake Storage Gen2

These input resources can live in the same Azure subscription as your Stream Analytics job or a different subscription.

## Compression

Stream Analytics supports compression across all data stream input sources. Supported compression types are: None, Gzip, and Deflate compression. Support for compression is not available for reference data. If the input format is Avro data that is compressed, it's handled transparently. You don't need to specify compression type with Avro serialization.

## Create, edit, or test inputs

You can use the Azure portal, Visual Studio, and Visual Studio Code to add and view or edit existing inputs on your streaming job. You can also test input connections and test queries from sample data from the Azure portal, Visual Studio, and Visual Studio Code. When you write a query, you list the input in the FROM clause. You can get the list of available inputs from the Query page in the portal. If you wish to use multiple inputs, you can JOIN them or write multiple SELECT queries.

## Stream data from Event Hubs

Azure Event Hubs provides highly scalable publish-subscribe event ingestors. An event hub can collect millions of events per second so that you can process and analyze the massive amounts of data produced by your connected devices and applications. Together, Event Hubs and Stream Analytics provide an end-to-end solution for real-time analytics. Event Hubs lets you feed events into Azure in real-time, and Stream Analytics jobs can process those events in real-time. For example, you can send web clicks, sensor readings, or online log events to Event Hubs. You can then create Stream Analytics jobs to use Event Hubs as the input data streams for real-time filtering, aggregating, and correlation.

`EventEnqueuedUtcTime` is the timestamp of an event's arrival in an event hub and is the default timestamp of events coming from Event Hubs to Stream Analytics. To process the data as a stream using a timestamp in the event payload, you must use the TIMESTAMP BY keyword.

### Event Hubs consumer groups

You should configure each Stream Analytics event hub input to have its own consumer group. When a job contains a self-join or has multiple inputs, some inputs might be read by more than one reader downstream. This situation impacts the number of readers in a single consumer group. To avoid exceeding the Event Hubs limit of five readers per consumer group per partition, it's a best practice to designate a consumer group for each Stream Analytics job. There is also a limit of 20 consumer groups for a Standard tier event hub.

### Create an input from Event Hubs

The following table explains each property in the **New input** page in the Azure portal to stream data input from an event hub:

:::row:::
  :::column:::
    **Property**
  :::column-end:::
  :::column:::
    **Description**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Input alias
  :::column-end:::
  :::column:::
    A friendly name that you use in the job's query to reference this input.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Subscription
  :::column-end:::
  :::column:::
    Choose the subscription in which the Event hub resource exists.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Event Hub namespace
  :::column-end:::
  :::column:::
    The Event Hub namespace is a container for a set of messaging entities. When you create a new event hub, you also create the namespace.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Event Hub name
  :::column-end:::
  :::column:::
    The name of the event hub to use as input.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Event Hub policy name
  :::column-end:::
  :::column:::
    The shared access policy that provides access to the Event Hub. Each shared access policy has a name, permissions that you set, and access keys. This option is automatically populated, unless you select the option to provide the Event Hub settings manually.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Event Hub consumer group (recommended)
  :::column-end:::
  :::column:::
    It is highly recommended to use a distinct consumer group for each Stream Analytics job. This string identifies the consumer group to use to ingest data from the event hub. If no consumer group is specified, the Stream Analytics job uses the $Default consumer group.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Event serialization format
  :::column-end:::
  :::column:::
    The serialization format (JSON, CSV, Avro, or Other (Protobuf, XML, proprietary...)) of the incoming data stream. Ensure the JSON format aligns with the specification and doesn’t include leading 0 for decimal numbers.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Encoding
  :::column-end:::
  :::column:::
    UTF-8 is currently the only supported encoding format.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Event compression type
  :::column-end:::
  :::column:::
    The compression type used to read the incoming data stream, such as None (default), Gzip, or Deflate.
  :::column-end:::
:::row-end:::


When your data comes from an Event Hub stream input, you have access to the following metadata fields in your Stream Analytics query:

:::row:::
  :::column:::
    **Property**
  :::column-end:::
  :::column:::
    **Description**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    EventProcessedUtcTime
  :::column-end:::
  :::column:::
    The date and time that the event was processed by Stream Analytics.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    EventEnqueuedUtcTime
  :::column-end:::
  :::column:::
    The date and time that the event was received by Event Hubs.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    PartitionId
  :::column-end:::
  :::column:::
    The zero-based partition ID for the input adapter.
  :::column-end:::
:::row-end:::


For example, using these fields, you can write a query like the following example:

```SQL
SELECT
    EventProcessedUtcTime,
    EventEnqueuedUtcTime,
    PartitionId
FROM Input

```

> [!NOTE]
> When using Event Hub as an endpoint for IoT Hub Routes, you can access to the IoT Hub metadata using the GetMetadataPropertyValue function - described here: \[https://docs.microsoft.com/stream-analytics-query/getmetadatapropertyvalue\](/stream-analytics-query/getmetadatapropertyvalue)

## Stream data from IoT Hub

Azure IoT Hub is a highly scalable publish-subscribe event ingestor optimized for IoT scenarios.

The default timestamp of events coming from an IoT Hub in Stream Analytics is the timestamp that the event arrived in the IoT Hub, which is `EventEnqueuedUtcTime`. To process the data as a stream using a timestamp in the event payload, you must use the TIMESTAMP BY keyword.

### IoT Hub consumer groups

You should configure each Stream Analytics IoT Hub input to have its own consumer group. When a job contains a self-join or when it has multiple inputs, some input might be read by more than one reader downstream. This situation impacts the number of readers in a single consumer group. To avoid exceeding the Azure IoT Hub limit of five readers per consumer group per partition, it's a best practice to designate a consumer group for each Stream Analytics job.

### Configure an IoT Hub as a data stream input

The following table explains each property in the New input page in the Azure portal when you configure an IoT Hub as a stream input.

:::row:::
  :::column:::
    **Property**
  :::column-end:::
  :::column:::
    **Description**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Input alias
  :::column-end:::
  :::column:::
    A friendly name that you use in the job's query to reference this input.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Subscription
  :::column-end:::
  :::column:::
    Choose the subscription in which the IoT Hub resource exists.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    IoT Hub
  :::column-end:::
  :::column:::
    The name of the IoT Hub to use as input.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Endpoint
  :::column-end:::
  :::column:::
    The endpoint for the IoT Hub.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Shared access policy name
  :::column-end:::
  :::column:::
    The shared access policy that provides access to the IoT Hub. Each shared access policy has a name, permissions that you set, and access keys.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Shared access policy key
  :::column-end:::
  :::column:::
    The shared access key used to authorize access to the IoT Hub. This option is automatically populated in unless you select the option to provide the Iot Hub settings manually.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Consumer group
  :::column-end:::
  :::column:::
    It is highly recommended that you use a different consumer group for each Stream Analytics job. The consumer group is used to ingest data from the IoT Hub. Stream Analytics uses the $Default consumer group unless you specify otherwise.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Event serialization format
  :::column-end:::
  :::column:::
    The serialization format (JSON, CSV, Avro, or Other (Protobuf, XML, proprietary...)) of the incoming data stream. Ensure the JSON format aligns with the specification and doesn’t include leading 0 for decimal numbers.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Encoding
  :::column-end:::
  :::column:::
    UTF-8 is currently the only supported encoding format.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Event compression type
  :::column-end:::
  :::column:::
    The compression type used to read the incoming data stream, such as None (default), Gzip, or Deflate.
  :::column-end:::
:::row-end:::


When you use stream data from an IoT Hub, you have access to the following metadata fields in your Stream Analytics query:

:::row:::
  :::column:::
    **Property**
  :::column-end:::
  :::column:::
    **Description**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    EventProcessedUtcTime
  :::column-end:::
  :::column:::
    The date and time that the event was processed.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    EventEnqueuedUtcTime
  :::column-end:::
  :::column:::
    The date and time that the event was received by the IoT Hub.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    PartitionId
  :::column-end:::
  :::column:::
    The zero-based partition ID for the input adapter.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    IoTHub.MessageId
  :::column-end:::
  :::column:::
    An ID that's used to correlate two-way communication in IoT Hub.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    IoTHub.CorrelationId
  :::column-end:::
  :::column:::
    An ID that's used in message responses and feedback in IoT Hub.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    IoTHub.ConnectionDeviceId
  :::column-end:::
  :::column:::
    The authentication ID used to send this message. This value is stamped on servicebound messages by the IoT Hub.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    IoTHub.ConnectionDeviceGenerationId
  :::column-end:::
  :::column:::
    The generation ID of the authenticated device that was used to send this message. This value is stamped on servicebound messages by the IoT Hub.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    IoTHub.EnqueuedTime
  :::column-end:::
  :::column:::
    The time when the message was received by the IoT Hub.
  :::column-end:::
:::row-end:::


## Stream data from Blob storage

For scenarios with large quantities of unstructured data to store in the cloud, Azure Blob storage offers a cost-effective and scalable solution. Data in Blob storage is usually considered data at rest; however, blob data can be processed as a data stream by Stream Analytics.

Log processing is a commonly used scenario for using Blob storage inputs with Stream Analytics. In this scenario, telemetry data files have been captured from a system and need to be parsed and processed to extract meaningful data.

The default timestamp of Blob storage events in Stream Analytics is the timestamp that the blob was last modified, which is `BlobLastModifiedUtcTime`. If a blob is uploaded to a storage account at 13:00, and the Azure Stream Analytics job is started using the option Now at 13:01, the blob will not be picked up as its modified time falls outside the job run period.

If a blob is uploaded to a storage account container at 13:00, and the Azure Stream Analytics job is started using Custom Time at 13:00 or earlier, the blob will be picked up as its modified time falls inside the job run period.

If an Azure Stream Analytics job is started using Now at 13:00, and a blob is uploaded to the storage account container at 13:01, Azure Stream Analytics will pick up the blob.

To process the data as a stream using a timestamp in the event payload, you must use the TIMESTAMP BY keyword. A Stream Analytics job pulls data from Azure Blob storage input every second if the blob file is available. If the blob file is unavailable, there is an exponential backoff with a maximum time delay of 90 seconds.

CSV-formatted inputs require a header row to define fields for the data set, and all header row fields must be unique.

> [!NOTE]
> Stream Analytics does not support adding content to an existing blob file. Stream Analytics will view each file only once, and any changes that occur in the file after the job has read the data are not processed. Best practice is to upload all the data for a blob file at once and then add other newer events to a different, new blob file.

Uploading a very large number of blobs at once might cause Stream Analytics to skip reading few blobs in rare cases. It is recommended to upload blobs at least 2 seconds apart to Blob storage. If this option is not feasible, you can use Event Hubs to stream large volumes of events.

### Configure Blob storage as a stream input

The following table explains each property in the New input page in the Azure portal when you configure Blob storage as a stream input.

:::row:::
  :::column:::
    **Property**
  :::column-end:::
  :::column:::
    **Description**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Input alias
  :::column-end:::
  :::column:::
    A friendly name that you use in the job's query to reference this input.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Subscription
  :::column-end:::
  :::column:::
    Choose the subscription in which the IoT Hub resource exists.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Storage account
  :::column-end:::
  :::column:::
    The name of the storage account where the blob files are located.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Storage account key
  :::column-end:::
  :::column:::
    The secret key associated with the storage account. This option is automatically populated in unless you select the option to provide the Blob storage settings manually.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Container
  :::column-end:::
  :::column:::
    The container for the blob input. Containers provide a logical grouping for blobs stored in the Microsoft Azure Blob service. When you upload a blob to the Azure Blob storage service, you must specify a container for that blob. You can choose either Use existing container or Create new to have a new container created.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Path pattern (optional)
  :::column-end:::
  :::column:::
    The file path used to locate the blobs within the specified container. If you want to read blobs from the root of the container, do not set a path pattern. Within the path, you can specify one or more instances of the following three variables: \{date\}, \{time\}, or \{partition\}

Example 1: cluster1/logs/\{date\}/\{time\}/\{partition\}

Example 2: cluster1/logs/\{date\}

The \* character is not an allowed value for the path prefix. Only valid Azure blob characters are allowed. No not include container names or file names.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Date format (optional)
  :::column-end:::
  :::column:::
    If you use the date variable in the path, the date format in which the files are organized. Example: YYYY/MM/DD
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Time format (optional)
  :::column-end:::
  :::column:::
    If you use the time variable in the path, the time format in which the files are organized. Currently the only supported value is HH for hours.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Event serialization format
  :::column-end:::
  :::column:::
    The serialization format (JSON, CSV, Avro, or Other (Protobuf, XML, proprietary...)) of the incoming data stream. Ensure the JSON format aligns with the specification and doesn’t include leading 0 for decimal numbers.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Encoding
  :::column-end:::
  :::column:::
    For CSV and JSON, UTF-8 is currently the only supported encoding format.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Compression
  :::column-end:::
  :::column:::
    The compression type used to read the incoming data stream, such as None (default), Gzip, or Deflate.
  :::column-end:::
:::row-end:::


When your data comes from a Blob storage source, you have access to the following metadata fields in your Stream Analytics query:

:::row:::
  :::column:::
    **Property**
  :::column-end:::
  :::column:::
    **Description**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    BlobName
  :::column-end:::
  :::column:::
    The name of the input blob that the event came from.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    EventProcessedUtcTime
  :::column-end:::
  :::column:::
    The date and time that the event was processed by Stream Analytics.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    BlobLastModifiedUtcTime
  :::column-end:::
  :::column:::
    The date and time that the blob was last modified.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    PartitionId
  :::column-end:::
  :::column:::
    The zero-based partition ID for the input adapter.
  :::column-end:::
:::row-end:::


For example, using these fields, you can write a query like the following example:

```SQL
SELECT
    BlobName,
    EventProcessedUtcTime,
    BlobLastModifiedUtcTime
FROM Input

```
