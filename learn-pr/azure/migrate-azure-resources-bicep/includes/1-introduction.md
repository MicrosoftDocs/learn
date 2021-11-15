Your team may have already deployed Azure resources by using the Azure portal, JSON Azure Resource Manager templates (ARM templates), or a command-line interface (CLI). If you're used to working with JSON ARM templates, you've learned how Bicep improves the template authoring process over using JSON ARM templates. It's worth the investment to use Bicep for your Azure resources, but migrating your existing deployments to Bicep isn't accomplished with a click of a button. The process involves a recommended workflow that includes converting, migrating, refactoring, and testing.

## Example scenario

Suppose you're responsible for deploying and configuring the Azure infrastructure at a toy company. Recently, your company acquired a smaller competitor that has created a popular toy truck. This company also uses Azure to host its application infrastructure, but the company deployed its resources by using the Azure portal. It deployed a virtual machine that provides some of the services that support the toy truck.

You want to begin the process of standardizing on Bicep for all resource deployments. To accomplish this task, you'll convert and migrate your resources to Bicep. You'll refactor the templates for clarity and test deployments to verify the migration.

## What will we be doing?

In this module, you'll learn about the recommended workflow for migrating your Azure resources to Bicep. This workflow consists of five phases: convert, migrate, refactor, test, and deploy.

:::image type="content" source="../media/1-five-phases.png" alt-text="Diagram of the recommended workflow for migrating Azure resources to Bicep." border="false":::

You'll learn how to convert and migrate your Azure resources and JSON templates to Bicep files. You'll also learn about tools and resources that can help improve the quality of your templates. Finally, you'll learn how to do test deployments of your converted templates.

## What is the main goal?

After completing this module, you'll understand how to migrate your Azure resources to Bicep. You'll also gain confidence in the fidelity of the templates you'll use in future deployments.

## Prerequisites

You should be familiar with:

- Azure, including the Azure portal, subscriptions, and resource groups.
- ARM templates (both JSON and Bicep), including parameters, modules, the `existing` keyword, and child and extension resources.
- The what-if operation.
- Refactoring Bicep files to align with best practices.

To follow along with the exercises in the module, you'll need:

- An Azure account, with the ability to create resource groups.
  > [!TIP]
  > If you can't meet these requirements with your current Azure account, you can get a [free trial](https://azure.microsoft.com/free/?azure-portal=true) and create a new Azure subscription and tenant.
- [Visual Studio Code](https://code.visualstudio.com?azure-portal=true), installed locally.  
- The [Bicep extension for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-bicep&azure-portal=true), installed locally. 
- Either:
  - The latest [Azure CLI](/cli/azure/install-azure-cli/?azure-portal=true) tools, installed locally.  
  - The latest version of [Azure PowerShell](/powershell/azure/install-az-ps/?azure-portal=true), installed locally.
