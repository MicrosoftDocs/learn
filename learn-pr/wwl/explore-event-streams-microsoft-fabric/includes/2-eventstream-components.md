Microsoft Fabric eventstreams are a no-code feature that lets you capture and send real-time events to different places. You can use it to make event-driven apps, such as IoT, streaming, and dashboards. You can also connect to various data sources and destinations, and preview the event data. Microsoft Fabric eventstream is part of the Real-Time Intelligence experience in Microsoft Fabric. You should use it if you want to use real-time data in a simple way.

## How eventstream works

Microsoft Fabric eventstreams work by creating a pipeline of events from multiple internal and external sources to different destinations. You can think of it as a conveyor belt that moves data from one place to another. You can also add some transformations to the data along the way, such as filtering, aggregating, or enriching.

![Screenshot of an eventstream.](../media/real-time-intelligence-eventstream-workflow.png)

Event stream's Main Editor can be used to design your pipeline by dragging and dropping different nodes, such as sources, destinations, and transformations. You can also see the event data flowing through the pipeline in real-time. Microsoft Fabric eventstream handles the scaling, reliability, and security of your event stream automatically. You don’t need to write any code or manage any infrastructure to use Microsoft Fabric event stream.

## The components of eventstream

Microsoft Fabric eventstream is a feature that lets you work with real-time events in a simple way. You can capture events from different sources, transform them as you need, and send them to various destinations without writing any code. You can also connect your event streams with Azure services like Event Hubs, KQL databases, and lakehouses.

The main components of Microsoft Fabric eventstream are:

* **Sources**: Sources are where your event data comes from. You can pick Azure Event Hubs, sample data, or custom app as your source type. You can also choose the data format and the consumer group of your source.
- **Transformations**: You can add transformations that filter or aggregate the data as is is processed from the stream.
* **Destinations**: Destinations are where your transformed event data is stored. For example, you can store the results of your stream processing in a table in an eventhouse or a lakehouse.

You can use the eventstream editing canvas to add and manage your sources and destinations. You can also see the event data, check the data insights, and view logs for each source or destination. Each source or destination shows up as a tile (node) in the place. The Fabric eventstreams feature supports sending data to diverse destinations, such as Lakehouse, KQL database, Reflex, and Custom App. You can attach multiple destinations in an event stream to simultaneously receive data from your event streams without interfering with each other.

## The benefits of eventstreams

Some of the main benefits of Microsoft Fabric eventstreams are:

* Eventstream lets you capture, transform, and route real-time events to various destinations with a no-code experience. You can use the drag and drop feature to make your event data processing logic without writing any code.
* Eventstream gives you various source connectors to get event data from different sources, such as Azure Event Hubs, sample data, or custom app. You can also choose the data format and the consumer group of your source.
* Eventstream supports sending data to different destinations, such as lakehouse, KQL database, or custom app. You can also attach multiple destinations in an event stream to get data from your event streams at the same time without interfering with each other.
* Eventstream uses a scalable infrastructure that manages scaling and resourcing automatically. The scalable infrastructure helps you capture your real-time events easily, making streaming ETL (Extract, Transform, Load) operations possible.
* Eventstream connects your event streams and has full interoperability with Azure services like Event Hubs, KQL databases, and lakehouses. This interoperability gives you more options and flexibility to work with your event data.