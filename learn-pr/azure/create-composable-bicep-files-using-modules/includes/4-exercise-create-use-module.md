You've been tasked with adding a content delivery network, or CDN, to your company's website for the launch of a toy wombat. However, other teams in your company have told you they don't need a CDN. In this exercise, you'll create modules for the website and the CDN, and you'll add the modules to a template.

During the process, you'll:

> [!div class="checklist"]
>
> - Add a module for your application.
> - Create a Bicep template that uses the module.
> - Add another module for the CDN.
> - Add the CDN module to your template, while making it optional.
> - Deploy the template to Azure.
> - Review the deployment history.

[!INCLUDE [Install the Bicep extension for Visual Studio Code](../../includes/azure-template-bicep-exercise-vscode-extension.md)]

## Create a blank Bicep file

1. Open Visual Studio Code.

1. Create a new file called _main.bicep_.

1. Save the empty file so that Visual Studio Code loads the Bicep tooling.

   You can either select **File** > **Save As** or select <kbd>Ctrl+S</kbd> on Windows (<kbd>⌘+S</kbd> on macOS). Be sure to remember where you save the file. For example, you might want to create a _templates_ folder to save it in.

## Create a module for your application

1. Create a new folder called _modules_ in the same folder where you created your _main.bicep_ file. In the _modules_ folder, create a file called _app.bicep_. Save the file.

1. Add the following content into the _app.bicep_ file:

   :::code language="bicep" source="code/4-app.bicep" :::

   This file deploys an Azure App Service plan and an app. Notice that the module is fairly generic. It doesn't include any assumptions about the names of resources, or the App Service plan's SKU. This makes it easy to reuse the module for different deployments.

1. Save the changes to the file.

## Add the module to your Bicep template

Here, you add the _app_ module to your Bicep template as a starting point.

1. Open the _main.bicep_ file.

1. Add the following parameters and variable to the file:

   :::code language="bicep" source="code/4-template-1.bicep" range="1-10" :::

   Because this is the template that you intend to deploy for your toy websites, it's a little more specific. The App Service plan name is defined as a variable. The SKU parameter has a default value that makes sense for the toy launch website.

   [!INCLUDE [Sandbox location note](../../includes/azure-template-bicep-exercise-sandbox-location.md)]

1. Below the parameters, create a blank line. Now, type the first line of the app module definition:

   :::code language="bicep" source="code/4-template-1.bicep" range="12" :::

   As you type, notice that the Bicep extension for Visual Studio Code helps you to scaffold the module declaration. When you type the path to your module and type the equals (`=`) character, a pop-up menu appears with several options.

1. Select **Required properties** from the pop-up menu:

   :::image type="content" source="../media/4-module-scaffold.png" alt-text="Screenshot of Visual Studio Code that shows the option to scaffold a module with its required properties.":::

1. Complete the module declaration:

   :::code language="bicep" source="code/4-template-1.bicep" range="12-20" :::

1. At the bottom of the file, define an output:

   :::code language="bicep" source="code/4-template-1.bicep" range="22-23" :::

1. Save the changes to the file.

## Create a module for the content delivery network

1. In the _modules_ folder, create a file called _cdn.bicep_. Save the file.

1. Add the following content into the _cdn.bicep_ file:

   :::code language="bicep" source="code/4-cdn.bicep" :::

   This file deploys two resources: a CDN profile and a CDN endpoint.

1. Save the changes to the file.

## Add the modules to the main Bicep template

1. Open the _main.bicep_ file.

1. Below the `appServicePlanSkuName` parameter, add the following parameter:

   :::code language="bicep" source="code/4-template-2.bicep" range="10-11" :::

1. Below the `app` module definition, define the `cdn` module:

   :::code language="bicep" source="code/4-template-2.bicep" range="25-31" :::

   Notice that the module has a condition so that it's deployed only when the `deployCdn` parameter's value is set to `true`. Also, notice that the module's `originHostName` parameter is set to the value of the `appServiceAppHostName` output from the `app` module.

1. Update the host name output so that it selects the correct host name. When a CDN is deployed, you want the host name to be that of the CDN endpoint.

   :::code language="bicep" source="code/4-template-2.bicep" range="34" :::

1. Save the changes to the file.

## Deploy the Bicep template to Azure

::: zone pivot="cli"

[!INCLUDE [Bootstrapping instructions for first Bicep exercise - CLI](../../includes/azure-template-bicep-exercise-sandbox-deploy-cli.md)]

### Deploy the template to Azure

Run the following code from the terminal in Visual Studio Code to deploy the Bicep template to Azure. This process can take a minute or two to finish, and then you'll get a successful deployment.

```azurecli
az deployment group create --template-file main.bicep
```

The status `Running...` appears in the terminal.

::: zone-end

::: zone pivot="powershell"

[!INCLUDE [Bootstrapping instructions for first Bicep exercise - PowerShell](../../includes/azure-template-bicep-exercise-sandbox-deploy-powershell.md)]

### Deploy the template to Azure

Deploy the template to Azure by using the following Azure PowerShell command in the terminal. This can take a minute or two to finish, and then you'll get a successful deployment.

```azurepowershell
New-AzResourceGroupDeployment -TemplateFile main.bicep
```

::: zone-end

## Review the deployment history

1. Go to the [Azure portal](https://portal.azure.com) and make sure you're in the sandbox subscription:

   1. Select your avatar in the upper-right corner of the page.
   1. Select **Switch directory**. In the list, choose the **Microsoft Learn Sandbox** directory.

1. On the left-side panel, select **Resource groups**.

1. Select **<rgn>[sandbox resource group name]</rgn>**.

1. On the left menu, select **Deployments**.

   :::image type="content" source="../media/4-deployments.png" alt-text="Screenshot of the Azure portal that shows the resource group, with the Deployments menu item highlighted." :::

   Three deployments are listed.

1. Select the **main** deployment and expand **Deployment details**.

   Notice that both of the modules are listed, and that their types are displayed as `Microsoft.Resources/deployments`. The modules are listed twice because their outputs are also referenced within the template.

   :::image type="content" source="../media/4-deployment-modules.png" alt-text="Screenshot of the Azure portal that shows the deployment details for the main deployment." :::

1. Select the **toy-launch-cdn** and **toy-launch-app** deployments and review the resources deployed in each. Notice that they correspond to the resources defined in the respective module.

## Test the website

1. Select the **toy-launch-app** deployment.

1. Select **Outputs**.

   :::image type="content" source="../media/4-outputs.png" alt-text="Screenshot of the Azure portal that shows the deployment, with the Outputs menu item highlighted." :::

1. Select the copy button for the `appServiceAppHostName` output.

1. On a new browser tab, try to go to the address that you copied in the previous step.

   :::image type="content" source="../media/4-web-app.png" alt-text="Screenshot of the web app's welcome page, with the address bar showing the App Service host name." :::

   The App Service welcome page appears, showing that you've successfully deployed the app.

1. Go to the **main** deployment and select **Outputs**.

1. Copy the value of the `websiteHostName` output. Notice that this host name is different, because it's an Azure Content Delivery Network host name.

1. On a new browser tab, try to go to the host name that you copied in the previous step. Add `https://` to the start of the address.

   CDN endpoints take a few minutes to become active. If you get a "Page not found" error, wait a few minutes and try pasting the link again. Also, ensure that you added `https://` to the start of the URL so that you're using HTTPS.

   When the CDN endpoint is active, you'll get the same App Service welcome page. This time, it has been served through the Azure Content Delivery Network service, which helps improve the website's performance.

   :::image type="content" source="../media/4-web-cdn.png" alt-text="Screenshot of the web app's welcome page, with the address bar showing the CDN endpoint." :::
