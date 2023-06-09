There are several services available for real-time analytics and streaming processing on Azure.

## When to use Azure Stream Analytics

Azure Stream Analytics is the recommended service for stream analytics on Azure. It's meant for a wide range of scenarios that include but aren't limited to:

 -  Dashboards for data visualization
 -  Real-time alerts from temporal and spatial patterns or anomalies
 -  Extract, Transform, Load (ETL)
 -  Event Sourcing pattern
 -  IoT Edge

Adding an Azure Stream Analytics job to your application is the fastest way to get streaming analytics up and running in Azure, using the SQL language you already know. Azure Stream Analytics is a job service, so you don't have to spend time managing clusters, and you don't have to worry about downtime with a 99.9% SLA at the job level. Billing is also done at the job level making startup costs low (one Streaming Unit), but scalable (up to 192 Streaming Units). It's much more cost effective to run a few Stream Analytics jobs than it is to run and maintain a cluster.

Azure Stream Analytics has a rich out-of-the-box experience. You can immediately take advantage of the following features without any other setup:

 -  Built-in temporal operators, such as windowed aggregates, temporal joins, and temporal analytic functions.
 -  Native Azure input and output adapters.
 -  Support for slow changing reference data (also known as a lookup tables), including joining with geospatial reference data for geofencing.
 -  Integrated solutions, such as Anomaly Detection.
 -  Multiple time windows in the same query.
 -  Ability to compose multiple temporal operators in arbitrary sequences.
 -  Under 100-ms end-to-end latency from input arriving at Event Hubs, to output landing in Event Hubs, including the network delay from and to Event Hubs, at sustained high throughput.

## When to use other technologies

### You need to input from or output to Kafka

Azure Stream Analytics doesn't have an Apache Kafka input or output adapter. If you have events landing in or need to send to Kafka and you don't have a requirement to run your own Kafka cluster, you can continue to use Stream Analytics by sending events to Event Hubs using the Event Hubs Kafka API without changing the event sender. If you do need to run your own Kafka cluster, you can use Spark Structured Streaming, which is fully supported on Azure Databricks.

### You want to write UDFs, UDAs, and custom deserializers in a language other than JavaScript or C\#

Azure Stream Analytics supports user-defined functions (UDF) or user-defined aggregates (UDA) in JavaScript for cloud jobs and C\# for IoT Edge jobs. C\# user-defined deserializers are also supported. If you want to implement a deserializer, a UDF, or a UDA in other languages, such as Java or Python, you can use Spark Structured Streaming. You can also run the Event Hubs `EventProcessorHost` on your own virtual machines to do arbitrary streaming processing.

### Your solution is in a multicloud or on-premises environment

Azure Stream Analytics is Microsoft's proprietary technology and is only available on Azure. If you need your solution to be portable across Clouds or on-premises, consider open-source technologies such as Spark Structured Streaming.
