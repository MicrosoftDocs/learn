Bicep modules enable you to easily reuse your Bicep code in multiple deployments. By using Bicep registries, you can use modules that others have created, and you can share your own modules within your organization and, optionally, with the wider Bicep development community.

## Example scenario

Suppose you're responsible for deploying and configuring the Azure infrastructure at a toy company. You've been asked to help your research and development (R&D) team, who is building a new toy car. The car will use machine learning to detect different colored traffic lights and stop or slow down for them. The R&D team has asked you to provision a new Azure Machine Learning workspace to help them develop and train their system. The team also needs an Azure Cosmos DB database to store the data from the test runs.

Another part of the R&D team is starting a project to build another autonomous toy - a dog that chases the robotic car. You expect that team will have similar requirements as the toy car team.

You want to reuse your Bicep code as much as possible, so you plan to create Bicep modules, and to share and reuse the modules throughout your organization.

## What will we be doing?

In this module, you'll learn about public and private registries for sharing modules. You'll find out how to consume modules from the public Bicep registry. You'll also learn how to create your own private registry, and how you publish to and consume modules from a private registry.

## What is the main goal?

By the end of this module, you'll be able to use Bicep modules from the public registry, and you'll be able to create and use private registries.

## Prerequisites

You should be familiar with using:

- Bicep, including how to use modules, parameters, and how to deploy Bicep files to Azure.
- Azure, including the Azure portal, subscriptions, resource groups, and resources.

To work through the exercises, you'll also need the following installed locally:

- [Visual Studio Code](https://code.visualstudio.com?azure-portal=true).
- The [Bicep extension for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-bicep&azure-portal=true).
- The latest [Azure CLI](/cli/azure/install-azure-cli) tools *or* the latest [Azure PowerShell](/powershell/azure/install-az-ps).
