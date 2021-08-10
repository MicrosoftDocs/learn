By automating Bicep deployments through GitHub Actions, you can create a flexible and reusable process for propagating your changes to your Azure environment. A GitHub Actions workflow enforces the process you specify to ensure the quality of your deployments and your Azure environment. A workflow also ensures the same process is used by everyone who collaborates on your Bicep files. In this module, you'll learn how to define a GitHub Actions workflow, and how to deploy your Bicep code by using the workflow.

## Example scenario

Suppose you're responsible for deploying and configuring the Azure infrastructure at a toy company. You've built a Bicep template to deploy your company's website. Every time you need to reconfigure the website you update your Bicep files and redeploy them from your computer. Your website team asks for changes regularly so the deployment process has become time-consuming, and you want to find a way to automate the process so that you can spend your time on more important things.

You also want to enable your colleagues to make changes to the Bicep templates and deploy them themselves. But, you need to ensure they follow the same process as you. You decide to create a GitHub Actions workflow, which will run automatically every time the Bicep code is updated in your shared repository. It will deploy your Bicep files to Azure.

:::image type="content" source="../media/1-workflow.png" alt-text="Diagram that shows a change to a Bicep file, which is pushed to a GitHub repository. This then automatically triggers a GitHub Actions workflow, which deploys to Azure." border="false":::

## What will you be doing?

In this module, you'll learn how you can automate the deployment of Bicep templates by using GitHub Actions. You'll understand the benefits of using GitHub Actions workflows to deploy your code, and you'll learn how to build a basic workflow that deploys a Bicep file. Along the way, you'll learn how to give your workflow the secrets to deploy resources to your Azure environment, and how to configure when the workflow runs.

## What is the main goal?

After completing this module, you'll be able to create a workflow in GitHub Actions that deploys a basic Bicep file to an Azure resource group.

## Prerequisites

You should be familiar with:

- Creating and deploying basic Bicep files.
- Azure, including the Azure portal, subscriptions, resource groups, and resources.
- Service principals.
- Basic Git commands, including cloning, committing files, and pushing changes to a GitHub repository.

To follow along with the exercises in the module, you'll need an Azure account, with the ability to create resource groups and to create Azure Active Directory applications and service principals.

You'll also need the following installed locally:

- [Visual Studio Code](https://code.visualstudio.com?azure-portal=true).
- The [Bicep extension for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-bicep&azure-portal=true).
- Either:
  - The latest [Azure CLI](/cli/azure/install-azure-cli) tools.
  - The latest [Azure PowerShell](/powershell/azure/install-az-ps).
- [Git](https://git-scm.com/download?azure-portal=true).
