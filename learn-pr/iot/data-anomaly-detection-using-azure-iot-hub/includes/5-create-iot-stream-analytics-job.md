The architecture of our vibration monitoring system requires that data be sent to two destinations: storage, and vibration analysis. Azure IoT provides a convenient method of directing data to the right service, through _message routing_.

## Set up message routing

Message routing enables data to be sent to a range of endpoints. These endpoints include blob storage and _Event Hubs_. Blob storage is clearly for archiving the data. Event Hubs is a data streaming platform. We don't really test the bandwidth of Event Hubs much in this module, with just one telemetry message every two seconds. However,Event Hubs are capable of handling huge quantities of data: millions of telemetry readings per second. Event Hubs are designed to scale, so if your telemetry requirements increased massively, your code and Azure resources would not have to change much.

### Analyze data for anomalies hidden in plain sight

Event Hubs are ideal for anomaly detection. Anomalies in data include the excessive vibration we are looking for in our scenario. Anomalies also include such things as fraud detection, identifying of outliers, identifying hidden trends, and any scenario where something is not right, but the troubled data can be well hidden in the sheer mass of data.

In our scenario, we need one route to storage, which we will keep simple and use Azure Blob storage (though Data Lake storage is also an option). The second route will be to an Event Hub. Event Hubs are a convenient input to Stream Analytics. One key feature of message routing is that we can filter incoming data, and stream the output down the route only when certain conditions are met.

In addition to storage and Event Hubs, messages can be routed to Azure Service Bus Queues, and Azure Service Bus Topics. We don't use these more advanced features in this module, but Service Buses can be used to decouple apps and services. This decoupling allows for situations such as the app client and service not being online at the same time. Also, there might be one provider of data, but many subscribers to that data. Deferring messages for later analysis is another use of Service Buses. 

Message routes are best built and tested one at a time. To build the storage route, all the features are in the Azure portal. We will call this the "logging" route, and it involves digging a few levels deep into the creation of Azure resources.