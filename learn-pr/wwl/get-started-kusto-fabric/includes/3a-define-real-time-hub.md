Real-Time Intelligence in Microsoft Fabric provides two primary approaches for ingesting streaming data: using eventstreams or directly ingesting data into a KQL database in an Eventhouse.

## Eventstreams for data ingestion and transformation

Eventstreams are a way to bring real-time events into Fabric, to transform them, and then route data to a destination.

:::image type="content" source="../media/eventstream.png" alt-text="Screenshot of an Eventstream in Microsoft Fabric." lightbox="../media/eventstream.png":::

The image shows the three main components of an Eventstream: **sources** where data originates, **transformations** optional processing applied to the data, and **destinations** where the processed data is sent.

Think of the Eventstream components like a water pipe system. The source is your faucet, transformations are filters along the way and you need a destination like a sink or bucket to collect and use the water.

Next, let's review each component of an Eventstream.

## Data sources for eventstreams

Once you create an eventstream in Fabric, you can connect it to a wide range of data sources. You can stream data from Microsoft sources and also ingest data from non-Microsoft platforms including:

- **Microsoft sources**, like Azure Event Hubs, Azure IoT Hubs, Azure Service Bus, Change Data Capture (CDC) feeds in database services, and others.
- **Azure events**, like Azure Blob Storage events.
- **Fabric events**, such as changes to items in a Fabric workspace, data changes in OneLake data stores, and events associated with Fabric jobs.
- **External sources**, such as Apache Kafka, Google Cloud Pub/Sub, and MQTT (Message Queuing Telemetry Transport) (in preview)

> [!TIP]
> To see all supported sources, see **[Supported sources](/fabric/real-time-intelligence/event-streams/add-manage-eventstream-sources?pivots=enhanced-capabilities&azure-portal=true#supported-sources)**.

## Event transformations in eventstreams

Raw data from a source system is rarely in the exact format you need for analysis or storage. Transformations are what make your data useful and actionable. You can transform the data as it flows in an eventstream, enabling you to filter, summarize, and reshape it before storing it. Examples of available transformations include: SQL code, filter, manage fields, aggregate, group by, expand and join.

> [!TIP]
> For more information about supported transformations, see **[Process event data with event processor editor](/fabric/real-time-intelligence/event-streams/process-events-using-event-processor-editor?azure-portal=true)** and **[Process events using SQL code editor](/fabric/real-time-intelligence/event-streams/process-events-using-sql-code-editor?azure-portal=true)**.

## Data destinations in eventstreams

Streaming data flows continuously and is temporary by nature. It requires immediate processing and storage to retain its value. The destination in an eventstream is what makes your real-time data processing actionable. It's where your processed data becomes available for queries, reports, dashboards, alerts, actions, or integration with other systems. You can load the data from your stream into the following destinations: a KQL database in an Eventhouse, Lakehouse, a derived stream, Fabric Activator, or a custom endpoint.

> [!TIP]
> For more information about supported destinations, see **[Add and manage a destination in an eventstream](/fabric/real-time-intelligence/event-streams/add-manage-eventstream-destinations?azure-portal=true)**.

## Direct ingestion to a KQL database in an Eventhouse

Data can also be directly ingested into a KQL (Kusto Query Language) database in an Eventhouse. Some examples of data ingestion sources include: local files, Azure storage, Amazon S3, Azure Event Hubs, OneLake, and more. Data ingestion can be configured using **connectors** or through the **Get data** option in a KQL database as shown in this image.

:::image type="content" source="../media/get-data.png" alt-text="Screenshot of the get data option in a KQL database in an Eventhouse in Microsoft Fabric." lightbox="../media/get-data.png":::

> [!TIP]
> For more information about supported ingestion sources for KQL databases in Eventhouses, see **[Data sources](/fabric/real-time-intelligence/get-data-overview?azure-portal=true)** and **[Data connectors overview](/fabric/real-time-intelligence/data-connectors/data-connectors?azure-portal=true)**.

## Data transformation in a KQL database in Eventhouse with update policies

When directly ingesting data into a KQL database, data first lands in the database, then can be transformed using **update policies**. This is different from eventstream transformations that occur *during* stream processing, before routing data to a destination.

Update policies are automation mechanisms triggered when new data is written to a table. They run a query to transform ingested data and save the result to a destination table.
