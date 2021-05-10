For your toy company, you need to deploy multiple Azure SQL Server resources to support new toy launch. You need to follow requirement, that each country where toy is launched, needs dedicated Azure SQL Server deployed in same country or compliant Azure region. In this exercise you will create flexible Bicep template, which will enable you to specify locations where Azure SQL Server is deployed by using parameters.

During the process, you'll:

> [!div class="checklist"]
> * Create a Bicep template with a copy loop to deploy Azure SQL Servers resources as specified by parameter value.
> * Deploy Bicep template and verify deployment of Azure SQL Server resources.
> * Modify parameter values to add additional location, redeploy template and verify new Azure SQL Server resource deployed.

This exercise uses [the Bicep extension for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-bicep). Be sure to install this extension in Visual Studio Code.

## Move resources into a module

1. In Visual Studio Code, create a new folder called *modules* in the same folder where you created your *main.bicep* file.

1. Move your *main.bicep* file into the *modules* folder you just created..

1. Rename the *main.bicep* file to *database.bicep*.

## Deploy multiple instances using a copy loop

1. Create a new *main.bicep* file to replace the one you just renamed.

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

Run the following code from the terminal in Visual Studio Code to deploy the Bicep template to Azure. This can take couple of minutes to complete, and then you'll see a successful deployment.

```azurecli
az deployment group create --template-file main.bicep
```

::: zone-end

::: zone pivot="powershell"

Deploy the template to Azure by using the following Azure PowerShell command in the terminal. This can take couple of minutes to complete, and then you'll see a successful deployment.

```azurepowershell
New-AzResourceGroupDeployment -TemplateFile main.bicep
```

::: zone-end

You'll see `Running...` in the terminal. As you didn't specify any parameter value, the default value for ```sqlLocations``` parameter will be used. Wait for deployment to finish.

## Verify the deployment

After deployment is finished, you want to verify that new SQL servers are deployed and that they are located in correct Azure regions.

1. Go to the [Azure portal](https://portal.azure.com?azure-portal=true) and make sure you're in the sandbox subscription.

1. Select **<rgn>[sandbox resource group name]</rgn>**.

1. Verify that new SQL servers deployed are located in regions you specified in parameter ```sqlLocations``` default value.

    :::image type="content" source="../media/5-loop-deployment.png" alt-text="Screenshot of the Azure portal interface for the specific deployment, with SQL servers in different locations." border="true":::

1. Leave the page open in your browser. You'll check on deployments again later.

## Update and redeploy the template to Azure with additional location for Azure SQL Servers

You deployed Azure SQL Server in two initial locations. Now you have requirement to deploy additional Azure SQL Server in the East Asia region. You need to update your template and redeploy it.

1. Return to Visual Studio Code. At the top of the *main.bicep* file, add a new value into the `locations` array:

   ::: code language="plaintext" source="code/5-add-location.bicep" highlight="5" :::

1. Save the changes to the file.

1. Redeploy the file by running the following code from the terminal in Visual Studio Code:

::: zone pivot="cli"

```azurecli
az deployment group create --template-file main.bicep
```

::: zone-end

::: zone pivot="powershell"

```azurepowershell
New-AzResourceGroupDeployment -TemplateFile main.bicep
```

::: zone-end

Wait for the deployment to finish.

## Verify the redeployment

With redeployment of updated Bicep template finished you want to verify that additional SQL server was created in East Asia.

1. Return to the [Azure portal](https://portal.azure.com?azure-portal=true) and select **<rgn>[sandbox resource group name]</rgn>** Resource Group. If required, click refresh in Resource Group menu to see newly deployed resources.

1. Verify new Azure SQL Server is deployed in new location.

    :::image type="content" source="../media/5-loop-redeployment.png" alt-text="Screenshot of the Azure portal interface for the specific deployment, with SQL servers in additional location." border="true":::
