As we mentioned in previous modules,

  1. [Deploy consistent infrastructure in Azure by using Azure Resource Manager (ARM) templates](https://docs.microsoft.com/learn/modules/create-azure-resource-manager-template-vs-code/)
  1. [Deploy to multiple Azure environments by using ARM templates](https://docs.microsoft.com/learn/modules/modify-azure-resource-manager-template-reuse/)

Microsoft Azure Resource Manager (ARM) templates allow you to specify your project's infrastructure in a declarative and reusable way. The templates can be versioned and stored in a source control system, perhaps even the same source control system for the rest of the development project it supports.

As a developer or the operations person for your enterprise you always need to control the deployments of your resources. You'll need to control what, how, and when resources are being deployed.  In this module you are introduced to the different ways of deploying your ARM templates. We will also cover content from identifying the ways to reference the template to deploy, to deploying from complex infrastructure from single template or multiple linked templates, and finally how you can integrate your templates in your Infrastructure as Code (IaC) deployments through Github Actions.

## Learning objectives

In this module, you will:

- Learn how you can deploy the templates you are authoring, from a variety of methods.
- Modularize the template by creating a linked templates.
- Learn how to create a Github Action to deploy templates.

## Prerequisites

- Familiar with Azure including the Azure portal, subscriptions, resource groups, and resource definitions  
- [Visual Studio Code](https://code.visualstudio.com?azure-portal=true) installed locally.
- The latest [Azure CLI](https://docs.microsoft.com/cli/azure/install-azure-cli?view=azure-cli-latest&azure-portal=true&WT.mc_id=MSLearn-ARM-pierrer) tools installed locally
- The [Azure Resource Manager Tools for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=msazurermtools.azurerm-vscode-tools&WT.mc_id=MSLearn-ARM-pierrer) extension installed locally
- Either:
  - The latest [Azure CLI](https://docs.microsoft.com/cli/azure/install-azure-cli?view=azure-cli-latest&WT.mc_id=MSLearn-ARM-pierrer) tools installed locally
  - The latest [Azure PowerShell](https://docs.microsoft.com/powershell/azure/install-az-ps?view=azps-4.3.0&WT.mc_id=MSLearn-ARM-pierrer) installed locally

- For unit 8 and 9 a [GitHub](https://github.com) account with the ability to navigate and edit files in GitHub is required
  - (For more information about GitHub, see [Introduction to GitHub](https://docs.microsoft.com/en-us/learn/modules/introduction-to-github/).)

## Recommended

The following are not required, but are recommended to understand and complete this module:

- [Deploy consistent infrastructure in Azure by using Azure Resource Manager (ARM) templates](https://docs.microsoft.com/learn/modules/create-azure-resource-manager-template-vs-code/?WT.mc_id=MSlearn-ARM-pierrer)
- [Deploy to multiple Azure environments by using ARM templates](https://docs.microsoft.com/learn/modules/modify-azure-resource-manager-template-reuse/?WT.mc_id=MSlearn-ARM-pierrer)