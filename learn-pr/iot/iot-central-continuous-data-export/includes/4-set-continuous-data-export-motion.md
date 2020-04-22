Let's go over some of the concepts behind continuous data export.

Data export from IoT Central can be sent to three services. Let's take a quick look at each of these services.

## Azure Blob storage

Blob storage is the go-to storage for Azure services. It is not as sophisticated, or costly, as the Cosmos DB service. Blob storage is ideal for logging, archiving, and general purpose storage.

One of the key differences between continuous data to Blob storage, and the other two services, is that the data is sent once every minute. Continuous data to Azure Service Bus, or Azure Event Hubs, is near real-time. This makes blob storage a less suitable route for warm path data analysis, if responding well within a minute is important.

Data sent to blob storage can become the input to Azure Machine Learning, training the models. Alternatively, the data could be sent to Microsoft Power Bi, or PowerApps, perhaps for longer-term trend analysis, or to be visualized in charts or graphs.

As blob storage is the cheaper, simpler, option, we will implement it in this module.

## Azure Service Bus

The Azure Service Bus is a message brokering service, decoupling apps from services. Data is transferred between different apps and services using _messages_.

A message is in binary format, and can contain JSON, XML, or text.

Service Bus messages are secure, and transmitted asynchronously. By decoupling apps from services, both client and service do not have to be online at the same time. Also, decoupling can improve the reliability and scalability of an app.

Common applications of the Service Bus include standard business communications, such as purchase orders, sales, and inventory. There can be a one-to-many relationship between publisher and subscriber. Messages can be ordered, and deferred. Messages can be queued, so the receiving app can receive and process them in order. Also, multiple queues and topics can be held in a single namespace. The namespaces often serving as a container.

We will not be implementing a Service Bus in this module. The key takeaway is that Service Bus is an enterprise-level message routing service.

## Azure Event Hubs

Event Hubs are a big-data streaming platform. The range of applications that it is designed for is similar to that of an Azure IoT Hub, except that, for IoT devices, the recommended solution is the IoT Hub. An Azure Event Hub however, may well be part of a larger solution, and you may want your IoT data exported to it.

Event Hubs can handle millions of events per second. Back-end processes may well handle real-time analytics, storage, anomaly detection, analytics pipelines, live dashboarding, transaction processing, and many other processes.

Event Hubs represents the "front door" for an event pipeline, often called an event ingestor in solution architectures.

We will not be implementing an Event Hub in this module. However, if you want to know more, follow the links on the Summary page.

## Practical tips when implementing data export

When creating the data export service from IoT Central, you can define one of the three services described above. You will be given the option of selecting any from within your subscription. However, you can send data to any of these services outside of your subscription, using a connection string.

Another tip is that you must set the continuous data service running. If your IoT devices are sending telemetry data, and your data export is _not_ running, the telemetry data is lost. Only when the data export service is started, will data be exported. The advice is, set it running early! Capture that data.

Let's now put some of this theory to practice, and set data export in motion.

