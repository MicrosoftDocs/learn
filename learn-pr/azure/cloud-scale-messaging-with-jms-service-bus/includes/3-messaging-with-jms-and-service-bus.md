While your Azure Service Bus namespace is being created, let's have a look at what Java Message Service (JMS) 2.0 is.

## What is Java Message Service (JMS)?

Java Message service (JMS) is an application programming interface which acts as a messaging pseudo-standard for Java and Spring application deployments. It allows applications to perform the below operations:

   * Management operations - Create, Read, Update and Delete Queues, Topics and Subscriptions.
   * Data operations - Create, send, read, and receive/delete messages.

JMS API enables applications to interface with enterprise messaging brokers (much like Azure Service Bus) in an asynchronous manner.

## Azure Service Bus with JMS and Spring Boot

Let's focus on utilizing the super popular Java Messaging Service (JMS) 2.0 API to communicate with Azure Service Bus.

Using Spring Boot, typically with [Spring Initializr](https://start.spring.io/), you will have three main tasks to achieve:

   * Add Azure Service Bus dependencies to your application.
   * Send messages to an Azure Service Bus queue.
   * Receive messages from the Azure Service Bus queue.

This setup will utilize 2 Spring Boot applications - one sender, and one receiver.
