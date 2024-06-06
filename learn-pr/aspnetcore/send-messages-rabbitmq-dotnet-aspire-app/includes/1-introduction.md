When you create a cloud-native application, you build a set of microservices, each of which implements a small part of your complete functionality and can be managed and scaled independently. Microservices must communicate reliably with each other regardless of the load on the application. Message queues can help with this communication. By maintaining an ordered queue of messages, queuing services such as RabbitMQ ensure that communications are more reliable and robust.

Imagine that you work for an outdoor clothing retailer. Your new public-facing ecommerce site, which consists of microservices and uses .NET Aspire, must scale to cope with intense user demand at peak periods. You want to ensure that the separate microservices can communicate robustly and you want to assess RabbitMQ as a solution for queue management.

In this module, you see how to use built-in components to send and receive messages through the RabbitMQ message queuing service.

## Learning objectives

By the end of this module, you'll be able to:

- Select from the work queues, topics, subscriptions, and routes available on a RabbitMQ server to send messages to the intended recipient microservices.
- Add messages to a queue on a RabbitMQ exchange server by using the .NET Aspire RabbitMQ client message broker.
