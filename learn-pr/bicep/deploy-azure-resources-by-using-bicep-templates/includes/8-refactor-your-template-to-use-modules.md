> [!NOTE]
> The first time you activate a sandbox and accept the terms, your Microsoft account is associated with a new Azure directory named Microsoft Learn Sandbox. You're also added to a special subscription named Concierge Subscription.

In this exercise, you'll update the Bicep template that you previously created so that it uses a module for the App Service resources. Modules help to keep the intention of the main template clearer. It also means that you can reuse the App Service module in other templates if you choose to.

During the process, you'll:

> [!div class="checklist"]
> * Add a new module and move the App Service resources into it.
> * Reference the module from the main Bicep template.
> * Add an output for the App Service app's host name, and emit it from the module and template deployments.
> * Test the deployment to ensure the template is valid.

This exercise uses [Bicep for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-bicep). Be sure to install this extension in Visual Studio Code.

## Add a new module file

1. In Visual Studio Code, create a new folder called *modules* in the same folder that you created your *main.bicep* file. Inside the *modules* folder, create a file called *appService.bicep*.

1. Add the following content into the *appService.bicep* file:

   ```bicep
   param location string
   param appServiceAppName string

   @allowed([
     'nonprod'
     'prod'
   ])
   param environmentType string
   
   var appServicePlanName = 'toy-product-launch-plan'
   var appServicePlanSkuName = (environmentType == 'prod') ? 'P2_v3' : 'F1'
   var appServicePlanTierName = (environmentType == 'prod') ? 'PremiumV3' : 'Free'
   
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

   Notice you have copied the parameters and variables from your *main.bicep* template, since the *appService.bicep* template needs to be self-contained.

1. Save the changes to the file. Notice that Visual Studio Code doesn't show you any red squiggles indicating warnings about missing variables or parameters, or invalid resources.

### Add a reference to the module from the parent template

Now that you have a complete module to deploy the App Service resources, you can refer to the module within the parent template. Since the module now deploys the App Service resources, you can delete the associated resources and variables from the parent template.

1. In the *main.bicep* file, delete the App Service resources and the  `appServicePlanName`, `appServicePlanSkuName`, and `appServicePlanTierName` variable definitions. Don't delete the App Service-related parameters, because you still need them. Also, don't delete the storage account parameters, variable, or resources.

1. At the bottom of the *main.bicep* file, add the following Bicep code:

   ```bicep
   module appService 'modules/appService.bicep' = {
       name: 'appService'
       params: {
         location: location
         appServiceAppName: appServiceAppName
         environmentType: environmentType
       }
   }
   ```

   Notice that you are specifying the parameters for your module by referencing the parameters in the parent template.

   After you're finished, your *main.bicep* file should look like this:

   ```bicep
    param location string = resourceGroup().location
    param storageAccountName string = 'toylaunch${uniqueString(resourceGroup().id)}'
    param appServiceAppName string = 'toylaunch${uniqueString(resourceGroup().id)}'

    @allowed([
      'nonprod'
      'prod'
    ])
    param environmentType string

    var storageAccountSkuName = (environmentType == 'prod') ? 'Standard_GRS' : 'Standard_LRS'
    
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
    
    module appService 'modules/appService.bicep' = {
      name: 'appService'
      params: {
        location: location
        appServiceAppName: appServiceAppName
        environmentType: environmentType
      }
    }
    ```

1. Save the changes to the file.

## Add the host name as an output

1. Add the following Bicep code at the bottom of the *appService.bicep* file:

   ```bicep
   output appServiceAppHostName string = appServiceApp.properties.defaultHostName
   ```

   This code is declaring an output for this module, which will be named `appServiceAppHostName`, will be of type `string`, and will take its value from the `defaultHostName` property of the App Service app.

1. Save the changes to the file.

This output is declared within a Bicep file that we'll use as a module, so it's only going to be available to the parent template. You need to return the output to the person executing the template as well.

1. Open the *main.bicep* file and add the following code at the bottom of the file:

   ```bicep
   output appServiceAppHostName string = appService.outputs.appServiceAppHostName
   ```

   Notice this output is declared in a similar way to the output in the module, but this time you are referencing the module's output instead of a resource property.

1. Save the changes to the file.

### Deploy the updated Bicep template

::: zone pivot="cli"

Run the following Azure CLI commands in the terminal. This snippet is the same code you used previously, but the name of the deployment is changed.

```azurecli
templateFile="main.bicep"
today=$(date +"%d-%b-%Y")
DeploymentName="addmodule-"$today

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
$today = Get-Date -Format 'dd-MMM-yyyy'
$deploymentName = "addmodule-$today"

New-AzResourceGroupDeployment `
  -Name $deploymentName `
  -TemplateFile $templateFile `
  -environmentType nonprod
```

::: zone-end

### Check your deployment

1. In your browser, go back to the Azure portal. Go to your resource group, and you'll see that there are now **5 Succeeded** deployments. Select this link.

1. Notice that you have two new deployments in the list. One begins with the name **addmodule**, and another is called **appService**:

    :::image type="content" source="../media/8-addmodule-deployment.png" alt-text="Azure portal interface for the deployments with the five deployments listed and succeeded statuses." border="true":::

1. Select the deployment that begins with **addmodule**, then select **Deployment details** to expand the list of deployed resources. Notice our module deployment appears in the list - in fact it appears twice, because we referenced it as an output too.

    :::image type="content" source="../media/8-addmodule-details.png" alt-text="Azure portal interface for the specific deployment with one resource listed." border="true":::

1. Select the **Outputs** tab. Notice that there is an output called **appServiceAppHostName** with the host name of your App Service app. Copy the host name to your clipboard.

    :::image type="content" source="../media/8-addmodule-outputs.png" alt-text="Azure portal interface for the specific deployment's outputs." border="true":::

1. Open a new browser tab and paste the host name you just copied. You should see a page with the default App Service welcome page. Congratulations - you've successfully deployed the foundations for a great app!

     :::image type="content" source="../media/8-addmodule-appservice.png" alt-text="The default App Service welcome page." border="true":::