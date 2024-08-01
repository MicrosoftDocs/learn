While your Azure Service Bus namespace is being created, let's have a look at what Java Message Service (JMS) 2.0 is.

## What is Java Message Service?

JMS is an application programming interface that acts as a messaging pseudo-standard for Java and Spring application deployments. It allows applications to perform the following operations:

* **Management operations**: Create, read, update, and delete queues, topics, and subscriptions.
* **Data operations**: Create, send, read, and receive and delete messages.

JMS API enables applications to interface with enterprise messaging brokers, much like Service Bus, in an asynchronous manner.

## Service Bus with JMS and Spring Boot

Let's focus on utilizing the super-popular JMS 2.0 API to communicate with Service Bus.

Using Spring Boot, typically with [Spring Initializr](https://start.spring.io/), you have three main tasks to achieve:

* Add Service Bus dependencies to your application.
* Send messages to a Service Bus queue.
* Receive messages from the Service Bus queue.

This setup uses two Spring Boot applications: one sender and one receiver.
