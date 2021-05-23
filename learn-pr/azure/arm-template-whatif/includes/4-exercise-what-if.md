[!INCLUDE [Sandbox explanation](../../../bicep/shared/includes/bicep-sandbox-subscription.md)]

Here, you'll deploy a template that creates a virtual network in your sandbox subscription. After the deployment is complete, you'll deploy a template that's slightly different. The second deployment will include the what-if operation to review the expected changes.

::: zone pivot="biceppowershell,bicepcli"

This exercise uses [the Bicep extension for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-bicep). Be sure to install this extension in Visual Studio Code.

::: zone-end

## Create the starting template

You start with an existing template that your team has been using. The template creates the virtual network.

::: zone pivot="jsonpowershell,jsoncli"

1. Open Visual Studio Code.

1. Create a new file called *azuredeploy.json*.

1. Copy the following code into *azuredeploy.json*.

   :::code language="json" source="code/4-template-before.json" :::

1. Save the template.

::: zone-end

::: zone pivot="biceppowershell,bicepcli"

1. Open Visual Studio Code.

1. Create a new file called *main.bicep*.

1. Copy the following code into *main.bicep*.

   :::code language="bicep" source="code/4-template-before.bicep" :::

1. Save the template.

::: zone-end

## Deploy the template to Azure

::: zone pivot="biceppowershell"

[!include[](../../../bicep/shared/includes/bicep-exercise-deploy-powershell.md)]

::: zone-end

::: zone pivot="bicepcli"

[!include[](../../../bicep/shared/includes/bicep-exercise-deploy-cli.md)]

::: zone-end

::: zone pivot="jsonpowershell"

[!include[](exercise/json-exercise-deploy-powershell.md)]

::: zone-end

::: zone pivot="jsoncli"

[!include[](exercise/json-exercise-deploy-cli.md)]

::: zone-end

::: zone pivot="biceppowershell"

### Deploy the template using Azure PowerShell

Run `New-AzResourceGroupDeployment` to deploy the template.

```powershell
New-AzResourceGroupDeployment -TemplateFile main.bicep
```

You'll see the text **Running...** in the terminal. The deployment will take a minute or two to finish.

::: zone-end

::: zone pivot="jsonpowershell"

### Deploy the template using Azure PowerShell

Run `New-AzResourceGroupDeployment` to deploy the template.

```powershell
New-AzResourceGroupDeployment -TemplateFile azuredeploy.json
```

You'll see the text **Running...** in the terminal. The deployment will take a minute or two to finish.

::: zone-end

::: zone pivot="bicepcli"

### Deploy the template using the Azure CLI

Run `az deployment group create` to deploy the template.

```azurecli
az deployment group create --template-file main.bicep
```

The deployment will take a minute or two to finish.

::: zone-end

::: zone pivot="jsoncli"

### Deploy the template using the Azure CLI

Run `az deployment group create` to deploy the template.

```azurecli
az deployment group create --template-file azuredeploy.json
```

The deployment will take a minute or two to finish.

::: zone-end

## Verify the deployment

To validate that your deployment has been created and sent to Azure, you go to the [Azure portal](https://portal.azure.com?azure-portal=true) and make sure you're in the sandbox subscription:

   1. Select your avatar in the upper corner of the page.

   1. Select **Switch directory**. In the list, select the **Microsoft Learn Sandbox** directory.

   1. Select **Resource groups**.

   1. Select <rgn>[sandbox resource group name]</rgn>.

   1. In **Overview**, you see that one deployment succeeded.

   1. Select **1 Succeeded** to see the details of the deployment.

      :::image type="content" source="../media/4-portal-deployment-success.png" alt-text="Azure portal interface for the deployments with the one deployment listed and a succeeded status." border="true":::

   1. Select the **main** deployment to see what resources were deployed. In this case, one virtual network (address space 10.0.0.0/16) with two subnets has been deployed.

      :::image type="content" source="../media/4-portal-deployment-details.png" alt-text="Azure portal interface for the specific deployment with no resources listed." border="true":::

      :::image type="content" source="../media/4-portal-deployment-details-2.png" alt-text="Azure portal interface for the specific deployment with one virtual network resource listed." border="true":::

      Leave the page open in your browser. You'll check on deployments again later.

## Modify the template

::: zone pivot="jsonpowershell,jsoncli"

1. In the *azuredeploy.json* file in Visual Studio Code, delete the tag named `Owner` and its value. After you're done, the `tags` property of the virtual network should look like this: 

   :::code language="json" source="code/4-template-after.json" range="12-14" :::

1. Update the `addressPrefixes` to change the `/16` to `/15`. After you're done, the `addressSpace` property of the virtual network should look like this:

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

The what-if output is similar to the below:

::: zone pivot="jsoncli,bicepcli"

# [Screenshot](#tab/screenshpt)

:::image type="content" source="../media/4-whatif-cli.png" alt-text="Screenshot of the Azure CLI showing the output from the what-if operation." border="true":::

# [Text](#tab/text)

```output
Note: The result may contain false positive predictions (noise).
You can help us improve the accuracy of the result by opening an issue here: https://aka.ms/WhatIfIssues.

Resource and property changes are indicated with these symbols:
  - Delete
  + Create
  ~ Modify

The deployment will update the following scope:

Scope: /subscriptions/b4219936-de68-4fe4-8393-4bd7d7f7fe99/resourceGroups/learn-31a62588-9867-48a4-9e6b-666a7bdbefff

  ~ Microsoft.Network/virtualNetworks/vnet-001 [2018-10-01]
    - tags.Owner:                    "Team A"
    + properties.enableVmProtection: false
    ~ properties.addressSpace.addressPrefixes: [
      - 0: "10.0.0.0/16"
      + 0: "10.0.0.0/15"
      ]
    ~ properties.subnets: [
      - 0:

          name:                     "subnet001"
          properties.addressPrefix: "10.0.0.0/24"

      ]

Resource changes: 1 to modify.
```

---

::: zone-end

::: zone pivot="jsonpowershell,biceppowershell"

# [Screenshot](#tab/screenshpt)

:::image type="content" source="../media/4-whatif-powershell.png" alt-text="Screenshot of Azure PowerShell showing the output from the what-if operation." border="true":::

# [Text](#tab/text)

```output
Note: The result may contain false positive predictions (noise).
You can help us improve the accuracy of the result by opening an issue here: https://aka.ms/WhatIfIssues.

Resource and property changes are indicated with these symbols:
  - Delete
  + Create
  ~ Modify
  * Ignore

The deployment will update the following scope:

Scope: /subscriptions/b4219936-de68-4fe4-8393-4bd7d7f7fe99/resourceGroups/learn-31a62588-9867-48a4-9e6b-666a7bdbefff

  ~ Microsoft.Network/virtualNetworks/vnet-001 [2018-10-01]
    - tags.Owner:                    "Team A"
    + properties.enableVmProtection: false
    ~ properties.addressSpace.addressPrefixes: [
      - 0: "10.0.0.0/16"
      + 0: "10.0.0.0/15"
      ]
    ~ properties.subnets: [
      - 0:

          name:                     "subnet001"
          properties.addressPrefix: "10.0.0.0/24"

      ]

  * Microsoft.Storage/storageAccounts/cloudshell843483168

Resource changes: 1 to modify, 1 to ignore.
```

---

::: zone-end

You'll notice that the result is color-coded in addition to having a prefix:

- Purple and **~** for any modifications
- Green and **+** for new resources to be created
- Orange and **-** for deletions

## Remove the resources in the template

::: zone pivot="jsonpowershell,jsoncli"

1. Update the *azuredeploy.json* file in Visual Studio Code, remove all of the contents of the `resources` array. When you're done, your template should look like this:

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

1. Run `New-AzResourceGroupDeployment` with the `-Mode Complete` flag to run the deployment in complete mode:

    ```powershell
    New-AzResourceGroupDeployment `
    -Mode Complete `
    -Confirm `
    -TemplateFile main.bicep
    ```

    [!include[](exercise/confirm-whatif-output-powershell.md)]

1. Enter **A** for **[A] Yes to All**, to execute the deployment and clean out your environment.

::: zone-end

::: zone pivot="jsonpowershell"

1. Run `New-AzResourceGroupDeployment` with the `-Mode Complete` flag to run the deployment in complete mode:

    ```powershell
    New-AzResourceGroupDeployment `
    -Mode Complete `
    -Confirm `
    -TemplateFile azuredeploy.json
    ```

    [!include[](exercise/confirm-whatif-output-powershell.md)]

1. Enter **A** for **[A] Yes to All**, to execute the deployment and clean out your environment.

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

Go back to the open browser that you used earlier, and verify that the virtual network is no longer there, as in this screenshot:

:::image type="content" source="../media/4-portal-deployment-complete-details.png" alt-text="Azure portal interface for the complete deployment with the virtual network resource no longer listed." border="true":::
