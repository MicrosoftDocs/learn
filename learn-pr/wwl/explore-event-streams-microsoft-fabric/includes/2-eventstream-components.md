The Eventstream feature in Fabric works by creating a pipeline that ingests events from streaming data sources, processes them through optional transformations, and delivers them to various destinations. Eventstream is the delivery mechanism that carries events from where they happen to where they need to be processed, analyzed, or acted upon.

You can use the eventstream canvas, which is a visual editor, to design your pipeline by dragging and dropping different nodes, such as sources, transformations, and destinations. You can also see the event data flowing through the pipeline in real-time. You don't need to write any code or manage any infrastructure to use Eventstream.

:::image type="content" source="../media/real-time-intelligence-eventstream-workflow.png" alt-text="Screenshot of an eventstream." lightbox="../media/real-time-intelligence-eventstream-workflow.png":::

This image shows the eventstream canvas. There's a real-time data source called **Bicycles**, which includes: city bike rental data including bike locations, bike station street names and more. **Bicycle-data** is an eventstream that ingests data from the **Bicycles** data source. The data is transformed by an operation named **GroupByStreet** that sums the number of bikes by bike station street name. This data is stored in a table in an Eventhouse called **Bikes-by-street-table**.

The main components of an eventstream are:

* **Sources**: Sources are where your event data comes from. You can stream data from Microsoft sources and also ingest data from non-Microsoft platforms.
* **Transformations**: You can transform the data as it flows in an eventstream, enabling you to filter, summarize, and reshape it before storing it. Examples of available transformations include: SQL code, filter, manage fields, aggregate, group by, expand and join.
* **Destinations**: Destinations are where your transformed event data goes for storage, further processing, alerts, or integration with other systems. You can route the data from your stream to various destinations such as tables in an Eventhouse or lakehouse, custom endpoints, derived streams for more processing, or Fabric Activator to trigger actions.