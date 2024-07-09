In any cloud-native app, microservices must communicate in order to obtain all the information they need to respond to users. You should make sure that this messaging is robust even when there are network issues or failures between the components. RabbitMQ is one tool you can use to increase the reliability of messaging.

In your outdoor equipment retailer, you're making rapid progress with your microservices. However, in application testing some calls from one microservice to another seem to be lost. You'd like to ensure this problem doesn't arise in your production environment where your company's reputation is at stake.

In this unit, you'll see how RabbitMQ can create a flexible and resilient communication platform for microservices.

## Why use a message broker in a cloud-native app?

Cloud-native apps consist of independent microservices, often built by separate teams and using different technologies and languages. Each team has its own development sprints and upgrade schedules and may deploy fixes and new features continuously. However, when a request arrives from a user, the microservice that receives it almost always needs to call other microservices and backing services and receive replies from them to formulate the complete response.

Obviously the format and schema of these inter-service requests and responses must be agreed between the development teams and change rarely. They're usually implemented as REST APIs. You should preferentially implement new features of each interface without altering existing methods and parameters. However, if you choose to have microservices communicate directly, several issues can arise:

- When a destination microservice is offline or busy, what happens to messages sent to it? What are the consequences of messages being lost?
- How can you send the same message to more than one destination?
- If a microservice is running on more than one container, which should you send messages to?

A message broker is middleware that addresses these issues. Services send messages to the message broker instead of directly to a destination. The broker stores them in queues in the order in which they arrive. Destination services subscribe to these queues and pick up messages, one at a time, for processing.

If the destination service is unavailable, the sending microservice can still place messages in the queue. When the destination restarts, it continues to pick up messages from the queue, from the same point. No messages are lost, although the sender has to wait for longer.

Because more than one destination can subscribe to a queue, a single message can be received by more than one microservice. Furthermore, when multiple containers host instances of a single microservice, the first instance that becomes available picks up the message. The broker automatically distributes messages to instances to spread the load.

## What is RabbitMQ?

RabbitMQ is one of the most popular message brokers and has many features that make it an ideal candidate to handle communications in a cloud-native app. It includes:

- The RabbitMQ server, which hosts the queues. The server supports clustering and failover for high availability and can run in containers.
- Implementations of Advanced Message Queuing Protocol (AMQP), Simple Text Oriented Message Protocol (STOMP), and Message Queuing Telemetry Transport (MQTT).
- AMQP client libraries that you can use in .NET, Java, and Erlang.

### RabbitMQ concepts

In RabbitMQ terms, your microservices, which send and receive messages, are **clients**. Clients that send messages are termed **message producers**. Clients that receive messages are **message consumers**. The RabbitMQ service is the **message broker**.

## How to send messages

RabbitMQ is versatile and capable of implementing many different queuing models. Let's examine some popular patterns.

If you have a single producer and a single consumer, you use a single queue and all messages reach the same destination. Even in this simple configuration, you build a robust messaging system that handles outages smoothly:

:::image type="content" source="../media/simple-queue.png" alt-text="Diagram showing a single RabbitMQ queue with a single producer and a single consumer.":::

### Sending messages to competing consumers

In the competing consumers model, a producer sends messages to a single work queue. Two or more consumers retrieve messages from the queue. The consumers compete to retrieve messages because each message can only be retrieved by a single consumer.

:::image type="content" source="../media/competing-consumers.png" alt-text="Diagram showing a single RabbitMQ queue with a single producer and two competing consumers.":::

This pattern is useful in cloud-native apps when you have a consuming microservice hosted on multiple containers to boost capacity. Each message will only reach one instance of the consumer, so will be processed only once. Work will not be duplicated.

### Publishing and subscribing

If you want to send a single message from a producer to multiple consumers, use the **publish/subscribe** model. The producer sends messages to an **exchange**. Each consumer subscribes to messages from that exchange. When they subscribe, RabbitMQ creates a new work queue for that subscription. Each message is copied to every queue for that exchange and is received by every consumer that has subscribed. Consumers don't compete for each message. Instead they all receive a copy of every message.

The publish/subscribe model uses a **fanout** exchange, which copies every message to every work queue.

:::image type="content" source="../media/publish-subscribe.png" alt-text="Diagram showing a publish subscribe model with a single producer, a fanout exchange, and two consumers.":::

This pattern is useful when you want each message to be processed by multiple microservices. For example, when a customer checks out a basket, you might want to send a message about the number of each product that they bought. This message should reach both the shipping microservice, to instruct the warehouse to pack the parcel, and the stock microservice, to decrement stock numbers and perhaps trigger orders to suppliers.

### Routing messages and topics

Sometimes you want to distribute single messages to multiple consumers but, for each consumer, apply a filter. This pattern is called a **message router**. As in the publish/subscribe model, consumers subscribe to the exchange to create multiple work queues. However, instead of a fanout exchange, the model uses a **direct** exchange. With this exchange, each subscription has a binding key. Only messages whose routing key matches the binding key are sent to this subscription. Others are filtered out.

:::image type="content" source="../media/routing-messages.png" alt-text="Diagram showing message routing model with a single producer, a direct exchange, and two consumers.":::

This pattern is useful when some consumers should only process a subset of the message stream. For example, suppose you have a microservice that sends messages when errors occur. All errors should be sent to the logging microservice. Critical errors should be sent to the administration microservice that will alert engineers to fix the problem.

The direct exchange routes messages based on a single criteria. To make things even more flexible, you can use a **topic** exchange. For each message, you can use a routing key with multiple terms separated by dots. In the binding key, you can use the wild cards **\***, to substitute for exactly one word, or **#** to substitute for zero or more words.

> [!NOTE]
> Alternatives to RabbitMQ include Apache Kafka and Azure Service Bus. Both these message brokers are supported by dedicated components in .NET Aspire. You'll learn about Azure Service Bus in a later module in this Learning Path.

## Learn more

- [RabbitMQ Tutorials](https://www.rabbitmq.com/tutorials)
- [.NET Aspire RabbitMQ component](/dotnet/aspire/messaging/rabbitmq-client-component)
- [.NET Aspire Apache Kafka component](/dotnet/aspire/messaging/kafka-component)
