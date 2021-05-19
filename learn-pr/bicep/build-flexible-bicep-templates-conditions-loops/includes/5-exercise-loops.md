So far, your Bicep template has deployed a single SQL server, with auditing settings included for your production environment. You now need to deploy multiple SQL servers so that you can have one in each region your company is launching its new smart teddy bear into. In this exercise you'll extend the Bicep code you previously created to deploy instances of your databases in multiple Azure regions.

During the process, you'll:

> [!div class="checklist"]
> * Move your existing Bicep code into a module.
> * Create a new Bicep file with a copy loop to deploy the module's resources multiple times.
> * Deploy the Bicep file, and verify the deployment of the resources.
> * Modify the parameter to add an additional location, then redeploy the file and verify that the new resources have been deployed.

This exercise uses [the Bicep extension for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-bicep). Be sure to install this extension in Visual Studio Code.

## Move resources into a module

1. In Visual Studio Code, create a new folder called *modules* in the same folder where you created your *main.bicep* file.

1. Move your *main.bicep* file into the *modules* folder you just created..

1. Rename the *main.bicep* file to *database.bicep*.

## Deploy multiple instances using a copy loop

1. Create a new *main.bicep* file to replace the one you just moved and renamed.

1. Open the new *main.bicep* file and add the following parameters:

   ::: code language="bicep" source="code/5-template.bicep" range="1-13" :::

1. Add the following module declaration below the parameter declarations:

   ::: code language="bicep" source="code/5-template.bicep" range="15-22" :::

   Notice that the module declaration loops over all of the values in the `locations` array parameter.

   Your *main.bicep* file should look like this:

   ::: code language="bicep" source="code/5-template.bicep" :::

1. Save the changes to the file.

## Deploy the Bicep template to Azure

::: zone pivot="cli"

Run the following code from the terminal in Visual Studio Code to deploy the Bicep template to Azure.

```azurecli
az deployment group create --template-file main.bicep
```

::: zone-end

::: zone pivot="powershell"

Deploy the template to Azure by using the following Azure PowerShell command in the terminal.

```azurepowershell
New-AzResourceGroupDeployment -TemplateFile main.bicep
```

::: zone-end

> [!CAUTION]
> Make sure you use the same login and password that you used previously. If you don't, the deployment won't complete successfully.

You see `Running...` in the terminal. Wait for the deployment to finish.

## Verify the deployment

After deployment is finished, you want to verify that new SQL server and database are deployed and that they are located in correct Azure regions.

1. Go to the [Azure portal](https://portal.azure.com?azure-portal=true) and make sure you're in the sandbox subscription.

1. Select **<rgn>[sandbox resource group name]</rgn>**.

1. Verify that new SQL server and database are located in the regions you specified in the `locations` parameter's default value.

    :::image type="content" source="../media/5-loop-deployment.png" alt-text="Screenshot of the Azure portal interface for the specific deployment, with SQL servers in different locations." border="true":::

1. Leave the page open in your browser. You'll check on deployments again later.

## Update and redeploy the template to Azure with additional location for Azure SQL Servers

The team launching the new teddy bear has told you they are about to launch again - this time into Asia. They've asked for a new database server and database in the East Asia region. You need to update your Bicep parameter and redeploy your template.

1. Return to Visual Studio Code. At the top of the *main.bicep* file, add a new value into the `locations` array:

   ::: code language="plaintext" source="code/5-add-location.bicep" highlight="5" :::

1. Save the changes to the file.

::: zone pivot="cli"

1. Redeploy the file by running the following code from the terminal in Visual Studio Code:

    ```azurecli
    az deployment group create --template-file main.bicep
    ```

::: zone-end

::: zone pivot="powershell"

1. Redeploy the file by running the following code from the terminal in Visual Studio Code:

    ```azurepowershell
    New-AzResourceGroupDeployment -TemplateFile main.bicep
    ```

::: zone-end

> [!CAUTION]
> Make sure you use the same login and password that you used previously. If you don't, the deployment won't complete successfully.

You see `Running...` in the terminal. Wait for the deployment to finish.

## Verify the redeployment

Now that you've redeployed the resources, you want to verify that the additional SQL server and database resources have been created in East Asia.

1. Return to the [Azure portal](https://portal.azure.com?azure-portal=true) and select the **<rgn>[sandbox resource group name]</rgn>** resource group. If required, select **Refresh** to see the newly deployed resources.

1. Verify the new SQL server and database have been deployed in East Asia.

    :::image type="content" source="../media/5-loop-redeployment.png" alt-text="Screenshot of the Azure portal interface for the specific deployment, with SQL servers in additional location." border="true":::
