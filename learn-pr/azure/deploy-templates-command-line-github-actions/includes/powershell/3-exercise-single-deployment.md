### Sign in to Azure

1. From the terminal in Visual Studio Code, run the following command to sign in to Azure. Running this command will open a browser that allows you to sign in to your account.

    ```powershell
    Connect-AzAccount
    ```

1. After you're signed in, you see a list of the subscriptions associated with this account in the terminal. If you activated the sandbox, the Concierge Subscription should be in this list.
1. Verify the subscription name. The following command will list your subscriptions, names, and their IDs in an easy-to-read table format. Look for `Concierge Subscription`.

    ```powershell
    Get-AzSubscription
    ```

1. Change your active subscription to the Concierge Subscription.

    ```powershell
    $context = Get-AzSubscription -SubscriptionName "Concierge Subscription" | Set-AzContext
    ```

### Set the default resource group

You now need to set the resource group created for you in the sandbox as the default resource group. To perform that operation, you first need to get the resource group name by running the following command.

```powershell
Get-AzResourceGroup | where-object ResourceGroupName -match "learn" | Set-AzDefault
```

In this command, use the resource name that you got from the previous command. (It looks like something like `learn-a73131a1-b618-48b8-af70-21af7ca420c4`.) This command allows you to omit that parameter from the rest of the Azure PowerShell commands in this exercise.

> [!NOTE]
> Normally, when you run a PowerShell or Azure CLI command to deploy a template, you must specify the target resource group name. Running the previous command, we've set the context of our deployment. We've specified our sandbox resource group name by running the [Set-AzDefault](/powershell/module/az.accounts/set-azdefault?azure-portal=true&view=azps-4.5.0) PowerShell command:
>
> ```powershell
> Set-AzDefault -ResourceGroupName {Resource Group Name}
> ```

## Deploy a local template

In the following exercise, you'll deploy a template from your local machine. The name of the resource group that you normally use when deploying in your own environment isn't needed here, because we already defined the default resource group in the previous section.

1. To get started, copy and paste the content of the following template code into a file in a local directory. Use `C:\JSON\maintemplate.json`, for example.

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

1. After you've saved the file locally, you can use the PowerShell command to deploy it at the resource group level that we talked about in the last unit. Namely, use [New-AzResourceGroupDeployment](/powershell/module/az.resources/new-azresourcegroupdeployment?azure-portal=true&view=azps-4.4.0):

    ```powershell
    $templateFile="C:\JSON\maintemplate.json"
    $today=Get-Date -Format "MM-dd-yyyy"
    $DeploymentName="DeployLocalTemplate-"+"$today"

    New-AzResourceGroupDeployment `
    -Name $DeploymentName `
    -TemplateFile $templateFile
    ```

    After it finishes, you should have results like this:

    ```azurepowershell
    DeploymentName          : DeployLocalTemplate-08-24-2020
    ResourceGroupName       : learn-03f041a7-cd17-4f50-9c81-5f6678feb217
    ProvisioningState       : Succeeded
    Timestamp               : 2020-08-24 5:50:04 p.m.
    Mode                    : Incremental
    TemplateLink            :
    Parameters              :
                              Name             Type                       Value
                              ===============  =========================  ==========
                              vnetName         String                     VNet-001
                              costCenterIO     String                     12345
                              ownerName        String                     John Smith

    Outputs                 :
    DeploymentDebugLogLevel :

    ```

### Deploy the same local template with parameter values

In the last exercise, you deployed your template by using the parameter's default value. When you're deploying a local ARM template, you might need to pass parameter values. You can use either inline parameters or a parameter file.

To pass inline parameters to your deployment, you need to provide the names of the parameter with the `New-AzResourceGroupDeployment` cmdlet. In the next exercise, you'll pass the parameters as inline` parameters and as a parameter file.

1. By using the same template as the last exercise, construct a hash table that will contain the values for the required template parameters:

    ```powershell
    $parameters = @{vnetName = "VNet-001"; costCenterIO = "12345"; ownerName = "John Smith"}
    $templateFile="C:\JSON\maintemplate.json"
    $today=Get-Date -Format "MM-dd-yyyy"
    $DeploymentName="DeployLocalTemplate-2-"+"$today"

    New-AzResourceGroupDeployment `
        -Name $DeploymentName `
        -TemplateFile $templateFile `
        -TemplateParameterObject $parameters
    ```

    After it finishes, you should have results like this:

    ```azurepowershell
    DeploymentName          : DeployLocalTemplate-2-08-24-2020
    ResourceGroupName       : learn-03f041a7-cd17-4f50-9c81-5f6678feb217
    ProvisioningState       : Succeeded
    Timestamp               : 2020-08-24 5:51:55 p.m.
    Mode                    : Incremental
    TemplateLink            :
    Parameters              :
                              Name             Type                       Value
                              ===============  =========================  ==========
                              vnetName         String                     VNet-001
                              costCenterIO     String                     12345
                              ownerName        String                     John Smith

    Outputs                 :
    DeploymentDebugLogLevel :
    ```

    Rather than pass parameters as inline values in your script, you might find it easier to use a JSON file that contains the parameter values. The parameter file can be a local file or an external/remote file with an accessible URI. For more information about the parameter file, see [Create Resource Manager parameter file](/azure/azure-resource-manager/templates/parameter-files?azure-portal=true).

1. To pass a local parameter file, we use the `TemplateParameterFile` parameter in the same command that we've been using. But first, you need to create and save your parameter file:

    1. Because we're using Visual Studio Code with the Azure Resource Manager Tools extension, you can open the ARM template that you saved locally and click the **Select/create parameter file...** link.

    1. Select **New** on the menu, and then select **Only required parameters**. The extension creates a parameter file based on the template that's currently opened.

    :::image type="content" source="../../media/5-parameter-file-create-2.png" alt-text="Screenshot that shows selections for creating a parameter file in Visual Studio Code." loc-scope="vs-code":::

1. Use the following PowerShell command with the `TemplateParameterFile` parameter:

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

    After the deployment, you should have results like the following:

    ```azurepowershell
    DeploymentName          : DeployLocalTemplate-3-08-24-2020
    ResourceGroupName       : learn-03f041a7-cd17-4f50-9c81-5f6678feb217
    ProvisioningState       : Succeeded
    Timestamp               : 2020-08-24 5:54:40 p.m.
    Mode                    : Incremental
    TemplateLink            :
    Parameters              :
                              Name             Type                       Value
                              ===============  =========================  ==========
                              vnetName         String                     VNet-001
                              costCenterIO     String                     12345
                              ownerName        String                     John Smith

    Outputs                 :
    DeploymentDebugLogLevel :

    ```

## Deploy an external or remote template

In some instances, you need to deploy from an external or remote location instead of from a template on your local machine. You can store templates in a source control repository (such as GitHub). Or, you can store them in an Azure storage account for shared access in your organization.

1. To deploy an external template, use the `TemplateUri` parameter.
    
    In the next exercise, you'll deploy an ARM template from a GitHub repo. The repo is public, so you don't need to worry about deploying a template that requires a shared access signature (SAS) token. For details about using a private or secured remote location, see [Deploy a private template with SAS token](/azure/azure-resource-manager/templates/secure-template-with-sas-token?azure-portal=true&tabs=azure-powershell).

    The template URI for the exercise is https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/quickstarts/microsoft.storage/storage-account-create/azuredeploy.json. It's a short template that will deploy a simple storage account in your sandbox environment.

1. The PowerShell command is exactly the same as for a local template. The only difference is that the `-TemplateUri` parameter replaces the `-TemplateFile` parameter.
    
    Use the following code to deploy in the provided sandbox:

    ```powershell
    $parameters = @{vnetName = "VNet-001"; costCenterIO = "12345"; ownerName = "John Smith"}
    $today=Get-Date -Format "MM-dd-yyyy"
    $DeploymentName="DeployLocalTemplate-4-"+"$today"

    New-AzResourceGroupDeployment `
        -Name $DeploymentName `
        -TemplateUri https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/quickstarts/microsoft.storage/storage-account-create/azuredeploy.json
    ```

    The results will be like the following screen capture. They outline the details of the template location.

    ```azurepowershell
    DeploymentName          : DeployLocalTemplate-4-08-24-2020
    ResourceGroupName       : learn-03f041a7-cd17-4f50-9c81-5f6678feb217
    ProvisioningState       : Succeeded
    Timestamp               : 2020-08-24 5:56:55 p.m.
    Mode                    : Incremental
    TemplateLink            :
                              Uri            :
                              https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/quickstarts/microsoft.storage/storage-account-create/azuredeploy.json
                              ContentVersion : 1.0.0.0

    Parameters              :
                              Name                  Type                       Value
                              ====================  =========================  ==========
                              storageAccountType    String                     Standard_LRS
                              location              String                     westus

    Outputs                 :
                              Name                  Type                       Value
                              ====================  =========================  ==========
                              storageAccountName    String                     storepgxosadmbq77e

    DeploymentDebugLogLevel :

    ```