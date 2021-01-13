You've been able to build and test an Azure Function using Maven, which resolves part of the scenario that you are researching for your company. You next task is to investigate how to deploy your function to Azure Functions.

In this unit, you'll learn how you can use Maven to deploy your Java functions to Azure from within the Cloud Shell. In addition, you'll learn about several of the other deployment options that are available for deploying applications to Azure.

## Deploying an application to Azure with Maven

One of the benefits of using the Maven Plugin for Azure Functions is that it helps to streamline your deployment. This is especially advantageous when you are using Maven in conjunction with the Azure Cloud Shell or Azure Command Line Interface (CLI). When you are using either of those two technologies, you're already logged into the Azure portal, so you aren't required to authenticate when you're deploying your application. In addition, because the Azure Cloud Shell is kept up to date for you, there's no need to check your environment, because all of the required libraries and tools are automatically provided.

Once your application has been properly configured for deployment to Azure, the process of deploying your application is as easy as the following Maven command:

```bash
mvn azure-functions:deploy
```

In the next exercise, you'll use Maven to deploy your function to Azure.
