In this exercise, you'll update the Bicep template you previously created so it uses a module for the Azure App Service resources. Modules help to keep the intention of the main template clearer. You can reuse the App Service module in other templates if you choose to.

During the process, you'll:

> [!div class="checklist"]
>
> - Add a new module and move the App Service resources into it.
> - Reference the module from the main Bicep template.
> - Add an output for the App Service app's host name, and emit it from the module and template deployments.
> - Test the deployment to ensure that the template is valid.

## Add a new module file

1. In Visual Studio Code, create a new folder called _modules_ in the same folder where you created your _main.bicep_ file. In the _modules_ folder, create a file called _appService.bicep_. Save the file.

1. Add the following content into the _appService.bicep_ file:

   :::code language="bicep" source="code/8-app-service.bicep" range="1-28" :::

   Notice that you've copied the parameters and variables from your _main.bicep_ template, because the _appService.bicep_ template needs to be self-contained.

1. Save the changes to the file. Notice that Visual Studio Code doesn't show you any red squiggles to indicate warnings about missing variables, missing parameters, or invalid resources.

### Add a reference to the module from the parent template

Now that you have a complete module to deploy the App Service resources, you can refer to the module within the parent template. Because the module deploys the App Service resources, you can delete the associated resources and variables from the parent template.

1. In the _main.bicep_ file, delete the App Service resources and the `appServicePlanName` and `appServicePlanSkuName` variable definitions. Don't delete the App Service parameters, because you still need them. Also, don't delete the storage account parameters, variable, or resources.

1. At the bottom of the _main.bicep_ file, add the following Bicep code:

   :::code language="bicep" source="code/8-template.bicep" range="25-32" :::

   Notice that you're specifying the parameters for your module by referencing the parameters in the parent template.

1. Save the changes to the file.

## Add the host name as an output

1. Add the following Bicep code at the bottom of the _appService.bicep_ file:

   :::code language="bicep" source="code/8-app-service.bicep" range="30" :::

   This code declares that an output for this module, which will be named `appServiceAppHostName`, will be of type `string`. The output will take its value from the `defaultHostName` property of the App Service app.

1. Save the changes to the file.

   This output is declared within a Bicep file we'll use as a module, so it's going to be available only to the parent template. You also need to return the output to the person who deployed the template.

1. Open the _main.bicep_ file and add the following code at the bottom of the file:

   :::code language="bicep" source="code/8-template.bicep" range="34" :::

   Notice that this output is declared in a similar way to the output in the module. But this time, you're referencing the module's output instead of a resource property.

1. Save the changes to the file.

## Verify your Bicep files

After you've completed all of the preceding changes, your _main.bicep_ file should look like this example:

:::code language="bicep" source="code/8-template.bicep" :::

Your _appService.bicep_ file should look like this example:

:::code language="bicep" source="code/8-app-service.bicep" :::

If either file doesn't match, copy the example or adjust your template to match the example.

### Deploy the updated Bicep template

::: zone pivot="cli"

Run the following Azure CLI command in the terminal.

```azurecli
az deployment group create \
  --template-file main.bicep \
  --parameters environmentType=nonprod
```

::: zone-end

::: zone pivot="powershell"

Run the following Azure PowerShell command in the terminal.

```azurepowershell
New-AzResourceGroupDeployment `
  -TemplateFile main.bicep `
  -environmentType nonprod
```

::: zone-end

### Check your deployment

1. In your browser, go back to the Azure portal. Go to your resource group, and you'll see that there are now two successful deployments.

1. Select the **2 Succeeded** link. Notice that you have a deployment called **main** in the list, and a new deployment called **appService**.

    :::image type="content" source="../media/8-addmodule-deployment.png" alt-text="Screenshot of the Azure portal interface for the deployments, with the two deployments listed and succeeded statuses." border="true":::

1. Select the deployment called **main**, then select **Deployment details** to expand the list of deployed resources.

    Notice that our module deployment appears in the list.

    :::image type="content" source="../media/8-addmodule-details.png" alt-text="Screenshot of the Azure portal interface for the specific deployment, with one resource listed." border="true":::

1. Select the **Outputs** tab. Notice that there's an output called **appServiceAppHostName** with the host name of your App Service app. Copy the host name to your clipboard.

    :::image type="content" source="../media/8-addmodule-outputs.png" alt-text="Screenshot of the Azure portal interface for the specific deployment's outputs." border="true":::

1. Open a new browser tab and paste the host name that you copied. You should see the default App Service welcome page.

     :::image type="content" source="../media/8-addmodule-appservice.png" alt-text="Screenshot of the default App Service welcome page." border="true":::

Congratulations! You've successfully deployed the foundations for a great app.
