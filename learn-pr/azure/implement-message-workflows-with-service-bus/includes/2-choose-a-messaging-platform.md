Many communications platforms are available to help improve the reliability of a distributed application, including several in Microsoft Azure. Each platform is a tool that serves a different purpose. It's important to choose the right tool for each requirement in your application. Take a look at your options in Azure Service Bus.

The distributed architecture of the proposed Contoso Bicycles ordering and tracking application requires several components, including a website, data storage, and a back-end service. You can bind the components of your application together in many different ways, and a single application can take advantage of multiple techniques.

You need to decide which techniques to use in the new Contoso Bicycles application. The first step is to evaluate each place where there's communication between multiple parts. Some components _must_ run in a timely manner for your application to be doing its job at all. Some might be important, but not time-critical. Finally, other components, like mobile app notifications, are a bit more optional.

## Decide between messages and events

Both messages and events are _datagrams_: packages of data sent from one component to another. They're different in ways that at first seem subtle, but the differences can make significant differences in how you architect your application.

### Messages

In the terminology of distributed applications, the defining characteristic of a message is that the overall integrity of the application may rely on messages being received. You can think of sending a message as one component passing the baton of a workflow to a different component. The entire workflow may be a vital business process, and the message is the mortar that holds the components together.

A message generally contains the actual data, not just a reference (like an ID or a URL) to data. Sending data as part of a datagram is less brittle than sending a reference. The messaging architecture guarantees delivery of the message, and because no extra lookups are required, the message is reliably handled. However, the sending application needs to know exactly what data to include to avoid sending too much data, which would require the receiving component to do unnecessary work. In this sense, the sender and receiver of a message are often coupled by a strict data contract.

In the new architecture for Contoso Bicycles, when an order is placed, the company likely will use messages. The web front end or mobile app will send a message to the back-end processing components. On the back end, steps like routing to the store nearest the customer and charging a credit card would take place.

### Events

An event triggers a notification that something has occurred. Events are "lighter" than messages and are most often used for broadcast communications.

Events have the following characteristics:

* The event may be sent to multiple receivers, or to none at all.
* Events are often intended to "fan out," or have a large number of subscribers for each publisher.
* The publisher of the event has no expectation about the action a receiving component takes.

A bicycle parts chain would likely use events for notifications to users about status changes. Status change events could be sent to Azure Event Grid, then on to Azure Functions, and to Azure Notification Hubs for a completely _serverless_ solution.

This difference between events and messages is fundamental because communications platforms are generally designed to handle one or the other. Service Bus is designed to handle messages. If you want to send events, you would likely choose Event Grid.

Azure also has Azure Event Hubs, but it's most often used for a specific type of high-flow stream of communications used for analytics. For example, if you had networked sensors in your manufacturing warehouses, you could use Event Hubs coupled with Azure Stream Analytics to watch for patterns in temperature changes that might indicate an unwanted fire or component wear.

## Service Bus topics and queues

Azure Service Bus can exchange messages in two different ways: queues and topics.

### What is a queue?

A Service Bus _queue_ is a simple temporary storage location for messages. A sending component adds a message to the queue. A destination component picks up the message at the front of the queue. Under ordinary circumstances, each message is received by only one receiver.

:::image type="content" source="../media/2-service-bus-queue.png" alt-text="Illustration that shows a sample message queue with one sender sending the messages to the queue and one receiver retrieving them one by one from the queue.":::

Queues decouple the source and destination components to insulate destination components from high demand.

During peak times, messages may come in faster than destination components can handle them. Because source components have no direct connection to the destination, the source is unaffected, and the queue will grow. Destination components will remove messages from the queue as they're able to handle them. When demand drops, destination components can catch up and the queue shortens.

A queue responds to high demand without needing to add resources to the system. However, for messages that need to be handled quickly, creating more instances of your destination component can allow them to share the load. Each message is handled by only one instance. This is an effective way to scale your entire application by only adding resources to the components that actually need it.

### What is a topic?

A Service Bus _topic_ is similar to a queue, but a topic can have multiple subscriptions. This means that multiple destination components can subscribe to a specific topic, so each message is delivered to multiple receivers. Subscriptions can also filter the messages in the topic to receive only messages that are relevant. Subscriptions provide the same decoupled communications as queues and respond to high demand in the same way. Use a topic if you want each message to be delivered to more than one destination component.

> [!NOTE]
> Topics are not supported in the Basic pricing tier.

:::image type="content" source="../media/2-service-bus-topic.png" alt-text="Illustration that shows one sender sending messages to multiple receivers through a topic that contains three subscriptions. These subscriptions are used by three receivers to retrieve the relevant messages.":::

## Service Bus queues and storage queues

Two Azure services include message queues: Service Bus and Azure Storage. As a general guide, storage queues are simpler to use, but they're less sophisticated and less flexible than Service Bus queues.

The key advantages of Service Bus queues include:

* Supports larger messages sizes of 256 KB (standard tier) or 100 MB (premium tier) per message versus 64 KB for Azure Storage queue messages.
* Supports both at-most-once and at-least-once delivery. Choose between a very small chance that a message is lost or a very small chance it's handled twice.
* Guarantees _first-in, first-out (FIFO)_ order. Messages are handled in the same order they're added. Although FIFO is the normal operation of a queue, the default FIFO pattern is altered if the organization sets up sequenced or scheduled messages or during interruptions like a system crash. For more information, see [Compare Azure Storage queues and Azure Service Bus queues](/azure/service-bus-messaging/service-bus-azure-and-service-bus-queues-compared-contrasted#additional-information).
* Can group multiple messages in one transaction. If one message in the transaction fails to be delivered, all messages in the transaction aren't delivered.
* Supports role-based security.
* Doesn't require destination components to continuously poll the queue.

Advantages of storage queues:

* Supports unlimited queue size (versus 80-GB limit for Service Bus queues).
* Maintains a log of all messages.

## How to choose a communications technology

You've seen the different concepts and the implementations Azure provides. Next, consider what your decision process should look like for each of your communications.

### Considerations

As you choose a method for sending and receiving messages, consider the following questions:

* Is the communication an event? If so, consider using Event Grid or Event Hubs.

* Should a single message be delivered to more than one destination? If so, use a Service Bus topic. Otherwise, use a Service Bus queue.

### Queues: Service Bus vs. storage

If you decide that you need a queue, narrow down your choice further.

Choose a _Service Bus_ queue if:

* You need an at-most-once delivery guarantee.
* You need a FIFO guarantee (if no other settings preempt the default FIFO order)
* You need to group messages into transactions.
* You want to receive messages without polling the queue.
* You need to provide role-based access to the queues.
* You need to handle messages larger than 64 KB but smaller than 256 KB for the standard tier or 100 MB for the premium tier.
* Your queue size won't grow larger than 80 GB.
* You'd like to be able to publish and consume batches of messages.

Choose a _storage_ queue if:

* You need a simple queue with no particular extra requirements.
* You need an audit trail of all messages that pass through the queue.
* You expect the queue to exceed 80 GB in size.
* You want to track progress for processing a message inside the queue.

Although the components of a distributed application can communicate directly, you often can increase the reliability of that communication by using an intermediate communication platform like Azure Event Hubs or Azure Event Grid.

Event Hubs and Event Grid are designed for events, which notify recipients only of an event and don't contain the raw data associated with that event. Azure Event Hubs is designed for high-flow, analytics types of events.

Azure Service Bus and storage queues are for messages, which can be used for binding the core pieces of any application workflow.

If your requirements are simple, if you want to send each message to only one destination, or if you want to write code as quickly as possible, a storage queue may be the best option. Otherwise, Service Bus queues provide many more options and flexibility.

If you want to send messages to multiple subscribers, use a Service Bus topic.
