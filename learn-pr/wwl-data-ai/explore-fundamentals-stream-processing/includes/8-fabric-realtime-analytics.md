Microsoft Fabric includes native support for real-time data analytics, including real-time data ingestion from multiple streaming sources.


![Diagram of realtime analytics in Microsoft Fabric.](../media/fabric-realtime-analytics.png)

In Microsoft Fabric, you can use an eventstream to capture real-time event data from a streaming source and persist it in a destination such as a table in a Lakehouse or a KQL database.

When writing eventstream data to a Lakehouse table, you can apply aggregations and filters to summarize the captured data.
A KQL database supports tables based on the Data Explorer engine, enabling you to perform real-time analytics on the data in tables by running KQL queries.
After capturing real-time data in a table, you can use Power BI in Microsoft Fabric to create real-time data visualizations.