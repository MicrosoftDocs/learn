Apache Spark Structured Streaming is a fast, scalable, and fault-tolerant stream processing API. You can use it to perform analytics on your streaming data in near real time. 

With Structured Streaming, you can use SQL queries to process streaming data in the same way that you would process static data. The API continuously increments and updates the final data.

## Event Hubs and Spark Structured Streaming

Azure Event Hubs is a scalable real-time data ingestion service that processes millions of data in a matter of seconds. It can receive large amounts of data from multiple sources and stream the prepared data to Azure Data Lake or Azure Blob storage. 

Azure Event Hubs can be integrated with Spark Structured Streaming to perform processing of messages in near real time. You can query and analyze the processed data as it comes by using a Structured Streaming query and Spark SQL.

## Streaming concepts

Stream processing is where you continuously incorporate new data into Data Lake storage and compute results. The streaming data comes in faster than it can be consumed. A stream of data is treated as a table to which data is continuously appended. Examples of such data include bank card transactions, Internet of Things (IoT) device data, and video game play events.

Data coming from a stream is typically not ordered in any way.

A streaming system consists of:

- Input sources such as Kafka, Azure event hubs, files on a distributed system, or TCP-IP sockets
- Sinks such as Kafka, Azure event hubs, various file formats, forEach sinks, console sinks, or memory sinks

### Streaming and Databricks Delta

In streaming, the problems of traditional data pipelines are exacerbated. Specifically, with frequent metadata refreshes, table repairs and small files accumulate every minute or second. Many small files result because data might be streamed in at low volumes with short triggers.

Databricks Delta is uniquely designed to address these needs. In this module, we'll explore some of these capabilities and look at how Databricks Delta helps with streaming data.