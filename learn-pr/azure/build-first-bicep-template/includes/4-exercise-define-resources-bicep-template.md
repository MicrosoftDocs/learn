[!INCLUDE [Sandbox explanation](../../includes/azure-template-exercise-sandbox-subscription.md)]

For your toy-launch website, you decide to first create a proof of concept by creating a basic Bicep template. In this exercise, you'll create a storage account, Azure App Service plan, and app. Later, you'll modify the template to make it more reusable.

During the process, you'll:

> [!div class="checklist"]
>
> - Create a template that defines a single storage account resource that includes hard-coded values.
> - Provision your infrastructure and verify the result.
> - Add an App Service plan and app to the template.
> - Provision the infrastructure again to see the new resources.

[!INCLUDE [Install the Bicep extension for Visual Studio Code](../../includes/azure-template-bicep-exercise-vscode-extension.md)]

## Create a Bicep template that contains a storage account

1. Open Visual Studio Code.

1. Create a new file called _main.bicep_.

1. Save the empty file so that Visual Studio Code loads the Bicep tooling.

   You can either select **File** > **Save As** or select <kbd>Ctrl+S</kbd> in Windows (<kbd>⌘+S</kbd> on macOS). Be sure to remember where you've saved the file. For example, you might want to create a _templates_ folder in which to save the file.

1. Add the following Bicep code into the file. You'll deploy the template soon. It's a good idea to type the code yourself instead of copying and pasting, so you can see how the tooling helps you to write your Bicep files.

   :::code language="bicep" source="code/4-template.bicep" range="1-11":::

   > [!TIP]
   > Bicep is strict about where you put line breaks, so make sure you don't put line breaks in different places than listed here.

   Notice that Visual Studio Code automatically suggests property names as you type. The Bicep extension for Visual Studio Code understands the resources you're defining in your template, and it lists the available properties and values that you can use.

1. Update the name of the storage account from `toylaunchstorage` to something that's likely to be unique, because every storage account needs a globally unique name. Make sure the name is 3 to 24 characters and includes only lowercase letters and numbers.

   > [!IMPORTANT]
   > Don't skip this step. If you do, your Bicep file won't deploy successfully.

1. Save the changes to the file.

## Deploy the Bicep template to Azure

::: zone pivot="cli"

[!INCLUDE [Bootstrapping instructions for first Bicep exercise - CLI](../../includes/azure-template-bicep-exercise-sandbox-deploy-cli.md)]

### Deploy the template to Azure

Run the following command from the terminal in Visual Studio Code to deploy the Bicep template to Azure. The command can take a minute or two to complete, and then you'll see a successful deployment. If you see a warning about the location being hard-coded, you can ignore it. You'll fix the location later in the module. It's safe to proceed and the deployment will succeed.

```azurecli
az deployment group create --template-file main.bicep
```

You'll see `Running...` in the terminal.

::: zone-end

::: zone pivot="powershell"

[!INCLUDE [Bootstrapping instructions for first Bicep exercise - PowerShell](../../includes/azure-template-bicep-exercise-sandbox-deploy-powershell.md)]

### Deploy the template to Azure

Deploy the template to Azure by using the following Azure PowerShell command in the terminal. The command can take a minute or two to complete, and you'll see a successful deployment. If you see a warning about the location being hard-coded, you can ignore it. You'll fix the location later in the module. It's safe to proceed and the deployment will succeed.

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

1. In **Overview**, you can see that one deployment succeeded. You might need to expand the **Essentials** area to see the deployment.

    :::image type="content" source="../media/4-deployment-succeeded.png" alt-text="Screenshot of the Azure portal interface for the resource group overview, with the deployments section showing that one succeeded." border="true":::

1. Select **1 Succeeded** to see the details of the deployment.

    :::image type="content" source="../media/4-deployment.png" alt-text="Screenshot of the Azure portal interface for the deployments, with the one deployment listed and a succeeded status." border="true":::

1. Select the deployment called **main** to see which resources were deployed, then select **Deployment details** to expand it. In this case, there's one storage account with the name that you specified.

    :::image type="content" source="../media/4-deployment-details.png" alt-text="Screenshot of the Azure portal interface for the specific deployment, with one storage account resource listed." border="true":::

1. Leave the page open in your browser. You'll check on deployments again later.

::: zone pivot="cli"

You can also verify the deployment from the command line. To do so, run the following Azure CLI command:

```azurecli
az deployment group list --output table
```

::: zone-end

::: zone pivot="powershell"

You can also verify the deployment from the command line. To do so, run the following Azure PowerShell command:

```azurepowershell
Get-AzResourceGroupDeployment -ResourceGroupName <rgn>[sandbox resource group name]</rgn> | Format-Table
```

::: zone-end

## Add an App Service plan and app to your Bicep template

In the previous task, you learned how to create a template that contains a single resource and deploy it. Now you're ready to deploy more resources, including a dependency. In this task, you'll add an App Service plan and app to the Bicep template.

1. In the _main.bicep_ file in Visual Studio Code, add the following code to the bottom of the file:

   :::code language="bicep" source="code/4-template.bicep" range="13-29":::

1. Update the name of the App Service app from `toy-product-launch-1` to something that's likely to be unique. Make sure the name is 2 to 60 characters with uppercase and lowercase letters, numbers, and hyphens, and doesn't start or end with a hyphen.

1. Save the changes to the file.

### Deploy the updated Bicep template

::: zone pivot="cli"

Run the following Azure CLI command in the terminal. You can ignore the warnings about the hard-coded location. You'll fix the location soon.

```azurecli
az deployment group create --template-file main.bicep
```

::: zone-end

::: zone pivot="powershell"

Run the following Azure PowerShell command in the terminal. You can ignore the warning messages about the hard-coded location. You'll fix the location soon.

```azurepowershell
New-AzResourceGroupDeployment -TemplateFile main.bicep
```

::: zone-end

### Check your deployment

1. Return to the Azure portal and go to your resource group. You'll still see one successful deployment, because the deployment used the same name as the first deployment.

1. Select the **1 Succeeded** link.

1. Select the deployment called **main**, and then select **Deployment details** to expand the list of deployed resources.

    :::image type="content" source="../media/4-addapp-details.png" alt-text="Screenshot that shows the Azure portal interface for the specific deployment, with storage account and App Service resources listed." border="true":::

1. Notice that the App Service plan and app were deployed.
