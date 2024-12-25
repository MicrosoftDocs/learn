[!INCLUDE [Sandbox explanation](../../includes/azure-template-exercise-sandbox-subscription.md)]

The design team at your toy company has asked you to update a template that configures a virtual network. In this unit, you use what-if to verify the effects of deploying the updated template.

During the process, you'll:

> [!div class="checklist"]
> * Create and deploy an initial template.
> * Prepare to deploy a template that's slightly different, and use the what-if operation to review the expected changes.
> * Use a complete deployment to deploy an empty template, and use the what-if operation to review the expected changes.

::: zone pivot="jsoncli,jsonpowershell"

[!INCLUDE [Install the JSON ARM template extension for Visual Studio Code](../../includes/azure-template-json-exercise-vscode-extension.md)]

::: zone-end

::: zone pivot="biceppowershell,bicepcli"

[!INCLUDE [Install the Bicep extension for Visual Studio Code](../../includes/azure-template-bicep-exercise-vscode-extension.md)]

::: zone-end

## Create the starting template

You start with an existing template that your team has been using. The template creates the virtual network.

::: zone pivot="jsonpowershell,jsoncli"

1. Open Visual Studio Code.

1. Create a new file called *azuredeploy.json*.

1. Save the empty file so that Visual Studio Code loads the ARM template tooling. 
 
   You can either select **File** > **Save As** or select <kbd>Ctrl+S</kbd> in Windows (<kbd>⌘+S</kbd> on macOS). Be sure to remember where you've saved the file. For example, you might want to create a *scripts* folder to save it in.

1. Copy the following code into *azuredeploy.json*.

   :::code language="json" source="code/4-template-before.json" :::

1. Save the template.

::: zone-end

::: zone pivot="biceppowershell,bicepcli"

1. Open Visual Studio Code.

1. Create a new file called *main.bicep*.

1. Save the empty file so that Visual Studio Code loads the Bicep tooling. 
 
   You can either select **File** > **Save As** or select <kbd>Ctrl+S</kbd> in Windows (<kbd>⌘+S</kbd> on macOS). Be sure to remember where you've saved the file. For example, you might want to create a *scripts* folder to save it in.

1. Copy the following code into *main.bicep*.

   :::code language="bicep" source="code/4-template-before.bicep" :::

1. Save the template.

::: zone-end

## Deploy the template to Azure

::: zone pivot="biceppowershell"

[!include[](../../includes/azure-template-bicep-exercise-sandbox-deploy-powershell.md)]

::: zone-end

::: zone pivot="bicepcli"

[!include[](../../includes/azure-template-bicep-exercise-sandbox-deploy-cli.md)]

::: zone-end

::: zone pivot="jsonpowershell"

[!include[](../../includes/azure-template-json-exercise-sandbox-deploy-powershell.md)]

::: zone-end

::: zone pivot="jsoncli"

[!include[](../../includes/azure-template-json-exercise-sandbox-deploy-cli.md)]

::: zone-end

::: zone pivot="biceppowershell"

### Deploy the template by using Azure PowerShell

Run `New-AzResourceGroupDeployment` to deploy the template.

```powershell
New-AzResourceGroupDeployment -TemplateFile main.bicep
```

The text **Running...** appears in the terminal. The deployment takes a minute or two to finish.

::: zone-end

::: zone pivot="jsonpowershell"

### Deploy the template by using Azure PowerShell

Run `New-AzResourceGroupDeployment` to deploy the template.

```powershell
New-AzResourceGroupDeployment -TemplateFile azuredeploy.json
```

The text **Running...** appears in the terminal. The deployment takes a minute or two to finish.

::: zone-end

::: zone pivot="bicepcli"

### Deploy the template by using the Azure CLI

Run `az deployment group create` to deploy the template.

```azurecli
az deployment group create --template-file main.bicep
```

The deployment takes a minute or two to finish.

::: zone-end

::: zone pivot="jsoncli"

### Deploy the template by using the Azure CLI

Run `az deployment group create` to deploy the template.

```azurecli
az deployment group create --template-file azuredeploy.json
```

The deployment takes a minute or two to finish.

::: zone-end

## Verify the deployment

To validate that your deployment has been created and sent to Azure, go to the [Azure portal](https://portal.azure.com?azure-portal=true) and make sure you're in the sandbox subscription:

   1. Select your avatar in the upper corner of the page.

   1. Select **Switch directory**. In the list, select the **Microsoft Learn Sandbox** directory.

   1. Select **Resource groups**.

   1. Select <rgn>[sandbox resource group name]</rgn>.

   1. In **Overview**, you see that one deployment succeeded.

   1. Select **1 Succeeded** to see the details of the deployment.

      :::image type="content" source="../media/4-portal-deployment-success.png" alt-text="Screenshot of the Azure portal interface for the deployments, with the one deployment listed and a succeeded status." :::

   1. Select the **main** deployment to see what resources were deployed. In this case, one virtual network (address space 10.0.0.0/16) with two subnets has been deployed.

      :::image type="content" source="../media/4-portal-deployment-details.png" alt-text="Screenshot of the Azure portal interface for the specific deployment, with no resources listed." :::

      :::image type="content" source="../media/4-portal-deployment-details-2.png" alt-text="Screenshot of the Azure portal interface for the specific deployment, with one virtual network resource listed." :::

      Leave the page open in your browser so you can check on deployments again later.

## Modify the template

::: zone pivot="jsonpowershell,jsoncli"

1. In the *azuredeploy.json* file in Visual Studio Code, delete the tag named `Owner` and its value. After you're done, the `tags` property of the virtual network should look like this: 

   :::code language="json" source="code/4-template-after.json" range="12-14" :::

1. Update the `addressPrefixes` to change `/16` to `/15`. After you're done, the `addressSpace` property of the virtual network should look like this:

   :::code language="json" source="code/4-template-after.json" range="16-20" :::

1. Delete the subnet named `subnet001`. Make sure to delete the whole subnet object. After you're done, the `subnets` property of the virtual network should look like this:

   :::code language="json" source="code/4-template-after.json" range="23-30" :::

1. Save the template.

::: zone-end

::: zone pivot="biceppowershell,bicepcli"

1. In the *main.bicep* file in Visual Studio Code, delete the tag named `Owner` and its value. After you're done, the `tags` property of the virtual network should look like this: 

   :::code language="bicep" source="code/4-template-after.bicep" range="4-6" :::

1. Update the `addressPrefixes` to change the `/16` to `/15`. After you're done, the `addressSpace` property of the virtual network should look like this:

   :::code language="bicep" source="code/4-template-after.bicep" range="8-12" :::

1. Delete the subnet named `subnet001`. Make sure to delete the whole subnet object. After you're done, the `subnets` property of the virtual network should look like this:

   :::code language="bicep" source="code/4-template-after.bicep" range="15-22" :::

1. Save the template.

::: zone-end

## Run the what-if command with the modified template

::: zone pivot="biceppowershell"

Run `New-AzResourceGroupDeployment` with the `-WhatIf` flag to perform the what-if operation.

```powershell
New-AzResourceGroupDeployment `
  -WhatIf `
  -TemplateFile main.bicep
```

::: zone-end

::: zone pivot="jsonpowershell"

Run `New-AzResourceGroupDeployment` with the `-WhatIf` flag to perform the what-if operation.

```powershell
New-AzResourceGroupDeployment `
  -WhatIf `
  -TemplateFile azuredeploy.json
```

::: zone-end

::: zone pivot="bicepcli"

Run `az deployment group what-if` to perform the what-if operation:

```azurecli
az deployment group what-if \
  --template-file main.bicep
```

::: zone-end

::: zone pivot="jsoncli"

Run `az deployment group what-if` to perform the what-if operation:

```azurecli
az deployment group what-if \
  --template-file azuredeploy.json
```

::: zone-end

The what-if output is similar to the following one:

::: zone pivot="jsoncli,bicepcli"

[!include[](exercise/whatif-output-cli.md)]

::: zone-end

::: zone pivot="jsonpowershell,biceppowershell"

[!include[](exercise/whatif-output-powershell.md)]

::: zone-end

Notice that the result is color-coded in addition to having a prefix:

- Purple and **~** for any modifications
- Green and **+** for new resources to be created
- Orange and **-** for deletions

## Remove the resources in the template

::: zone pivot="jsonpowershell,jsoncli"

1. Update the *azuredeploy.json* file in Visual Studio Code, and remove all of the contents of the `resources` array. When you're done, your template should look like this:

   :::code language="json" source="code/4-template-empty.json" :::

1. Save the template.

::: zone-end

::: zone pivot="biceppowershell,bicepcli"

1. In the *main.bicep* file in Visual Studio Code, delete all of the contents of the file but don't delete the file itself.

1. Save the template.

::: zone-end

## Deploy by using complete mode and the confirmation option

In these next steps, you'll deploy an empty template over your existing environment.

::: zone pivot="biceppowershell,jsonpowershell"

> [!WARNING]
> Doing this in real life *will remove* anything you have in the cloud. The following code is interesting as an intellectual experiment, but be careful about using this mode. At minimum, use the `-Confirm` flag so you can stop this operation if you don't like the proposed changes.

::: zone-end

::: zone pivot="bicepcli,jsoncli"

> [!WARNING]
> Doing this in real life *will remove* anything you have in the cloud. The following code is interesting as an intellectual experiment, but be careful about using this mode. At minimum, use the `--confirm-with-what-if` flag so you can stop this operation if you don't like the proposed changes.

::: zone-end

::: zone pivot="biceppowershell"

1. Run `New-AzResourceGroupDeployment` with the `-Mode Complete` flag to execute the deployment in complete mode:

    ```powershell
    New-AzResourceGroupDeployment `
    -Mode Complete `
    -Confirm `
    -TemplateFile main.bicep
    ```

    [!include[](exercise/confirm-whatif-output-powershell.md)]

1. For **[A] Yes to All**, enter **A** to execute the deployment and clean out your environment.

::: zone-end

::: zone pivot="jsonpowershell"

1. Run `New-AzResourceGroupDeployment` with the `-Mode Complete` flag to execute the deployment in complete mode:

    ```powershell
    New-AzResourceGroupDeployment `
    -Mode Complete `
    -Confirm `
    -TemplateFile azuredeploy.json
    ```

    [!include[](exercise/confirm-whatif-output-powershell.md)]

1. For **[A] Yes to All**, enter **A** to execute the deployment and clean out your environment.

::: zone-end

::: zone pivot="bicepcli"

1. Run `az deployment group create` with the flag `--mode Complete` to create a deployment in complete mode:

    ```azurecli
    az deployment group create \
      --mode Complete \
      --confirm-with-what-if \
      --template-file main.bicep
    ```

    [!include[](exercise/confirm-whatif-output-cli.md)]

1. Enter **y** (for "yes") to execute the deployment and clean out your environment.

::: zone-end

::: zone pivot="jsoncli"

1. Run `az deployment group create` with the flag `--mode Complete` to create a deployment in complete mode:

    ```azurecli
    az deployment group create \
      --mode Complete \
      --confirm-with-what-if \
      --template-file azuredeploy.json
    ```

    [!include[](exercise/confirm-whatif-output-cli.md)]

1. Enter **y** (for "yes") to execute the deployment and clean out your environment.

::: zone-end

## Verify the deployment

Go back to the open browser that you used earlier. Verify that the virtual network is no longer there, as in this screenshot:

:::image type="content" source="../media/4-portal-deployment-complete-details.png" alt-text="Screenshot of the Azure portal interface for the complete deployment, with the virtual network resource no longer listed." :::
