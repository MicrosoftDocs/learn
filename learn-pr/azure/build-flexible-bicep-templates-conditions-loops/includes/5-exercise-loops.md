So far, your Bicep template has deployed a single Azure SQL logical server, with auditing settings included for your production environment. You now need to deploy multiple logical servers, one for each region where your company is launching its new smart teddy bear. 

In this exercise, you'll extend the Bicep code that you created previously so that you can deploy instances of your databases to multiple Azure regions.

During the process, you'll:

> [!div class="checklist"]
> * Move your existing Bicep code into a module.
> * Create a new Bicep file with a copy loop to deploy the module's resources multiple times.
> * Deploy the Bicep file, and verify the deployment of the resources.
> * Modify the parameter to add an additional location, redeploy the file, and then verify that the new resources have been deployed.

## Move resources into a module

1. In Visual Studio Code, create a new folder called *modules* in the same folder where you created your *main.bicep* file.

1. Move your *main.bicep* file into the *modules* folder you just created.

1. Rename the *main.bicep* file to *database.bicep*.

## Deploy multiple instances by using a copy loop

1. Create a new *main.bicep* file to replace the one you just moved and renamed.

1. Open the new *main.bicep* file, and add the following parameters:

   ::: code language="bicep" source="code/5-template.bicep" range="1-13" :::

1. Below the parameter declarations, add the following module declaration:

   ::: code language="bicep" source="code/5-template.bicep" range="15-22" :::

   Notice that the module declaration loops over all the values in the `locations` array parameter.

1. Save the changes to the file.

## Verify your Bicep file

After you've completed all of the preceding changes, your *main.bicep* file should look like this example:

::: code language="bicep" source="code/5-template.bicep" :::

Your *database.bicep* file should look like this example:

::: code language="bicep" source="code/3-template.bicep" :::

If it doesn't, either copy the example or adjust your template to match the example.

## Deploy the Bicep template to Azure

::: zone pivot="cli"

In the Visual Studio Code terminal, deploy the Bicep template to Azure by running the following code:

```azurecli
az deployment group create --template-file main.bicep
```

::: zone-end

::: zone pivot="powershell"

In the Visual Studio Code terminal, deploy the Bicep template to Azure by running the following Azure PowerShell command:

```azurepowershell
New-AzResourceGroupDeployment -TemplateFile main.bicep
```

::: zone-end

> [!CAUTION]
> Be sure to use the same login and password that you used previously, or the deployment won't finish successfully.

Wait for the deployment to finish.

## Verify the deployment

After the deployment is finished, you want to verify that the new logical server and database are deployed and that they're located in the correct Azure regions.

1. Go to the [Azure portal](https://portal.azure.com?azure-portal=true), and make sure that you're in the sandbox subscription.

1. Select **<rgn>[sandbox resource group name]</rgn>**.

1. Verify that new logical server and database are located in the East US 2 region, which you specified in the `locations` parameter's default value.

    :::image type="content" source="../media/5-loop-deployment.png" alt-text="Screenshot of the Azure portal, showing the deployment of the logical servers and databases in various locations." border="true":::

1. Leave the page open in your browser. You'll check on deployments again later.

## Update and redeploy the template to Azure with an additional location for a logical server

The teddy bear toy team is about to launch again, this time into Asia. The team is asking you to deploy a new server and database in the East Asia region. To do so, you need to update your Bicep parameter and redeploy your template.

::: zone pivot="cli"

1. Return to Visual Studio Code. At the top of the *main.bicep* file, add a new value to the `locations` array:

   ::: code language="bicep" source="code/5-add-location.bicep" highlight="5" :::

1. Save the changes to the file.

1. In the Visual Studio Code terminal, redeploy the file by running the following code:

    ```azurecli
    az deployment group create --template-file main.bicep
    ```

::: zone-end

::: zone pivot="powershell"

1. Return to Visual Studio Code. At the top of the *main.bicep* file, add a new value to the `locations` array:

   ::: code language="bicep" source="code/5-add-location.bicep" highlight="5" :::

1. Save the changes to the file.

1. In the Visual Studio Code terminal, redeploy the file by running the following code:

    ```azurepowershell
    New-AzResourceGroupDeployment -TemplateFile main.bicep
    ```

::: zone-end

> [!CAUTION]
> Be sure to use the same login and password that you used previously, or the deployment won't finish successfully.

Wait for the deployment to finish.

## Verify the redeployment

Now that you've redeployed the resources, you want to verify that the additional logical server and database resources have been created in the East Asia region.

1. Return to the [Azure portal](https://portal.azure.com?azure-portal=true) and select the **<rgn>[sandbox resource group name]</rgn>** resource group. If necessary, select **Refresh** to see the newly deployed resources.

1. Verify that the new logical server and database have been deployed in the East Asia region.

    :::image type="content" source="../media/5-loop-redeployment.png" alt-text="Screenshot of the Azure portal, showing the deployment of a logical server and database in an additional region." border="true":::
