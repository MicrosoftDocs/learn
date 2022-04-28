Azure provides four services that assist IoT hub in delivering event and message data to downstream locations within a solution. These services are:

 -  Event Grid
 -  Event Hubs
 -  Service Bus
 -  Azure Storage Queues

Although they have some similarities, each service is designed for particular scenarios. The sections below describe the differences between these services, and help you to understand which one to choose for your application. In many cases, the messaging services are complementary and can be used together.

## Event vs. message services

There's an important distinction to note between services that deliver an event and services that deliver a message.

### Event

An event is a lightweight notification of a condition or a state change. The publisher of the event has no expectation about how the event is handled. The consumer of the event decides what to do with the notification. Events can be discrete units or part of a series.

Discrete events report state change and are actionable. To take the next step, the consumer only needs to know that something happened. The event data has information about what happened but doesn't have the data that triggered the event. For example, an event notifies consumers that a file was created. It may have general information about the file, but it doesn't have the file itself. Discrete events are ideal for serverless solutions that need to scale.

Series events report a condition and are analyzable. The events are time-ordered and interrelated. The consumer needs the sequenced series of events to analyze what happened.

### Message

A message is raw data produced by a service to be consumed or stored elsewhere. The message contains the data that triggered the message pipeline. The publisher of the message has an expectation about how the consumer handles the message. A contract exists between the two sides. For example, the publisher sends a message with the raw data, and expects the consumer to create a file from that data and send a response when the work is done.

## Comparison of services

:::row:::
  :::column:::
    **Service**
  :::column-end:::
  :::column:::
    **Purpose**
  :::column-end:::
  :::column:::
    **Type**
  :::column-end:::
  :::column:::
    **When to use**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Event Grid
  :::column-end:::
  :::column:::
    Reactive programming
  :::column-end:::
  :::column:::
    Event distribution (discrete)
  :::column-end:::
  :::column:::
    React to status changes.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Event Hubs
  :::column-end:::
  :::column:::
    Big data pipeline
  :::column-end:::
  :::column:::
    Event streaming (series)
  :::column-end:::
  :::column:::
    Telemetry and distributed data streaming.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Service Bus
  :::column-end:::
  :::column:::
    High-value enterprise messaging
  :::column-end:::
  :::column:::
    Message
  :::column-end:::
  :::column:::
    Order processing and financial transactions.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Azure Storage Queues
  :::column-end:::
  :::column:::
    Simple, reliable, persistent messaging within and between services
  :::column-end:::
  :::column:::
    Message
  :::column-end:::
  :::column:::
    Very large message stores (over 80 GB), unreliable consumers.
  :::column-end:::
:::row-end:::


### Event Grid

Event Grid is an eventing backplane that enables event-driven, reactive programming. It uses a publish-subscribe model. Publishers emit events, but have no expectation about which events are handled. Subscribers decide which events they want to handle.

Event Grid is deeply integrated with Azure services and can be integrated with third-party services. It simplifies event consumption and lowers costs by eliminating the need for constant polling. Event Grid efficiently and reliably routes events from Azure and non-Azure resources. It distributes the events to registered subscriber endpoints. The event message has the information you need to react to changes in services and applications. Event Grid isn't a data pipeline, and doesn't deliver the actual object that was updated. Event Grid supports dead-lettering for events that aren't delivered to an endpoint.

It has the following characteristics:

 -  Dynamically scalable
 -  Low cost
 -  Serverless
 -  At least once delivery

### Event Hubs

Azure Event Hubs is a big data pipeline. It facilitates the capture, retention, and replay of telemetry and event stream data. The data can come from many concurrent sources. Event Hubs allows telemetry and event data to be made available to a variety of stream-processing infrastructures and analytics services. It is available either as data streams or bundled event batches. This service provides a single solution that enables rapid data retrieval for real-time processing as well as repeated replay of stored raw data. It can capture the streaming data into a file for processing and analysis.

It has the following characteristics:

 -  Low latency
 -  Capable of receiving and processing millions of events per second
 -  At least once delivery

### Service Bus

Service Bus is intended for traditional enterprise applications. These enterprise applications require transactions, ordering, duplicate detection, and instantaneous consistency. Service Bus enables cloud-native applications to provide reliable state transition management for business processes. When handling high-value messages that cannot be lost or duplicated, use Azure Service Bus. Service Bus also facilitates highly secure communication across hybrid cloud solutions and can connect existing on-premises systems to cloud solutions.

Service Bus is a brokered messaging system. It stores messages in a "broker" (for example, a queue) until the consuming party is ready to receive the messages.

It has the following characteristics:

 -  Reliable asynchronous message delivery (enterprise messaging as a service) that requires polling
 -  Advanced messaging features like FIFO, batching/sessions, transactions, dead-lettering, temporal control, routing and filtering, and duplicate detection
 -  At least once delivery
 -  Optional in-order delivery

### Azure Storage queues

Azure Queue Storage is a service for storing large numbers of messages. You access messages from anywhere in the world via authenticated calls using HTTP or HTTPS. A queue message can be up to 64 KB in size. A queue may contain millions of messages, up to the total capacity limit of a storage account. Queues are commonly used to create a backlog of work to process asynchronously.

For more information on selecting between the two message solutions, refer to: [Storage queues and Service Bus queues - compared and contrasted](/azure/service-bus-messaging/service-bus-azure-and-service-bus-queues-compared-contrasted).
