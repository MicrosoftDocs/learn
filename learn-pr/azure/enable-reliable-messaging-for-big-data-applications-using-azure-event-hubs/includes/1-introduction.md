## Motivation

Suppose you work at a bank that issues credit cards. The system receives a stream of transactions and needs to process them in real time. Your component is responsible for fraud testing to determine whether to approve or decline each transaction.

The load on your system can spike during weekends and holidays. If transactions arrive more quickly than you can process them, you might allow bad transactions to proceed which costs the bank money and inconveniences customers.

Scenarios like this are common in big data applications.
The banking system would need to handle thousands of transactions per second. An application that worked with sensor data might need to process millions of transactions per second.

Azure Event Hubs helps solve this problem by decoupling the message sender from the message receiver. Messages are stored by Event Hubs until processing resources are available. Event Hubs can handle workloads on the level needed by big data applications. You can even configure your hub to scale dynamically which gives you performance when you need it while still managing costs.

Here, you will see how to use Event Hubs to connect sending and receiving applications, and to reliably process potentially millions of data messages per second. You'll set up and test an Event Hub that connects an application that collects customer's credit card data, with an application that verifies the validity of that credit card. You'll be using a small dataset for this evaluation.

## Learning objectives

- Create an Event Hub using the Azure CLI
- Configure applications to send or receive messages through an Event Hub
- Evaluate Event Hub performance using the Azure Portal

## Prerequisites

- Experience creating and managing resources using the Azure Portal.
- Experience with using Azure CLI 2.0 to sign into Azure, and to create resources.
- Knowledge of basic big data concepts such as streaming and event processing.
