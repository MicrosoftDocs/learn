In [Deploy consistent infrastructure in Azure by using ARM templates](/learn/modules/create-azure-resource-manager-template-vs-code/) and [Deploy to multiple Azure environments by using ARM template features](/learn/modules/modify-azure-resource-manager-template-reuse/?azure-portal=true), you learned the basics of creating JSON Azure Resource Manager (ARM) templates.

In this module, you'll focus on how you deploy templates. You'll start with deploying a local template, and then deploy an external template that's staged in GitHub. You'll learn how to deploy a template that links to other external templates. Finally, you'll learn how to automate template deployment by integrating it with your continuous integration and continuous delivery (CI/CD) pipeline.

[!INCLUDE [Bicep introduction for JSON modules](../../includes/azure-template-json-bicep-intro.md)]

## Learning objectives

After completing this module, you'll be able to:

- Choose the best way to deploy JSON ARM templates, based on your needs.
- Modularize your templates by using linked templates.
- Learn how to create GitHub Actions to deploy templates.

## Prerequisites

- Ability to go to the Azure portal
- [Visual Studio Code](https://code.visualstudio.com?azure-portal=true)
- [Azure Resource Manager Tools for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=msazurermtools.azurerm-vscode-tools&azure-portal=true)
- Either:
  - The latest version of the [Azure CLI](/cli/azure/install-azure-cli?azure-portal=true&view=azure-cli-latest)
  - The latest version of [Azure PowerShell](/powershell/azure/install-az-ps?azure-portal=true&view=azure-cli-latest)
- A [GitHub](https://github.com?azure-portal=true) account
- An [Azure subscription](https://azure.microsoft.com/free/?azure-portal=true)