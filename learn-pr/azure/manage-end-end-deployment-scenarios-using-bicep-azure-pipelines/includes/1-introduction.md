When you use pipelines, you can automate the validation, testing, and deployment of your Bicep code. Many of the benefits of using Bicep come from deploying your Azure infrastructure alongside the other components of your solution, such as applications and the database configuration. In this module, you'll learn how to extend a pipeline that already deploys Bicep code to deploy an entire solution.

## Example scenario

Suppose you're responsible for deploying and configuring the Azure infrastructure at a toy company. You've built a Bicep template to deploy your company's website, which deploys an Azure App Service app, an Azure SQL database for your product list, and a storage account for hosting product images. You've already created a pipeline that deploys your Azure resources by using your Bicep template. Now, you want to extend the pipeline to deploy your app, to configure your database, and to seed some test data you need for your website.

:::image type="content" source="../media/1-architecture-diagram.png" alt-text="Architecture diagram illustrating the solution's Azure components, with the pipeline deploying the Bicep file and performing the additional steps on the resources." border="false":::

## What will you be doing?

In this module, you'll learn how to extend a deployment pipeline so that it deploys Azure infrastructure, applications, databases, and data together. You'll add a build stage to your pipeline that compiles an application and database project, and you'll use pipeline artifacts to propagate the deployable files through your pipeline. You'll use Bicep outputs from your pipeline to integrate your pipeline's components, and you'll update your deployment stage to publish your application, website, and sample data.

## What is the main goal?

After completing this module, you'll be able to create a unified deployment pipeline that:

- Provisions Azure resources by using a Bicep file.
- Deploys an application to Azure App Service.
- Publishes a database schema to an Azure SQL database.
- Adds sample data to an Azure SQL database and an Azure Storage blob container.

You'll also know how to effectively use pipeline artifacts, Bicep outputs, and pipeline variables to coordinate the different parts of your pipeline.

## Prerequisites

You should be familiar with using:

- Bicep, including child resources, and how to deploy Bicep files to Azure.
- Azure, including the Azure portal, subscriptions, resource groups, and resources.
- Basic Git commands, including cloning, committing files, and pushing changes to Azure Repos.
- YAML pipelines through Azure Pipelines, including multistage pipelines, environments, and service connections.

To work through the exercises in the module, you'll need:
  
- An Azure account, with the ability to create resource groups, Azure Active Directory applications, and service principals.
- An Azure DevOps organization and account.

To work through the exercises, you'll also need the following installed locally:

- [Visual Studio Code](https://code.visualstudio.com?azure-portal=true).
- The [Bicep extension for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-bicep&azure-portal=true).
- The [Azure Pipelines extension for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=ms-azure-devops.azure-pipelines&azure-portal=true).
- The latest [Azure CLI](/cli/azure/install-azure-cli) tools *or* the latest [Azure PowerShell](/powershell/azure/install-az-ps).
