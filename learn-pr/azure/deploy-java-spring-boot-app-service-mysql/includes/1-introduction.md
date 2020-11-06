Imagine you're a Java developer working for a company that creates Spring Boot apps that currently run on on-premises servers. Your app also integrates to a relational database (in this case MySQL). You want to build a todo list app that uses a MySQL database, and you've decided to build this Spring Boot app from scratch.

In this module, you'll first scaffold a Spring Boot web app using the Spring Initializr. This scaffold gives us a base to work from. We'll then code a Todo Application that stores tasks in a relational database. The tasks will need a MySQL database so we'll create and host using Azure Database for MySQL.

Next we will build the App and also configure it to connect to the MySQL database. Before we deploy, you'll confirm the app can run locally. You'll then deploy via Maven and host it as an Azure App Service.

By the end of this module, you'll be able to incorporate Spring Boot apps to Azure App Service and integrate with a relational database.

You'll use your own Azure subscription to deploy the resources in this module. If you don't have an Azure subscription, create a [free account](https://azure.microsoft.com/free/java/?azure-portal=true) before you begin.
> [!IMPORTANT]
> To avoid unnecessary charges in your Azure subscription, remember to de-provision your Azure resources when you're done with this module.

## Learning objectives

By the end of this module, you will be able to:

- Develop a Spring Boot Web App
- Connect your App to a MySQL database
- Deploy the web app to Azure App services

## Prerequisites

As a Java developer, you're already familiar with Spring applications. As you complete the exercises in this module, you'll use a personal Azure account, you would need to make sure that you have the following items installed:
>  
- An Azure Subscription
- Local installations of Java JDK (1.8+), Maven (3.0+), and the Azure CLI (2.12+)
>