> [!NOTE]
> The first time you activate a sandbox and accept the terms, your Microsoft account is associated with a new Azure directory named *Microsoft Learn Sandbox*. You're also added to a special subscription named *Concierge Subscription*.

As part of the HR application migration, you decided to create a Bicep template to deploy Azure resources. In this exercise, you'll create Azure App Service plan and App Service app. You'll appropriately apply decorators to each parameter.

During the process, you'll:

> [!div class="checklist"]
> * Create a Bicep template what include parameters and variables.
> * Update the parameters with various decorators.
> * Test the deployment to ensure that the template is valid.

This exercise uses [Bicep for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-bicep). Be sure to install this extension in Visual Studio Code.

## Create Bicep template with parameters

1. Open Visual Studio Code, and create a new file called _main.bicep_. Save the empty file so that Visual Studio Code loads the Bicep tooling. You can select File > Save, or use the Ctrl+S keyboard shortcut (⌘+S on macOS). Make sure you remember where you save the file - for example, you might want to create a scripts folder to save it in.

1. Add the following content into the file. You'll deploy the template at the end of this exercise. It's a good idea to type this in yourself instead of copying and pasting, so that you can see how the tooling helps you to write your Bicep files.

    ```bicep
    param environmentName string = 'dev'
    param solutionName string = 'toyhr${uniqueString(resourceGroup().id)}'
    param appServicePlanInstanceCount int = 2
    param location string = resourceGroup().location

    var appServicePlanName = '${environmentName}-${solutionName}-plan'
    var appServiceAppName = '${environmentName}-${solutionName}-app'
    ```

    Notice that you're using `string` and `int` type parameters. You're defining default values for each parameter. Some of the default values include string interpolation, the `uniqueString()` function, and the `resourceGroup()` function. Someone deploying this template can override the default parameter values by specifying the values at deployment time, but they can't override the variable values.

    Also note that you're defining variables for the name of the Azure App Service plan and App Service app. However you're using parameters for the other names. App Service apps need globally unique names, whereas App Service plans need to be unique only within their resource group. It's not a concern to use the same App Service plan name across different deployments, as long as the deployments are all going into different resource groups.

1. In the *main.bicep* file in Visual Studio Code, append the following code to the bottom of the file:

    ```bicep  
    resource appServicePlan 'Microsoft.Web/serverFarms@2020-06-01' = {
      name: appServicePlanName
      location: location
      sku: {
        name: 'S1'
        tier: 'Standard'
        capacity: appServicePlanInstanceCount
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

1. Save the changes to the file.

### Add parameter description

1. In the *main.bicep* file in Visual Studio Code, add `@description` decorator and description directly above every parameter that you created in the previous task. The parameters should look similar this:

    ```bicep
    @description('The name of the environment to deploy. This must be dev, test, or prod.')
    param environmentName string = 'dev'
  
    @description('The unique name of the solution to deploy.')
    param solutionName string = 'toyhr${uniqueString(resourceGroup().id)}'
    ```

    Notice that you're describing each parameter with `@description` decorator. Remember, it is a good practice.

1. Save the changes to the file.

### Control input values

1. Your toy company requires that you deploy HR application to three environments - dev, test, and prod. In the *main.bicep* file in Visual Studio Code, insert `@allowed` decorator above `@description` decorator of `environmentName` parameter. After you're finished, the parameter should look like this:

      ```bicep
      @allowed([
            'dev'
            'test'
            'prod'
      ])
      @description('Name of environment to deploy - only accept dev, test, and prod')
      param environmentName string
      ```

    Notice that you're limiting parameter value for `environmentName` parameter to only dev, test, and prod. You'll need to add new environment to this list if addition environment is requested.

1. Save the changes to the file.

### Restrict input length

1. In the *main.bicep* file in Visual Studio Code, add `@minLength` and `@maxLength` decorators above `@description` decorator for `solutionName` parameter. After you're done, the parameter should look like below:

      ```bicep
      @minLength(5)
      @maxLength(30)
      @description('Unique name of solution you want to deploy')
      param solutionName string = 'toyhr${uniqueString(resourceGroup().id)}'
      ```

      Notice that you're restricting character length of input value for the parameter. The `solutionName` parameter is used later in your Bicep code to assign value for variables. These variables are used for naming Azure App Service plan and App Service app must follow [Naming rules and restrictions for Azure Resources](/azure/azure-resource-manager/management/resource-name-rules).

1. Save the changes to the file.

### Limit number input

1. In the *main.bicep* file in Visual Studio Code, add `@minValue` and `@maxValue` decorators above `@description` decorator for `appServicePlanInstanceCount` parameter. When completed, the parameter should look like this:

      ```bicep
      @minValue(2)
      @maxValue(10)
      @description('The number of App Service plan instances to run at all times. This must be between 2 and 10.')
      param appServicePlanInstanceCount int = 2
      ```

      Notice that you're accepting only number value between 2 and 10 for `appServicePlanInstanceCount` parameter.

1. Save the changes to the file.

1. After you've completed the above tasks, the final Bicep file should look like this:

      ```bicep
      @allowed([
            'dev'
            'test'
            'prod'
      ])
      @description('Name of environment to deploy - only accept dev, test, and prod')
      param environmentName string = 'dev'
      
      @minLength(5)
      @maxLength(30)
      @description('Unique name of solution you want to deploy')
      param solutionName string = 'toyhr${uniqueString(resourceGroup().id)}'
      
      @minValue(2)
      @maxValue(10)
      @description('Number of App Service Plan Instance to run at all time - allowed number between 2 and 10')
      param appServicePlanInstanceCount int = 2
            
      @description('Azure region where you want to deploy')
      param location string = resourceGroup().location
            
      var appServicePlanName = '${environmentName}-${solutionName}-plan'
      var appServiceAppName = '${environmentName}-${solutionName}-app'
            
      resource appServicePlan 'Microsoft.Web/serverFarms@2020-06-01' = {
        name: appServicePlanName
        location: location
        sku: {
          name: 'F1'
          tier: 'Free'
          capacity: appServicePlanInstanceCount
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

## Deploy the Bicep template to Azure

::: zone pivot="cli"

[!INCLUDE [Bootstrapping instructions for first Bicep exercise - CLI](../../shared/includes/bicep-exercise-deploy-cli.md)]

### Deploy the template to Azure

Run the following code from the terminal in Visual Studio Code to deploy the Bicep template to Azure. You don't need to specify all of the other parameter values because they have default values specified. This can take a minute or two to complete, and then you'll see a successful deployment.

```azurecli
az deployment group create --template-file main.bicep
```

You'll see ```Running...``` in the terminal.

::: zone-end

::: zone pivot="powershell"

[!INCLUDE [Bootstrapping instructions for first Bicep exercise - PowerShell](../../shared/includes/bicep-exercise-deploy-powershell.md)]

### Deploy the template to Azure

Deploy the template to Azure by using the following Azure PowerShell command in the terminal. You don't need to specify all of the other parameter values because they have default values specified. This can take a minute or two to complete, and then you'll see a successful deployment.

```azurepowershell
New-AzResourceGroupDeployment -TemplateFile main.bicep
```

::: zone-end

## Verify the deployment

The first time you deploy a Bicep template, you might want to use the Azure portal to verify that the deployment has finished successfully and to inspect the results.

1. Go to the [Azure portal](https://portal.azure.com?azure-portal=true) and make sure you're in the sandbox subscription:

   1. Select your avatar in the upper-right corner of the page.
   1. Select **Switch directory**. In the list, choose the **Microsoft Learn Sandbox** directory.

1. On the left-side panel, select **Resource groups**.

1. Select **<rgn>[sandbox resource group name]</rgn>**.

1. In **Overview**, you can see that one deployment succeeded.

    :::image type="content" source="../media/4-deployment-succeeded.png" alt-text="Screenshot of the Azure portal interface for the resource group overview, with the deployments section showing that one succeeded." border="true":::

1. Select **1 Succeeded** to see the details of the deployment.

    :::image type="content" source="../media/4-deployment.png" alt-text="Screenshot of the Azure portal interface for the deployments, with the one deployment listed and a succeeded status." border="true":::

1. Select the deployment called **main** to see what resources were deployed, and then select **Deployment details** to expand it. In this case, there's one storage account with the name that you specified.

    :::image type="content" source="../media/4-deployment-details.png" alt-text="Screenshot of the Azure portal interface for the specific deployment, with one storage account resource listed." border="true":::

1. Notice that the App Service plan and App Service app have been deployed.
