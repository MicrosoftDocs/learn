The OneLake catalog helps you find data that's already stored — lakehouses, warehouses, and semantic models. But some data never stops moving. Inventory levels change as products sell, sensors send readings every few seconds, and transactions stream in continuously. You need a different tool to discover this kind of data.


## What Real-Time hub shows you

The **Real-Time hub** is the centralized catalog for streaming data in Microsoft Fabric. It shows eventstreams and KQL tables that are actively running across your tenant.

**Eventstreams** are continuous flows of data from sources like Azure Event Hubs, IoT devices, Apache Kafka, database change data capture (CDC), or custom applications.

Streaming data often flows into **eventhouses**, which hold one or more KQL databases. These databases store time-based events and support fast querying with Kusto Query Language (KQL).

## How to find streaming data

The Real-time hub's **Streaming data** page shows all eventstreams and KQL tables you have access to. Like with the OneLake catalog, you can filter by workspace, search by name, or browse what other teams created.

For each stream, you see the stream name, source item, owner, workspace, endorsement status, and sensitivity label. You can also check whether a stream is actively receiving data and when it last updated — this helps you decide whether it's reliable enough for production use.

## What you can do with a discovered stream

Once you find a stream, your options depend on the type:

- **Eventstreams**: View properties, set alerts with Fabric Activator, or create shortcuts if the stream sends data to a lakehouse.
- **KQL tables**: Query data directly with a KQL queryset, create real-time dashboards, or set alerts on query results.

Real-time data can also flow into lakehouses through eventstreams. This creates a bridge between streaming and batch analytics — you can build reports that combine both.

:::image type="content" source="../media/batch-streaming-discovery.png" alt-text="Diagram of OneLake catalog for stored data alongside Real-Time hub for streaming data feeding one solution.":::

> [!TIP]
> Does your organization use streaming data? Do you also track streaming data in a warehouse or lakehouse?
