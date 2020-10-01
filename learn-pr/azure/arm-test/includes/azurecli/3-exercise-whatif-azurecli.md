## Prerequisites

- **Install Visual Studio Code extension**. This exercise uses the [Azure Resource Manager Tools for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=msazurermtools.azurerm-vscode-tools). Be sure to install this extension in Visual Studio Code.

- **Install latest Azure CLI**. To use what-if in Azure CLI, you must have Azure CLI 2.5.0 or later. If needed, [install the latest version of Azure CLI](https://docs.microsoft.com/cli/azure/install-azure-cli?view=azure-cli-latest).

## Deploy the first ARM Template

Here's an overview of the steps you are about to carry out:

- **Sign in to Azure**. You will be able to sign in using Visual Studio Code and using the integrated terminal.
- **Set the active subscription**. This can be accomplished by invoking a Azure CLI command.
- **Set default resource group**. This can be accomplished by invoking a Azure CLI command. The reason for setting these default values on subscription and resource group is to ensure the resources are created in the correct place.
- **Carry out the deployment**. This step involves using the command **az deployment group create** with a URL to a template as an argument.

## Sign in to Azure

1. Open the integrated terminal in Visual Studio Code. Be sure you are signing in to the same account that activated the sandbox.

1. Run `az login` to login from the Visual Studio Code terminal.

    ```azurecli
    az login
    ```

  1. Select an appropriate user in the browser and close browser window when prompted.

     Once you are logged in, you see a list, in JSON format. The list contains subscriptions associated with this account in the terminal, if you activated the sandbox.

## Set the active subscription

Run `az account set` to set a specific subscription as active:

```azurecli
   az account set -s "Concierge Subscription"
```

This will set the active subscription to that of the *Concierge Subscription*.

> [!NOTE]
> if it fails, run `az account list --refresh --all` and then rerun the command

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

  Use the name of the resource name provided by the last command in this command. (It will look like something like **learn-a73131a1-b618-48b8-af70-21af7ca420c4**). Using the name, will allow you to omit that parameter from the rest of the Azure PowerShell commands in this exercise.

  > [!NOTE]
  > Normally, when you use an Azure CLI command to deploy a template you need to specify the target **resource group** name.  In the exercise in this module we are bypassing this requirement by setting the context of our deployment by specifying our sandbox resource group name in the step below by using the **az configure** Azure CLI command.

## Deploy the first template to Azure

Now that you have setup your subscription in the Visual Studio Code (Visual Studio Code) terminal, you are ready to deploy the ARM template to Azure. The ARM template doesn't have any resources yet, so you won't see any resources being created. However, you'll see a successful deployment.

Run `az deployment group create` to deploy the template:

   ```azurecli
   az deployment group create \
      --template-uri "https://raw.githubusercontent.com/Azure/azure-docs-json-samples/master/azure-resource-manager/what-if/what-if-before.json"
   ```

   The terminal output will show ```Running...```. When that finishes, the results of the above command will be something similar to the below output:

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

  The above output indicates that your deployment succeeded as part of the response states **"provisioningState": "Succeeded"**.

## Verify the deployment in the portal

To validate that your deployment has been created and sent to Azure you can navigate to the Azure portal, [Azure portal](https://portal.azure.com?azure-portal=true), make sure you are in the sandbox subscription.

   1. Select your avatar in the upper top corner of the page.
   1. Choose **Switch directory**. In the list, choose the **Microsoft Learn Sandbox** directory.
   1. Choose *Resource groups*.
   1. Select <rgn>[sandbox resource group name]</rgn>.
   1. In the **Overview**, you see one deployment succeeded.
   1. Select **1 Succeeded** to see the details of the deployment.

   :::image type="content" source="../../media/3-portal-deployment-success.png" alt-text="Azure portal interface for the deployments with the one deployment listed and a succeeded status." border="true":::

   1. Select the **what-if-before** deployment to see what resources were deployed. In this case, one VNet (address space 10.0.0.0/16) with two subnets have been deployed.

   :::image type="content" source="../../media/3-portal-deployment-details.png" alt-text="Azure portal interface for the specific deployment with no resources listed." border="true":::

   :::image type="content" source="../../media/3-portal-deployment-details-2.png" alt-text="Azure portal interface for the specific deployment with VNet resource listed." border="true":::

   Leave the page open in your browser. You will check on deployments again.

## Deploy the modified template in the same environment

Now that you've deployed the template, you're ready to test the *what-if* operation. This time you will deploy a template that changes the virtual network you deployed in un the first part.

The differences in the second template are:

- **Tag removed**. The original tag was removed.
- **Subnet removed**. A subnet has been removed.
- **Prefix changed**. Address prefix has changed.

1. Run **az deployment group what-if** to carry out the *what-if* operation**:

    ```azurecli
    az deployment group what-if \
      --template-uri "https://raw.githubusercontent.com/Azure/azure-docs-json-samples/master/azure-resource-manager/what-if/what-if-after.json"
    ```

    The *what-if* output appears similar to:

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

   You'll notice that the result is color coded in addition to a "prefix"

      - **Purple** and "~" for any modifications
      - **Green** and "+" for new resources to be created
      - **Orange** and "-" for deletion.

## Deploy using Complete mode and the confirm-with-what-if option

In these next steps, you will deploy an empty template over your existing environment.

> [!WARNING]
> Doing this in real life *will remove* anything you have in the cloud. The below is interesting as an intellectual experiment but be careful of using this mode. At minimum use the `-Confirm` flag so you have a chance to abort this operation if the proposed changes is not to your liking.

1. Run `az deployment group` with the flag `--mode Complete` to create the a deployment in *complete mode*:

    ```azurecli
    az deployment group \
      --mode Complete \
      --confirm-with-what-if \
      --template-uri "https://raw.githubusercontent.com/Azure/azure-docs-json-samples/master/empty-template/azuredeploy.json"
    ```

    Your output will look similar to the below text:

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

    Note above how the last line of the output is a confirmation, asking you to select **y/n** to proceed.

1. Type **y** for **Yes** to *Confirm deployment*. :

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

1. Navigate back to the open browser you used earlier, and verify that there were two successful deployments.

    1. The first one you deployed.
    1. The complete one that removed all resources, and the VNet is no longer there.

   :::image type="content" source="../../media/3-portal-deployment-complete-details.png" alt-text="Azure portal interface for the complete deployment with VNet resource no longer listed." border="true":::
