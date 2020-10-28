Imagine you're a Java developer working for a company that creates Spring Boot apps that currently run on on-premises servers. Your app also integrates to a relational database (in this case MySQL). You want to build a todo list app that uses a MySQL database, and you've decided to build this Spring Boot app from scratch.

In this module, you will first create a Spring Boot web app using the [Spring Initializr](https://start.spring.io). This gives us a base to work from. We will then code a Todo Application that stores tasks in a relational database. The tasks will need a MySQL database so we will create and host using Azure Database for MySQL.
Next we will build the App and also configure it to connect to the MySQL database. Before we deploy, we will need confirm the app can run locally. You'll then deploy via Maven and host it as an Azure App Service.

By the end of this module, you'll learn to incorporate Spring Boot apps to Azure App Service and integrate with a relational database.

## Learning objectives

By the end of this module, you will be able to:

- Develop a Spring Boot Web App
- Connect your App to a MySQL database
- Deploy the web app to Azure App services

## Prerequisites

- An Azure Subscription
- Local installations of Java JDK, Maven and the Azure CLI
- Basic familiarity with relational databases and using JPA for persistence
- Experience writing Spring Apps in Java
- Basic familiarity with Spring Boot App Lifecycle
- Experience writing Applications for Azure App Service
- Basic familiarity with build tools including Maven workflows
