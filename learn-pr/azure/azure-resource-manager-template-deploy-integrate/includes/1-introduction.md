As we mentioned in previous modules, Microsoft Azure Resource Manager (ARM) templates allow you to specify your project's infrastructure in a declarative and reusable way. The templates can be versioned and saved in the same source control as your development project.

In previous modules you deployed resources in a resource group. If for some reason you need to either modify a template or create a new one to deploy more resources in this resource group.  How would you know the impact on existing resources? Will the new resource have an adverse effect on the existing resources? the "what-if" operation is here to address these possibilities.

Azure Resource Manager now provides the what-if operation to let you see how resources will change if you deploy the template. The what-if operation doesn't make any changes to existing resources. Instead, it predicts the changes if the specified template is deployed.

You can use the what-if operation with Azure PowerShell, Azure CLI, or REST API operations. What-if is supported for resource group and subscription level deployments.

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
