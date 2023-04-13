[!INCLUDE [Sandbox explanation](../../includes/azure-template-exercise-sandbox-subscription.md)]

As part of the HR application migration, you're creating a Bicep template to deploy Azure resources. In this exercise, you'll create an Azure App Service plan and App Service app. You'll apply decorators to each parameter to ensure that they'll always contain the values you expect.

During the process, you'll do the following tasks:

> [!div class="checklist"]
>
> - Create a Bicep file that includes parameters and variables.
> - Add decorators to the parameters.
> - Test the deployment to ensure that the template is valid.

[!INCLUDE [Install the Bicep extension for Visual Studio Code](../../includes/azure-template-bicep-exercise-vscode-extension.md)]

## Create a Bicep template with parameters

1. Open Visual Studio Code.

1. Create a new file called _main.bicep_.

1. Save the empty file so that Visual Studio Code loads the Bicep tooling.

   You can either select **File** > **Save As** or select <kbd>Ctrl+S</kbd> in Windows (<kbd>⌘+S</kbd> on macOS). Be sure to remember where you've saved the file. For example, you might want to create a _scripts_ folder to save it in.

1. Add the following content into the file. You'll deploy the template soon. Enter the content yourself instead of copying and pasting so that you can see how the tooling helps you to write your Bicep files.

   :::code language="bicep" source="code/3-template.bicep" range="7,12,17,20-23,26-29" :::

   You're creating several parameters here, and they use a mixture of types. You're defining default values for each parameter. Some of the default values include string interpolation and the `uniqueString()` function.

   > [!TIP]
   > The `uniqueString()` function is useful for creating globally unique resource names. It returns a string that's the same on every deployment to the same resource group, but different when you deploy to different resource groups or subscriptions.

   You're also defining variables that construct the names of the Azure App Service plan and App Service app. Their values include some of the parameters you've specified. Parameter values can be overridden by the user who executes the deployment, but the values of the variables can't be overridden.

   [!INCLUDE [Sandbox location note](../../includes/azure-template-bicep-exercise-sandbox-location.md)]

1. In the _main.bicep_ file in Visual Studio Code, add the following code to the bottom of the file:

   :::code language="bicep" source="code/3-template.bicep" range="31-49" :::

   Notice that the resources use the values of the parameters you defined.

1. Save the changes to the file.

### Add parameter descriptions

1. In the _main.bicep_ file in Visual Studio Code, add the `@description` decorator directly above every parameter that you created in the previous task. The parameters should look similar to this example:

   :::code language="bicep" source="code/3-template.bicep" range="1,7-9,12-14,17-26" highlight="1,4,7,10,16" :::

1. Save the changes to the file.

### Limit input values

Your toy company will deploy the HR application to three environments: `dev`, `test`, and `prod`. You'll limit the `environmentName` parameter to only allow those three values.

1. In the _main.bicep_ file in Visual Studio Code, find the `environmentName` parameter. Insert an `@allowed` decorator underneath its `@description` decorator. After you're finished, the parameter should look like this example:

   :::code language="bicep" source="code/3-template.bicep" range="1-7" highlight="2-6" :::

   Notice that you're limiting the parameter value for `environmentName` parameter to only `dev`, `test`, and `prod`. If more environments are added in the future, you'll need to update this list.

1. Save the changes to the file.

### Limit input lengths

Your `solutionName` parameter is used to generate the names of resources. You want to enforce a minimum length of 5 characters and a maximum length of 30 characters.

1. In the _main.bicep_ file in Visual Studio Code, find the `solutionName` parameter. Add `@minLength` and `@maxLength` decorators underneath the `@description` decorator. After you're finished, the parameter should look like this example:

   :::code language="bicep" source="code/3-template.bicep" range="9-12" highlight="2-3" :::

1. Save the changes to the file.

### Limit numeric values

Next, you'll ensure that the `appServicePlanInstanceCount` parameter only allows values between 1 and 10.

1. In the _main.bicep_ file in Visual Studio Code, find the `appServicePlanInstanceCount` parameter. Add `@minValue` and `@maxValue` decorators underneath the `@description` decorator. After you're finished, the parameter should look like this example:

   :::code language="bicep" source="code/3-template.bicep" range="14-17" highlight="2-3" :::

1. Save the changes to the file.

## Verify your Bicep file

After you've completed all of the preceding changes, your Bicep file should look like this example:

:::code language="bicep" source="code/3-template.bicep" :::

If it doesn't, either copy the example or adjust your template to match the example.

## Deploy the Bicep template to Azure

::: zone pivot="cli"

[!INCLUDE [Bootstrapping instructions for first Bicep exercise - CLI](../../includes/azure-template-bicep-exercise-sandbox-deploy-cli.md)]

### Deploy the template to Azure by using the Azure CLI

Run the following code from the terminal in Visual Studio Code to deploy the Bicep template to Azure. You don't need to specify the parameter values because they have default values specified. This process can take a minute or two to complete, and then you'll see a successful deployment.

```azurecli
az deployment group create --template-file main.bicep
```

You'll see ```Running...``` in the terminal.

::: zone-end

::: zone pivot="powershell"

[!INCLUDE [Bootstrapping instructions for first Bicep exercise - PowerShell](../../includes/azure-template-bicep-exercise-sandbox-deploy-powershell.md)]

### Deploy the template to Azure by using PowerShell

Deploy the template to Azure by using the following Azure PowerShell command in the terminal. You don't need to specify the parameter values because they have default values specified. This process can take a minute or two to complete, and then you'll see a successful deployment.

```azurepowershell
New-AzResourceGroupDeployment -TemplateFile main.bicep
```

::: zone-end

## Verify your deployment

1. Go to the [Azure portal](https://portal.azure.com) and make sure you're in the sandbox subscription:

   1. Select your avatar in the upper-right corner of the page.
   1. Select **Switch directory**. In the list, choose the **Microsoft Learn Sandbox** directory.

1. On the left-side panel, select **Resource groups**.

1. Select **<rgn>[sandbox resource group name]</rgn>**.

1. In **Overview**, you can see that one deployment succeeded.

    :::image type="content" source="../media/3-deployment-succeeded.png" alt-text="Screenshot of the Azure portal interface for the resource group overview, with the deployments section showing that one succeeded." border="true":::

1. Select **1 Succeeded** to see the details of the deployment.

    :::image type="content" source="../media/3-deployment.png" alt-text="Screenshot of the Azure portal interface for the deployments, with the one deployment listed and a succeeded status." border="true":::

1. Select the deployment called **main** to see what resources were deployed, and then select **Deployment details** to expand it. In this case, there's an App Service plan and app.

    :::image type="content" source="../media/3-deployment-details.png" alt-text="Screenshot of the Azure portal interface for the specific deployment, with an App Service plan and app listed." border="true":::

1. On the left menu, select **Inputs**.

    :::image type="content" source="../media/3-menu-inputs.png" alt-text="Screenshot of the Azure portal interface for the specific deployment, with the 'Inputs' menu item highlighted." border="true":::

1. Notice that the parameters and their values are listed.

    :::image type="content" source="../media/3-deployment-parameters.png" alt-text="Screenshot of the Azure portal interface for the specific deployment showing the parameter values." border="true":::

1. Leave the page open in your browser. You'll check on deployments again later.
