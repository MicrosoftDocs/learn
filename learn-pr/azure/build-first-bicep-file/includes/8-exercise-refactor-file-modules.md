> [!NOTE]
> This exercise is optional. If you want to complete it, you'll need an Azure subscription before you begin. If you don't have an Azure account or don't want to create one now, you can read through the instructions to understand the concepts.

In this exercise, you'll update the Bicep file you previously created so it uses a module for the Azure App Service resources. Modules help to keep the intention of the main file clearer. You can reuse the App Service module in other Bicep files if you choose to.

During the process, you'll:

> [!div class="checklist"]
>
> - Add a new module and move the App Service resources into it.
> - Reference the module from the main Bicep file.
> - Add an output for the App Service app's host name, and emit it from the module and Bicep file deployments.
> - Test the deployment to ensure that the Bicep file is valid.

## Add a new module file

Create a self-contained module for your App Service resources:

1. In Visual Studio Code, create a new folder called _modules_ in the same folder where you created your _main.bicep_ file. In the _modules_ folder, create a file called _appService.bicep_. Save the file.

1. Add the following content into the _appService.bicep_ file:

   :::code language="bicep" source="code/8-app-service.bicep" range="1-28" :::

   Notice that you've copied the parameters and variables from your _main.bicep_ Bicep file since the _appService.bicep_ Bicep file needs to be self-contained.

1. Save the changes to the file. Notice that Visual Studio Code doesn't show you any red squiggles to indicate warnings about missing variables, missing parameters, or invalid resources.

### Add a reference to the module from the parent Bicep file

Now that you've created a complete module to deploy the App Service resources, you can refer to the module within the parent Bicep file. Because the module deploys the App Service resources, you can delete the associated resources and variables from the parent file.

1. In the _main.bicep_ file, delete the App Service resources and the `appServicePlanName` and `appServicePlanSkuName` variable definitions. Don't delete the App Service parameters, because you still need them. Also, don't delete the storage account parameters, variable, or resources.

1. At the bottom of the _main.bicep_ file, add the following Bicep code:

   :::code language="bicep" source="code/8-template.bicep" range="25-32" :::

   Notice that you're specifying the parameters for your module by referencing the parameters in the parent Bicep file.

1. Save the changes to the file.

## Add the host name as an output

Expose the app's host name from both the module and its parent file:

1. Add the following Bicep code at the bottom of the _appService.bicep_ file:

   :::code language="bicep" source="code/8-app-service.bicep" range="30" :::

   This code declares that an output for this module, which will be named `appServiceAppHostName`, will be of type `string`. The output will take its value from the `defaultHostName` property of the App Service app.

1. Save the changes to the file.

   The output is declared in the App Service module. The parent file can read it through `appService.outputs.appServiceAppHostName`, but it isn't automatically included in the parent deployment's outputs. Add a matching output to the parent file so that someone inspecting the `main` deployment can retrieve it there. This ordinary, non-secret output can also be read from the module's nested deployment record by a user with the required deployment read permissions.

1. Open the _main.bicep_ file and add the following code at the bottom of the file:

   :::code language="bicep" source="code/8-template.bicep" range="34" :::

   Notice that this output is declared in a similar way to the output in the module. But this time, you're referencing the module's output instead of a resource property.

1. Save the changes to the file.

## Verify your Bicep files

After you've completed all of the preceding changes, your _main.bicep_ file should look like this example:

:::code language="bicep" source="code/8-template.bicep" :::

Your _appService.bicep_ file should look like this example:

:::code language="bicep" source="code/8-app-service.bicep" :::

If either Bicep file doesn't match, copy the example or adjust your file to match the example.

### Deploy the updated Bicep file

> [!NOTE]
> Use the same subscription and resource group throughout these exercises. Reapply any resource-name or location parameter overrides from the preceding deployment; otherwise, the defaults in the template are used again.
>
> Continue setting `environmentType` to `nonprod` and using the same exercise resource group for this walkthrough. The `prod` value illustrates a paid production configuration, not a step to run in these exercises. Before using it for a separate environment, review the production deployment prerequisites in Selecting SKUs for resources in the Add flexibility by using parameters and variables unit.

::: zone pivot="cli"

Run the following Azure CLI command in the terminal.

```azurecli
az deployment group create \
  --resource-group "$resourceGroupName" \
  --name main \
  --template-file main.bicep \
  --parameters environmentType=nonprod
```

::: zone-end

::: zone pivot="powershell"

Run the following Azure PowerShell command in the terminal.

```azurepowershell
New-AzResourceGroupDeployment `
  -ResourceGroupName $resourceGroupName `
  -Name main `
  -TemplateFile main.bicep `
  -environmentType nonprod
```

::: zone-end

### Check your deployment

Confirm that the module deployed and returned the app's host name:

1. In your browser, return to the Azure portal. Go to your resource group and open **Deployments**.

1. Locate the `main` deployment and the nested `appService` deployment. A successful run creates or updates these named entries. Other deployments might also be listed.

    :::image type="content" source="../media/8-addmodule-deployment.png" alt-text="Screenshot of Azure portal deployment history showing successful main and appService deployments." border="true":::

1. Select the deployment called **main**. Confirm that its latest operation succeeded and corresponds to the command you just ran, then select **Deployment details** to expand the list of deployed resources.

    Notice that our module deployment appears in the list.

    :::image type="content" source="../media/8-addmodule-details.png" alt-text="Screenshot of Azure portal deployment details listing the App Service module." border="true":::

1. Select the **Outputs** tab. Notice that there's an output called **appServiceAppHostName** with the host name of your App Service app. Copy the host name to your clipboard.

    :::image type="content" source="../media/8-addmodule-outputs.png" alt-text="Screenshot of Azure portal deployment outputs showing the App Service app's host name." border="true":::

1. Open a new browser tab and paste the host name that you copied. You should see the default App Service welcome page.

     :::image type="content" source="../media/8-addmodule-appservice.png" alt-text="Screenshot of the default welcome page for an Azure App Service app." border="true":::

Congratulations! You've successfully deployed the foundations for a great app.
