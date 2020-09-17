
> [!NOTE]
> The first time you activate a sandbox and accept the terms, your Microsoft account is associated with a new Azure directory named Microsoft Learn Sandbox. You're added to a special subscription named Concierge Subscription.

Here, you will deploy an Azure Resource Manager (ARM) template from a sample repository that deploys a Virtual Network (VNet) in your sandbox subscription. Once the deployment is complete, you will then deploy a template that is slightly different. It differs in the following ways:

1. **Changed address space**. A change of address space in a virtual subnet
1. **Additional subnet**. An additional subnet in the virtual network

The second deployment will include the *what-if* operation in order to review the expected changes.

## Prerequisites

- **Install Visual Studio Code extension**. This exercise uses the [Azure Resource Manager Tools for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=msazurermtools.azurerm-vscode-tools). Be sure to install this extension in Visual Studio Code.

- **Install latest Azure CLI**. To use what-if in Azure CLI, you must have Azure CLI 2.5.0 or later. If needed, [install the latest version of Azure CLI](https://docs.microsoft.com/cli/azure/install-azure-cli?view=azure-cli-latest).

## Deploy the first ARM Template

You will be able to deploy your ARM Template by carrying out the following steps:

1. **Sign in to Azure**. You will be able to sign in using Visual Studio Code and using the integrated terminal.
1. **Set the active subscription**. This can be accomplished by invoking a PowerShell cmdlet.
1. **Set default resource group**. Also this can be done by invoking a PowerShell cmdlet. The reason for setting these default values on subscription and resource group is to ensure the resources are created in the correct place.
1. **Carry out the deployment**. This step involves using the command **az deployment group create** with a URL to a template as an argument.

### Sign in to Azure

1. **Open the integrated terminal in Visual Studio Code**. Be sure you are signing in to the same account that activated the sandbox.

1. **Sign in to Azure**. From the Visual Studio Code terminal, run this command to sign in to Azure. Running this command will open a browser that allows you to sign in to your account.

    ```azurecli
    az login
    ```

    Select an appropriate user in the browser and close browser window when prompted.

   Once you are logged in, you see a JSON list of the subscriptions associated with this account in the terminal, if you activated the sandbox.

### Set the active subscription

1. **Get the subscription ID**. The command will list your subscriptions and their IDs. The subscription ID is the second column. Look for Concierge Subscription and copy the SubscriptionId (third column). It will look something like *cf49fbbc-217c-4eb6-9eb5-a6a6c68295a0*.

    ```azurecli
    az account list -o table
    ```

1. **Change your active subscription to the Concierge Subscription**. Be sure to substitute *{Your subscription ID}* with the ID of the Concierge Subscription you just got in the last command.

    ```azurecli
    az account set -s {Your subscription ID}
    ```

### Set the default resource group

1. You now need to set the resource group created for you in the sandbox as the default resource group. To perform that operation:

    1. **Get the resource group name**. You first need to get the resource group name by using the following command.

       ```azurecli
       az group list -o table
       ```

    1. **Set the default name**. Use the name of the resource name provided by the last command in this command. (It will look like something like **learn-a73131a1-b618-48b8-af70-21af7ca420c4**). Using the name, will allow you to omit that parameter from the rest of the Azure PowerShell commands in this exercise.

       ```azurecli
       az configure --defaults group=resource group name
       ```

    > [!NOTE]
    > Normally, when you use an Azure CLI command to deploy a template you need to specify the target **resource group** name.  In the exercise in this module we are bypassing this requirement by setting the context of our deployment by specifying our sandbox resource group name in the step below by using the **az configure** Azure CLI command.

### Deploy the first template to Azure

Now that you have setup your subscription in the Visual Studio Code (Visual Studio Code) terminal, you are ready to deploy the ARM template to Azure. The ARM template doesn't have any resources yet, so you won't see any resources being created. However, you'll see a successful deployment.

1. **Deploy the template**. Type the following command in the terminal:

    ```azurecli
    az deployment group create \
      --template-uri "https://raw.githubusercontent.com/Azure/azure-docs-json-samples/master/azure-resource-manager/what-if/what-if-before.json"
    ```

    The terminal output will show ```Running...```. When that finishes, the results of the above command will be something similar to the below output:

    ```output
    {
      "id": "/subscriptions/03821083-c843-496d-b555-65106b80c178/resourceGroups/learn-2c05151d-0776-4ba4-b522-2543d030b66c/providers/Microsoft.Resources/deployments/what-if-before",
      "location": null,
      "name": "what-if-before",
      "properties": {
        "correlationId": "26078ea9-518b-43f7-923c-dd8cbf7d1f0e",
        "debugSetting": null,
        "dependencies": [],
        "duration": "PT10.5969509S",
        "mode": "Incremental",
        "onErrorDeployment": null,
            "id": "/subscriptions/03821083-c843-496d-b555-65106b80c178/resourceGroups/learn-2c05151d-0776-4ba4-b522-2543d030b66c/providers/Microsoft.Network/virtualNetworks/vnet-001",
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

1. **Verify the deployment in the portal**. To validate that your deployment has been created and sent to Azure you can navigate to the Azure portal, [Azure portal](https://portal.azure.com?azure-portal=true), make sure you are in the sandbox subscription.

   1. Select your avatar in the upper right corner of the page.
   1. Choose **Switch directory**. In the list, choose the **Microsoft Learn Sandbox** directory.
   1. On the left side panel, choose *Resource groups*.
   1. Select <rgn>[sandbox resource group name]</rgn>.
   1. In the *Overview*, you see one deployment succeeded.
   1. Select *1 Succeeded* to see the details of the deployment.

   :::image type="content" source="../../media/3-portal-deployment-success.png" alt-text="Azure portal interface for the deployments with the one deployment listed and a succeeded status." border="true":::

1. **Inspect deployment details**. Click the *what-if-before* deployment to see what resources were deployed. In this case, one VNet (address space 10.0.0.0/16) with two subnets have been deployed.

   :::image type="content" source="../../media/3-portal-deployment-details.png" alt-text="Azure portal interface for the specific deployment with no resources listed." border="true":::

   :::image type="content" source="../../media/3-portal-deployment-details-2.png" alt-text="Azure portal interface for the specific deployment with VNet resource listed." border="true":::

Leave the page open in your browser. You will check on deployments again.

## Deploy the modified template in the same environment

Now that you've deployed the template, you're ready to test the *what-if* operation. This time you will deploy a template that changes the virtual network you deployed in un the first part.

The differences in the second template are:

- **Tag removed**. The original tag was removed.
- **Subnet removed**. A subnet has been removed.
- **Prefix changed**. Address prefix has changed.

1. **Perform the *what-if* operation**. Type in the following Azure CLI command in the terminal:

    ```azurecli
    az deployment group \
      what-if \
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

    Scope: /subscriptions/03821083-c843-496d-b555-65106b80c178/resourceGroups/learn-2c05151d-0776-4ba4-b522-2543d030b66c

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

1. **Run the deployment in complete mode**. Type the following Azure CLI command:

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

    Scope: /subscriptions/03821083-c843-496d-b555-65106b80c178/resourceGroups/learn-2c05151d-0776-4ba4-b522-2543d030b66c

      - Microsoft.Network/virtualNetworks/vnet-001

          id:              "/subscriptions/03821083-c843-496d-b555-65106b80c178/resourceGroups/learn-2c05151d-0776-4ba4-b522-2543d030b66c/providers/Microsoft.Network/virtualNetworks/vnet-001"
          location:        "westus"
          name:            "vnet-001"
          tags.CostCenter: "12345"
          tags.Owner:      "Team A"
          type:            "Microsoft.Network/virtualNetworks"

    Resource changes: 1 to delete.

    Are you sure you want to execute the deployment? (y/n):
    ```

    Note above how the last line of the output is a confirmation, asking you to select **y/n** to proceed.

1. **Confirm deployment**. Type **y** for **Yes**. The command completes with an output similar to the below:

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

1. **Verify deployment**. Navigate back to the open browser you used earlier, and verify that there were two successful deployments.

    1. The first one you deployed.
    1. The complete one that removed all resources, and the VNet is no longer there.

   :::image type="content" source="../../media/3-portal-deployment-complete-details.png" alt-text="Azure portal interface for the complete deployment with VNet resource no longer listed." border="true":::
