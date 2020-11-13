> [!NOTE]
> The first time you activate a sandbox and accept the terms, your Microsoft account is associated with a new Azure directory named Microsoft Learn Sandbox. You're added to a special subscription named Concierge Subscription.

Here, you deploy an Azure Resource Manager (ARM) template from your computer and from a GitHub repository by specifying a URI.

> [!IMPORTANT]
> This exercise uses [Azure Resource Manager Tools for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=msazurermtools.azurerm-vscode-tools&azure-portal=true). Be sure to install this extension in Visual Studio Code.

## Set up your environment with the Microsoft Learn Sandbox subscription

To perform each deployment in this unit, you need to sign in to your Azure account from the Visual Studio Code terminal.

Be sure you're signing in to the same account that activated the sandbox.

::: zone pivot="powershell"

[!include[](./powershell/3-exercise-single-deployment.md)]

::: zone-end

::: zone pivot="cli"

[!include[](./azurecli/3-exercise-single-deployment.md)]

::: zone-end
