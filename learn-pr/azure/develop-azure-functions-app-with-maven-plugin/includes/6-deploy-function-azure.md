So far, you've created an Azure Functions application from the Maven Azure-functions-archetype, and have run and tested it locally through the Azure CLI.

Now you need to deploy the application to Azure, turning it into an Azure function.  

In this unit, you'll learn about the different deployment options, and when you would use them.  Also, you'll see how you can use Maven through the cloud shell to deploy your Java application functions into Azure.

## Trigger Syncing

When deploying your applications, you must consider what the trigger condition will be; for example, this may be an HTTP request or a webhook.  If your Functions application changes the trigger type, the Azure Functions engine might not be aware of it.  Depending on the deployment technology you use, synchronization of the triggers happens automatically.  However, you'll need to manually force a sync of your triggers if you use any of these deployment options: external package URL, cloud sync, local Git, or FTP. 

## Remote build

This is a new feature with Azure Functions that work in conjunction with the zip deployment option.  Azure Functions will automatically build the project code as part of the deployment process.  There are two distinct flavors, one for use with Windows systems and the other for Linux.

## Deployment options

When it comes to deploying your Azure Functions project to Azure, there are many different options available.  Each deployment option suits a specific type or flavor of the Azure Functions project.  The recommended deploy option for Azure Functions projects is zip deployment.

### External package URL

The external package URL deployment option allows you to supply a URL to the server that holds your function application package. When this option is run, it downloads the file from the URL location and runs it in **run from package** mode.

The run from package feature requires you to add the WEBSITE_RUN_FROM_PACKAGE flag to your application settings.  The value will be the URL address where the package is.  This type of deployment is best suited to Linux environments.

The external package URL is compatible with the following operating system and host types: Windows, Windows premium, Windows dedicated, Linux, Linux premium.

### Zip deploy

The zip deployment option allows you to supply a zip file containing your Azure Functions application.  This deployment option also allows you to **run from package** or do a remote build.

The run from package option requires the WEBSITE_RUN_FROM_PACKAGE flag to be set to 1.  Since you're supplying the package to the Azure Functions engine.

To trigger a remote build during the zip deployment, you'll need to use an Azure Functions Core Tools command.

```BASH
func azure functionapp publish <app name> --build remote
```

The zip deploy method is recommended for Azure Functions.

This deployment option is compatible with: Windows, Windows premium, windows dedicated, Linux, Linux premium.

### Docker container

The Docker container option lets you use a Linux container to deploy your Azure Function application into a Linux environment.

To use this option, you'll need a supporting Azure App Service plan. This option is recommended for Linux Function apps, and is compatible with: Linux premium.

### Web Deploy

The Web Deploy option lets you package and deploy your Function application to a Windows server running IIS and including Windows virtual machines running in Azure. 

This deployment option should be invoked using the Visual Studio for Azure functions.  In addition you can use the Web Deploy 3.6 tool, which will allow you to deploy to Azure directly.

Compatible with: Windows, Windows premium, windows dedicated.

### Source control

The source control option is designed to link to your organization's Git repository. Any updates to the Git repo will automatically trigger a deployment.

To use this option, you'll need to configure publishing from source control in the Deployment Center of Functions.

This deployment option is best suited to teams working on the same Azure function, and is among the best practices for the best deployment strategies.

Compatible with: Windows, Windows premium, windows dedicated, Linux premium.

### Local Git

The local Git deployment option lets you use your own Git repo hosted on an on-premises server or local development machine to deploy filers into Azure.

While this deployment option can be used, the recommendation would be to use one of the other deployment options.

This option requires that you do manual sync after deployment of the application.

Compatible with: Windows, Windows premium, windows dedicated, Linux premium.

### Cloud sync

The cloud sync option lets you use a cloud storage service like Dropbox or OneDrive as the source for deploying files into Azure.

While this deployment option can be used, the recommendation would be to use one of the other deployment options.

This option requires that you do manual sync after deployment of the application.

Compatible with: Windows, Windows premium, windows dedicated, Linux premium.

## Deploying a Maven app into Azure

When using the Azure CLI, you're already logged into the Azure portal, so you aren't required to authenticate when doing a deployment. 

Also, because you're using the Azure CLI, there's no need to check the environment as all the required libraries are automatically included.

Through the Azure CLI, it's possible to deploy the application that was previously created.  To deploy the application, use the Maven command below:
```BASH
mvn azure-functions:deploy
```
