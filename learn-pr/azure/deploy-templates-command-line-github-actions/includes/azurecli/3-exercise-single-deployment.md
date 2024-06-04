> [!NOTE]
> This section was written using Azure CLI commands in Windows Linux Subsystem (WSL2) on Windows 10. The commands are the same whether you're using the Azure CLI in a PowerShell, CMD, or Bash shell.  But the way the variables are addressed can differ.

### Sign in to Azure

1. From the terminal in Visual Studio Code, run the following command to sign in to Azure. Running this command opens a browser that allows you to sign in to your account.

    ```azurecli
    az login
    ```

1. After you're signed in, you see a JSON list of the subscriptions associated with this account in the terminal. If you activated the sandbox, the Concierge Subscription should be in this list.

1. Get the subscription ID. The following command lists your subscriptions and their IDs. The subscription ID is the third column. Look for `Concierge Subscription` and copy the third column. It should look something like `cf49fbbc-217c-4eb6-9eb5-a6a6c68295a0`.

    ```azurecli
    az account list -o table
    ```

1. Change your active subscription to the Concierge Subscription. Be sure to substitute `{Your subscription ID}` with the ID of the Concierge Subscription that you got in the previous command.

    ```azurecli
    az account set -s {Your subscription ID}
    ```

### Set the default resource group

You now need to set the resource group created for you in the sandbox as the default resource group. To perform that operation, you first need to get the resource group name by using the following command:

```azurecli
az group list -o table
```

In this command, use the resource name that you got from the previous command. (It looks something like `learn-a73131a1-b618-48b8-af70-21af7ca420c4`.) This command allows you to omit that parameter from the rest of the Azure CLI commands in this exercise.

> [!NOTE]
> Normally, when you use an Azure CLI command to deploy a template, you need to specify the target resource group name.  In the exercise in this module, we're bypassing this requirement by setting the context of our deployment. We're specifying our sandbox resource group name in the next step by using the [az configure](/cli/azure/azure-cli-configuration?azure-portal=true&view=azure-cli-latest&preserve-view=true) Azure CLI command.

```azurecli
az configure --defaults group={Resource Group Name}
```

## Deploy a local template

In the following exercise, you deploy a template from your local machine. The name of the resource group that you normally use when deploying in your own environment isn't needed here, because we already defined the default resource group in the previous section.

1. To get started, copy and paste the content of the following template code into a file in a local directory. Use `C:\JSON\maintemplate.json` or `/mnt/c/Users/you/json/maintemplate.json`, for example.

    ```json
    {
        "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
        "contentVersion": "1.0.0.0",
        "parameters": {
          "VnetName": {
            "type": "string",
            "defaultValue": "VNet-001",
            "metadata": {
              "description": "Virtual Network Name"
            }
          },
          "CostCenterIO": {
            "type": "string",
            "defaultValue": "12345",
            "metadata": {
              "description": "Cost Center IO number for cross billing"
            }
          },
          "OwnerName": {
            "type": "string",
            "defaultValue": "John Smith",
            "metadata": {
              "description": "Name of the stakeholder responsible for this resource"
            }
          }
        },
        "variables": {},
        "resources": [
            {
                "apiVersion": "2018-10-01",
                "type": "Microsoft.Network/virtualNetworks",
                "name": "[parameters('VnetName')]",
                "location": "[resourceGroup().location]",
                "tags": {
                    "CostCenter": "[parameters('CostCenterIO')]",
                    "Owner": "[parameters('OwnerName')]"
                },  
                "properties": {
                    "addressSpace": {
                        "addressPrefixes": [
                            "10.0.0.0/16"
                        ]
                    },
                    "enableVmProtection": false,
                    "enableDdosProtection": false,
                    "subnets": [
                        {
                            "name": "subnet001",
                            "properties": {
                                "addressPrefix": "10.0.0.0/24"
                            }
                        },
                        {
                            "name": "subnet002",
                            "properties": {
                                "addressPrefix": "10.0.1.0/24"
                            }
                        }
                    ]
                }
            }
        ]
    }
    ```

1. After you save the file locally, you can use the Azure CLI command to deploy it at the resource group level that we talked about in the last unit. Namely, use [az deployment group create](/cli/azure/deployment/group?azure-portal=true&view=azure-cli-latest&preserve-view=true#az-deployment-group-create).

    > [!NOTE]
    > In the following example, the template file is in a **json** folder in the home drive in Windows Linux Subsystem (WSL2). Adjust your command based on your shell of choice.

    ```bash
    templateFile=/mnt/c/Users/<UserName>/json/maintemplate.json
    today=$(date +"%Y-%m-%d")
    deploymentname="DeployLocalTemplate-"$today

    az deployment group create \
      --name $deploymentname \
      --template-file $templateFile
    ```

    After it finishes, the resulting output should look like the following example. To ensure that your deployment succeeded, look for the `"provisioningState": "Succeeded"` line.

    ```json
    {
      "id": "/subscriptions/082d0d73-f197-45c5-9884-581c8f0ce102/resourceGroups/learn-e692001a-b605-48d4-97bd-7c05669db9dd/providers/Microsoft.Resources/deployments/DeployLocalTemplate-2020-08-19",
      "location": null,
      "name": "DeployLocalTemplate-2020-08-19",
      "properties": {
        "correlationId": "6ad759d5-cda5-4a71-a772-05a03d983c6f",
        "debugSetting": null,
        "dependencies": [],
        "duration": "PT8.9060761S",
        "error": null,
        "mode": "Incremental",
        "onErrorDeployment": null,
        "outputResources": [
          {
            "id": "/subscriptions/082d0d73-f197-45c5-9884-581c8f0ce102/resourceGroups/    learn-e692001a-b605-48d4-97bd-7c05669db9dd/providers/Microsoft.Network/virtualNetworks/VNet-001",
            "resourceGroup": "learn-e692001a-b605-48d4-97bd-7c05669db9dd"
          }
        ],
        "outputs": null,
        "parameters": {
          "costCenterIO": {
            "type": "String",
            "value": "12345"
          },
          "ownerName": {
            "type": "String",
            "value": "John Smith"
          },
          "vnetName": {
            "type": "String",
            "value": "VNet-001"
          }
        },
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
        "templateHash": "11553431046699679955",
        "templateLink": null,
        "timestamp": "2020-08-19T14:47:06.403362+00:00",
        "validatedResources": null
      },
      "resourceGroup": "learn-e692001a-b605-48d4-97bd-7c05669db9dd",
      "tags": null,
      "type": "Microsoft.Resources/deployments"
    }
    ```

### Deploy the same local template with parameter values

In the last exercise, you deployed your template by using the parameter's default value. When you're deploying a local ARM template, you might need to pass parameter values. You can use either inline parameters or a parameter file.

In the next exercise, you pass inline parameters to your deployment. You need to provide the names of the parameters whether you're using inline parameters or a parameter file, by using the `az deployment group create` command.

1. By using the same template as the last exercise, construct a variable that contains the parameters in a JSON string format for the required template parameters.  

    > [!NOTE]
    > In the following example, the template file is in a **json** folder in Windows Linux Subsystem (WSL2). Adjust your command based on your shell and OS of choice.

    ```azurecli
    parameters="{\"vnetName\":{\"value\":\"VNet-001\"},\"costCenterIO\":{\"value\":\"12345\"},\"ownerName\":{\"value\":\"John Smith\"}}"
    templateFile=/mnt/c/Users/<UserName>/json/maintemplate.json
    today=$(date +"%Y-%m-%d")
    deploymentname="DeployLocalTemplate-2-"$today

    az deployment group create \
    --name $deploymentname \
    --template-file $templateFile \
    --parameters "$parameters"
    ```

    After it finishes, you should have results like the following example. To ensure that the command was successful, see the `"parameters"` section and the `"provisioningState"` value.

    ```json
      {- Finished ..
        "id": "/subscriptions/082d0d73-f197-45c5-9884-581c8f0ce102/resourceGroups/learn-e692001a-b605-48d4-97bd-7c05669db9dd/providers/Microsoft.Resources/deployments/DeployLocalTemplate-2-2020-08-19",      
        "location": null,
        "name": "DeployLocalTemplate-2-2020-08-19",
        "properties": {
          "correlationId": "edb2992e-08be-4ec2-940e-df23b1c09453",
          "debugSetting": null,
          "dependencies": [],
          "duration": "PT4.6990388S",
          "error": null,
          "mode": "Incremental",
          "onErrorDeployment": null,
          "outputResources": [
            {
              "id": "/subscriptions/082d0d73-f197-45c5-9884-581c8f0ce102/resourceGroups/learn-e692001a-b605-48d4-97bd-7c05669db9dd/providers/Microsoft.Network/virtualNetworks/VNet-001",
              "resourceGroup": "learn-e692001a-b605-48d4-97bd-7c05669db9dd"
            }
          ],
          "outputs": null,
          "parameters": {
            "costCenterIO": {
              "type": "String",
              "value": "12345"
            },
            "ownerName": {
              "type": "String",
              "value": "John Smith"
            },
            "vnetName": {
              "type": "String",
              "value": "VNet-001"
            }
          },
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
          "templateHash": "11553431046699679955",
          "templateLink": null,
          "timestamp": "2020-08-19T16:40:20.249786+00:00",
          "validatedResources": null
        },
        "resourceGroup": "learn-e692001a-b605-48d4-97bd-7c05669db9dd",
        "tags": null,
        "type": "Microsoft.Resources/deployments"
      }
    ```

    Rather than pass parameters as inline values in your script, you might find it easier to use a JSON file that contains the parameter values. The parameter file can be a local file or an external/remote file with an accessible URI. For more information about the parameter file, see [Create Resource Manager parameter file](/azure/azure-resource-manager/templates/parameter-files?azure-portal=true).

1. To pass a local parameter file, we use the `--parameters` parameter in the same command that we've been using. But first, you need to create and save your parameter file.

    1. Because we're using Visual Studio Code with the Azure Resource Manager Tools extension, you can open the ARM template that you saved locally and select the **Select or create a parameter file to enable full validation** link.

    1. Select **New** on the menu. The extension creates a parameter file based on the currently opened template.

    :::image type="content" source="../../media/5-parameter-file-create-2.png" alt-text="Screenshot that shows selections for creating a parameter file in Visual Studio Code." loc-scope="vs-code":::

1. Use the following Azure CLI command with the `--parameters` parameter.

    > [!NOTE]
    > In the following example, the template file is in a **json** folder in Windows Linux Subsystem (WSL2). Adjust the command based on your shell and OS of choice.

    ```bash
    templateFile=/mnt/c/Users/<UserName>/json/maintemplate.json
    templateparameterfile=/mnt/c/Users/<UserName>/json/maintemplate.parameters.json
    today=$(date +"%Y-%m-%d")
    deploymentname="DeployLocalTemplate-3-"$today

    az deployment group create \
    --name $deploymentname \
    --template-file $templateFile \
    --parameters $templateparameterfile
    ```

    After the deployment, your results houdl look like the following example.

    ```json
      {- Finished ..
        "id": "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/learn-159e2742-d3a1-4e71-84a3-16e19830242b/providers/Microsoft.Resources/deployments/DeployLocalTemplate-3-2020-08-19",
        "location": null,
        "name": "DeployLocalTemplate-3-2020-08-19",
        "properties": {
          "correlationId": "2a668f55-d8d0-48ac-862f-7170b48c02b6",
          "debugSetting": null,
          "dependencies": [],
          "duration": "PT4.2058912S",
          "error": null,
          "mode": "Incremental",
          "onErrorDeployment": null,
          "outputResources": [
            {
              "id": "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/learn-159e2742-d3a1-4e71-84a3-16e19830242b/providers/Microsoft.Network/virtualNetworks/VNet-001",
              "resourceGroup": "learn-159e2742-d3a1-4e71-84a3-16e19830242b"
            }
          ],
          "outputs": null,
          "parameters": {
            "costCenterIO": {
              "type": "String",
              "value": "12345"
            },
            "ownerName": {
              "type": "String",
              "value": "John Smith"
            },
            "vnetName": {
              "type": "String",
              "value": "VNet-001"
            }
          },
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
          "templateHash": "11553431046699679955",
          "templateLink": null,
          "timestamp": "2020-08-19T20:42:44.069215+00:00",
          "validatedResources": null
        },
        "resourceGroup": "learn-159e2742-d3a1-4e71-84a3-16e19830242b",
        "tags": null,
        "type": "Microsoft.Resources/deployments"
      }
    ```

## Deploy an external or remote template

In some instances, you need to deploy from an external or remote location instead of from a template on your local machine. You can store templates in a source control repository (such as GitHub). Or, you can store them in an Azure storage account for shared access in your organization.

1. To deploy an external template, use the `--template-uri` parameter.

  In this exercise, you deploy an ARM template from a GitHub repo. The repo is public, so you don't need to worry about deploying a template that requires a shared access signature (SAS) token. For details about using a private or secured remote location, see [Deploy a private template with SAS token](/azure/azure-resource-manager/templates/secure-template-with-sas-token?azure-portal=true&tabs=azure-cli).

  The template URI for the exercise is https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/quickstarts/microsoft.storage/storage-account-create/azuredeploy.json. It's a short template that deploys a basic storage account in your sandbox environment.

1. The Azure CLI command is exactly the same as for a local template. The only difference is that the `--template-uri` parameter replaces the `--template-file` parameter.

1. Use the following code to deploy in the provided sandbox:

    ```bash
    parameters="{\"vnetName\":{\"value\":\"VNet-001\"},\"costCenterIO\":{\"value\":\"12345\"},\"ownerName\":{\"value\":\"John Smith\"}}"
    today=$(date +"%Y-%m-%d")
    deploymentname="DeployLocalTemplate-4-"$today

    az deployment group create \
    --name $deploymentname \
    --template-uri https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/quickstarts/microsoft.storage/storage-account-create/azuredeploy.json
    ```

    The results are like the following code block. They outline the details of the template location in the `"templateLink"` section. They also show if the deployment is successful in the `"provisioningState"` section.

    ```json
    {- Finished ..
      "id": "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/learn-159e2742-d3a1-4e71-84a3-16e19830242b/providers/Microsoft.Resources/deployments/DeployLocalTemplate-4-2020-08-19",
      "location": null,
      "name": "DeployLocalTemplate-4-2020-08-19",
      "properties": {
        "correlationId": "2ccc49de-9d46-4375-a25d-19ec10daf88b",
        "debugSetting": null,
        "dependencies": [],
        "duration": "PT24.3286124S",
        "error": null,
        "mode": "Incremental",
        "onErrorDeployment": null,
        "outputResources": [
          {
            "id": "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/learn-159e2742-d3a1-4e71-84a3-16e19830242b/providers/Microsoft.Storage/storageAccounts/store7zk7eyqew54l4",
            "resourceGroup": "learn-159e2742-d3a1-4e71-84a3-16e19830242b"
          }
        ],
        "outputs": {
          "storageAccountName": {
            "type": "String",
            "value": "store7zk7eyqew54l4"
          }
        },
        "parameters": {
          "location": {
            "type": "String",
            "value": "westus"
          },
          "storageAccountType": {
            "type": "String",
            "value": "Standard_LRS"
          }
        },
        "parametersLink": null,
        "providers": [
          {
            "id": null,
            "namespace": "Microsoft.Storage",
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
                "resourceType": "storageAccounts"
              }
            ]
          }
        ],
        "provisioningState": "Succeeded",
        "templateHash": "12600309984865991765",
        "templateLink": {
          "contentVersion": "1.0.0.0",
          "id": null,
          "relativePath": null,
          "uri": "https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/quickstarts/microsoft.storage/storage-account-create/azuredeploy.json"
        },
        "timestamp": "2020-08-19T20:53:36.759312+00:00",
        "validatedResources": null
      },
      "resourceGroup": "learn-159e2742-d3a1-4e71-84a3-16e19830242b",
      "tags": null,
      "type": "Microsoft.Resources/deployments"
    }
    ```