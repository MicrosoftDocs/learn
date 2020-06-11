Microsoft Azure Resource Manager templates allow you to specify your project's infrastructure in a declarative and reusable way. The templates can be versioned and saved in the same source control as your development project.

Suppose you are managing a software team that is developing an inventory system for your partner companies. This product is going to be deployed to Azure and each partner company will have their own solution. During development, the team will need to quickly deploy consistent infrastructure in Azure for their development, test, and staging environments. Once the project is ready to deploy to the partner companies, the infrastructure will need to be reliably duplicated in each of their environments. You decide to use the practice of *Infrastructure as Code* using Azure Resource Manager templates to ensure that your infrastructure deployments will be consistent, flexible, and that the versions can be tracked.

In this module, you are introduced to Azure Resource Manager template structure and you practice creating and deploying a template to Azure.

## Learning objectives

In this module, you:

- Explore Azure Resource Manager templates to implement infrastructure as code
- Create and deploy an Azure Resource Manager template to Azure by using Visual Studio Code and Azure CLI
- Declare resources and add flexibility to your template by adding resources, parameters, and outputs
- Predict what changes would be made to your infrastructure by using the *what-if* switch

## Prerequisites

- Familiar with [Visual Studio Code](https://code.visualstudio.com?azure-portal=true)
- Familiar with [Azure fundamentals](https://docs.microsoft.com/learn/paths/azure-fundamentals?azure-portal=true)
- The latest [Azure CLI](https://docs.microsoft.com/cli/azure/install-azure-cli?view=azure-cli-latest&azure-portal=true) tools installed locally
- The [Azure Resource Manager Tools for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=msazurermtools.azurerm-vscode-tools&azure-portal=true) extension installed locally
