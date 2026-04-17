Once you create an eventstream in Fabric, you can connect it to a wide range of data sources, optionally transform it, and route the transformed, or processed data to multiple destinations. In this unit, we'll review eventstream sources and destinations. 

## Eventstream sources
You can stream data from Microsoft sources and also ingest data from non-Microsoft platforms including:

- **Microsoft sources**, like Azure Event Hubs, Azure IoT Hubs, Azure Service Bus, Change Data Capture (CDC) feeds in database services, and others.
- **Azure events**, like Azure Blob Storage events.
- **Fabric events**, such as changes to items in a Fabric workspace, data changes in OneLake data stores, and events associated with Fabric jobs.
- **External sources**, such as Apache Kafka, Google Cloud Pub/Sub, and MQTT (Message Queuing Telemetry Transport)

## Configure eventstream sources

After you create an eventstream, you can add data sources using the eventstream canvas. You can either create a new source or connect to an existing source from the Real-Time Hub:

:::image type="content" source="../media/configure-sources.png" alt-text="Screenshot showing how to configure sources in eventstream canvas." lightbox="../media/configure-sources.png":::

> [!TIP]
> To see all supported sources, see **[Add and manage eventstream sources](/fabric/real-time-intelligence/event-streams/add-manage-eventstream-sources?pivots=enhanced-capabilities&azure-portal=true#supported-sources)**.

## Eventstream destinations

Streaming data requires immediate processing and storage to retain its value. Destinations in an eventstream serve as endpoints where your processed data becomes available for queries, reports, dashboards, alerts, actions, or integration with other systems. You can load the data from your stream into the following destinations:
- **Eventhouse**: This destination lets you ingest your real-time event data into an Eventhouse, where you can use Kusto Query Language (KQL) to query and analyze the data.
- **Lakehouse**: This destination gives you the ability to transform your real-time events before ingesting them into your lakehouse. Real-time events are converted into Delta Lake format and then stored in designated lakehouse tables.
- **Derived stream**: You can think of derived streams as transformed versions of your original data stream that enable **content-based routing**. Derived streams let you route subsets of data from your *default* or original stream to different destinations based on the *content* of data. For example, you could filter IoT sensor data to send high-temperature alerts to Fabric Activator while routing hourly averages to a KQL database.
- **Fabric Activator**: Directly connect your real-time event data to an event detection engine that automatically triggers actions when specific patterns or conditions are detected in your streaming data. When data reaches certain thresholds or matches patterns, Activator can send notifications, launch Power Automate workflows, or trigger other automated responses.
- **Custom endpoint**: With this destination, you can route your real-time events to a custom endpoint. This destination is useful when you want to direct real-time data to an external system or custom application outside Microsoft Fabric.

You can attach to multiple destinations within an event stream at the same time without impacting or colliding with each other.

> [!TIP]
> For more information about supported destinations, see **[Add and manage a destination in an eventstream](/fabric/real-time-intelligence/event-streams/add-manage-eventstream-destinations?azure-portal=true)**.

## Configure eventstream destinations

Eventstream destinations can be configured in the eventstream canvas. A destination can be specified after a datasource is connected or after optional transformations are applied.

:::image type="content" source="../media/eventstream-destinations.png" alt-text="Screenshot showing how to configure destinations in eventstream canvas." lightbox="../media/eventstream-destinations.png":::

The eventstream canvas in the image shows:

- **Add destination dropdown**: for configuring new destinations
- **Three configured destinations**: a derived stream, a Fabric Activator, and an Eventhouse  
- **Content-based routing** where the output of the GroupByStreet transformation is routed to a derived stream that's then routed to both an Activator to check if there are bikes at every station and to an Eventhouse to insert bike counts by street into a KQL database