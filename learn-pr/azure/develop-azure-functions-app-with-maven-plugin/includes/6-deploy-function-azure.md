You've been able to build and test an Azure Function using Maven, which resolves part of the scenario that you are researching for your company. You next task is to investigate how to deploy your function to Azure Functions.

In this unit, you'll learn how you can use Maven to deploy your Java functions to Azure from within the Cloud Shell. In addition, you'll learn about several of the other deployment options that are available for deploying applications to Azure.

## Deploying an application to Azure with Maven

One of the benefits of using the Maven Plugin for Azure Functions is that it helps to streamline your deployment. This is especially advantageous when you are using Maven in conjunction with the Azure Cloud Shell or Azure Command Line Interface (CLI). When you are using either of those two technologies, you're already logged into the Azure portal, so you aren't required to authenticate when you're deploying your application. In addition, because the Azure Cloud Shell is kept up to date for you, there's no need to check your environment, because all of the required libraries and tools are automatically provided.

Once your application has been properly configured for deployment to Azure, the process of deploying your application is as easy as the following Maven command:

```bash
mvn azure-functions:deploy
```

The deployment type is specified in your project's *pom.xml* file, which you will configure in the exercise that is in the next unit of this module. The following section of this unit describes a few of the different deployment options that are available. However, this is only a partial list; for a more exhaustive list of deployment options, see [Deployment technologies in Azure Functions](https://docs.microsoft.com/azure/azure-functions/functions-deployment-technologies).

## Deployment technologies

There are several different options that are available for you to deploy your Azure Functions projects to Azure, and some deployment options will work better depending on the project that you are creating. However, in general, *Zip Deploy* is the recommended deployment technology for Azure Functions.

The following table describes a few of the options that are available to you for deploying your functions to Azure.

| Technology | Description |
|---|---|
| **Zip Deploy** | *Zip Deploy* is the recommended deployment option for Azure Functions, where you specify a zip file that contains your Azure Functions application.<br><br>Zip deploy also allows you to **run from package**, or perform a **remote build**.<br><br>The **run from package** option requires you add `WEBSITE_RUN_FROM_PACKAGE` to your application settings, and set its value to `1`.<br><br>To trigger a **remote build** during the zip deployment, you'll need to use an Azure Functions Core Tools command: `func azure functionapp publish <app name> --build remote`. |
| **External Package URL** | *External Package URL* deployment allows you to supply a URL to a server that hosts your function application package.<br><br>When you use this deployment option, it downloads the application package from the URL location and deploys the application in **run from package** mode.<br><br>This option requires you add `WEBSITE_RUN_FROM_PACKAGE` to your application settings, and set its value to the URL where your application package is located. |
| **Docker Container** | The *Docker Container* option lets you use a Linux container to deploy your Azure Function application into a Linux environment.<br><br>To use this option, you'll need a supporting Azure App Service plan, and this option is useful for developers who want more control over the Linux environment where their function is running. |
| **Web Deploy** | The *Web Deploy* option lets you package and deploy your function application to any Windows server that is running IIS, which includes Windows virtual machines that are running in Azure.<br><br>You should only use this deployment option from within Visual Studio.<br><br>You can also use the Web Deploy 3.6 command line tool, *MSDeploy.exe*, which will allow you to deploy to Azure directly. |
| **Source Control** | *Source Control* deployment connects to your organization's Git repository, so any updates to your Git repo will automatically trigger a deployment.<br><br>To use this option, you'll need to configure publishing from source control in the **Deployment Center* of Azure Functions.<br><br>Source Control deployment is best suited to teams that are working on the same Azure function, and it is a best practice for deployment strategies. |
| **Local Git** | *Local Git* deployment connects to a Git repo that your organization is hosting on an on-premises server or local development machine.<br><br>While Local Git is a supported deployment option, a better recommendation would be to use one of the other deployment options. |
| **Cloud Sync** | *Cloud Sync* deployment allows developers to use a cloud storage service like Dropbox or OneDrive as the source for deploying files into Azure.<br><br>While Cloud Sync is a supported deployment option, a better recommendation would be to use one of the other deployment options. |

In the next exercise, you'll use Maven to deploy your function to Azure.
