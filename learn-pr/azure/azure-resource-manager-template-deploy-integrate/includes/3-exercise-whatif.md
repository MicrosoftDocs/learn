
> [!NOTE]
> The first time you activate a sandbox and accept the terms, your Microsoft account is associated with a new Azure directory named Microsoft Learn Sandbox. You're added to a special subscription named Concierge Subscription.

Here, you will deploy a simple Azure Resource Manager (ARM) template from a sample repository that deploys a Virtual Network (VNet) in your sandbox subscription.  Once the deployment is complete, you will then deploy a template that is slightly different:

1. A change od address space in a virtual subnet
1. An additional Subnet in the virtual network

The second deployment will include the *what-if* operation in order to review the expected changes.

This exercise uses the [Azure Resource Manager Tools for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=msazurermtools.azurerm-vscode-tools). Be sure to install this extension in Visual Studio Code.

## What-if prerequisites

::: zone pivot="PowerShell"

[!include[](../include/powershell/3-exercise-whatif-powershell.md)]

::: zone-end

::: zone pivot="Azure CLI"

[!include[](../include/powershell/3-exercise-whatif-azurecli.md)]

::: zone-end
