Azure Event Grid enables developers to easily build applications with event-based architectures.

Implementing Event Grid in a solution involves the following steps:

 -  Select the Azure resource that you would like Event Grid to subscribe to (such as IoT Hub).
 -  Process or transform the event data (if necessary).
 -  Specify the downstream event handler or WebHook endpoint that you want Event Grid to send the event to.

Event Grid has built-in support for events coming from Azure services such as IoT Hub, Blob Storage, and Resource Groups. Event Grid also has support for your own events, using custom topics.

You can use filters to route specific events to different endpoints, multicast to multiple endpoints, and make sure your events are reliably delivered.

Azure Event Grid is deployed to maximize availability by natively spreading across multiple fault domains in every region, and across availability zones (in regions that support them). For a list of regions that are supported by Event Grid, see Products available by region [https://azure.microsoft.com/global-infrastructure/services/?products=event-grid&amp;regions=all](https://azure.microsoft.com/global-infrastructure/services/?products=event-grid&amp;regions=all).

:::image type="content" source="../media/m05-l03-business-integration-event-grid-functional-model-a9936b39.png" alt-text="Diagram that shows the Event Sources and Event Handlers provided by Event Grid.":::


This image shows how Event Grid connects sources and handlers, and isn't a comprehensive list of supported integrations.

## Event sources

Currently, the following Azure services support sending events to Event Grid:

 -  Azure Subscriptions (management operations)
 -  Container Registry
 -  Custom Topics
 -  Event Hubs
 -  IoT Hub
 -  Media Services
 -  Resource Groups (management operations)
 -  Service Bus
 -  Storage Blob
 -  Azure Maps

## Event handlers

Currently, the following Azure services support handling events from Event Grid:

 -  Azure Automation
 -  Azure Functions
 -  Event Hubs
 -  Hybrid Connections
 -  Logic Apps
 -  Power Automate (Formerly known as Microsoft Flow)
 -  Queue Storage
 -  Service Bus
 -  WebHooks

## Concepts

Azure Event Grid can be described within the context of the following five concepts:

 -  Events - What happened.
 -  Event sources - Where the event took place.
 -  Topics - The endpoint where publishers send events.
 -  Event subscriptions - The endpoint or built-in mechanism to route events, sometimes to more than one handler. Subscriptions are also used by handlers to intelligently filter incoming events.
 -  Event handlers - The app or service reacting to the event.

### Events definition

An event is the smallest amount of information that fully describes something that happened in the system. Every event has common information like: source of the event, time the event took place, and unique identifier. Every event also has specific information that is only relevant to the specific type of event. For example, an event about a new file being created in Azure Storage has details about the file, such as the lastTimeModified value. Or, an Event Hubs event has the URL of the Capture file.

An event of size up to 64 KB is covered by General Availability (GA) Service Level Agreement (SLA). The support for an event of size up to 1 MB is currently in preview. Events over 64 KB are charged in 64-KB increments.

### Event sources definition

An event source is where the event happens. Each event source is related to one or more event types. For example, Azure Storage is the event source for blob created events. IoT Hub is the event source for device created events. Your application is the event source for custom events that you define. Event sources are responsible for sending events to Event Grid.

### Topics definition

The event grid topic provides an endpoint where the source sends events. The publisher creates the event grid topic, and decides whether an event source needs one topic or more than one topic. A topic is used for a collection of related events. To respond to certain types of events, subscribers decide which topics to subscribe to.

System topics are built-in topics provided by Azure services. You don't see system topics in your Azure subscription because the publisher owns the topics, but you can subscribe to them. To subscribe, you provide information about the resource you want to receive events from. As long as you have access to the resource, you can subscribe to its events.

Custom topics are application and third-party topics. When you create or are assigned access to a custom topic, you see that custom topic in your subscription.

When designing your application, you have flexibility when deciding how many topics to create. For large solutions, create a custom topic for each category of related events. For example, consider an application that sends events related to modifying user accounts and processing orders. It's unlikely any event handler wants both categories of events. Create two custom topics and let event handlers subscribe to the one that interests them. For small solutions, you might prefer to send all events to a single topic. Event subscribers can filter for the event types they want.

### Event subscriptions definition

A subscription tells Event Grid which events on a topic you're interested in receiving. When creating the subscription, you provide an endpoint for handling the event. You can filter the events that are sent to the endpoint. You can filter by event type, or subject pattern.

The event subscription is automatically expired after that date. Set an expiration for event subscriptions that are only needed for a limited time and you don't want to worry about cleaning up those subscriptions. For example, when creating an event subscription to test a scenario, you might want to set an expiration.

### Event handlers definition

From an Event Grid perspective, an event handler is the place where the event is sent. The handler takes some further action to process the event. Event Grid supports several handler types. You can use a supported Azure service or your own webhook as the handler. Depending on the type of handler, Event Grid follows different mechanisms to guarantee the delivery of the event. For HTTP webhook event handlers, the event is retried until the handler returns a status code of 200 – OK. For Azure Storage Queue, the events are retried until the Queue service successfully processes the message push into the queue.

### Additional concept considerations

Some additional considerations when planning to implement Event Grid include security, event delivery, and batching.

#### Security

Event Grid provides security for subscribing to topics, and publishing topics. When subscribing, you must have adequate permissions on the resource or event grid topic. When publishing, you must have a SAS token or key authentication for the topic.

#### Event delivery

If Event Grid can't confirm that an event has been received by the subscriber's endpoint, it redelivers the event.

#### Batching

When using a custom topic, events must always be published in an array. This can be a batch of one for low-throughput scenarios, however, for high volume use cases, it's recommended that you batch several events together per publish to achieve higher efficiency. Batches can be up to 1 MB. Each event should still not be greater than 64 KB (General Availability) or 1 MB (preview).

## Capabilities

Here are some of the key features of Azure Event Grid:

 -  Simplicity - Point and click to aim events from your Azure resource to any event handler or endpoint.
 -  Advanced filtering - Filter on event type or event publish path to make sure event handlers only receive relevant events.
 -  Fan-out - Subscribe several endpoints to the same event to send copies of the event to as many places as needed.
 -  Reliability - 24-hour retry with exponential backoff to make sure events are delivered.
 -  Pay-per-event - Pay only for the amount you use Event Grid.
 -  High throughput - Build high-volume workloads on Event Grid with support for millions of events per second.
 -  Built-in Events - Get up and running quickly with resource-defined built-in events.
 -  Custom Events - Use Event Grid route, filter, and reliably deliver custom events in your app.

## How much does Event Grid cost?

Azure Event Grid uses a pay-per-event pricing model, so you only pay for what you use. The first 100,000 operations per month are free. Operations are defined as event ingress, subscription delivery attempts, management calls, and filtering by subject suffix. For details, see the pricing page [https://azure.microsoft.com/pricing/details/event-grid/](https://azure.microsoft.com/pricing/details/event-grid/).
