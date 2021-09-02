Bicep modules enable you to easily reuse your Bicep code in multiple deployments. By using Bicep module registries, you can use modules that others have created, and you can share your own modules within your organization and, optionally, with the wider Bicep development community.

## Example scenario

Suppose you're responsible for deploying and configuring the Azure infrastructure at a toy company. Recently, you three separate teams asked you to build Bicep templates that included a static website hosted on Azure Storage, and two of the templates included an Azure Functions app that had to be configured to meet your organization's requirements. You want to reuse your Bicep code as much as possible, so you created Bicep modules for the shared components. Now, you need to understand how to share and reuse the modules throughout your organization.

## What will we be doing?

In this module, you'll learn about public and private module registries. You'll find out how to consume modules from the public Bicep module registry. You'll also learn how to create your own private module registry, and how you publish to and consume modules from a private registry.

## What is the main goal?

By the end of this module, you'll be able to use Bicep modules from the public module registry, and you'll be able to create and use private module registries.

## Prerequisites

You should be familiar with using:

- Bicep, including how to use modules, parameters, and how to deploy Bicep files to Azure.
- Azure, including the Azure portal, subscriptions, resource groups, and resources.

To work through the exercises, you'll also need the following installed locally:

- [Visual Studio Code](https://code.visualstudio.com?azure-portal=true).
- The [Bicep extension for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-bicep&azure-portal=true).
- The latest [Azure CLI](/cli/azure/install-azure-cli) tools *or* the latest [Azure PowerShell](/powershell/azure/install-az-ps).
