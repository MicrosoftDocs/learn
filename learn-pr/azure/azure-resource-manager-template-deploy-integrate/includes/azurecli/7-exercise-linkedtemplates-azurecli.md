### Sign in to Azure

1. From the terminal in Visual Studio Code, run this command to sign in to Azure. Running this command will open a browser that allows you to sign in to your account.

    ```azurecli
    az login
    ```

1. Once you are logged in, you see a JSON list of the subscriptions associated with this account in the terminal. If you activated the sandbox.
1. Get the subscription ID. The command will list your subscriptions and their IDs. The subscription ID is the second column. Look for Concierge Subscription and copy the SubscriptionId (third column). It will look something like cf49fbbc-217c-4eb6-9eb5-a6a6c68295a0

    ```azurecli
    az account list -o table
    ```

1. Change your active subscription to the Concierge Subscription. Be sure to substitute {Your subscription ID} with the ID of the Concierge Subscription you just got in the last command.

    ```azurecli
    az account set -s {Your subscription ID}
    ```

### Set the default resource group

1. You now need to set the resource group created for you in the sandbox as the default resource group.  To perform that operation you first need to get the resource group name by using the following command.

    ```azurecli
    az group list -o table
    ```

    And use the name of the resource name provided by the last command in this command. (It will look like something like **learn-a73131a1-b618-48b8-af70-21af7ca420c4**) This allows you to omit that parameter from the rest of the Azure CLI commands in this exercise.

    > [!NOTE] Normally, when you use an Azure CLI command to deploy a template you need to specify the target **resource group** name.  In the exercise in this module we are bypassing this requirement by setting the context of our deployment by specifying our sandbox resource group name in the step below by using the **[az configure](https://docs.microsoft.com/cli/azure/azure-cli-configuration?view=azure-cli-latest&WT.mc_id=mslearn-arm-pierrer)** Azure CLI command.

    ```azurecli
    az configure --defaults group={Resource Group Name}
    ```


## Deploying a linked template

In this exercise, we will review and deploy a template that includes two linked templates.

1. To add a linked template to your ARM template, add a **Microsoft.Resources/deployments** resource and the **templateLink** property configured with the location of the template.

    In the sample template below, you will notice that there are two variable that define remote or external templates located on a GitHub repo.

    - "linked-template": "https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/101-storage-account-create/azuredeploy.json"
    - "linked-template-2": "https://raw.githubusercontent.com/Azure/azure-docs-json-samples/master/azure-resource-manager/what-if/what-if-before.json"

    Review the template and note the **"type": "Microsoft.Resources/deployments"** sections that define where and how the linked templates will be deployed.

    The fist linked template deploys a storage account.  it consumes the parent parameters and deploys the storage template.

    The second linked template is configured to depend on the storage deployment, and to deploy a virtual network template.

    ```json
    {
    "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
    "contentVersion": "1.0.0.0",
    "parameters": {
        "name": {
            "type": "string",
            "defaultValue": "linkeddemo001"
        }
    },
    "variables": {
        "linked-template": "https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/101-storage-account-create/azuredeploy.json",
        "linked-template-2": "https://raw.githubusercontent.com/Azure/azure-docs-json-samples/master/azure-resource-manager/what-if/what-if-before.json"
    },
    "resources": [
        {
            "name": "storage",
            "type": "Microsoft.Resources/deployments",
            "apiVersion": "2019-10-01",
            "properties": {
                "mode": "Incremental",
                "templateLink": {
                    "uri": "[variables('linked-template')]",
                    "contentVersion": "1.0.0.0"
                },
                "parameters": {
                    "location": { "value": "[resourceGroup().location]" }
                }
            }
        },
        {
            "name": "identity",
            "type": "Microsoft.Resources/deployments",
            "apiVersion": "2019-10-01",
            "dependsOn": [
                "[resourceId('Microsoft.Resources/deployments','storage')]"
            ],
            "properties": {
                "mode": "Incremental",
                "templateLink": {
                    "uri": "[variables('linked-template-2')]",
                    "contentVersion": "1.0.0.0"
                }
            }
        }
    ],
    "outputs": {}
    }
    ```

1. To get started copy and paste the content of the following template code, into a file in a local directory.  **C:\JSON\linkedtemplate.json** or **/mnt/c/Users/<UserName>/json/linkedtemplate.json** for example.

    Once you have saved that file locally, you can proceed to deploy it using the Azure CLI command to deploy at the resource group level. Namely, **[az deployment group create](https://docs.microsoft.com/cli/azure/deployment/group?view=azure-cli-latest&WT.mc_id=mslearn-arm-pierrer#az-deployment-group-create)**

    ```bash
    templateFile=/mnt/c/Users/<UserName>/json/linkedtemplate.json
    today=$(date +"%Y-%m-%d")
    deploymentname="DeployLocalTemplate-3-"$today

    az deployment group create \
    --name $deploymentname \
    --template-file $templateFile
    ```

    Once it completes, you should have results like the example below.  Just check the ** "provisioningState"** to ensure it succeeded.

    ```json
    {- Finished ..
      "id": "/subscriptions/76972a65-0cc5-4520-bd43-938429557ba6/resourceGroups/learn-159e2742-d3a1-4e71-84a3-16e19830242b/providers/Microsoft.Resources/deployments/DeployLocalTemplate-3-2020-08-19",
      "location": null,
      "name": "DeployLocalTemplate-3-2020-08-19",
      "properties": {
        "correlationId": "f127f689-badf-4063-ad55-dff549e63e48",
        "debugSetting": null,
        "dependencies": [
          {
            "dependsOn": [
              {
                "id": "/subscriptions/76972a65-0cc5-4520-bd43-938429557ba6/resourceGroups/learn-159e2742-d3a1-4e71-84a3-16e19830242b/providers/Microsoft.Resources/deployments/storage",
                "resourceGroup": "learn-159e2742-d3a1-4e71-84a3-16e19830242b",
                "resourceName": "storage",
                "resourceType": "Microsoft.Resources/deployments"
              }
            ],
            "id": "/subscriptions/76972a65-0cc5-4520-bd43-938429557ba6/resourceGroups/learn-159e2742-d3a1-4e71-84a3-16e19830242b/providers/Microsoft.Resources/deployments/identity",
            "resourceGroup": "learn-159e2742-d3a1-4e71-84a3-16e19830242b",
            "resourceName": "identity",
            "resourceType": "Microsoft.Resources/deployments"
          }
        ],
        "duration": "PT16.4639167S",
        "error": null,
        "mode": "Incremental",
        "onErrorDeployment": null,
        "outputResources": [
          {
            "id": "/subscriptions/76972a65-0cc5-4520-bd43-938429557ba6/resourceGroups/learn-159e2742-d3a1-4e71-84a3-16e19830242b/providers/Microsoft.Network/virtualNetworks/vnet-001",
            "resourceGroup": "learn-159e2742-d3a1-4e71-84a3-16e19830242b"
          },
          {
            "id": "/subscriptions/76972a65-0cc5-4520-bd43-938429557ba6/resourceGroups/learn-159e2742-d3a1-4e71-84a3-16e19830242b/providers/Microsoft.Storage/storageAccounts/store7zk7eyqew54l4",
            "resourceGroup": "learn-159e2742-d3a1-4e71-84a3-16e19830242b"
          }
        ],
        "outputs": {},
        "parameters": {
          "name": {
            "type": "String",
            "value": "linkeddemo001"
          }
        },
        "parametersLink": null,
        "providers": [
          {
            "id": null,
            "namespace": "Microsoft.Resources",
            "registrationPolicy": null,
            "registrationState": null,
            "resourceTypes": [
              {
                "aliases": null,
                "apiVersions": null,
                "capabilities": null,
                "locations": [
                  null
                ],
                "properties": null,
                "resourceType": "deployments"
              }
            ]
          }
        ],
        "provisioningState": "Succeeded",
        "templateHash": "12700491000282730217",
        "templateLink": null,
        "timestamp": "2020-08-19T21:07:18.729310+00:00",
        "validatedResources": null
      },
      "resourceGroup": "learn-159e2742-d3a1-4e71-84a3-16e19830242b",
      "tags": null,
      "type": "Microsoft.Resources/deployments"
    }
    ```

1. To validate the results in the Azure portal, navigate to [Azure](https://portal.azure.com?azure-portal=true) and make sure you are in the sandbox subscription. To do that, select your avatar in the upper right corner of the page. Choose **Switch directory**. In the list, choose the **Microsoft Learn Sandbox** directory.

    1. On the left side panel, choose *Resource groups*.
    1. Select <rgn>[sandbox resource group name]</rgn>.
    1. In the *Overview*, you see the deployment has succeeded.
    1. Select *3 Succeeded* to see the details of the deployment. *(There may be more completed deployment depending on whether you performed the previous unit's exercises)*

:::image type="content" source="../media/7-portal-deployment-details.png" alt-text="Azure portal interface for the deployments with the one deployment listed and a succeeded status." border="true":::

2. You will notice that you deployed one Template but 3 are listed in the deployment pane of the portal. Those three deployments correspond to the Main template and the two linked templates.

:::image type="content" source="../media/7-portal-deployment-listing.png" alt-text="Azure portal interface for the specific deployment with no resources listed." border="true":::
