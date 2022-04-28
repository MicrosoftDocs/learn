Message routing enables you to send messages from your devices to cloud services in an automated, scalable, and reliable manner. Message routing can be used for:

 -  Sending device telemetry messages and events, namely device lifecycle events and device twin change events, to the built-in-endpoint and custom endpoints.
 -  Filtering data before routing it to various endpoints by applying rich queries. Message routing allows you to query on the message properties and message body as well as device twin tags and device twin properties.

IoT Hub needs write access to these service endpoints for message routing to work. If you configure your endpoints through the Azure portal, the necessary permissions are added for you. Make sure you configure your services to support the expected throughput. For example, if you are using Event Hubs as a custom endpoint, you must configure the throughput units for that Event Hubs so it can handle the ingress of events you plan to send via IoT Hub message routing. Similarly, when using a Service Bus Queue as an endpoint, you must configure the maximum size to ensure the queue can hold all the data ingressed, until it is egressed by consumers. When you first configure your IoT solution, you may need to monitor your other endpoints and make any necessary adjustments for the actual load.

If a message matches multiple routes that point to the same endpoint, IoT Hub delivers the message to that endpoint only once. Therefore, you don't need to configure deduplication on your Service Bus queue or topic. In partitioned queues, partition affinity guarantees message ordering.

## Custom endpoints

IoT hub supports Azure Storage containers, Event Hubs, Service Bus queues, and Service Bus topics as custom endpoints.

### Azure Storage endpoint

There are two storage services IoT Hub can route messages to -- Azure Blob Storage and Azure Data Lake Storage Gen2 (ADLS Gen2) accounts. Azure Data Lake Storage accounts are hierarchical namespace-enabled storage accounts built on top of blob storage. Both of these use blobs for their storage.

### Event Hubs

Event Hubs is a service that processes large amounts of event data (telemetry) from connected devices and applications. After you collect data into Event Hubs, you can store the data using a storage cluster or transform it using a real-time analytics provider. This large-scale event collection and processing capability is a key component of modern application architectures including the Internet of Things (IoT).

### Service Bus Queues and Service Bus Topics

Service Bus queues and topics used as IoT Hub endpoints must not have Sessions or Duplicate Detection enabled. If either of those options are enabled, the endpoint appears as Unreachable in the Azure portal.

## Fallback route

The fallback route sends all the messages that don't satisfy query conditions on any of the existing routes to the built-in endpoint (messages/events) that is compatible with Event Hubs. If message routing is turned on, you can enable the fallback route capability. Once a route is created, data stops flowing to the built-in-endpoint, unless a route is created to that endpoint. If there are no routes to the built-in-endpoint and a fallback route is enabled, only messages that don't match any query conditions on routes will be sent to the built-in-endpoint. Also, if all existing routes are deleted, fallback route must be enabled to receive all data at the built-in-endpoint.

You can enable/disable the fallback route in the Azure portal-&gt;Message Routing blade. You can also use Azure Resource Manager for FallbackRouteProperties to use a custom endpoint for fallback route.

## Non-telemetry events

In addition to device telemetry, message routing also enables sending device twin change events, device lifecycle events, and digital twin change events (in public preview). For example, if a route is created with data source set to device twin change events, IoT Hub sends messages to the endpoint that contain the change in the device twin. Similarly, if a route is created with data source set to device lifecycle events, IoT Hub sends a message indicating whether the device was deleted or created. Finally, as part of the IoT Plug and Play public preview, a developer can create routes with data source set to digital twin change events and IoT Hub sends messages whenever a digital twin property is set or changed, a digital twin is replaced, or when a change event happens for the underlying device twin.

IoT Hub also integrates with Azure Event Grid to publish device events to support real-time integrations and automation of workflows based on these events. See [this document](/azure/iot-hub/iot-hub-event-grid-routing-comparison) comparing message routing and Event Grid for IoT Hub to learn which works best for your scenario.

## Testing routes

When you create a new route or edit an existing route, you should test the route query with a sample message. You can test individual routes or test all routes at once and no messages are routed to the endpoints during the test. Azure portal, Azure Resource Manager, Azure PowerShell, and Azure CLI can be used for testing. Outcomes help identify whether the sample message matched the query, message did not match the query, or test couldn't run because the sample message or query syntax are incorrect. To learn more, see [Test Route](/rest/api/iothub/iothubresource/testroute) and [Test all routes](/rest/api/iothub/iothubresource/testallroutes).

## Ordering guarantees with at least once delivery

IoT Hub message routing guarantees ordered and at least once delivery of messages to the endpoints. This means that there can be duplicate messages and a series of messages can be retransmitted honoring the original message ordering. For example, if the original message order is `[1,2,3,4]`, you could receive a message sequence like `[1,2,1,2,3,1,2,3,4]`. The ordering guarantee is that if you ever receive message `[1]`, it would always be followed by `[2,3,4]`.

For handling message duplicates, we recommend stamping a unique identifier in the application properties of the message at the point of origin, which is usually a device or a module. The service consuming the messages can handle duplicate messages using this identifier.

## Latency

When you route device-to-cloud telemetry messages using built-in endpoints, there is a slight increase in the end-to-end latency after the creation of the first route.

In most cases, the average increase in latency is less than 500 ms. You can monitor the latency using `Routing: message latency for messages/events` or `d2c.endpoints.latency.builtIn.events` IoT Hub metric. Creating or deleting any route after the first one does not impact the end-to-end latency.

## Monitoring and troubleshooting

IoT Hub provides several metrics related to routing and endpoints to give you an overview of the health of your hub and messages sent. You can combine information from multiple metrics to identify root cause for issues. For example, use metric `Routing: telemetry messages dropped` or `d2c.telemetry.egress.dropped` to identify the number of messages that were dropped when they didn't match queries on any of the routes and fallback route was disabled. [IoT Hub metrics](/azure/iot-hub/iot-hub-metrics) lists all metrics that are enabled by default for your IoT Hub.

You can use the REST API [Get Endpoint Health](/rest/api/iothub/iothubresource/getendpointhealth) to get health status of the endpoints. We recommend using the IoT Hub metrics related to routing message latency to identify and debug errors when endpoint health is dead or unhealthy. For example, for endpoint type Event Hubs, you can monitor `d2c.endpoints.latency.eventHubs`. The status of an unhealthy endpoint will be updated to healthy when IoT Hub has established an eventually consistent state of health.

Using the `routes` diagnostic logs in Azure Monitor diagnostic settings, you can track errors that occur during evaluation of a routing query and endpoint health as perceived by IoT Hub, for example when an endpoint is dead. These diagnostic logs can be sent to Azure Monitor logs, Event Hubs, or Azure Storage for custom processing.
