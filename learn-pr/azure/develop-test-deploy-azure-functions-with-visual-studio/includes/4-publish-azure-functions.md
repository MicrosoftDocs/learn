An Azure Function runs in the cloud in the context of an Azure Functions app. A function app is a container that specifies the operating system for running an Azure Function, together with the resources available, such as the memory, computing power, and disk space. The Azure Functions app also provides the public URL for running your functions. Behind the scenes, an Azure Functions app is a collection of one or more virtual machines (VMs), running a web server. When you publish an Azure Function, you deploy it to these VMs.

In the luxury watch online website scenario, you'll deploy the Azure Functions you create to the cloud. You need to create an Azure Functions app, and then publish your functions to this app. You want to determine the best way to do this.

There are several of options available for publishing an Azure Function. In this unit, you'll learn about some of these options.

## Deploy from Visual Studio

Azure Functions tools for Visual Studio enable you to deploy an Azure Function directly from Visual Studio. The Azure Functions template provides a Publish wizard. Using this wizard, you connect to your Azure account, and either specify an existing Azure Functions app, or create a new one. The functions in your project are rebuilt and then deployed to the Azure Functions app.

The **Publish** wizard requires that you either have access to the Azure Functions app that will host your functions, or you have an Azure subscription that you can use to create an Azure Functions app as part of the publication process. You'll investigate the **Publish** wizard in more detail in the exercise that follows this unit.

Deployment from Visual Studio is great feature for developers. If developers have access to an Azure subscription, they can create an Azure Functions app and publish code to Azure, to perform testing in an environment that is similar to production environment. Once a function is stable, it can be deployed to an Azure Functions app providing the production environment.

## Continuous deployment

Azure Functions makes it easy to deploy your function app using App Service continuous integration. Azure Functions integrates with BitBucket, Dropbox, GitHub, and Azure DevOps. This enables a workflow where function code updates made by using one of these integrated services triggers deployment to Azure.

Continuous deployment is a great option for projects where multiple and frequent contributions are being integrated. It also lets you maintain source control on your functions code. The following deployment sources are currently supported:

- Bitbucket
- Dropbox
- External repository (Git or Mercurial)
- Git local repository
- GitHub
- OneDrive
- Azure DevOps

![Screenshot of the Deployment Center page in an Azure Functions app](../media/4-deployment-center.png)

You can configure continuous deployment from the Azure portal, using the **Deployment Center** feature of an Azure Functions app. Deployment is configured on a per-function app basis.

## Zip deployment

Azure Functions can be deployed from a zip file using the push deployment technique. You can do this with the Azure CLI, or by using the REST interface.

The zip file contains the executable code for your functions. Zip deployment copies these files to the `wwwwroot` folder in the function app. You can perform zip deployment using the `functionapp deployment` command in the Azure CLI.

```azurecli
az functionapp deployment source config-zip \
-g <resource-group> \
-n <function-app-name> \
--src <zip-file>
```