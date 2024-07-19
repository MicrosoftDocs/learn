Azure Event Hubs is a native data-streaming service in the cloud that can stream millions of events per second, with low latency, from any source to any destination. Event Hubs is compatible with Apache Kafka. It enables you to run existing Kafka workloads without any code changes.

With Event Hubs, you can ingest, buffer, store, and process your stream in real time to get actionable insights. Event Hubs uses a partitioned consumer model. It enables multiple applications to process the stream concurrently and lets you control the speed of processing. Event Hubs also integrates with Azure Functions for serverless architectures.

A broad ecosystem is available for the industry-standard AMQP 1.0 protocol. SDKs are available in languages like .NET, Java, Python, and JavaScript, so you can start processing your streams from Event Hubs. All supported client languages provide low-level integration.

## Key capabilities

Learn about the key capabilities of Azure Event Hubs in the following sections.

### Apache Kafka on Azure Event Hubs

Event Hubs is a multi-protocol event streaming engine that natively supports Advanced Message Queuing Protocol (AMQP), Apache Kafka, and HTTPS protocols. Because it supports Apache Kafka, you can bring Kafka workloads to Event Hubs without making any code changes. You don't need to set up, configure, or manage your own Kafka clusters or use a Kafka-as-a-service offering that's not native to Azure.

### Schema Registry in Event Hubs

Azure Schema Registry in Event Hubs provides a centralized repository for managing schemas of event streaming applications. Schema Registry comes free with every Event Hubs namespace. It integrates with your Kafka applications or Event Hubs SDK-based applications.

### Real-time processing of streaming events with Stream Analytics

Event Hubs integrates with Azure Stream Analytics to enable real-time stream processing. With the built-in no-code editor, you can develop a Stream Analytics job by using drag-and-drop functionality, without writing any code.

Alternatively, developers can use the SQL-based Stream Analytics query language to perform real-time stream processing and take advantage of a wide range of functions for analyzing streaming data.

## Key concepts

Event Hubs contains the following key components:

* **Producer applications**: These applications can ingest data to an event hub by using Event Hubs SDKs or any Kafka producer client.
* **Namespace**: The management container for one or more event hubs or Kafka topics. The management tasks such as allocating streaming capacity, configuring network security, and enabling geo-disaster recovery are handled at the namespace level.
* **Event Hubs/Kafka topic**: In Event Hubs, you can organize events into an event hub or a Kafka topic. It's an append-only distributed log, which can comprise one or more partitions.
* **Partitions**: They're used to scale an event hub. They're like lanes in a freeway. If you need more streaming throughput, you can add more partitions.
* **Consumer applications**: These applications can consume data by seeking through the event log and maintaining consumer offset. Consumers can be Kafka consumer clients or Event Hubs SDK clients.
* **Consumer group**: This logical group of consumer instances reads data from an event hub or Kafka topic. It enables multiple consumers to read the same streaming data in an event hub independently at their own pace and with their own offsets.
