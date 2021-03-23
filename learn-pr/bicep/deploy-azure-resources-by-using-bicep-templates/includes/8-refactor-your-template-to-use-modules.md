> [!NOTE]
> The first time you activate a sandbox and accept the terms, your Microsoft account is associated with a new Azure directory named Microsoft Learn Sandbox. You're also added to a special subscription named Concierge Subscription.

In this exercise, you update the Bicep template that you previously created so that it uses a module for the App Service resources. Modules help to keep the intention of the main template clearer. It also means that we can reuse the App Service module in other templates if we want.

During the process, you:

> [!div class="checklist"]
> * Add a new module and move the App Service resources into it.
> * Reference the module from the main Bicep template.
> * Add an output for the App Service app's host name, and emit it from the module and template deployments.
> * Test the deployment to ensure the template is valid.

This exercise uses [Bicep for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-bicep). Be sure to install this extension in Visual Studio Code.

> [!IMPORTANT]
> To complete this module, you need your own [Azure subscription](https://azure.microsoft.com/free/?azure-portal=true). Get started for free.

> [!CAUTION]
> TODO: images are not correct!

## Add a new module file

1. In Visual Studio Code, create a new folder called *modules* in the same place you created your *main.bicep* file. Inside this folder, create a file called *appService.bicep*.

1. Add the following content into the *appService.bicep* file:

   ```bicep
   param location string
   param appServiceAppName string
   @allowed([
     'nonprod'
     'prod'
   ])
   param environmentType string
   
   var appServicePlanName = 'ToyLaunchPlan'
   var appServicePlanSkuName = (environmentType == 'prod') ? 'P2_v3' : 'S1'
   
   resource appServicePlan 'Microsoft.Web/serverFarms@2020-06-01' = {
     name: appServicePlanName
     location: location
     sku: {
       name: appServicePlanSkuName
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

   Notice we have copied the parameters and variables from our *main.bicep* template, since the *appService.bicep* template needs to be self-contained.

1. Save the changes to the file. Notice there are no warnings about missing variables or parameters, or invalid resource.

### Add a reference to the module from the parent template

Now that we have a complete module to deploy our App Service resources, we can refer to the module within our parent template. Since the module now deploys our App Service resources, we can delete the associated resources and variables from our parent template.

1. In the *main.bicep* file, delete the App Service resources and the  `appServicePlanName` and `appServicePlanSkuName` variable definitions. Don't delete the App Service-related parameters, because we still need them.

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

   Notice we are specifying the parameters for our module by referencing the parameters in our parent template.

1. Save the changes to the file.

## Add the host name as an output

1. Add the following Bicep code at the bottom of the *appService.bicep* file:

   ```bicep
   output appServiceAppHostName string = appServiceApp.properties.defaultHostName
   ```

   This code is declaring an output for this module, which will be named `appServiceAppHostName`, will be of type `string`, and will take its value from the `defaultHostName` property of our App Service app.

1. Save the changes to the file.

Because this output is declared within a module, it's only going to be available to the parent template. We need to return the output to the person executing the template as well.

1. Open the *main.bicep* file and add the following code at the bottom of the file:

   ```bicep
   output appServiceAppHostName string = appService.outputs.appServiceAppHostName
   ```

   Notice this output is declared in a similar way to the output in our module, but this time we are referencing the module's output instead of a resource property.

1. Save the changes to the file.

### Deploy the updated Bicep template

::: zone pivot="cli"

Run the following Azure CLI commands in the terminal. This snippet is the same code you used previously, but the name of the deployment is changed.

```azurecli
templateFile="main.bicep"
today=$(date +"%d-%b-%Y")
DeploymentName="addmodule-"$today

az group deployment create \
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
$deploymentName = "addmodule-$today"
New-AzResourceGroupDeployment `
  -Name $deploymentName `
  -TemplateFile $templateFile `
  -environmentType nonprod
```

::: zone-end

### Check your deployment

1. In your browser, go back to Azure. Go to your resource group, and you'll see that there are now **5 Succeeded** deployments. Select this link.

1. Notice that we have two new deployments in the list. One begins with the name **`addmodule`**, and another is called **`appService`**:

    :::image type="content" source="../media/4-addstorage-deployment.png" alt-text="Azure portal interface for the deployments with the two deployments listed and succeeded statuses." border="true"::: <!-- TODO image -->

1. Select **`addmodule`**.

    :::image type="content" source="../media/4-show-resource-deployed.png" alt-text="Azure portal interface for the specific deployment with one resource listed." border="true"::: <!-- TODO image -->

1. Click the **Outputs** tab. Notice that there is an output called `appServiceAppHostName` with the host name of our App Service app.
