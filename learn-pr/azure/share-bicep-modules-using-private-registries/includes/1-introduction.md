Bicep modules enable you create composable, reusable files that define a set of related resources. You then use those modules in your deployment templates. When you work with Bicep code in your own organization, you often create reusable modules that your colleagues would benefit from. These modules might create resources in a way that fits your organization's requirements, such as by using your defined naming conventions and configuring resources so that they meet your security requirements. Private Bicep registries provide an easy way for you to share these modules within your organization.

## Example scenario

TODO new scenario

<!-- TODO can we include arch diagram? -->

## What will we be doing?

In this module, you'll learn about private registries for sharing modules. You'll find out how create your own private registry, and how you publish modules to it. You'll also learn about how to consume modules from a private registry.

## What is the main goal?

By the end of this module, you'll be able to create private registries, publish modules to them, and consume modules from them.

## Prerequisites

You should be familiar with using:

- Bicep, including how to use modules, parameters, and how to deploy Bicep files to Azure.
- Azure, including the Azure portal, subscriptions, resource groups, and resources.

To work through the exercises, you'll also need the following installed locally:

- [Visual Studio Code](https://code.visualstudio.com?azure-portal=true).
- The [Bicep extension for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-bicep&azure-portal=true).
- The latest [Azure CLI](/cli/azure/install-azure-cli) tools *or* the latest [Azure PowerShell](/powershell/azure/install-az-ps).
