Many applications consist of programs that run on several different computers or devices. In such distributed applications, messages must be sent between the components across networks and long distances. Even on the same server or in the same data center, loosely coupled architectures require mechanisms for components to communicate. Reliable messaging is often a critical problem.

Suppose you work at a software company that develops a music-sharing application. Musicians can upload music they create to your platform by using a web front end or a mobile app. They can listen to and comment on other members' work. The application consists of the following components:

- A website that runs at your internet service provider (ISP)
- A mobile app that runs on users' mobile devices
- A Web API that runs in Azure
- An Azure SQL Database for data storage.

You observed that at times of high demand, some music files aren't successfully uploaded, and some comments aren't posted. Your testing shows that dropped messages between front-end components and the web API cause these issues. You plan to solve these issues by using one or more of the following technologies: Azure Storage queues, Azure Event Hubs, Azure Event Grid, and Azure Service Bus.

Here, you learn how to choose the right messaging technology in Azure for each communication task in a distributed application.

## Learning objectives

In this module, you will:

- Describe events and messages, and the challenges you can use them to solve in a distributed application.
- Identify scenarios in which Storage queue is the best messaging technology for an application.
- Identify scenarios in which Event Grid is the best messaging technology for an application.
- Identify scenarios in which Event Hubs is the best messaging technology for an application.
- Identify scenarios in which Service Bus is the best messaging technology for an application.
