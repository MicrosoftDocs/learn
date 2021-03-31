> [!NOTE]
> The first time you activate a sandbox and accept the terms, your Microsoft account is associated with a new Azure directory named Microsoft Learn Sandbox. You're also added to a special subscription named Concierge Subscription.

In this exercise, you update the Bicep template that you previously created so that it accepts parameters for the resource locations and names, and uses your company's business rules to select the right SKUs for the resources being deployed.

During the process, you:

> [!div class="checklist"]
> * Update the template to include a `location` parameter.
> * Update the template to include parameters and variables for the resource names.
> * Use expressions to set default values for the parameters.
> * Update the template to include variables for the SKU of each resource.
> * Test the deployment to ensure the template is valid.

This exercise uses [Bicep for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-bicep). Be sure to install this extension in Visual Studio Code.

## Add the location and resource name parameters

1. In the *main.bicep* file in Visual Studio Code, add the following to the top of the file:

   ```bicep
   param location string = resourceGroup().location
   param storageAccountName string = 'toylaunch${uniqueString(resourceGroup().id)}'
   param appServiceAppName string = 'toylaunch${uniqueString(resourceGroup().id)}'
   var appServicePlanName = 'ToyLaunchPlan'
   ```

   Notice you're using expressions including string interpolation, the `uniqueString()` function, and the `resourceGroup()` function to define the variable and default parameter values. Someone executing this template could override the default parameter values by specifying the values at deployment time, but they can't override the variable values.

   Also notice you're using a variable for the App Service plan name, but you use parameters for the other names. Storage accounts and App Service apps need globally unique names, while App Service plans only need to be unique within their resource group. This difference means it's not a concern to use the same App Service plan name across different deployments, as long as they're all going to be deployed into different resource groups.

1. Find the places within the resource definitions where the `location` and `name` properties are set, and update them to use the parameter values. After you're finished, your resource definitions should look like this:

   ```bicep
   resource storageAccount 'Microsoft.Storage/storageAccounts@2019-06-01' = {
     name: storageAccountName
     location: location
     sku: {
       name: 'Standard_LRS'
     }
     kind: 'StorageV2'
     properties: {
       accessTier: 'Hot'
     }
   }

   resource appServicePlan 'Microsoft.Web/serverFarms@2020-06-01' = {
     name: appServicePlanName
     location: location
     sku: {
       name: 'F1'
       tier: 'Free'
     }
   }

   resource appServiceApp 'Microsoft.Web/sites@2020-06-01' = {
     name: appServiceAppName
     location: location
     properties: {
       serverFarmId: appServicePlan.id
       httpsOnly: true
     }
   }
   ```

## Automatically set the SKUs for each environment type

1. In the *main.bicep* file in Visual Studio Code, add the following Bicep code below the parameters you created in the previous task:

   ```bicep
   @allowed([
    'nonprod'
    'prod'
   ])
   param environmentType string
   ```

   Notice you're defining a parameter with a set of allowed values, but you're not specifying a default value for this parameter.

1. Below the lines you inserted, add the following Bicep code:

   ```bicep
   var storageAccountSkuName = (environmentType == 'prod') ? 'Standard_GRS' : 'Standard_LRS'
   var appServicePlanSkuName = (environmentType == 'prod') ? 'P2_v3' : 'F1'
   var appServicePlanTierName = (environmentType == 'prod') ? 'PremiumV3' : 'Free'
   ```

   Notice you're setting these variables' values by using the ternary operator to evaluate an if-then-else condition.

1. Find the places within the resource definitions where the  `sku` properties are set, and update them to use the parameter values. After you're finished, your resource definitions should look like this:

   ```bicep
   resource storageAccount 'Microsoft.Storage/storageAccounts@2019-06-01' = {
     name: storageAccountName
     location: location
     sku: {
       name: storageAccountSkuName
     }
     kind: 'StorageV2'
     properties: {
       accessTier: 'Hot'
     }
   }

   resource appServicePlan 'Microsoft.Web/serverFarms@2020-06-01' = {
     name: appServicePlanName
     location: location
     sku: {
       name: appServicePlanSkuName
       tier: appServicePlanTierName
     }
   }

   resource appServiceApp 'Microsoft.Web/sites@2020-06-01' = {
     name: appServiceAppName
     location: location
     properties: {
       serverFarmId: appServicePlan.id
       httpsOnly: true
     }
   }
   ```

   Notice you haven't parameterized everything. You've set some properties right in the resource definitions where you know these aren't going to change between deployments.

### Deploy the updated Bicep template

::: zone pivot="cli"

Run the following Azure CLI commands in the terminal. This snippet is the same code you used previously, but the name of the deployment is changed.

```azurecli
templateFile="main.bicep"
today=$(date +"%d-%b-%Y")
DeploymentName="addparams-"$today

az deployment group create \
  --name $DeploymentName \
  --template-file $templateFile \
  --parameters environmentType=nonprod
```

::: zone-end

::: zone pivot="powershell"

Run the following Azure PowerShell commands in the terminal. This snippet is the same code you used previously, but the name of the deployment is changed.

```azurepowershell
$templateFile = 'main.bicep'
$today = Get-Date -Format 'MM-dd-yyyy'
$deploymentName = "addparams-$today"
New-AzResourceGroupDeployment `
  -Name $deploymentName `
  -TemplateFile $templateFile `
  -environmentType nonprod
```

::: zone-end

Notice that you're explicitly specifying the value for the `environmentType` parameter when you execute the deployment. You don't need to specify all of the other parameter values because they have defaults that make sense.

### Check your deployment

1. In your browser, go back to Azure. Go to your resource group, and you'll see that there are now **3 Succeeded** deployments. Select this link.

1. Notice that all three of the deployments are in the list.

    :::image type="content" source="../media/6-addparams-deployment.png" alt-text="Azure portal interface for the deployments with the three deployments listed and succeeded statuses." border="true":::

1. Select the deployment that begins with **`addparams`**, then select **Deployment details** to expand the list of deployed resources.

    :::image type="content" source="../media/6-addparams-details.png" alt-text="Azure portal interface for the specific deployment with one resource listed." border="true":::

1. Notice that the resources have been deployed using new, randomly generated, names.
