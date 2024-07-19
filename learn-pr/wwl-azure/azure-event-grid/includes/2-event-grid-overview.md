Azure Event Grid is a highly scalable, fully managed Pub Sub message distribution service that offers flexible message consumption patterns using the Hypertext Transfer Protocol (HTTP) and Message Queuing Telemetry Transport (MQTT) protocols. With Azure Event Grid, you can build data pipelines with device data, integrate applications, and build event-driven serverless architectures. Event Grid enables clients to publish and subscribe to messages over the MQTT v3.1.1 and v5.0 protocols to support Internet of Things (IoT) solutions. Through HTTP, Event Grid enables you to build event-driven solutions where a publisher service announces its system state changes (events) to subscriber applications. Event Grid can be configured to send events to subscribers (push delivery) or subscribers can connect to Event Grid to read events (pull delivery). Event Grid supports CloudEvents 1.0 specification to provide interoperability across systems.

## Concepts in Azure Event Grid

There are several concepts in Azure Event Grid you need to understand to help you get started.

### Publishers

A publisher is the application that sends events to Event Grid. It can be the same application where the events originated, the event source. Azure services publish events to Event Grid to announce an occurrence in their service. You can publish events from your own application. Organizations that host services outside of Azure can publish events through Event Grid too.

A *partner* is a kind of publisher that sends events from its system to make them available to Azure customers. Partners not only can publish events to Azure Event Grid, but they can also receive events from it. These capabilities are enabled through the Partner Events feature.

### Events and CloudEvents

An event is the smallest amount of information that fully describes something that happened in a system. Every event has common information like `source` of the event, the `time` the event took place, and a unique identifier. Every event also has specific information that is only relevant to the specific type of event.

Event Grid conforms to Cloud Native Computing Foundation’s open standard [CloudEvents 1.0](https://github.com/cloudevents/spec) specification using the [HTTP protocol binding](https://github.com/cloudevents/spec/blob/v1.0.2/cloudevents/bindings/http-protocol-binding.md) with [JSON format](https://github.com/cloudevents/spec/blob/v1.0.2/cloudevents/formats/json-format.md). It means that your solutions publish and consume event messages using a format like the following example:

```json
{
    "specversion" : "1.0",
    "type" : "com.yourcompany.order.created",
    "source" : "https://yourcompany.com/orders/",
    "subject" : "O-28964",
    "id" : "A234-1234-1234",
    "time" : "2018-04-05T17:31:00Z",
    "comexampleextension1" : "value",
    "comexampleothervalue" : 5,
    "datacontenttype" : "application/json",
    "data" : {
       "orderId" : "O-28964",
       "URL" : "https://com.yourcompany/orders/O-28964"
    }
}
```

The maximum allowed size for an event is 1 MB. Events over 64 KB are charged in 64-KB increments.

### Event sources

An event source is where the event happens. Each event source is related to one or more event types. For example, Azure Storage is the event source for blob created events. IoT Hub is the event source for device created events. Your application is the event source for custom events that you define. Event sources are responsible for sending events to Event Grid.

### Topics

A topic holds events that have been published to Event Grid. You typically use a topic resource for a collection of related events. To respond to certain types of events, subscribers (an Azure service or other applications) decide which topics to subscribe to. There are several kinds of topics: custom topics, system topics, and partner topics.

**System topics** are built-in topics provided by Azure services. You don't see system topics in your Azure subscription because the publisher owns the topics, but you can subscribe to them. To subscribe, you provide information about the resource you want to receive events from. As long as you have access to the resource, you can subscribe to its events.

**Custom topics** are application and third-party topics. When you create or are assigned access to a custom topic, you see that custom topic in your subscription.

**Partner topics** are a kind of topic used to subscribe to events published by a partner. The feature that enables this type of integration is called Partner Events. Through that integration, you get a partner topic where events from a partner system are made available. Once you have a partner topic, you create an event subscription as you would do for any other type of topic.

### Event subscriptions

A subscription tells Event Grid which events on a topic you're interested in receiving. When creating the subscription, you provide an endpoint for handling the event. You can filter the events that are sent to the endpoint. You can filter by event type, or subject pattern. Set an expiration for event subscriptions that are only needed for a limited time and you don't want to worry about cleaning up those subscriptions.

### Event handlers

From an Event Grid perspective, an event handler is the place where the event is sent. The handler takes some further action to process the event. Event Grid supports several handler types. You can use a supported Azure service or your own webhook as the handler. Depending on the type of handler, Event Grid follows different mechanisms to guarantee the delivery of the event. For HTTP webhook event handlers, the event is retried until the handler returns a status code of `200 – OK`. For Azure Storage Queue, the events are retried until the Queue service successfully processes the message push into the queue.

### Security

Event Grid provides security for subscribing to topics and when publishing events to topics. When subscribing, you must have adequate permissions on the Event Grid topic. If using push delivery, the event handler is an Azure service, and a managed identity is used to authenticate Event Grid, the managed identity should have an appropriate RBAC role. For example, if sending events to Event Hubs, the managed identity used in the event subscription should be a member of the Event Hubs Data Sender role.
