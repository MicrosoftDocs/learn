Message routing enables you to send messages from your devices to cloud services in an automated, scalable, and reliable manner. Message routing can be used for:

* Sending device telemetry messages and events to the built-in endpoint and custom endpoints. Events that can be routed include device lifecycle events, device twin change events, digital twin change events, and device connection state events.

* Filtering data before routing it to various endpoints by applying rich queries. Message routing allows you to query on the message properties and message body as well as device twin tags and device twin properties.

As described in the previous unit, Azure IoT Hub defines a common set of features for all device-to-cloud messaging for interoperability across protocols.

> [!NOTE]
> Some of the features mentioned in this unit, like cloud-to-device messaging, device twins, and device management, are only available in the standard tier of Azure IoT Hub.

## Routing endpoints

Each Azure IoT hub has a default built-in endpoint (**messages/events**) that is compatible with Event Hubs. You also can create custom endpoints that point to other services in your Azure subscription.

Each message is routed to all endpoints whose routing queries it matches. In other words, a message can be routed to multiple endpoints. If a message matches multiple routes that point to the same endpoint, Azure IoT Hub delivers the message to that endpoint only once.

## Built-in endpoint

You can use standard Event Hubs integration and SDKs to receive device-to-cloud messages from the built-in endpoint (messages/events). Once a route is created, data stops flowing to the built-in endpoint unless a route is created to that endpoint. Even if no routes are created, a fallback route must be enabled to route messages to the built-in endpoint. The fallback is enabled by default if you create your hub using the portal or the CLI.

The built-in endpoint is described in more detail in the next unit.

## Custom endpoints

In addition to the built-in endpoint, Azure IoT Hub supports the following custom endpoints:

* Storage containers
* Service Bus queues
* Service Bus topics
* Event Hubs
* Cosmos DB (preview)

Azure IoT Hub needs write access to these service endpoints for message routing to work. If you configure your endpoints through the Azure portal, the necessary permissions are added for you. If you configure your endpoints using PowerShell or the Azure CLI, you need to provide the write access permission.

Make sure you configure your services to support the expected throughput. For example, if you're using Event Hubs as a custom endpoint, you must configure the **throughput units** for that event hub so it can handle the ingress of events you plan to send via Azure IoT Hub message routing. Similarly, when using a Service Bus queue as an endpoint, you must configure the **maximum size** to ensure the queue can hold all the data ingressed, until it's egressed by consumers. When you first configure your IoT solution, you may need to monitor your other endpoints and make any necessary adjustments for the actual load.

### Azure Storage containers as a routing endpoint

There are two storage services that Azure IoT Hub can route messages to:

* Azure Blob Storage
* Azure Data Lake Storage Gen2 (ADLS Gen2)

Azure Data Lake Storage accounts are hierarchical namespace-enabled storage accounts built on top of blob storage. Both of these use blobs for their storage.

To learn how to read from this endpoint type, see [Blob storage](/azure/storage/blobs/storage-blob-event-quickstart).

### Azure Service Bus queues and Service Bus topics as a routing endpoint

Service Bus queues and topics used as Azure IoT Hub endpoints must not have **Sessions** or **Duplicate Detection** enabled. If either of those options are enabled, the endpoint appears as **Unreachable** in the Azure portal.

To learn how to read from these endpoint types, see:
* Read from [Service Bus queues](/azure/service-bus-messaging/service-bus-dotnet-get-started-with-queues).

* Read from [Service Bus topics](/azure/service-bus-messaging/service-bus-dotnet-how-to-use-topics-subscriptions).

### Event Hubs as a routing endpoint

Event Hubs is a service that processes large amounts of event data (telemetry) from connected devices and applications. After you collect data into Event Hubs, you can store the data using a storage cluster or transform it using a real-time analytics provider. This large-scale event collection and processing capability are a key component of modern application architectures including IoT.

See, read from [Event Hubs](/azure/event-hubs/event-hubs-dotnet-standard-getstarted-send) to learn about how to read messages from Event Hubs.

### Azure Cosmos DB as a routing endpoint (preview)

You can send data directly to Azure Cosmos DB from Azure IoT Hub. Cosmos DB is a fully managed hyperscale multi-model database service. It provides low latency and high availability, making it a great choice for scenarios like connected solutions and manufacturing that require extensive downstream data analysis.

## Route to an endpoint in another subscription

If the endpoint resource is in a different subscription than your Azure IoT hub, you need to configure your Azure IoT hub as a trusted Microsoft service before creating a custom endpoint. When you do create the custom endpoint, set the **Authentication** type to user-assigned identity.

For more information, see [Egress connectivity from IoT Hub to other Azure resources](/azure/iot-hub/iot-hub-managed-identity#egress-connectivity-from-iot-hub-to-other-azure-resources).

## Fallback route

The fallback route sends all the messages that don't satisfy query conditions on any of the existing routes to the built-in endpoint (**messages/events**), which is compatible with Event Hubs. If message routing is enabled, you can enable the fallback route capability. Once a route is created, data stops flowing to the built-in endpoint, unless a route is created to that endpoint. If there are no routes to the built-in endpoint and a fallback route is enabled, only messages that don't match any query conditions on routes are sent to the built-in endpoint. Also, if all existing routes are deleted, the fallback route capability must be enabled to receive all data at the built-in endpoint.

You can enable or disable the fallback route in the Azure portal, from the **Message routing** blade. You can also use Azure Resource Manager for **FallbackRouteProperties** to use a custom endpoint for the fallback route.

## Non-telemetry events

In addition to device telemetry, message routing also enables sending non-telemetry events, including:

* Device twin change events
* Device lifecycle events
* Device job lifecycle events
* Digital twin change events
* Device connection state events

For example, if a route is created with the data source set to **Device Twin Change Events**, Azure IoT Hub sends messages to the endpoint that contain the change in the device twin. Similarly, if a route is created with the data source set to **Device Lifecycle Events**, Azure IoT Hub sends a message indicating whether the device or module was deleted or created. When using Azure IoT Plug and Play, a developer can create routes with the data source set to **Digital Twin Change Events** and Azure IoT Hub sends messages whenever a digital twin property is set or changed, a digital twin is replaced, or when a change event happens for the underlying device twin. Finally, if a route is created with data source set to **Device Connection State Events**, Azure IoT Hub sends a message indicating whether the device was connected or disconnected.

Azure IoT Hub also integrates with Azure Event Grid to publish device events to support real-time integrations and automation of workflows based on these events.

## Limitations for device connection state events

Device connection state events are available for devices connecting using either the MQTT or AMQP protocol, or using either of these protocols over WebSockets. Requests made only with HTTPS don't trigger device connection state notifications. For Azure IoT Hub to start sending device connection state events, after opening a connection a device must call either the *cloud-to-device receive message* operation or the *device-to-cloud send telemetry* operation. Outside of the Azure IoT SDKs, in MQTT these operations equate to SUBSCRIBE or PUBLISH operations on the appropriate messaging topics. Over AMQP these operations equate to attaching or transferring a message on the appropriate link paths.

Azure IoT Hub doesn't report each individual device connect and disconnect, but rather publishes the current connection state taken at a periodic, 60-second snapshot. Receiving either the same connection state event with different sequence numbers or different connection state events both mean that there was a change in the device connection state during the 60-second window.

## Test routes

When you create a new route or edit an existing route, you should test the route query with a sample message. You can test individual routes or test all routes at once and no messages are routed to the endpoints during the test. Azure portal, Azure Resource Manager, Azure PowerShell, and Azure CLI can be used for testing. Outcomes help identify whether the sample message matched or didn't match the query, or if the test couldn't run because the sample message or query syntax are incorrect. To learn more, see [Test Route](/rest/api/iothub/iothubresource/testroute) and [Test All Routes](/rest/api/iothub/iothubresource/testallroutes).

## Latency

When you route device-to-cloud telemetry messages using built-in endpoints, there's a slight increase in the end-to-end latency after the creation of the first route.

In most cases, the average increase in latency is less than 500 milliseconds. However, the latency you experience can vary and can be higher depending on the tier of your Azure IoT hub and your solution architecture. You can monitor the latency using the **Routing: message latency for messages/events** or **d2c.endpoints.latency.builtIn.events** Azure IoT Hub metrics. Creating or deleting any route after the first one doesn't impact the end-to-end latency.

## Monitor and troubleshoot

Azure IoT Hub provides several metrics related to routing and endpoints to give you an overview of the health of your hub and messages sent. For a list of all of the Azure IoT Hub metrics broken out by functional category, see the [Metrics](/azure/iot-hub/monitor-iot-hub-reference#metrics) section of [Monitoring Azure IoT Hub data reference](/azure/iot-hub/monitor-iot-hub-reference). You can track errors that occur during evaluation of a routing query and endpoint health as perceived by Azure IoT Hub with the [routes category in IoT Hub resource logs](/azure/iot-hub/monitor-iot-hub-reference#routes). To learn more about using metrics and resource logs with Azure IoT Hub, see [Monitoring Azure IoT Hub](/azure/iot-hub/monitor-iot-hub).

You can use the REST API [Get Endpoint Health](/rest/api/iothub/iothubresource/getendpointhealth#iothubresource_getendpointhealth) to get the health status of the endpoints.

Use the [troubleshooting guide for routing](/azure/iot-hub/troubleshoot-message-routing) for more details and support for troubleshooting routing.
