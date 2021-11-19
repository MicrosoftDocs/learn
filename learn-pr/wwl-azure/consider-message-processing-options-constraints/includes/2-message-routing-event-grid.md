Azure IoT Hub provides the capability to stream data from your connected devices and integrate that data into your business applications. IoT Hub offers two methods for integrating IoT events into other Azure services or business applications.

 -  **IoT Hub message routing**: This IoT Hub feature enables users to route device-to-cloud messages to service endpoints like Azure Storage containers, Event Hubs, Service Bus queues, and Service Bus topics. Routing also provides a querying capability to filter the data before routing it to the endpoints. In addition to device telemetry data, you can also send non-telemetry events that can be used to trigger actions.
 -  **IoT Hub integration with Event Grid**: Azure Event Grid is a fully managed event routing service that uses a publish-subscribe model. IoT Hub and Event Grid work together to integrate IoT Hub events into Azure and non-Azure services, in near-real time. IoT Hub publishes both device events and telemetry events.

## Differences

While both message routing and Event Grid enable alert configuration, there are some key differences between the two. Refer to the following table for details:

:::row:::
  :::column:::
    **Feature**
  :::column-end:::
  :::column:::
    **IoT Hub message routing**
  :::column-end:::
  :::column:::
    **IoT Hub integration with Event Grid**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Device messages and events
  :::column-end:::
  :::column:::
    Yes, message routing can be used for telemetry data, report device twin changes, device lifecycle events, and digital twin change events (part of the IoT Plug and Play public preview).
  :::column-end:::
  :::column:::
    Yes, Event Grid can be used for telemetry data but can also report when devices are created, deleted, connected, and disconnected from IoT Hub.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Ordering
  :::column-end:::
  :::column:::
    Yes, ordering of events is maintained.
  :::column-end:::
  :::column:::
    No, order of events is not guaranteed.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Filtering
  :::column-end:::
  :::column:::
    Rich filtering on message application properties, message system properties, message body, device twin tags, and device twin properties. Filtering isn't applied to digital twin change events.
  :::column-end:::
  :::column:::
    Filtering based on event type, subject type and attributes in each event. When subscribing to telemetry events, you can apply more filters on the data to filter on message properties, message body and device twin in your IoT Hub, before publishing to Event Grid.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Endpoints
  :::column-end:::
  :::column:::
    Event Hubs
Azure Blob Storage
Service Bus queue
Service Bus topics

Paid IoT Hub SKUs (S1, S2, and S3) are limited to 10 custom endpoints. 100 routes can be created per IoT Hub.
  :::column-end:::
  :::column:::
    Azure Functions
Azure Automation
Event Hubs
Logic Apps
Storage Blob
Custom Topics
Queue Storage
Microsoft Flow
Third-party services through WebHooks

500 endpoints per IoT Hub are supported.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Cost
  :::column-end:::
  :::column:::
    There is no separate charge for message routing. Only ingress of telemetry into IoT Hub is charged. For example, if you have a message routed to three different endpoints, you are billed for only one message.
  :::column-end:::
  :::column:::
    There is no charge from IoT Hub. Event Grid offers the first 100,000 operations per month for free, and then $0.60 per million operations afterwards.
  :::column-end:::
:::row-end:::


## Similarities

IoT Hub message routing and Event Grid have similarities too, some of which are detailed in the following table:

:::row:::
  :::column:::
    **Feature**
  :::column-end:::
  :::column:::
    **IoT Hub message routing**
  :::column-end:::
  :::column:::
    **IoT Hub integration with Event Grid**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Maximum message size
  :::column-end:::
  :::column:::
    256 KB, device-to-cloud
  :::column-end:::
  :::column:::
    256 KB, device-to-cloud
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Reliability
  :::column-end:::
  :::column:::
    High: Delivers each message to the endpoint at least once for each route. Expires all messages that are not delivered within one hour.
  :::column-end:::
  :::column:::
    High: Delivers each message to the webhook at least once for each subscription. Expires all events that are not delivered within 24 hours.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Scalability
  :::column-end:::
  :::column:::
    High: Optimized to support millions of simultaneously connected devices sending billions of messages.
  :::column-end:::
  :::column:::
    High: Capable of routing 10,000,000 events per second per region.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Latency
  :::column-end:::
  :::column:::
    Low: Near-real time.
  :::column-end:::
  :::column:::
    Low: Near-real time.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Send to multiple endpoints
  :::column-end:::
  :::column:::
    Yes, send a single message to multiple endpoints.
  :::column-end:::
  :::column:::
    Yes, send a single message to multiple endpoints.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Security
  :::column-end:::
  :::column:::
    Iot Hub provides per-device identity and revocable access control.
  :::column-end:::
  :::column:::
    Event Grid provides validation at three points: event subscriptions, event publishing, and webhook event delivery.
  :::column-end:::
:::row-end:::
