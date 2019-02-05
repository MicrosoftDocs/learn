Apache Spark's Structured Streaming is dast, scalable, and fault-tolerant stream processing API that allows you to perform near real-time analytics on your streaming data. With Structured Streaming, you can use SQL queries to process streaming data in the same way as you would process static data. The API continuously increments/updates the final data.

## Event Hubs and Spark Structured Streaming

Azure Events Hub is a simple and scalable real-time data ingestion service that can process millions of data in a matter of seconds. It is capable of receiving large data from multiple sources and then stream the prepared data to Data Lake or Blob storage. Azure Event Hubs can be integrated with Spark Structured Streaming to perform near-real time processing of messages. You can then query and analyze the processed data as and when it comes using Structured Streaming query and Spark SQL.

## Streaming Concepts

Stream processing is where you continuously incorporate new data into a Data Lake storage and compute results. The streaming data comes in faster than it can be consumed. A stream of data is treated as a table to which data is continuously appended. Examples of such data include bank card transactions, Internet of Things (IoT) device data, and video game play events.

Data coming from a stream is typically not ordered in any way.

A streaming system consists of

- Input source such as Kafka, Azure Event Hub, files on a distributed system or TCP-IP sockets
- Sinks such as Kafka, Azure Event Hub, various file formats, forEach sinks, console sinks or memory sinks

### Streaming and Databricks Delta

In streaming, the problems of traditional data pipelines are exacerbated. Specifically, with frequent metadata refreshes, table repairs and accumulation of small files every minute or second. Many small files result because data (may be) streamed in at low volumes with short triggers.

Databricks Delta is uniquely designed to address these needs. In this module we will explore some of these capabilities and look at how Databricks Delta helps with streaming data.