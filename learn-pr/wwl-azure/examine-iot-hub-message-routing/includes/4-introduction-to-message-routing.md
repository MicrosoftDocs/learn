IoT Hub Message Routing enables users to route device-to-cloud messages to service-facing endpoints. Routing also provides a querying capability to filter the data before routing it to the endpoints.

## Routing endpoints

An IoT hub has a default built-in messaging endpoint (messages/events).

In addition, custom endpoints can be configured that link IoT hub to other services in your subscription. IoT Hub currently supports the following custom endpoints:

 -  Azure Storage containers
 -  Event Hubs
 -  Service Bus Queues
 -  Service Bus Topics

IoT Hub only supports writing data to Azure Storage containers as blobs. Also Service Bus queues and Service Bus topics that have Sessions or Duplicate Detection enabled are not supported as custom endpoints.

## Routing queries

A single message may match the condition on multiple routing queries, in which case IoT Hub delivers the message to the endpoint associated with each matched query. IoT Hub also automatically deduplicates message delivery, so if a message matches multiple queries that have the same destination, it is only written once to that destination.

> [!IMPORTANT]
> When you route message data to custom endpoints, messages are only delivered to the built-in endpoint if they don't match any query. To deliver messages to both the built-in endpoint and to a custom endpoint, add a route that sends messages to the built-in events endpoint.

Each routing query you configure has the following properties:

:::row:::
  :::column:::
    **Property**
  :::column-end:::
  :::column:::
    **Description**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Name
  :::column-end:::
  :::column:::
    The unique name that identifies the query.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Source
  :::column-end:::
  :::column:::
    The origin of the data stream to be acted upon. For example, device telemetry.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Condition
  :::column-end:::
  :::column:::
    The query expression for the routing query that is run against the message application properties, system properties, message body, device twin tags, and device twin properties to determine if it is a match for the endpoint. For more information about constructing a query, see the see message routing query syntax.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Endpoint
  :::column-end:::
  :::column:::
    The name of the endpoint where IoT Hub sends messages that match the query. We recommend that you choose an endpoint in the same region as your IoT hub.
  :::column-end:::
:::row-end:::
