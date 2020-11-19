Imagine you're a Java developer working for a company that creates Spring Boot applications that currently run on on-premises servers. Your application also integrates to a relational database (in this case MySQL). You want to build a todo list application that uses a MySQL database, and you've decided to build this Spring Boot application from scratch.

In this module, you'll first scaffold a Spring Boot web application using the Spring Initializr. The Spring Initializr is an online tool that generates spring boot project with just what you need to start quickly This scaffold gives us a base to work from. We'll then code a Todo application that stores tasks in a relational database. The tasks will need a MySQL database so we'll create and host using Azure Database for MySQL.

Next we will build the application and also configure it to connect to the MySQL database. Before we deploy, you'll confirm the application can run locally. You'll then deploy via Maven and host it on Azure App Service.

By the end of this module, you'll be able to incorporate Spring Boot applications to Azure App Service and integrate with a relational database.

You'll use your own Azure subscription to deploy the resources in this module. If you don't have an Azure subscription, create a [free account](https://azure.microsoft.com/free/java/?azure-portal=true&WT.mc_id=java-10785-ropreddy) before you begin.
> [!IMPORTANT]
> To avoid unnecessary charges in your Azure subscription, remember to de-provision your Azure resources when you're done with this module.

## Learning objectives

By the end of this module, you will be able to:

- Develop a Spring Boot Web application
- Connect your application to a MySQL database
- Deploy the web application to Azure App Service

## Prerequisites

As a Java developer, you're already familiar with Spring applications. As you complete the exercises in this module, you'll use a personal Azure account, you would need to make sure that you have the following items installed:
>  
- An Azure Subscription
- Local installations of Java JDK (1.8+), Maven (3.0+), and the Azure CLI (2.12+)
>