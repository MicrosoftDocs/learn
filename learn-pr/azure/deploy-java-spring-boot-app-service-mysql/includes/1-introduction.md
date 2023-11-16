Imagine you're a Java developer working for a company that creates Spring Boot applications. The applications currently run on on-premises servers. Your applications also integrate with a relational database (in this case, MySQL). 

You want to build a to-do list application that uses a MySQL database. You've decided to build this Spring Boot application from scratch.

In this module, you'll first scaffold a Spring Boot web application by using Spring Initializr. Spring Initializr is an online tool that generates a Spring Boot project that includes just what you need to start quickly. This scaffold gives you a base to work from. 

You'll then code a to-do application that stores tasks in a relational database. The tasks will need a MySQL database, so you'll create and host by using Azure Database for MySQL.

Next, you'll build the application and also configure it to connect to the MySQL database. Before you deploy, you'll confirm the application can run locally. You'll then deploy through Maven and host on Azure App Service.

By the end of this module, you'll be able to incorporate Spring Boot applications into Azure App Service and integrate with a relational database.

You'll use your own Azure subscription to deploy the resources in this module. If you don't have an Azure subscription, create a [free account](https://azure.microsoft.com/free/java/?azure-portal=true&WT.mc_id=java-10785-ropreddy) before you begin.
> [!IMPORTANT]
> To avoid unnecessary charges in your Azure subscription, remember to deprovision your Azure resources when you finish this module.

## Learning objectives

By the end of this module, you'll be able to:

- Develop a Spring Boot web application.
- Connect your application to a MySQL database.
- Deploy the web application to Azure App Service.

## Prerequisites

As a Java developer, you're already familiar with Spring applications. As you complete the exercises in this module, you'll use a personal Azure account. Make sure that you have the following resources:

- An Azure subscription
- Local installations of Java JDK (1.8 or later), Maven (3.0 or later), and the Azure CLI (2.12 or later)
