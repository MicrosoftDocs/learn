> [!NOTE]
> The first time you activate a sandbox and accept the terms, your Microsoft account is associated with a new Azure directory named Microsoft Learn Sandbox. You're added to a special subscription named Concierge Subscription.

Here, you'll deploy a template that creates a virtual network in your sandbox subscription. After the deployment is complete, you'll deploy a template that's slightly different. The second deployment will include the what-if operation to review the expected changes.

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

## TODO bootstrapping

## Deploy the template

::: zone pivot="biceppowershell"

Run `New-AzResourceGroupDeployment` to deploy the template.

```powershell
New-AzResourceGroupDeployment `
  -TemplateFile main.bicep
```

You'll see the text **Running...** in the terminal. The deployment will take a minute or two to finish.

::: zone-end

::: zone pivot="jsonpowershell"

Run `New-AzResourceGroupDeployment` to deploy the template.

```powershell
New-AzResourceGroupDeployment `
  -TemplateFile azuredeploy.json
```

You'll see the text **Running...** in the terminal. The deployment will take a minute or two to finish.

::: zone-end

::: zone pivot="bicepcli"

Run `az deployment group create` to deploy the template.

```azurecli
az deployment group create \
  --template-file main.bicep
```

The deployment will take a minute or two to finish.

::: zone-end

::: zone pivot="jsoncli"

Run `az deployment group create` to deploy the template.

```azurecli
az deployment group create \
  --template-file azuredeploy.json
```

The deployment will take a minute or two to finish.

::: zone-end

## Verify the deployment in the portal

To validate that your deployment has been created and sent to Azure, you go to the [Azure portal](https://portal.azure.com?azure-portal=true) and make sure you're in the sandbox subscription:

   1. Select your avatar in the upper corner of the page.
   1. Select **Switch directory**. In the list, select the **Microsoft Learn Sandbox** directory.
   1. Select **Resource groups**.
   1. Select <rgn>[sandbox resource group name]</rgn>.
   1. In **Overview**, you see that one deployment succeeded.
   1. Select **1 Succeeded** to see the details of the deployment.

      :::image type="content" source="../media/3-portal-deployment-success.png" alt-text="Azure portal interface for the deployments with the one deployment listed and a succeeded status." border="true":::

   1. Select the **what-if-before** deployment to see what resources were deployed. In this case, one virtual network (address space 10.0.0.0/16) with two subnets has been deployed.

      :::image type="content" source="../media/3-portal-deployment-details.png" alt-text="Azure portal interface for the specific deployment with no resources listed." border="true":::

      :::image type="content" source="../media/3-portal-deployment-details-2.png" alt-text="Azure portal interface for the specific deployment with one virtual network resource listed." border="true":::

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
  -Whatif `
  -TemplateFile main.bicep
```

::: zone-end

::: zone pivot="jsonpowershell"

Run `New-AzResourceGroupDeployment` with the `-WhatIf` flag to perform the what-if operation.

```powershell
New-AzResourceGroupDeployment `
  -Whatif `
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

The what-if output is similar to:

```output
Note: As What-If is currently in preview, the result may contain false positive predictions (noise).
You can help us improve the accuracy of the result by opening an issue here: https://aka.ms/WhatIfIssues.

Resource and property changes are indicated with these symbols:
  - Delete
  + Create
  ~ Modify
  * Ignore

The deployment will update the following scope:

Scope: /subscriptions/11112222-3333-4444-5555-1111222233334444/resourceGroups/learn-2c05151d-0776-4ba4-b522-2543d030b66c

    ~ Microsoft.Network/virtualNetworks/vnet-001 [2018-10-01]
      - tags.Owner: "Team A"
[
  - 0: "10.0.0.0/16"
  + 0: "10.0.0.0/15"
  ]
[
  - 0:

      name:                     "subnet001"
      properties.addressPrefix: "10.0.0.0/24"

  ]

* Microsoft.Storage/storageAccounts/cloudshell666004860

Resource changes: 1 to modify, 1 to ignore.

>
```

You'll notice that the result is color coded in addition to having a prefix:

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

1. Run `New-AzResourceGroupDeployment` with the `-Mode Complete` flag to run the deployment in complete mode:

    ```powershell
    New-AzResourceGroupDeployment `
    -Mode Complete `
    -Confirm `
    -TemplateUri "https://raw.githubusercontent.com/Azure/azure-docs-json-samples/master/empty-template/azuredeploy.json"
    ```

    The output will be similar to the following text:

    ```powershell
    > New-AzResourceGroupDeployment `
    >> -Mode Complete `
    >> -Confirm `
    >> -TemplateUri "https://raw.githubusercontent.com/Azure/azure-docs-json-samples/master/empty-template/azuredeploy.json"

    Note: As What-If is currently in preview, the result may contain false positive predictions (noise).
    You can help us improve the accuracy of the result by opening an issue here: https://aka.ms/WhatIfIssues.

    Resource and property changes are indicated with this symbol:
      - Delete

    The deployment will update the following scope:

    Scope: /subscriptions/03821083-c843-496d-b555-65106b80c178/resourceGroups/learn-2c05151d-0776-4ba4-b522-2543d030b66c

      - Microsoft.Network/virtualNetworks/vnet-001

          id:              "/subscriptions/03821083-c843-496d-b555-65106b80c178/resourceGroups/learn-2c05151d-0776-4ba4-b522-2543d030b66c/providers/Microsoft.Network/virtualNetworks/vnet-001"
          location:        "westus"
          name:            "vnet-001"
          tags.CostCenter: "12345"
          tags.Owner:      "Team A"
          type:            "Microsoft.Network/virtualNetworks"

      - Microsoft.Storage/storageAccounts/cloudshell666004860

          id:
    "/subscriptions/03821083-c843-496d-b555-65106b80c178/resourceGroups/learn-2c05151d-0776-4ba4-b522-2543d030b66c/providers/Microsoft.Storage/storageAccounts/cloudshell666004860"
          kind:                   "Storage"
          location:               "eastus"
          name:                   "cloudshell666004860"
          sku.name:               "Standard_GRS"
          sku.tier:               "Standard"
          tags.ms-resource-usage: "azure-cloud-shell"
          tags.x-created-by:      "freelearning"
          type:                   "Microsoft.Storage/storageAccounts"

    Resource changes: 2 to delete.

    Are you sure you want to execute the deployment?
    [Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help (default is "Y"):
    ```

1. Enter **A** for **[A] Yes to All**, to execute the deployment and clean out your environment. When the deployment finishes, it will display the following results:

    ```output
    Are you sure you want to execute the deployment?
    [Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help (default is "Y"): A

    DeploymentName          : azuredeploy
    ResourceGroupName       : learn-2c05151d-0776-4ba4-b522-2543d030b66c
    ProvisioningState       : Succeeded
    Timestamp               : 2020-08-18 4:23:23 p.m.
    Mode                    : Complete
    TemplateLink            :
                              Uri            : https://raw.githubusercontent.com/Azure/azure-docs-json-samples/master/empty-template/azuredeploy.json
                              ContentVersion : 1.0.0.0

    Parameters              :
    Outputs                 :
    DeploymentDebugLogLevel :


    >
    ```

::: zone-end

::: zone pivot="bicepcli,jsoncli"

> [!WARNING]
> Doing this in real life *will remove* anything you have in the cloud. The following code is interesting as an intellectual experiment, but be careful about using this mode. At minimum, use the `-Confirm` flag so you can stop this operation if you don't like the proposed changes.

1. Run `az deployment group create` with the flag `--mode Complete` to create a deployment in complete mode:

    ```azurecli
    az deployment group create \
      --mode Complete \
      --confirm-with-what-if \
      --template-uri "https://raw.githubusercontent.com/Azure/azure-docs-json-samples/master/empty-template/azuredeploy.json"
    ```

    Your output will look similar to the following text:

    ```output
    Argument '--confirm-with-what-if' is in preview. It may be changed/removed in a future release.
    Note: As What-If is currently in preview, the result may contain false positive predictions (noise).
    You can help us improve the accuracy of the result by opening an issue here: https://aka.ms/WhatIfIssues.

    Resource and property changes are indicated with this symbol:
      - Delete

    The deployment will update the following scope:

    Scope: /subscriptions/11112222-3333-4444-5555-111122223333/resourceGroups/learn-2c05151d-0776-4ba4-b522-2543d030b66c

      - Microsoft.Network/virtualNetworks/vnet-001

          id:              "/subscriptions/11112222-3333-4444-5555-1111222233334444/resourceGroups/learn-2c05151d-0776-4ba4-b522-2543d030b66c/providers/Microsoft.Network/virtualNetworks/vnet-001"
          location:        "westus"
          name:            "vnet-001"
          tags.CostCenter: "12345"
          tags.Owner:      "Team A"
          type:            "Microsoft.Network/virtualNetworks"

    Resource changes: 1 to delete.

    Are you sure you want to execute the deployment? (y/n):
    ```

    Note how the last line of the output is a confirmation. It's asking you to select **y** or **n** to proceed.

1. Enter **y** (for "yes") to confirm deployment.

    ```output
    Are you sure you want to execute the deployment? (y/n): y
    {- Finished ..
      "id": "/subscriptions/03821083-c843-496d-b555-65106b80c178/resourceGroups/learn-2c05151d-0776-4ba4-b522-2543d030b66c/providers/Microsoft.Resources/deployments/azuredeploy",
      "location": null,
      "name": "azuredeploy",
      "properties": {
        "correlationId": "bf585ec3-1511-462c-b20e-87a357fa835e",
        "debugSetting": null,
        "dependencies": [],
        "duration": "PT1M5.1558557S",
        "error": null,
        "mode": "Complete",
        "onErrorDeployment": null,
        "outputResources": [],
        "outputs": null,
        "parameters": null,
        "parametersLink": null,
        "providers": [],
        "provisioningState": "Succeeded",
        "templateHash": "1785727386360713170",
        "templateLink": {
          "contentVersion": "1.0.0.0",
          "id": null,
          "relativePath": null,
          "uri": "https://raw.githubusercontent.com/Azure/azure-docs-json-samples/master/empty-template/azuredeploy.json"
        },
        "timestamp": "2020-08-18T18:56:54.970750+00:00",
        "validatedResources": null
      },
      "resourceGroup": "learn-2c05151d-0776-4ba4-b522-2543d030b66c",
      "tags": null,
      "type": "Microsoft.Resources/deployments"
    }
    ```

::: zone-end

## Verify the deployment

Go back to the open browser that you used earlier, and verify that there were two successful deployments:

- The first one that you deployed
- The complete one that removed all resources, so the virtual network is no longer there

:::image type="content" source="../media/3-portal-deployment-complete-details.png" alt-text="Azure portal interface for the complete deployment with the virtual network resource no longer listed." border="true":::
