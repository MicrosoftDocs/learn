Suppose you're a Java developer working for a company that creates Quarkus applications. The applications currently run on on-premises servers. They also integrate with a relational database (in this case, PostgreSQL).

You want to create a to-do list application that uses a PostgreSQL database. You decide to create this Quarkus application from scratch.

In this module, you first scaffold a Quarkus web application by using the Quarkus Maven plugin. The Quarkus Maven plugin generates a Quarkus project that includes just what you need to start quickly. This scaffold gives you a base to work from.

You then code a to-do application that stores tasks in a relational database. The tasks are stored in a PostgreSQL database, so you need create an Azure Database for PostgreSQL database.

Next, you build the application and configure it to connect to the PostgreSQL database. Before you deploy it to Azure, you need to confirm that the application can run locally. You then deploy it by using Azure CLI and host it on Azure Container Apps.

By the end of this module, you'll be able to incorporate Quarkus applications into Container Apps and integrate them with a relational database.

You'll use your own Azure subscription to deploy the resources in this module. If you don't have an Azure subscription, create a [free account](https://azure.microsoft.com/free/java/?azure-portal=true) before you begin.
> [!IMPORTANT]
> To avoid unnecessary charges in your Azure subscription, remember to deprovision your Azure resources when you finish this module.

## Learning objectives

By the end of this module, you'll be able to:

- Develop a Quarkus application.
- Connect your application to a PostgreSQL database.
- Deploy the application to Container Apps.

## Prerequisites

You should be familiar with Java applications. Quarkus is explained as you follow along. As you complete the exercises in this module, you'll use a personal Azure account. Make sure that you have the following resources:
  
- An Azure subscription
- Local installations of Java JDK (17 or later), Maven (3.1), and the Azure CLI (2.57 or later)
- Docker and Docker Desktop
