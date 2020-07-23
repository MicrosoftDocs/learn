As we mentioned in previous modules, Microsoft Azure Resource Manager (ARM) templates allow you to specify your project's infrastructure in a declarative and reusable way. The templates can be versioned and saved in the same source control as your development project.

As a developer or the operation person for your enterprise you always need to control the deployments of your resources. You'll need to control what, how, and when resources are being deployed.

in this module you are introduced to the different ways of deploying your ARM templates.

## Learning objectives

In this module, you will:

- Evaluate the What-if operation so can preview the changes that will happen as you deploy your templates.
- Modularize the template by creating a linked templates.
- Learn how to create a Github Action to deploy templates.

## Prerequisites

- Familiar with Azure including the Azure portal, subscriptions, resource groups, and resource definitions  
- [Visual Studio Code](https://code.visualstudio.com?azure-portal=true) installed locally.
- The latest [Azure CLI](https://docs.microsoft.com/cli/azure/install-azure-cli?view=azure-cli-latest&azure-portal=true&WT.mc_id=MSLearn-ARM-pierrer) tools installed locally
- The [Azure Resource Manager Tools for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=msazurermtools.azurerm-vscode-tools&WT.mc_id=MSLearn-ARM-pierrer) extension installed locally
- Either:
  - The latest [Azure CLI](https://docs.microsoft.com/cli/azure/install-azure-cli?view=azure-cli-latest&WT.mc_id=MSLearn-ARM-pierrer) tools installed locally
  - The latest [Azure PowerShell](https://docs.microsoft.com/powershell/azure/install-az-ps?view=azps-4.3.0&WT.mc_id=MSLearn-ARM-pierrer)] installed locally
