In this unit, you'll learn how to create a Spring App, connect to a MySQL database, and run locally.

## Introduction to Azure App Service

Azure App Service provides flexible hosting solutions for Spring Applications.
The Azure App Service allows you to host your company's websites, web apps, REST APIs, and other application code on Azure. Your project code is running in the cloud; you don't have to provision or configure any infrastructure. Running your web app in Azure App Service provides you with all the benefits of running on Azure: your app is globally available, it scales automatically, has security and compliance built-in, and you only pay for the resources you use.
In our App you will build, you are looking at creating an application that hosts its logic in Azure App Services and its Database in an Azure MySQL Database.

## Develop your Spring app

Spring is the perfect framework to host and manage our applications. All we have to do is wire certain Spring components and without managing the underlying Server runtime.
You have decided to use Spring Boot, which is self-hosted and provides a rich ecosystem of backing services for your app.

The Spring injection annotations use Dependency injection to process the Components requests and utilizes the Azure Spring Starter integration libraries to configure and setup connections to the Backing services that are our MySQL database.

## Create your resources using the Azure CLI and Maven

### Azure CLI

Azure CLI is a command-line interface used to create and manage Azure resources.
It runs on Linux, macOS, and Windows and allows administrators and developers to execute their commands through a terminal or command-line prompt (or script!) instead of a web browser. For example, to get the details of a subscription, you would use a command like the following:

```bash
az account show
```

In this module, you use the Azure CLI to spin up the Azure App Service and Azure Database for MySQL instance. You can access the Azure CLI from a terminal or through Visual Studio Code. You can also access the Azure CLI from Azure Cloud Shell. This browser-based shell experience is hosted in the cloud. In Cloud Shell, the Azure CLI is configured for use with your Azure subscription.

### Maven

We'll use the Maven package manager to structure our project and pull in dependencies. Maven also provides the tooling necessary to configure and deploy our project to the Azure App services with the Azure WebApp Plugin.

### Azure Database for MySQL

Whether you're building new applications that target MySQL or migrating legacy applications, Azure Database for MySQL provides the enterprise-ready solution needed for modern applications. To learn more, see [Azure Database for MySQL](https://azure.microsoft.com/services/mysql/?azure-portal=true).
