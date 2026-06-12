::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=f1e9d97e-b273-4c05-98d9-40d87b5abb44]

> [!TIP]
> See the **Text and images** tab for more details!

::: zone-end

::: zone pivot="text"

Apache Spark is a powerful data processing engine designed to handle very large amounts of data quickly. Rather than processing data on a single computer, Spark splits the work across many machines (a *cluster*) so everything runs in parallel. You can use Spark on Microsoft Azure in the following services:

- Microsoft Fabric
- Azure Databricks

Spark supports code written in Python, Scala, or Java, and can handle both batch processing and stream processing.

## Spark Structured Streaming

**Spark Structured Streaming** is a library built into Spark that makes it straightforward to work with streaming data. Think of it as a way to treat a live data stream the same way you'd work with a table in a spreadsheet—except the table keeps growing in real time as new data arrives.

Here's how it works in practice:

1. You connect to a **streaming source**—for example, a message queue like Azure Event Hubs, a folder of files, or a network feed.
2. Spark reads incoming data into a **dataframe**—essentially a table of rows and columns that continuously fills with new data as events arrive.
3. You write a **query** on that dataframe—for example, to count events per minute or calculate a running average.
4. The query results are written to an **output** (a sink), such as a file, a database, or a dashboard.

[ ![Diagram of streaming data flowing from a source into a dataframe, being queried, and written to a sink.](../media/spark-structured-streaming.png) ](../media/spark-structured-streaming.png#lightbox)

Spark Structured Streaming is a good choice when you're already using Spark for data processing and want to extend that work to include real-time data streams.

> [!NOTE]
> For more information about Spark Structured Streaming, see the [Spark Structured Streaming programming guide.](https://spark.apache.org/docs/latest/structured-streaming-programming-guide.html)

## Delta Lake

**Delta Lake** is an open-source storage format that improves how data is stored in a data lake. By default, a data lake is just a collection of files—there's no built-in way to ensure that data is complete, consistent, or correctly structured. Delta Lake adds those guarantees, making data lake storage behave more like a traditional database.

Key benefits of Delta Lake include:

- **Reliability**: Changes to data are tracked, so partial or failed writes don't corrupt your data.
- **Schema enforcement**: Data must match a defined structure before it's accepted, preventing messy or incompatible records from slipping in.
- **Unified batch and streaming**: The same Delta table can serve as both a streaming sink (data written to it in real time) and a source for batch queries—so you don't need separate storage for historical and live data.

The Spark runtimes in Microsoft Fabric and Azure Databricks include built-in support for Delta Lake.

Delta Lake combined with Spark Structured Streaming is a good solution when you want a single, consistent data store that works for both real-time ingestion and historical analysis.

> [!NOTE]
> For more information about Delta Lake, see [Lakehouse and Delta Lake tables.](/fabric/data-engineering/lakehouse-and-delta-tables)

::: zone-end
