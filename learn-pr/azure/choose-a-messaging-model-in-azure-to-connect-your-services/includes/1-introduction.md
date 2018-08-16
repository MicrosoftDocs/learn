## Motivation

Many applications consist of programs that run on several different computers or devices. In such distributed applications, messages must be sent between the components across networks and long distances. Reliable messaging is often a critical problem.

Suppose you work at a software company that develops a music-sharing application. Musicians can upload music they create to your platform by using a web-front end or a mobile app. They can listen to and comment on other members' work. The application consists of a web site that runs at your ISP, a mobile app that runs on users' mobile devices, a web API that runs in Azure, and an Azure SQL Database where data is stored.

You have observed that, at times of high demand, some music files are not successfully uploaded and some comments are not successfully posted. Users have raised these issues with your support desk. Your testing has shown that these issues are caused by dropped messages between front-end components and the web API. You plan to solve these issues by using one or more of the following Azure technologies: Storage queues, Event Hubs, Event Grids, and Service Bus.

Here, you will learn how to choose the right messaging technology in Azure for each communication task in a distributed application.

## Learning Objectives

- Describe events and messages and the challenges you can use them to solve in a distributed application.
- Identify scenarios in which an Azure Storage queue is the best messaging technology for an application.
- Identify scenarios in which an Azure Event Grid is the best messaging technology for an application.
- Identify scenarios in which an Azure Event Hub is the best messaging technology for an application.
- Identify scenarios in which Azure Service Bus is the best messaging technology for an application.

## Prerequisites

- An understanding of distributed applications and their typical architectures
- Some experience with PowerShell scripts
- Knowledge of messaging formats including JSON
- Experience writing web applications
