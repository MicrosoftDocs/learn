> [!NOTE]
> The first time you activate a sandbox and accept the terms, your Microsoft account is associated with a new Azure directory named Microsoft Learn Sandbox. You're added to a special subscription named Concierge Subscription.

Here, you will deploy an Azure Resource Manager (ARM) template from local directory on your own machine and from a GitHub repo with a URI.

This exercise uses the [Azure Resource Manager Tools for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=msazurermtools.azurerm-vscode-tools). Be sure to install this extension in Visual Studio Code.

## Set up your environment with the provided Azure sandbox subscription

To perform each deployment in this unit, you need to sign in to your Azure account from the Visual Studio Code terminal.

:::image type="content" source="../media/vscode-terminal.gif" alt-text="Open the integrated terminal in Visual Studio Code." border="true":::

Be sure you are signing in to the same account that activated the sandbox.

::: zone pivot="powershell"

[!include[](./powershell/5-exercise-singledeployment-powershell.md)]

::: zone-end

::: zone pivot="cli"

[!include[](./azurecli/5-exercise-singledeployment-azurecli.md)]

::: zone-end
