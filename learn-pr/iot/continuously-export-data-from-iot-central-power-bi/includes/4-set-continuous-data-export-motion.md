Let's go over some of the concepts behind continuous data export.

Data export from IoT Central can be sent to three services. Let's take a quick look at each of these services.

## Azure Blob storage

Blob storage is the go-to storage for Azure services. It isn't as sophisticated, or costly, as the Cosmos database service. Blob storage is ideal for logging, archiving, and general purpose storage.

There's a key difference between sending continuous data to blob storage, instead of the other two services. Data for blob storage is batched, and sent once every minute. Continuous data to Azure Service Bus, or Azure Event Hubs, is near real time. This latency makes blob storage a less suitable route for warm path data analysis, if responding within a minute is important.

## Azure Service Bus

The Azure Service Bus is a message brokering service, decoupling apps from services. Data is transferred between different apps and services using _messages_.

A message is in binary format, and can contain JSON, XML, or text.

Service Bus messages are secure, and transmitted asynchronously. By decoupling apps from services, both client and service don't have to be online at the same time. Also, decoupling can improve the reliability and scalability of an app.

Common applications of the Service Bus include standard business communications, such as purchase orders, sales, and inventory. There can be a one-to-many relationship between publisher and subscriber. Messages can be ordered, and deferred. Messages can be queued, so the receiving app receives and processes them in order. Also, multiple queues and topics can be held in a single namespace. The namespaces often serving as a container.

We'll not be implementing a Service Bus in this module. The key takeaway is that Service Bus is an enterprise-level message routing service.

[![Artwork as a metaphor for a network of communications](../media/continuous-data-network.png)](../media/continuous-data-network.png#lightbox)

## Azure Event Hubs

An Event Hub is a big-data streaming platform. The range of applications that it's designed for is similar to that of an Azure IoT Hub, except that, for IoT devices, the recommended solution is the IoT Hub. An Azure Event Hub however, may well be part of a larger solution, and you may want your IoT data exported to it.

Event Hubs can handle millions of events per second. Back-end processes may well handle real-time analytics, storage, anomaly detection, analytics pipelines, live dashboards, transaction processing, and many other processes.

An Event Hub is a gateway to an event pipeline, often called an _event ingestor_ in solution architectures.

We'll implement an Event Hub in this module. The Event Hub is used as input to an Azure Stream Analytics job, which itself is used as input to Power BI.

## Practical tips when implementing data export

When creating the data export service from IoT Central, you can define one of the three services described above. You'll be given the option of selecting any from within your subscription. However, you can send data to any of these services outside of your subscription, using a connection string.

Another tip is that, if your IoT devices are sending telemetry data, and your data export is _not_ running, the telemetry data is lost. Only when the data export service is started, will data be exported. The advice is, set it running early! Capture that data.

Let's now put some of this theory to practice, and set data export in motion.
