### Sign in to Azure

1. From the terminal in Visual Studio Code, run this command to sign in to Azure. Running this command will open a browser that allows you to sign in to your account.

    ```powershell
    Connect-AzAccount
    ```

1. Once you are logged in, you see a list of the subscriptions associated with this account in the terminal. If you activated the sandbox.
1. Get the subscription ID. The command will list your subscriptions and their IDs. The subscription ID is the second column. Look for Concierge Subscription and copy the second column. It will look something like cf49fbbc-217c-4eb6-9eb5-a6a6c68295a0

    ```powershell
    Get-AzSubscription
    ```

1. Change your active subscription to the Concierge Subscription. Be sure to substitute {Your subscription ID} with the ID of the Concierge Subscription you just got in the last command.

    ```powershell
    $context = Get-AzSubscription -SubscriptionId {Your subscription ID}
    Set-AzContext $context
    ```

### Set the default resource group

1. You now need to set the resource group created for you in the sandbox as the default resource group.  do perform that operation you first need to get the resource group name by using the following command.

    ```powershell
    Get-AzResourceGroup
    ```

    and use the name of the resource name provided by the last command in this command. (It will look like something like **learn-a73131a1-b618-48b8-af70-21af7ca420c4**) This command allows you to omit that parameter from the rest of the Azure PowerShell commands in this exercise.

    > [!NOTE] Normally, when you use a PowerShell or an Azure CLI command to deploy a template you need to specify the target **resource group** name.  In the exercise in this module we are bypassing this requirement by setting the context of our deployment by specifying our sandbox resource group name in the step below by using the **[Set-AzDefault](https://docs.microsoft.com/powershell/module/az.accounts/set-azdefault?view=azps-4.5.0&WT.mc_id=MSlearn-ARM-pierrer)** Powershell command.

    ```powershell
    Set-AzDefault -ResourceGroupName {Resource Group Name}
    ```

## Deploy local template

In the following exercise, you will deploy a template from your local machine. The name of the resource group normally used when deploying in your own environment is not needed here since we already defined the default Resource Group context in the section above.

1. To get started copy and paste the content of the following template code, into a file in a local directory.  **C:\JSON\maintemplate.json** for example.

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

1. Once you have saved that file locally, you can proceed to deploy it using the PowerShell command to deploy at the resource group level we talked about in the last unit. Namely, [New-AzResourceGroupDeployment](https://docs.microsoft.com/powershell/module/az.resources/new-azresourcegroupdeployment?view=azps-4.4.0&WT.mc_id=MSLearn-ARM-pierrer)

    ```powershell
    $templateFile="C:\JSON\maintemplate.json"
    $today=Get-Date -Format "MM-dd-yyyy"
    $DeploymentName="DeployLocalTemplate-"+"$today"

    New-AzResourceGroupDeployment `
    -Name $DeploymentName `
    -TemplateFile $templateFile
    ```

    Once it completes, you should have results like this:

:::image type="content" source="../../media/5-parameter-prompt.png" alt-text="Results from deploying local template." border="true":::

### Deploy the same local template with parameter values

In the last exercise, you deployed your template using the parameters "Default Value".  When deploying a local ARM template, you may need to pass parameter values, you can use either inline parameters or a parameter file.

To pass inline parameters to your deployment, you need to provide the names of the parameter with the New-AzResourceGroupDeployment command. In the next exercise, you will pass the parameters as Inline parameters and as a parameter file.

1. Using the same template as the last exercise, you will construct an hashtable that will contain the values for the required template parameters.

    ```powershell
    $parameters = @{vnetName = "VNet-001"; costCenterIO = "12345"; ownerName = "John Smith"}
    $templateFile="C:\JSON\maintemplate.json"
    $today=Get-Date -Format "MM-dd-yyyy"
    $DeploymentName="DeployLocalTemplate-2-"+"$today"

    New-AzResourceGroupDeployment `
        -Name $DeploymentName `
        -TemplateFile $templateFile
    ```

    Once it completes, you should have results like this:

:::image type="content" source="../../media/5-parameter-inline.png" alt-text="Results from deploying local template with inline parameters." border="true":::

Rather than passing parameters as inline values in your script, you may find it easier to use a JSON file that contains the parameter values. The parameter file can be a local file or an external/remote file with an accessible URI.  For more information about the parameter file, see [Create Resource Manager parameter file](https://docs.microsoft.com/azure/azure-resource-manager/templates/parameter-files?WT.mc_id=MSLearn-ARM-pierrer).

1. To pass a local parameter file, use the TemplateParameterFile parameter in the same command we've been using.
1. But first, you need to create and save your parameter file.  Because we're using Visual Studio Code with the Azure Resource Manager (ARM) Tools extension, you can open the ARM template you saved locally and click on the "**Select or create a parameter file to enable full validation**" link.

1. Click the "New..." item in the menu and the extension will create a parameter file based on the template currently opened.

:::image type="content" source="../../media/5-parameter-file-create-2.png" alt-text="Create parameter file in VS Code." border="true":::

1. Once we have our local parameter file, we can use the following PowerShell command with the **TemplateParameterFile** parameters.

    ```powershell
    $parameters = @{vnetName = "VNet-001"; costCenterIO = "12345"; ownerName = "John Smith"}
    $templateFile="C:\JSON\maintemplate.json"
    $TemplateParameterFile= "C:\JSON\maintemplate.parameters.json"
    $today=Get-Date -Format "MM-dd-yyyy"
    $DeploymentName="DeployLocalTemplate-3-"+"$today"

    New-AzResourceGroupDeployment `
        -Name $DeploymentName `
        -TemplateFile $templateFile `
        -TemplateParameterFile $TemplateParameterFile
    ```

    after the deployment you should have results like the following:

:::image type="content" source="../../media/5-parameter-file-create-3.png" alt-text="Create parameter file in VS Code." border="true":::

## Deploy an external or remote template

In some instances you will need to deploy from an external or remote location instead of from a template on your local machine. You can store templates in a source control repository (such as GitHub). Or, you can store them in an Azure storage account for shared access in your organization.

1. To deploy an external template, use the TemplateUri parameter.
    In the next exercise, you will deploy an ARM template from a GitHub repo. The repo is public, therefore you don't need to worry about deploying a template that requires a shared access signature (SAS) token.  Details about using a private or secured remote location can be found in the following article. [Deploy private template with SAS token](https://docs.microsoft.com/azure/azure-resource-manager/templates/secure-template-with-sas-token?tabs=azure-powershell&WT.mc_id=MSLearn-ARM-pierrer).

    The template URI for the exercise is https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/101-storage-account-create/azuredeploy.json.  It's a short template that will deploy a simple storage account in your sandbox environment.
1. The PowerShell command/process is exactly the same as for a local template for the exception of the **-TemplateUri** parameter replacing the **-TemplateFile** parameters.
1. Use the following code to deploy in the provided sandbox

```powershell
$parameters = @{vnetName = "VNet-001"; costCenterIO = "12345"; ownerName = "John Smith"}
$today=Get-Date -Format "MM-dd-yyyy"
$DeploymentName="DeployLocalTemplate-4-"+"$today"

New-AzResourceGroupDeployment `
    -Name $DeploymentName `
    -TemplateUri https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/101-storage-account-create/azuredeploy.json
```

The results will be like the following screen capture. And they outline the details of the template location.

:::image type="content" source="../../media/5-remote-template.png" alt-text="Create parameter file in VS Code." border="true":::
