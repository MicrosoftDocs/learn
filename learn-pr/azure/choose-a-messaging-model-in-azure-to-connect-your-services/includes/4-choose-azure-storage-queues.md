## Motivation

Suppose you are planning the architecture for your music-sharing application. You want to choose ensure that music files are uploaded to the web API reliably from the mobile app.

Having understood that this communication should be a message, you must choose whether to use Azure Storage queues or Service Bus, both of which can be used to store queues of messages as they await processing.

## Delivery Guarantees

Queuing systems usually guarantee delivery of each message in the queue to a destination component. However, these guarantees can take different approaches:

- **At-Least-Once Delivery.** In this approach, each message is guaranteed to be delivered to at least one of the components that retrieve messages from the queue. Note, however, that in certain circumstances, it is possible that the same message may be delivered more than once. For example, if there are two instances of a web app retrieving messages from a queue, ordinarily each message goes to only one of those instances. However, if one instance takes a long time to process the message, and a time-out expires, the message may be sent to the other instance as well. Your web app code should be designed with this possibility in mind.
- **At-Most-Once Delivery.** In this approach, each message is not guaranteed to be delivered and there is a very small chance that it may not arrive. However, there is no chance that the message will be delivered twice as with At-Least-Once delivery.
- **First-In-First-Out (FIFO).** Usually, messages leave the queue in the same order in which they were added but you should consider whether this order is guaranteed. If messages in the wrong order may result in an error or other problems, you must choose a queue system that includes a FIFO guarantee.

## Transactions

Some closely related groups of messages may cause problems when delivery fails for one message in the group.

For example, consider an e-commerce application. When the user clicks the "Buy" button, a message with the order details is sent along with a message with the credit card details. If the credit card message is not delivered, the order may be dispatched without payment.

You can avoid these kinds of problems by grouping the two messages into a transaction. Transactions succeed or fail as a single unit. If the credit card details message delivery fails then so will the order details message.

## When to use Storage queues

Queues are used for messages but not events.

Azure Storage Accounts include queues, which can be used by distributed applications as simple temporary storage locations for messages. A source component can add a message to the queue. Destination components retrieve the message at the front of the queue for processing. Such queues increase the reliability of the message exchange because, at times of high demand, messages can simply wait until a destination component is ready to process them.

However, Azure also provides queues in Service Bus namespaces. If you have decided to use a queue in Azure for a specific communication, you must decide whether to use a Storage queue or a Service Bus queue.

To make this choice, consider the following questions:

- Do you need an At-Most-Once delivery guarantee?
- Do you need a FIFO guarantee?
- Do you need to group messages into transactions?
- Do you need to store messages larger than 64KB?

If the answer to any of these questions is yes, you must choose to use a Service Bus queue.

In addition consider:

- Do you need server-side logs of all messages that pass through the queue?
- Do you expect the queue to exceed 80GB in size?

If the answer to any of these questions is yes, you must choose to use a Storage queue.

## Summary

A queue is a simple temporary storage location for messages sent between the components of a distributed application. Use a queue to organize message and gracefully handle unpredictable surges in demand.

Use Azure Storage queues when you want a simple and easy-to-code queue system. For more advanced needs, use Azure Service Bus queues.