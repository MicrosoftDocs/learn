::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=d7dc56e7-1340-47de-a5b4-bf7a41603206]

::: zone-end

::: zone pivot="text"

Suppose a manufacturing company captures real-time telemetry data from factory floor sensors, and wants to monitor equipment performance, detect anomalies, and archive event data for long-term analysis. A common approach is to use a stream processing engine to continuously filter and aggregate the flow of sensor events, and route the results to one or more destinations—such as a data lake for storage, a relational database for operational reporting, or a message hub for downstream alerting systems.

Azure Stream Analytics is a fully managed, cloud-based stream processing service that enables you to build real-time analytics pipelines. It connects to streaming data sources such as Azure Event Hubs, Azure IoT Hub, and Azure Data Lake Storage, processes data using a SQL-based query language, and writes results to a wide range of output destinations.

![Diagram of a data stream captured in Azure Event Hubs, processed by Azure Stream Analytics, and loaded into Azure Synapse Analytics.](../media/stream-ingestion.png)

A typical pattern for real-time data processing in Azure includes these stages:

- A real-time source of data is captured in an event ingestor, such as Azure Event Hubs or Azure IoT Hub.
- The captured data is perpetually filtered, aggregated, or enriched by an Azure Stream Analytics query.
- The results of the query are written to one or more output destinations—such as a data lake, a relational database, or another event hub.

In this module, you learn how to configure Azure Stream Analytics jobs to process streaming data and route the results to a variety of output destinations.

::: zone-end

> [!NOTE]
> We recognize that different people like to learn in different ways. You can choose to complete this module in video-based format or you can read the content as text and images. The text contains greater detail than the videos, so in some cases you might want to refer to it as supplemental material to the video presentation.
