In this unit, you'll learn how to create a Spring application, connect it to a MySQL database, and run everything locally.

## Introduction to Azure App Service

Azure App Service allows you to host your company's websites, web applications, REST APIs, and other application code on Azure.  Running your web application in Azure App Service provides you with all the benefits of running on Azure: your application is available, it scales, and it has built-in security and compliance.

You want to create a Spring Boot application that hosts its logic in Azure App Service and hosts its database in an Azure MySQL database.

## Develop your Spring app

Spring is a great framework to host and manage your applications. You just wire certain Spring components without needing to manage the underlying server runtime.

You've decided to use Spring Boot. This framework is self-hosted, and it provides support services to run your application.

The Spring injection annotations use dependency injection to process the components.
You can use Azure Spring Starter integration libraries to configure and set up connections to Azure services.

## Create your resources by using the Azure CLI and Maven

You can use the Azure CLI to create and manage Azure resources.
It runs on Linux, macOS, and Windows. The CLI allows administrators and developers to run commands by using a terminal or command-line prompt (or script) instead of a web browser. 

For example, to get the details of a subscription, you can use the following command:

```bash
az account show
```

In this module, you use the Azure CLI to spin up the Azure App Service and Azure Database for MySQL instance. Access the Azure CLI from a terminal or through Visual Studio Code. Or you can access it from Azure Cloud Shell. This browser-based shell experience is hosted in the cloud. In Cloud Shell, the Azure CLI is configured for use with your Azure subscription.

You'll use the Maven package manager to structure your project and pull in dependencies. Maven also provides the tools you need to configure and deploy your project to Azure App Service by using the Azure Web Apps plug-in.

### Azure Database for MySQL

Whether you're building new applications that target MySQL or you're migrating legacy applications, Azure Database for MySQL provides the enterprise-ready solution that modern applications need. For more information, see [Azure Database for MySQL](https://azure.microsoft.com/services/mysql/?azure-portal=true&WT.mc_id=java-10785-ropreddy).
