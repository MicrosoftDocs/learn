If you want to host cloud-native .NET Aspire solutions in Azure, you can choose from two services: Azure Container Apps or Azure Kubernetes Service. Both can create highly flexible and scalable deployments but Azure Container Apps can be easier to configure.

In your outdoor equipment retailer, you want to deploy the new eShop for staging. You want a system that's easy to set up and configure but runs all the containers in one place. You want to know if Azure Container Apps is the right choice for this requirement.

In this unit, you'll learn how to deploy a .NET Aspire solution to Azure Container Apps by using Visual Studio or the Azure Developer CLI.

## Deploying .NET Aspire solutions

Cloud-native apps, such as those built with the .NET Aspire stack, consist of microservices and their associated backing services and other executables. Each of these microservices is independent and may employ different technologies and languages from the others. This structure often becomes complex for large apps and the necessary manual deployment steps can become similarly complex. The number of steps involved in the manual deployment of multiple microservices and their requirements is large and such procedures are prone to user error.

More complicating factors can be introduced when you need to deploy to several different environments such as testing, staging, and production.

To make deployment easier, .NET Aspire includes automated deployment tools that help you upload and run all the containers required:

- **Visual Studio**: When you right-click on the app host project and select **Publish**, you can use a wizard to deploy the app.
- **Azure Developer CLI (azd)**: You can use this command line tool to deploy many types of solution from a local development environment into various Azure services. By default `azd` supports deploying .NET Aspire solutions to Azure Container Apps.

### .NET Aspire deployment manifest files

Manifest files are an important part of deployment automation: they describe the content of the complete .NET Aspire solution, including all its containers and backing services. They also include properties necessary for a deployment, such as environment variables, for example.

When you use Visual Studio or azd to deploy an app, manifest files are created for you by using specialized targets of the app host project.

## What is Azure Container Apps?

A cloud-native application, whether it uses .NET Aspire or not, runs in containers. Each container image usually maps to one microservice or one backing service. To run them, you need a service that hosts containers in the cloud. Azure Container Apps is one such service.

Azure Container Apps is designed for simplicity, with its underlying infrastructure being managed for you. This allows you to deploy and configure your microservices with minimal code. Once the microservice is deployed, it will scale dynamically based on factors such as traffic, processing load, memory load, and other metrics.

> [!TIP]
> Azure Container Apps includes the KEDA automatic scaler, so you can use any metric supported by KEDA in your customized scaling regime.

Azure Container Apps is easier to use that other container orchestrators available on Azure because much of the underlying technology is automated. You don't have to become an expert in orchestration to deploy your first applications and you don't have to take charge of the underlying infrastructure. It can also scale to large deployments. However, if you have specialized needs, you may find that they aren't supported. For example, if you want to use a custom service mesh or make other adjustments, you may need to use Azure Kubernetes Services instead.

To deploy and run a containerized app in Azure Container Apps, you issue commands with the **Azure Developer CLI**. These commands can integrate into your preferred Continuous Integration/Continuous Deployment pipelines if you're using them. For example, you can add deployment commands to a GitHub Action so that a microservice is deployed every time a pull request is merged.

## Deploying apps using Visual Studio

If you used one of the .NET Aspire templates to create your solution in Visual Studio, you have a simple wizard that deploys your .NET Azure app to Azure Container Services. Visual Studio can complete these deployment tasks:

- Create an Azure resource group to organize all the necessary resources.
- Create a container registry to store all the necessary container images.
- Publish the .NET Aspire projects as container images in the registry.
- Provision a Redis container in Azure if the solution uses it.
- Deploy containers to Azure Container Apps.

To start the publishing wizard, in **Solution Explorer** right-click the **AppHost** project and then select **Publish**. Choose the publishing target **Azure Container Apps for .NET Aspire**. The wizard prompts you for these values:

- **Subscription**: Choose the Azure subscription that you want to host the app.
- **Location**: Choose the Azure region where you want to host the app.
- **Environment name**: All the resources the wizard creates in Azure have names based on this value.

:::image type="content" source="../media/deploy-aca-visual-studio.png" lightbox="../media/deploy-aca-visual-studio.png" alt-text="Screenshot showing the configuration page of the .NET Aspire deployment wizard in Visual Studio.":::

> [!NOTE]
> You'll deploy an app to Azure Container Services in the exercise later in this module.

## Deploying apps using the Azure Developer CLI

The Azure Developer CLI (`azd`) is a command-line tool that you can use to interact with Azure resources from your development machine. It includes options that help you deploy .NET Aspire solutions and can use Azure Container Apps as a deployment target.

> [!NOTE]
> In fact, the Visual Studio wizard that you've already seen uses the Azure Developer CLI behind the scenes and requires it to be installed on your development computer. Learning to use the CLI commands yourself enables you to build Continuous Integration/Continuous Deployment (CI/CD) pipielines that use it to deploy apps.

On Windows, use the `winget` package manager to install the CLI. On other systems, use their own package manager. For example, in Ubuntu, use `apt`.

```PowerShell
winget install microsoft.azd
```

Before you can deploy, you should initialize your solution with the CLI. Run the following command in the top level directory of your solution:

```azd
azd init
```

This command inspects your solution, asks questions, and generates deployment files including the .NET Aspire manifest.

After initializing the solution, you can package, provision, and deploy the app with a single command:

```azd
azd up
```

### Using the Azure Developer CLI to configure CI/CD

The Developer CLI can also help you to configure CI/CD by creating a GitHub repository, if you don't already have one, and adding a GitHub Action to it. Whenever changes are pushed to the repository, the GitHub Action executes to deploy the changes to Azure.

To set up this system, start with by executing the `azd init` command as you saw in the last section. Then you can use the following command to create the GitHub Action and connect it to your Azure subscription:

```azd
azd pipeline config
```

For for details, see [Tutorial: Deploy a .NET Aspire app using the Azure Developer CLI and GitHub Actions](/aspire/deployment/azure/aca-deployment-github-actions)

## Learn more

- [.NET Aspire deployments](/dotnet/aspire/deployment/overview)
- [Deploy a .NET Aspire app to Azure Container Apps using Visual Studio](/dotnet/aspire/deployment/azure/aca-deployment-visual-studio)
- [Deploy a .NET Aspire app to Azure Container Apps](/dotnet/aspire/deployment/azure/aca-deployment)
- [.NET Aspire manifest format for deployment tool builders](/dotnet/aspire/deployment/manifest-format)
