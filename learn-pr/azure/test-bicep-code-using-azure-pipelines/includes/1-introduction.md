When you automate your Bicep deployments by using Azure Pipelines, you create a consistent and reusable process for managing your Azure resources. Over time, your pipeline becomes the only way that changes can be made to your Azure environment. This means that it's important to ensure that your pipeline enforces quality checks before, during, and after each deployment. In this module, you'll learn how to extend your pipeline to add checks and tests. By doing this, you'll build confidence that your deployments meet your quality standards.

## Example scenario

Suppose you're the Azure administrator at a toy company. You've been working with your website team to create a Bicep template that deploys and configures the Azure resources, and you've recently also been creating a pipeline to deploy the Bicep file automatically.

Recently, you've had several situations where you and your team have made changes to your website's Bicep files that includes mistakes. You're worried that, one day, this might cause a production outage. You want to add testing to your Bicep deployment pipeline to ensure that each deployment has the best chance possible of succeeding.

## What will you be doing?

In this module, you'll learn how you can test your Bicep code within your Azure DevOps pipeline. When your pipeline runs, you'll immediately get feedback on the changes that were made to your Bicep files. You'll add linting to ensure the quality of your Bicep code, and preflight deployment validation to increase the chance that your deployments will succeed. You'll also use the what-if operation to add a manual approval step to your pipeline, and once deployed, you'll verify your environment by executing further tests.

## What is the main goal?

After completing this module, you'll be able to update your pipeline with tests that make sense for your Bicep deployments. These tests will make it possible to make a decision whether or not to deploy a certain change to your Azure environment. 

## Prerequisites

You should be familiar with using:

  - Bicep, including creating and deploying basic files.
  - Azure, including the Azure portal, subscriptions, resource groups, and resources.
  - The what-if operation.
  - Basic Git commands, including cloning, committing files, and pushing changes to Azure Repos.
  - Basic YAML pipelines using Azure Pipelines, including service connections.

To work through the exercises in the module, you'll need an Azure account, with the ability to create resource groups, Azure Active Directory applications, and service principals.
  
You'll also need the following installed locally:
  
  - [Visual Studio Code](https://code.visualstudio.com?azure-portal=true).
  - The [Bicep extension for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-bicep&azure-portal=true).
  - The [Azure Pipelines extension for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=ms-azure-devops.azure-pipelines).
  - The latest [Azure CLI](/cli/azure/install-azure-cli) tools *or* the latest [Azure PowerShell](/powershell/azure/install-az-ps).
  - [Git](https://git-scm.com/download?azure-portal=true).
