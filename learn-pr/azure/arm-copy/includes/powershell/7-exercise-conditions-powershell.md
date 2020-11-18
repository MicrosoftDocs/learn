Here you will deploy an ARM template, with a condition construct, using PowerShell and the Az module.

## Exercise overview

Here's an overview of the steps you are about to carry out:

> [!NOTE]
> If you already have a working Sandbox where you've done steps 1-3, then there's no need to repeat them.

1. **Sign in to Azure**. You will be able to sign in using Visual Studio Code and using the integrated terminal.

1. **Set the active subscription**. This task can be accomplished by invoking a PowerShell cmdlet.

1. **Set default resource group**. Also this task can be carried out by invoking a PowerShell cmdlet. The reason for setting these default values on subscription and resource group is to ensure the resources are created in the correct place.

1. **Carry out the deployment**. This step involves using the cmdlet **New-AzResourceGroupDeployment** with a URL to a template as an argument.

## Conditionally deploy a resource

Now that you have setup your subscription in the Visual Studio Code (Visual Studio Code) terminal, you are ready to deploy the ARM template to Azure.

1. Create a file `conditionally-deploy.json` and give it the following content:

   ```json
   {
     "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
     "contentVersion": "1.0.0.0",
     "parameters": {
     "environment": {
       "type": "string",
       "defaultValue": "dev",
       "allowedValues": [
         "dev",
         "staging",
         "production"
       ],
       "metadata": {
         "description": "a value that represents the different environments"
       }
     },
     "storageAccountName": {
       "type": "string",
       "metadata": {
         "description": "a name for the account"
       }
     }
    },
    "functions": [],
    "variables": {},
   "resources": [
     {
      "condition": "[equals(parameters('environment'),'production')]",
      "name": "[parameters('storageAccountName')]",
      "type": "Microsoft.Storage/storageAccounts",
      "apiVersion": "2019-06-01",
      "tags": {
        "displayName": "[parameters('storageAccountName')]"
      },
      "location": "[resourceGroup().location]",
      "kind": "StorageV2",
      "sku": {
        "name": "Premium_LRS",
        "tier": "Premium"
      }
     }
   ],
   "outputs": {}
   }
   ```

   In the above template you have two parameters `environment` and `storageAccountName`. `environment` is used in the `condition` construct and `storageAccountName` is something you need to provide at deploy time.

1. Run `New-AzResourceGroupDeployment` to deploy the template.

    ```powershell
    $storageAccountName = Read-Host -Prompt "Enter a storage account name"
    $environment = 'staging'

    New-AzResourceGroupDeployment `
    -TemplateUri "conditionally-deploy.json" `
    -environment $environment `
    -storageAccountName $storageAccountName
    ```

    You'll see the text **Running...** in the terminal. When the command finishes, the results of the above command should be something like the following

    ```powershell
    DeploymentName          : conditionally-deploy
    ResourceGroupName       : learn-2c05151d-0776-4ba4-b522-2543d030b66c
    ProvisioningState       : Succeeded
    Timestamp               : 2020-10-22 4:10:21 p.m.
    Mode                    : Incremental
    TemplateLink            :
                              Uri            : conditionally-deploy.json
                              ContentVersion : 1.0.0.0

    Parameters              :
    Outputs                 :
    DeploymentDebugLogLevel :
    >
   ```

   The above output says the deployment succeeded, but was the resource deployed? Let's verify what actually took place next.

## Verify the deployment

After the deployment has finished you will verify that the `condition` construct has worked as intended. You passed the value `staging` to the `environment` parameter and based on how you formulated the `condition` construct, the resource should not have been deployed.  Let's verify that everything has worked as intended.

1. Run the command `Get-AzStorageAccount`:

   ```powershell
   Get-AzStorageAccount -Name {the name you chose for storage account} -ResourceGroupName <rgn>sandbox resource group</rgn>
   ```

   ```output
   Get-AzStorageAccount: The Resource 'Microsoft.Storage/storageAccounts/{the name you chose for storage account}' under resource group '<rgn>name of resource group</rgn>' was not found. For more details please go to https://aka.ms/ARMResourceNotFoundFix
   ```

   You will see an output similar to the above response. Your resource has not been deployed, your `condition` construct has done its job.

## Deploy the resource

To deploy the resource you need to pass a parameter value to the `environment` variable that ensures the `condition` construct evaluates to true. Let's quickly look at the `condition` construct and remind ourselves what it looks like:

```json
"condition": "[equals(parameters('environment'),'production')]"
```

Based on the statement above, it needs you to pass the value `production`. Let's do a new attempt of deploying, this time with a new value to the `environment` variable.

1. Run the command `New-AzResourceGroupDeployment`

   ```powershell
    $storageAccountName = Read-Host -Prompt "Enter a storage account name"
    $environment = 'prod'

    New-AzResourceGroupDeployment `
     -TemplateUri "conditionally-deploy.json" `
     -environment $environment `
     -storageAccountName $storageAccountName
   ```

1. Run the `Get-AzStorageAccount` in the terminal:

   ```powershell
   Get-AzStorageAccount -Name {the name you chose for storage account} -ResourceGroupName <rgn>sandbox resource group</rgn>
   ```

   This time around you will get a different output. Instead of an error message it shows this table output that shows information about your storage account resource:

   ```output
   StorageAccountName     ResourceGroupName              PrimaryLocation  SkuName        Kind      AccessTier CreationTime        ProvisioningStat
                                                                                                                    e
   ------------------     -----------------              ---------------  -------        ----      ---------- ------------        ----------------
   {your storage account} <rgn>your resource group</rgn> northeurope      Standard_RAGRS StorageV2 Hot        18/01/2020 20:34:35 Succeeded
   ```
