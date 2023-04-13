---
interactive:bash
zone_pivot_groups:azure-interface
title:Introduction
---
At this point, you've deployed the Spring Petclinic application and the services are running. However, a few of your microservices need to send messages to a third party system using a message bus. Additionally, you want to enable the intake of telemetry events.

To provide a solution using native Azure services, you'll be utilizing Azure Service Bus and Azure Event Hubs.

In this module, you'll be using Azure Service Bus to test an existing microservice and update another microservice to utilize queues.

## Learning objectives

After completing this module, you'll be able to:

 -  Create an Azure Service Bus.
 -  Test run an existing microservice using Azure Service Bus.
 -  Update an existing microservice to use the queues.
 -  Add a message producer.

## Prerequisites

 -  Intermediate-level familiarity with and local installations of the following tools: Git, Java JDK 8 or later, and a Java IDE or text editor.
 -  Basic Git commands, including cloning, committing files, and pushing changes to GitHub.
 -  Intermediate-level familiarity with Azure.

> [!NOTE]
> The instructions provided in this exercise assume that you've successfully completed the previous exercises and are using the same lab environment, including your Git Bash session with the relevant environment variables already set.

To download the instructions for this module, see [Deploying and Running Java apps in Azure Spring Apps](https://github.com/MicrosoftLearning/Deploying-and-Running-Java-Applications-in-Azure-Spring-Apps) in GitHub.
