## Prerequisites

- **Install the Visual Studio Code extension**. This exercise uses [Azure Resource Manager Tools for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=msazurermtools.azurerm-vscode-tools). Be sure to install this extension in Visual Studio Code.

- **Install the latest Azure CLI**. To use what-if in the Azure CLI, you must have Azure CLI 2.5.0 or later. If needed, [install the latest version of the Azure CLI](https://docs.microsoft.com/cli/azure/install-azure-cli?view=azure-cli-latest&azure-portal=true).

## Deploy the first ARM template

Here's an overview of the steps you're about to carry out:

- **Sign in to Azure**. You can sign in by using Visual Studio Code and the integrated terminal.
- **Set the active subscription**. You can accomplish this by using an Azure CLI command.
- **Set the default resource group**. You can accomplish this by using an Azure CLI command. The reason for setting these default values on the subscription and resource group is to ensure that the resources are created in the correct place.
- **Carry out the deployment**. This step involves using the command **az deployment group create** with a URL to a template as an argument.

## Sign in to Azure

1. Open the integrated terminal in Visual Studio Code. Be sure you're signing in to the same account that activated the sandbox.

1. Run `az login` to sign in from the Visual Studio Code terminal.

    ```azurecli
    az login
    ```

1. Select an appropriate user in the browser, and close the browser window when prompted.

After you're signed in, you see a list in JSON format. The list contains subscriptions associated with this account in the terminal, if you activated the sandbox.

## Set the active subscription

Run `az account set` to set a specific subscription as active:

```azurecli
   az account set -s "Concierge Subscription"
```

This command will set the active subscription to that of the Concierge Subscription.

> [!NOTE]
> If it fails, run `az account list --refresh --all` and then rerun the command.

## Set the default resource group

You now need to set the resource group created for you in the sandbox as the default resource group.

1. Run `az group list` to get the resource group name.

   ```azurecli
   az group list -o table
   ```

1. Run `az configure` to set the default name.

   ```azurecli
   az configure --defaults group=<rgn>resource group name</rgn>
   ```

  In this command, use the name of the resource that the last command provided. (It will look like something like **learn-a73131a1-b618-48b8-af70-21af7ca420c4**.) Using the name will allow you to omit that parameter from the rest of the Azure PowerShell commands in this exercise.

  > [!NOTE]
  > Normally, when you use an Azure CLI command to deploy a template, you need to specify the target *resource group* name. In the exercise in this module, we're bypassing this requirement by setting the context of our deployment by specifying our sandbox resource group name in the next step through the **az configure** Azure CLI command.

## Deploy the first template to Azure

Now that you've set up your subscription in the Visual Studio Code terminal, you're ready to deploy the ARM template to Azure. The ARM template doesn't have any resources yet, so you won't see any resources being created. However, you'll see a successful deployment.

Run `az deployment group create` to deploy the template:

```azurecli
   az deployment group create \
      --template-uri "https://raw.githubusercontent.com/Azure/azure-docs-json-samples/master/azure-resource-manager/what-if/what-if-before.json"
   ```

The terminal output will show **Running...**. When that finishes, the results of the preceding command will be similar to the following output:

```output
{
   "id": "/subscriptions/00000000-1111-2222-333-4444444444444/resourceGroups/learn-2c05151d-0776-4ba4-b522-2543d030b66c/providers/Microsoft.Resources/deployments/what-if-before",
   "location": null,
   "name": "what-if-before",
   "properties": {
     "correlationId": "26078ea9-518b-43f7-923c-dd8cbf7d1f0e",
     "debugSetting": null,
     "dependencies": [],
     "duration": "PT10.5969509S",
     "mode": "Incremental",
     "onErrorDeployment": null,
         "id": "/subscriptions/00000000-1111-2222-3333-444455556666777/resourceGroups/learn-2c05151d-0776-4ba4-b522-2543d030b66c/providers/Microsoft.Network/virtualNetworks/vnet-001",
         "resourceGroup": "learn-2c05151d-0776-4ba4-b522-2543d030b66c"
       }
     ],
     "outputs": null,
     "parameters": {},
     "parametersLink": null,
     "providers": [
       {
         "id": null,
         "namespace": "Microsoft.Network",
         "registrationPolicy": null,
         "registrationState": null,
         "resourceTypes": [
           {
             "aliases": null,
             "apiVersions": null,
             "capabilities": null,
             "locations": [
               "westus"
             ],
             "properties": null,
             "resourceType": "virtualNetworks"
           }
         ]
       }
     ],
     "provisioningState": "Succeeded",
     "template": null,
     "templateHash": "1122925147183376254",
     "templateLink": {
       "contentVersion": "1.0.0.0",
       "uri": "https://raw.githubusercontent.com/Azure/azure-docs-json-samples/master/azure-resource-manager/what-if/what-if-before.json"
        },
     "timestamp": "2020-08-18T17:21:40.064344+00:00"
   },
   "resourceGroup": "learn-2c05151d-0776-4ba4-b522-2543d030b66c",
   "type": "Microsoft.Resources/deployments"
}
```

The preceding output indicates that your deployment succeeded. Part of the response states **"provisioningState": "Succeeded"**.

## Verify the deployment in the portal

To validate that your deployment has been created and sent to Azure, you go to the [Azure portal](https://portal.azure.com?azure-portal=true) and make sure you're in the sandbox subscription:

1. Select your avatar in the upper corner of the page.
1. Select **Switch directory**. In the list, select the **Microsoft Learn Sandbox** directory.
1. Select **Resource groups**.
1. Select <rgn>[sandbox resource group name]</rgn>.
1. In **Overview**, you see that one deployment succeeded.
1. Select **1 Succeeded** to see the details of the deployment.

   :::image type="content" source="../../media/3-portal-deployment-success.png" alt-text="Azure portal interface for the deployments with the one deployment listed and a succeeded status." border="true":::

1. Select the **what-if-before** deployment to see what resources were deployed. In this case, one virtual network (address space 10.0.0.0/16) with two subnets has been deployed.

   :::image type="content" source="../../media/3-portal-deployment-details.png" alt-text="Azure portal interface for the specific deployment with no resources listed." border="true":::

   :::image type="content" source="../../media/3-portal-deployment-details-2.png" alt-text="Azure portal interface for the specific deployment with one virtual network resource listed." border="true":::

Leave the page open in your browser. You'll check on deployments again.

## Deploy the modified template in the same environment

> [!NOTE]
> You will need to have carried out the prerequisite step of setting a default resource group in the Sandbox or the commands will fail as they normally require the parameter --resource-group to be specified.

Now that you've deployed the template, you're ready to test the what-if operation. This time, you'll deploy a template that changes the virtual network that you deployed in the first part.

The differences in the second template are:

- **Tag removed**. The original tag was removed.
- **Subnet removed**. A subnet has been removed.
- **Prefix changed**. The address prefix has changed.

Run `az deployment group create`, with flag `--confirm-with-what-if`, to carry out the what-if operation:

```azurecli
az deployment group create \
  --confirm-with-what-if \
  --template-uri "https://raw.githubusercontent.com/Azure/azure-docs-json-samples/master/azure-resource-manager/what-if/what-if-after.json"
```

The what-if output is similar to:

```output
This command is in preview. It may be changed/removed in a future release.
Note: As What-If is currently in preview, the result may contain false positive predictions (noise).
You can help us improve the accuracy of the result by opening an issue here: https://aka.ms/WhatIfIssues.

Resource and property changes are indicated with these symbols:
  - Delete
  + Create
  ~ Modify

The deployment will update the following scope:

Scope: /subscriptions/11112222-3333-4444-5555-1111222233334444/resourceGroups/learn-2c05151d-0776-4ba4-b522-2543d030b66c

  ~ Microsoft.Network/virtualNetworks/vnet-001 [2018-10-01]
    - tags.Owner: "Team A"
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

You'll notice that the result is color coded in addition to having a prefix:

- Purple and **~** for any modifications
- Green and **+** for new resources to be created
- Orange and **-** for deletions

## Deploy by using complete mode and the confirm-with-what-if option

In these next steps, you'll deploy an empty template over your existing environment.

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

1. Go back to the open browser that you used earlier, and verify that there were two successful deployments:

    - The first one that you deployed
    - The complete one that removed all resources, so the virtual network is no longer there

   :::image type="content" source="../../media/3-portal-deployment-complete-details.png" alt-text="Azure portal interface for the complete deployment with the virtual network resource no longer listed." border="true":::
