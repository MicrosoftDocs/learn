> [!NOTE]
> The first time you activate a sandbox and accept the terms, your Microsoft account is associated with a new Azure directory named Microsoft Learn Sandbox. You're also added to a special subscription named Concierge Subscription.

In this exercise, you create an Azure Resource Manager template (ARM template), deploy it to Azure, and then update that ARM template to add parameters and outputs.

This exercise uses [Azure Resource Manager Tools for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=msazurermtools.azurerm-vscode-tools). Be sure to install this extension in Visual Studio Code before starting the exercise.

## Create an ARM template

1. Open Visual Studio Code, and create a new file called *azuredeploy.json*.

1. The Visual Studio Code ARM template extension comes configured with snippets to help you develop templates. Let's start by adding a blank template. On the first line of the file, enter *arm*.

1. The VS Code automatically displays several potential choices that start with **arm!**. Select the **Azure Resource Manager (ARM) template**. VS Code automatically processes the schemas and languages for your template.

    :::image type="content" source="../media/3-arm-snippet.png" alt-text="Visual Studio Code azuredeploy.json file showing the snippet choices for Azure Resource Manager templates." border="true":::

    Your file now looks like this:

    ```json
    {
      "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
      "contentVersion": "1.0.0.0",
      "parameters": {},
      "functions": [],
      "variables": {},
      "resources": [],
      "outputs": {}
    }
    ```

    Notice that this file has all of the sections of an ARM template that we described in the previous unit.

1. Save the changes to the file by pressing <kbd>Ctrl+S</kbd>.

## Deploy the ARM template to Azure

::: zone pivot="cli"

To deploy this template to Azure, you need to sign in to your Azure account from the Visual Studio Code terminal. Be sure you have the [Azure CLI](/cli/azure/install-azure-cli) tools installed, and sign in with the same account you used to activate the sandbox.

1. Select **Terminal > New Terminal** to open a terminal window.

1. If the command bar of the terminal window says **bash**, you have the right shell to work from and you can skip to the next section.

1. If not, select the drop-down, and choose **Select Default Profile**.

      :::image type="content" source="../media/3-bash.png" alt-text="The Visual Studio Code terminal window with bash in the drop-down.":::

1. Select **Git Bash**.

      :::image type="content" source="../media/3-select-shell.png" alt-text="The Visual Studio Code terminal window showing the select shell drop-down.":::

1. Select **Terminal > New Terminal** to open a bash shell terminal window.

### Sign in to Azure

1. In the terminal window, run this command to sign in to Azure.

    ```azurecli
    az login
    ```

1. A browser opens so that you can sign in to your account. After you've signed in, a list of the subscriptions associated with this account display in the terminal. If you activated the sandbox, you should see one called *Concierge Subscription*. Use this one for the rest of the exercise.

1. In the bash shell, run the following command to set the default subscription for all of the Azure CLI commands you run in this session.

    ```azurecli
    az account set --subscription "Concierge Subscription"
    ```

   If you've used more than one sandbox recently, more than one *Concierge Subscription* might be listed. If so, use the next two steps to identify and set the default subscription.

    1. Run the following command to obtain the *Concierge Subscription* IDs.

   ```azurecli
    az account list \
      --refresh \
      --query "[?contains(name, 'Concierge Subscription')].id" \
      --output table
    ```

    1. Set the default subscription by running the following command, replacing *{your subscription ID}* with the latest Concierge Subscription ID.

    ```azurecli
    az account set --subscription {your subscription ID}
    ```

### Set the default resource group

By setting the default resource group to the one created when you activated the sandbox, you can omit that parameter from the Azure CLI commands in this exercise. To set the resource group, run the following command.

```azurecli
az configure --defaults group=<rgn>[sandbox resource group name]</rgn>
```

### Deploy the template to Azure

Run the following commands to deploy the ARM template to Azure. The ARM template doesn't have any resources yet, so you won't see any resources created. You will see a successful deployment.

```azurecli
templateFile="azuredeploy.json"
today=$(date +"%d-%b-%Y")
DeploymentName="blanktemplate-"$today

az deployment group create \
 --name $DeploymentName \
 --template-file $templateFile
```

The top section of the preceding code sets the Azure CLI variables, which include the path to the template file to deploy and the name of the deployment. The bottom section,  ```az  deployment group create```, deploys the template to Azure. Notice that the deployment name is `blanktemplate` with the date as a suffix.

You see ```Running...``` in the terminal.

::: zone-end

::: zone pivot="powershell"

To deploy this template to Azure, you need to sign in to your Azure account from the Visual Studio Code terminal. Be sure you have installed Azure PowerShell Tools from the VS Code Extensions, and sign in to the same account that activated the sandbox.

1. In the command bar, select **Terminal > New Terminal** to open a PowerShell window.

1. If the command bar of the terminal window shows **PowerShell**, you have the right shell to work from, and you can skip to the next section.

      :::image type="content" source="../media/3-pwsh.png" alt-text="The Visual Studio Code terminal window with pwsh terminal selected.":::

    1. If not, select the down arrow and in the dropdown list select PowerShell. If that option is missing, then select **Select Default Profile**.

    1. In the input field, scroll down and select **PowerShell**.

          :::image type="content" source="../media/3-select-shell.png" alt-text="The Visual Studio Code terminal window showing the select shell drop-down.":::

    1. Select **Terminal > New Terminal** to open a PowerShell terminal window.

### Sign in to Azure by using Azure PowerShell

1. From the terminal in Visual Studio Code, run the following command to sign in to Azure. A browser opens so you can sign in to your account.

    ```azurepowershell
    Connect-AzAccount
    ```

    > [!TIP]
    > The [Az PowerShell module](/powershell/azure/new-azureps-module-az) is the replacement of AzureRM and is the recommended version to use for interacting with Azure.

1. Sign in using the account you used to activate the sandbox. After you've signed in, VS Code lists the subscriptions associated with your account in the terminal window. If you activated the sandbox, you see a code block that contains `"name": "Concierge Subscription"`. This is the subscription to use for the rest of the exercise.

### Set the default subscription for all PowerShell commands in this session

1. Run the following command to obtain your subscription(s) and their ID(s). The subscription ID is the second column. Look for *Concierge Subscription*, and copy the value in the second column. It will look something like *cf49fbbc-217c-4eb6-9eb5-a6a6c68295a0*:

    ```azurepowershell
    Get-AzSubscription
    ```

1. Run the following command, replacing *{Your subscription ID}* with the one you copied in the previous step to change your active subscription to the Concierge Subscription.

    ```azurepowershell
    $context = Get-AzSubscription -SubscriptionId {Your subscription ID}
    Set-AzContext $context
    ```

1. Run the following command to let the default resource group be the resource group created for you in the sandbox environment. This action lets you omit that parameter from the rest of the Azure PowerShell commands in this exercise.

    ```azurepowershell
    Set-AzDefault -ResourceGroupName <rgn>[sandbox resource group name]</rgn>
    ```

### Deploy the template to Azure

Deploy the template to Azure by running the following commands. The ARM template doesn't have any resources yet, so you won't see resources created.

```azurepowershell
$templateFile="azuredeploy.json"
$today=Get-Date -Format "MM-dd-yyyy"
$deploymentName="blanktemplate-"+"$today"
New-AzResourceGroupDeployment `
  -Name $deploymentName `
  -TemplateFile $templateFile
```

The top section of the preceding code sets Azure PowerShell variables, which includes the path to the deployment file and the name of the deployment. Then, the ```New-AzResourceGroupDeployment``` command deploys the template to Azure. Notice that the deployment name is `blanktemplate` with the date as a suffix.

::: zone-end

When you've deployed your ARM template to Azure, go to the [Azure portal](https://portal.azure.com?azure-portal=true) and make sure you're in the sandbox subscription. To do that, select your avatar in the upper-right corner of the page. Select **Switch directory**. In the list, choose the **Microsoft Learn Sandbox** directory.

1. In the resource menu, select **Resource groups**.

1. Select the *<rgn>[sandbox resource group name]</rgn>* resource group.

1. On the **Overview** pane, you see that one deployment succeeded.

    :::image type="content" source="../media/3-deployment-succeeded.png" alt-text="Azure portal interface for the resource group overview with the deployments section showing that one succeeded.":::

1. Select **1 Succeeded** to see the details of the deployment.

    :::image type="content" source="../media/3-blanktemplate.png" alt-text="Azure portal interface for the deployments with the one deployment listed and a succeeded status.":::

1. Select `blanktemplate` to see what resources were deployed. In this case, it will be empty because you didn't specify any resources in the template yet.

    :::image type="content" source="../media/3-no-results.png" alt-text="Azure portal interface for the specific deployment with no resources listed.":::

1. Leave the page open in your browser. You'll check on deployments again.

## Add a resource to the ARM template

In the previous task, you learned how to create a blank template and deploy it. Now, you're ready to deploy an actual resource. In this task, you add an Azure storage account resource to the ARM template by using a snippet from the Azure Resource Manager Tools extension for Visual Studio Code.

1. In the *azuredeploy.json* file in Visual Studio Code, place your cursor inside the brackets in the resources block ```"resources":[],```.

1. Enter *storage* inside the brackets. A list of related snippets appears. Select **arm-storage**.

    :::image type="content" source="../media/3-arm-storage.png" alt-text="Visual Studio Code arm-storage snippet shown under the typed word storage.":::

    Your file will look like this:

    [!code-json[](code/parameter1.json)]

      Values that you should edit are highlighted in the new section of your file and can be navigated by pressing the <kbd>Tab</kbd> key.

    Notice the ```tags``` and ```location``` attributes are filled in. The ```location``` attribute uses a function to set the location of the resource to the location of the resource group. You'll learn about tags and functions in the next module.

1. Change the values of the resource *name* and *displayName* to something unique, (for example, **learnexercise12321**). This name must be unique across all of Azure, so choose something unique to you.

1. Change the value of the sku *name* from **Premium_LRS** to **Standard_LRS**. Change the value of *tier* to **Standard**. Notice that Visual Studio Code gives you the proper choices for your attribute values in IntelliSense. Delete the default value including the quotation marks, and enter quotation marks to see this work.

    :::image type="content" source="../media/3-vs-code-intellisense.png" alt-text="Visual Studio Code showing the IntelliSense choices for the name attribute of the storage SKU.":::

1. The location of the resource is set to the location of the resource group where it will be deployed. Leave the default here.

1. Save the file.

### Deploy the updated ARM template

Here, you change the name of the deployment to better reflect what this deployment does.

::: zone pivot="cli"

Run the following Azure CLI commands in the terminal. This snippet is the same code you used previously, but the name of the deployment is changed.

```azurecli
templateFile="azuredeploy.json"
today=$(date +"%d-%b-%Y")
DeploymentName="addstorage-"$today

az deployment group create \
  --name $DeploymentName \
  --template-file $templateFile
```

::: zone-end

::: zone pivot="powershell"

Run the following Azure PowerShell commands in the terminal. This snippet is the same code you used previously, but the name of the deployment is changed.

```azurepowershell
$templateFile="azuredeploy.json"
$today=Get-Date -Format "MM-dd-yyyy"
$deploymentName="addstorage-"+"$today"
New-AzResourceGroupDeployment `
  -Name $deploymentName `
  -TemplateFile $templateFile
```

::: zone-end

### Check your deployment

1. In your browser, go back to the Azure portal. Go to your resource group, and you'll see that there are now **2 Succeeded** deployments. Select this link.

    Notice that both deployments are in the list.

    :::image type="content" source="../media/3-addstorage-deployment.png" alt-text="Azure portal interface for the deployments with the two deployments listed and succeeded statuses.":::

1. Select `**addstorage**`.

    :::image type="content" source="../media/3-show-resource-deployed.png" alt-text="Azure portal interface for the specific deployment with one resource listed." :::

Notice that the storage account has been deployed.
