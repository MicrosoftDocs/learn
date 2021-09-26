TODO intro para

During the process, you'll:

> [!div class="checklist"]
> * Add new modules for your application and content delivery network.
> * Create a Bicep template that combines both modules together.
> * Deploy the template to Azure.
> * Review the deployment history.

[!INCLUDE [Install the Bicep extension for Visual Studio Code](../../includes/azure-template-bicep-exercise-vscode-extension.md)]

## Create a blank Bicep file

1. Open Visual Studio Code.

1. Create a new file called *main.bicep*.

1. Save the empty file so that Visual Studio Code loads the Bicep tooling. 
 
   You can either select **File** > **Save As** or select <kbd>Ctrl+S</kbd> in Windows (<kbd>⌘+S</kbd> on macOS). Be sure to remember where you've saved the file. For example, you might want to create a *templates* folder to save it in.

## Create a module for your application

1. Create a new folder called *modules* in the same folder where you created your *main.bicep* file. In the *modules* folder, create a file called *app.bicep*. Save the file.

1. Add the following content into the *app.bicep* file:

   :::code language="bicep" source="code/4-app.bicep" :::

   This file deploys an App Service plan and an app.

1. Save the changes to the file.

## Create a module for the content delivery network

1. In the *modules* folder, create a file called *cdn.bicep*. Save the file.

1. Add the following content into the *cdn.bicep* file:

   :::code language="bicep" source="code/4-cdn.bicep" :::

   This file deploys two resources: a CDN profile and a CDN endpoint.

1. Save the changes to the file.

## Add the modules to the main Bicep template

1. Open the *main.bicep* file.

1. Add the following parameters to the file:

   :::code language="bicep" source="code/4-template.bicep" range="1-8" :::

1. Below the parameters, create a blank line. Now, type the first line of the app module definition:

   :::code language="bicep" source="code/4-template.bicep" range="10" :::

   As you type, notice that the Bicep extension for Visual Studio Code helps you to scaffold the module declaration. When you type the path to your module and type the `=` character, it displays a popup with several options will appear. Select the **Required properties** item:

   :::image type="content" source="../media/4-module-scaffold.png" alt-text="Screenshot of Visual Studio Code showing the option to scaffold a module with its required properties.":::

1. Complete the module declaration:

   :::code language="bicep" source="code/4-template.bicep" range="10-17" :::

1. Below the `app` module, define the `cdn` module:

   :::code language="bicep" source="code/4-template.bicep" range="19-26" :::

1. At the bottom of the file, define an output:

   :::code language="bicep" source="code/4-template.bicep" range="29" :::

1. Save the changes to the file.

## Use unique deployment names

TODO intro

1. In the *main.bicep* file, update the module definitions: TODO

1. Save the changes to the file.

<!-- TODO use unique deployment names -->

<!-- TODO add condition to decide whether to include the CDN. and use a ternary thing to selectively send the right hostname back in the output -->

## Deploy the Bicep template to Azure

::: zone pivot="cli"

[!INCLUDE [Bootstrapping instructions for first Bicep exercise - CLI](../../includes/azure-template-bicep-exercise-sandbox-deploy-cli.md)]

### Deploy the template to Azure

Run the following code from the terminal in Visual Studio Code to deploy the Bicep template to Azure. This can take a minute or two to complete, and then you'll see a successful deployment.

```azurecli
az deployment group create --template-file main.bicep
```

You'll see `Running...` in the terminal.

::: zone-end

::: zone pivot="powershell"

[!INCLUDE [Bootstrapping instructions for first Bicep exercise - PowerShell](../../includes/azure-template-bicep-exercise-sandbox-deploy-powershell.md)]

### Deploy the template to Azure

Deploy the template to Azure by using the following Azure PowerShell command in the terminal. This can take a minute or two to complete, and then you'll see a successful deployment. 

```azurepowershell
New-AzResourceGroupDeployment -TemplateFile main.bicep
```

::: zone-end

## Review the deployment history

1. Go to the [Azure portal](https://portal.azure.com?azure-portal=true) and make sure you're in the sandbox subscription:

   1. Select your avatar in the upper-right corner of the page. 
   1. Select **Switch directory**. In the list, choose the **Microsoft Learn Sandbox** directory.

1. On the left-side panel, select **Resource groups**.

1. Select **<rgn>[sandbox resource group name]</rgn>**.

1. In the left menu, select **Deployments**.

   Three deployments are listed.

1. Select the **main** deployment. Notice that the two modules are listed, and that their types are displayed as `Microsoft.Resources/deployments`.

1. Select the **cdn** and **app** deployments and review the resources deployed in each. Notice that they correspond to the resources defined in the respective module.
