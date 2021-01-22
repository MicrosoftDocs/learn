Imagine you are a Java developer working with a bunch of Spring Boot applications that enable various customer online and offline scenarios. Your application is backed by a persistent storage layer and exposes a REST API that powers a Web UI. You want to extend this application to build better customer engagement at scale.

In this module, you'll utilize a Spring Boot microservices sample, the [Spring Petclinic microservices](https://github.com/Azure-Samples/spring-petclinic-microservices), and extend it to better engage with your customers through email.

The goal will be achieved by hosting another microservice (aptly called the communication service), that will send emails to the customer to better engage with the customer.

We will decouple the communication microservice from the existing microservices using a queue and topic-subscription, so we will use [Azure Service Bus](https://azure.microsoft.com/services/service-bus/), Azure's cloud messaging service with enterprise messaging features. 

The microservices will connect to Azure Service Bus using the popular Java Message Service (JMS) API and we will try out the send, receive and browse functionality that JMS provides.

By the end of this module, you'll be able to connect your Spring Boot applications and microservices to communicate with Azure Service Bus over the Java Message Service (JMS) 2.0 API.

You'll use your own Azure subscription to deploy the resources in this module. If you don't have an Azure subscription, create a [free account](https://azure.microsoft.com/free/java/?azure-portal=true&WT.mc_id=java-10785-ropreddy) before you begin.
> [!IMPORTANT]
> To avoid unnecessary charges in your Azure subscription, remember to de-provision your Azure resources when you're done with this module.

## Learning objectives

By the end of this module, you will be able to:

- Connect a Spring Boot Web application/microservice to Azure Service Bus over JMS 2.0
- Send messages to an Azure Service Bus queues.
- Send messages to an Azure Service Bus topics.
- Receive messages from Azure Service Bus queues.
- Receive messages from Azure Service Bus subscriptions.
- Browse messages on an Azure Service Bus queue.

## Prerequisites

As a Java developer, you're already familiar with Spring applications. As you complete the exercises in this module, you'll use a personal Azure account, you would need to make sure that you have the following items installed:
>  
- An Azure Subscription
- Local installations of Java JDK (1.8+), Maven (3.0+), and the Azure CLI (2.12+)
>