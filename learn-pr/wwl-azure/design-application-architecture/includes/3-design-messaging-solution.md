In this unit, you’ll learn how to choose the best architecture for a message-based delivery system. Let’s imagine you’re planning the music-sharing application. You want to: 

- Ensure that music files are uploaded to the web API reliably from the mobile app. 

- Deliver the details about new songs directly to the app. For example, when an artist adds new music to their collection. 

This scenario is a perfect use of a message-based system. Azure offers two message-based solutions Queue Storage and Azure Service Bus (queues and topics).

## What is Azure Queue Storage?

[Azure Queue storage](/azure/storage/queues/storage-queues-introduction) is a service that uses Azure Storage to store large numbers of messages. These messages can be securely accessed from anywhere in the world using a simple REST-based interface. Queues can contain millions of messages. Azure Queue storage is limited only by the capacity of the storage account that owns it. Queues generally provide increased reliability, guaranteed message delivery, and transactional support.

:::image type="content" source="../media/queue-storage.png" alt-text="A storage account has two message queues.":::


## What is Azure Service Bus?

Microsoft Azure Service Bus is a fully managed enterprise message broker with message queues and publish-subscribe topics. Service Bus is used to decouple applications and services from each other, providing the following benefits:

- Load-balancing work across competing workers.

- Safely routing and transferring data and control across service and application boundaries.

- Coordinating transactional work that requires a high degree of reliability.

### What are Azure Service Bus Queues?

[Azure Service Bus queues](/azure/service-bus-messaging/service-bus-queues-topics-subscriptions) is is a message broker system built on top of a dedicated messaging infrastructure. Like Azure queues, Service Bus holds messages until the target is ready to receive them. 

:::image type="content" source="../media/service-bus-queue.png" alt-text="A graphic depicts a sender and receiver communicating through a Message Queue.":::


Azure Service Bus is intended for enterprise applications. For example, an application that uses communication protocols and different data contracts. 

### What is an Azure Service Bus publish-subscribe topic?

[Azure Service Bus topics](/azure/service-bus-messaging/service-bus-queues-topics-subscriptions) are like queues but can have multiple subscribers. When a message is sent to a topic, multiple components can be triggered to perform a task. 

:::image type="content" source="../media/service-bus-topic.png" alt-text="A graphic depicts a sender and multiple receivers communicating through subscriptions.":::


For example, suppose a user is listening to a song using a music-sharing application. The mobile app might send a message to the *Listened* topic. That topic could have a subscription for *UpdateUserListenHistory*, and a different subscription for *UpdateArtistsFanList*. Each subscription receives its own copy of the message.

## Which messaging service should I choose?

Each messaging product has a slightly different feature set. This which means you can choose one or the other or use both. It depends on the problem you’re solving.

Use Azure Queue storage if you need/have:

- A simple queue to organize messages.

- An audit trail of all messages that pass through the queue.

- Queue to exceed 80 GB in size.

- To track progress for processing a message inside of the queue.

Use Azure Service Bus queues if you need/have:

- An At-Most-Once delivery guarantee.

- At-Least-Once message processing  (PeekLock receive mode)

- At-Most-Once message processing (ReceiveAndDelete receive mode)

- To group messages into transactions.

- To receive messages without polling the queue.

- To handle messages larger than 64 KB but less than 256 KB.

- Queue size will not grow larger than 80 GB..

- To publish and consume batches of messages.

Use Azure Service Bus topics if you need/have:

- Multiple receivers to handle each message.

- Multiple destinations for a single message but need queue-like behavior.