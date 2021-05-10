[!INCLUDE [Sandbox explanation](../../shared/includes/bicep-sandbox-subscription.md)]

As part of the HR application migration, you're creating a Bicep template to deploy Azure resources. In this exercise, you'll create an Azure App Service plan and App Service app. You'll apply decorators to each parameter to ensure that they'll always contain the values you expect. During the process, you'll:

> [!div class="checklist"]
> * Create a Bicep file that includes parameters and variables.
> * Add decorators to the parameters.
> * Test the deployment to ensure that the template is valid.

This exercise uses [Bicep for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-bicep). Be sure to install this extension in Visual Studio Code.

## Create Bicep template with parameters

1. Open Visual Studio Code, and create a new file called *main.bicep*. Save the empty file so that Visual Studio Code loads the Bicep tooling. You can select File > Save, or use the <kbd>Ctrl+S</kbd> keyboard shortcut (<kbd>⌘+S</kbd> on macOS). Make sure you remember where you save the file - for example, you might want to create a **scripts** folder to save it in.

1. Add the following content into the file. You'll deploy the template soon. It's a good idea to type this in yourself instead of copying and pasting, so that you can see how the tooling helps you to write your Bicep files.

   :::code language="bicep" source="code/3-template.bicep" range="7,12,17,20-23,26-29" :::

   Notice that you're creating several parameters here, and they use a mixture of types. You're defining default values for each parameter. Some of the default values include string interpolation, the `uniqueString()` function, and the `resourceGroup()` function.

   > [!TIP]
   > The `uniqueString()` function is useful for creating globally unique resource names. It will return a string that will be the same on every deployment to the same resource group, but different when you deploy to different resource groups or subscriptions.

   Also notice you're defining variables that construct the names of the Azure App Service plan and App Service app, and their values include some of the parameters you've specified. Parameter values can be overridden by the user executing the deployment, but the values of the variables can't be overridden.

1. In the *main.bicep* file in Visual Studio Code, add the following code to the bottom of the file:

   :::code language="bicep" source="code/3-template.bicep" range="31-48" :::

   Notice that the resources use the values of the parameters you defined above.

1. Save the changes to the file.

### Add parameter descriptions

1. In the *main.bicep* file in Visual Studio Code, add the `@description` decorator directly above every parameter that you created in the previous task. The parameters should look similar to this:

   :::code language="plaintext" source="code/3-template.bicep" range="1,7-9,12-14,17-26" highlight="1,4,7,10,16" :::

1. Save the changes to the file.

### Limit input values

Your toy company will deploy the HR application to three environments - dev, test, and prod. Let's limit the `environmentName` parameter to these three values.

1. In the *main.bicep* file in Visual Studio Code, find the `environmentName` parameter. Insert an `@allowed` decorator below its `@description` decorator. After you're finished, the parameter should look like this:

   :::code language="plaintext" source="code/3-template.bicep" range="1-7" highlight="2-6" :::

   Notice that you're limiting the parameter value for `environmentName` parameter to only `dev`, `test`, and `prod`. If more environments are added in the future, you'll need to update this list.

1. Save the changes to the file.

### Limit input lengths

Your `solutionName` parameter is used to generate the names of resources. You want to enforce a minimum length of five characters and a maximum length of 30 characters.

1. In the *main.bicep* file in Visual Studio Code, find the `solutionName` parameter. Add `@minLength` and `@maxLength` decorators below the `@description` decorator. After you're done, the parameter should look like below:

   :::code language="plaintext" source="code/3-template.bicep" range="9-12" highlight="2-3" :::

1. Save the changes to the file.

### Limit numeric values

You need to ensure that the `appServicePlanInstanceCount` parameter only allows values between 1 and 10.

1. In the *main.bicep* file in Visual Studio Code, find the `appServicePlanInstanceCount` parameter. Add `@minValue` and `@maxValue` decorators below the `@description` decorator. After you're done, the parameter should look like this:

   :::code language="plaintext" source="code/3-template.bicep" range="14-17" highlight="2-3" :::

   After you've completed all of the above changes, your Bicep file should look like this:

   :::code language="bicep" source="code/3-template.bicep" :::

1. Save the changes to the file.

## Deploy the Bicep template to Azure

::: zone pivot="cli"

[!INCLUDE [Bootstrapping instructions for first Bicep exercise - CLI](../../shared/includes/bicep-exercise-deploy-cli.md)]

### Deploy the template to Azure

Run the following code from the terminal in Visual Studio Code to deploy the Bicep template to Azure. You don't need to specify the parameter values because they have default values specified. This can take a minute or two to complete, and then you'll see a successful deployment.

```azurecli
az deployment group create --template-file main.bicep
```

You'll see ```Running...``` in the terminal.

::: zone-end

::: zone pivot="powershell"

[!INCLUDE [Bootstrapping instructions for first Bicep exercise - PowerShell](../../shared/includes/bicep-exercise-deploy-powershell.md)]

### Deploy the template to Azure

Deploy the template to Azure by using the following Azure PowerShell command in the terminal. You don't need to specify the parameter values because they have default values specified. This can take a minute or two to complete, and then you'll see a successful deployment.

```azurepowershell
New-AzResourceGroupDeployment -TemplateFile main.bicep
```

::: zone-end
