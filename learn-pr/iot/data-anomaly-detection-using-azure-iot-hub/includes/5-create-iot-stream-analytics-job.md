The architecture of our vibration monitoring system requires data be sent to two destinations: storage, and analysis. Azure IoT provides a great method of directing data to the right service, through _message routing_.

## Set up message routing

Message routing enables data to be sent to a range of endpoints. These endpoints include _blob storage_ and _Event Hubs_. Blob storage is clearly for archiving the data. Event Hubs is a data streaming platform. We don't really stress the bandwidth of Event Hubs much in this module, with just one telemetry message every two seconds. Event Hubs can handle millions of telemetry readings per second.

### Send data into cloud storage

In our scenario, we need one route to storage, which we will keep simple and use Azure Blob storage (though Data Lake storage is also available). The key feature of message routing is the filtering of incoming data. The filter, written in SQL, streams output down the route only when certain conditions are met.

One of the easiest ways to filter data is on a message property, which is why we added these two lines to our code:

```cs
    ...
    telemetryMessage.Properties.Add("sensorID", "VSTel");
    ...
    loggingMessage.Properties.Add("sensorID", "VSLog");
```

An SQL query embedded into our message route can test the `sensorID` value.

### Analyze data for anomalies hidden in plain sight

The second route will be to an Event Hub, because an Event Hub is a convenient input to Stream Analytics. And Stream Analytics is a convenient way of handling anomaly detection.

Anomalies in data include the excessive vibration we're looking for in our scenario. Anomalies also include such things as fraud detection, identifying of outliers, and identifying hidden trends. And any scenario where something isn't right, but the trouble can be well hidden in the sheer mass of data.

In addition to storage and Event Hubs, messages can be routed to Azure Service Bus Queues, and Azure Service Bus Topics. We don't use these features in this module, but Service Buses can be used to decouple apps and services. This decoupling allows for situations such as the app client and service not being online at the same time. Also, there might be one provider of data, but many subscribers to that data. Deferring messages for later analysis is another use of Service Buses.

## Create an Azure Stream Analytics job

Azure Stream Analytics is a service for analyzing the volumes of data that an IoT Hub, or Event Hub, can pump out. Stream Analytics can analyze input from a file. However, Stream Analytics is really all about real time (or, in reality, near real time).

A Stream Analytics job takes one or more inputs, runs the data through an SQL query, and returns results to one or more outputs.

Storing data in log files, as we're doing here, is at the boring end of what a Stream Analytics job can do. Boring, but necessary.

Examples of the fun end of what Stream Analytics can handle includes geospatial analysis of fleets of trucks, or perhaps, driverless vehicles. The real-time analysis of point-of-sale data, to optimize inventory control and maximize sales. The remote monitoring of machinery, for predictive maintenance. The predictions being done by machine learning algorithms running on the telemetry data. Given the power of SQL queries, there's really a limitless supply of possible scenarios.

## Move one step at a time

Message routes are best built and tested one at a time. To build the storage route, all the features are in the Azure portal. We'll call this route the "logging" route, and it involves digging a few levels deep into the creation of Azure resources.
