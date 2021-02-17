While your Azure Service Bus namespace is being created, let's have a look at what Azure Service Bus is and what it's recommended use cases are. We will also look at what Java Message Service (JMS) 2.0 is.

## What is Azure Service Bus?

Microsoft Azure Service Bus is a fully managed enterprise message broker providing point-to-point semantics with message queues and publish-subscribe semantics with topics.

Azure Service Bus is used to decouple applications and services from each other, providing the following benefits:

  * Load-balancing work across competing workers
  * Safely routing and transferring data and control across service and application boundaries
  * Coordinating transactional work that requires a high-degree of reliability

## Messaging scenarios

Some common messaging scenarios are:

   * *Messaging* Transfer business data, such as sales or purchase orders, journals, or inventory movements.
   * *Decouple applications*. Improve reliability and scalability of applications and services. Producer and consumer don't have to be online or readily available at the same time. The load is leveled such that traffic spikes don't overtax a service.
   * *Load Balancing*. Allow for multiple competing consumers to read from a queue at the same time, each safely obtaining exclusive ownership to specific messages.
   * *Topics and subscriptions*. Enable 1:n relationships between publishers and subscribers, allowing subscribers to select particular messages from a published message stream.
   * *Transactions*. Allows you to do several operations, all in the scope of an atomic transaction.
   * *Message sessions*. Implement high-scale coordination of workflows and multiplexed transfers that require strict message ordering or message deferral.

If you're familiar with other message brokers like **Apache ActiveMQ**,**Rabbit MQ**, and **IBM MQ**, Service Bus concepts are similar to what you know.

## What is Java Message Service (JMS)?

Java Message service (JMS) is an application programming interface which acts as a messaging pseudo-standard for Java and Spring application deployments. It allows applications based on the Java Enterprise Edition to perform the below operations:

   * Management operations - Create, Read, Update and Delete Queues, Topics and Subscriptions.
   * Data operations - Create, send, read, and receive/delete messages.

JMS API enables applications to interface with enterprise messaging brokers (much like Azure Service Bus) in an asynchronous manner.

## Use Azure Service Bus in Java

For Java developers, Azure Service Bus offers multiple ways to perform management and data plane operations -

   * Native SDKs - Java developers can leverage the native Azure Service Bus Java SDKs
      * [azure-servicebus](https://mvnrepository.com/artifact/com.microsoft.azure/azure-servicebus)
      * [azure-messaging-servicebus](https://mvnrepository.com/artifact/com.azure/azure-messaging-servicebus)
   * [Java Messaging Service (JMS) API](https://mvnrepository.com/artifact/com.microsoft.azure/azure-servicebus-jms) - Java developers can utilize the Azure Service Bus JMS maven library.

## Azure Service Bus with JMS and Spring Boot

Let's focus on utilizing the super popular Java Messaging Service (JMS) 2.0 API to communicate with Azure Service Bus.

Using Spring Boot, typically with [Spring Initializr](https://start.spring.io/), you will have three main tasks to achieve:

   * Add Azure Service Bus dependencies to your application.
   * Send messages to an Azure Service Bus queue.
   * Receive messages from the Azure Service Bus queue.

This setup will utilize 2 Spring Boot applications - one sender, and one receiver.

