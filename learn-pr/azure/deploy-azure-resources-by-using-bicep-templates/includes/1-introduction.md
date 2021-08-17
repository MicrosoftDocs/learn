Bicep enables you to define your Azure resources in a simple templating language and then deploy these resources across multiple environments and applications. Bicep helps reduce manual deployment operations, so you can scale your solutions more easily and with higher quality and consistency.

## Example scenario

Suppose you're responsible for deploying and configuring the Azure infrastructure at a toy company. Your company is launching a new toy. You've been asked to deploy a new marketing website in preparation for the launch. The marketing team has also told you that many new toys will be released this year, and it will need a website deployed for each one. You know from past experience that you're not always given much time to get new websites up and running before a toy launches.

You'll host the website in Azure by using Azure App Service. You'll incorporate a storage account for files such as manuals and specifications for each toy.

:::image type="content" source="../media/1-architecture-diagram.png" alt-text="Architecture diagram that shows a resource group containing an App Service plan, App Service app, and storage account." border="false":::

You decide to build the resources by using infrastructure as code (IaC) techniques so that you can reuse the template for future product launches.

## What will we be doing?

In this module, you'll create a reusable Bicep template to deploy a set of Azure resources for new product launches. You'll use many elements of the Bicep language, including:

- Resource definitions to deploy your Azure resources from your Bicep code.
- Parameters to make your template reusable.
- Variables and expressions to make it easier to write and deploy your template.
- Modules to help structure your template into multiple files.
- Outputs to send data from your template and modules back to whoever or whatever is deploying your infrastructure.

## What is the main goal?

By the end of this module, you'll be able to create Bicep templates that define your Azure resources. You'll be able to use parameters, variables, and expressions to make your templates reusable. You'll also be able to use modules and outputs to organize your templates into separate files.

## Prerequisites

You should be familiar with:

- What infrastructure as code is, and what its benefits are.
- Azure, including the Azure portal, subscriptions, resource groups, and resources.

To follow along with the exercises in the module, you'll need:

- [Visual Studio Code](https://code.visualstudio.com) installed locally.
- The [Bicep extension for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-bicep) installed locally.
- Either:
  - The latest [Azure CLI](/cli/azure/install-azure-cli) tools installed locally.
  - The latest version of [Azure PowerShell](/powershell/azure/install-az-ps) installed locally.
