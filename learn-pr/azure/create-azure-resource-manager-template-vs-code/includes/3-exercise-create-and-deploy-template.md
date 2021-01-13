> [!NOTE]
> The first time you activate a sandbox and accept the terms, your Microsoft account is associated with a new Azure directory named Microsoft Learn Sandbox. You're also added to a special subscription named Concierge Subscription.

In this exercise, you create an Azure Resource Manager template (ARM template), deploy it to Azure, and then update that ARM template to add parameters and outputs.

This exercise uses [Azure Resource Manager Tools for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=msazurermtools.azurerm-vscode-tools). Be sure to install this extension in Visual Studio Code.

## Create an ARM template

1. Open Visual Studio Code, and create a new file called *azuredeploy.json*.
1. The Visual Studio Code ARM template extension comes configured with snippets to help you develop templates. Let's start by adding a blank template. On the first line of the file, enter **arm**.
1. You see the IntelliSense choice **!arm**. Choose that snippet by selecting the box next to it.

    :::image type="content" source="../media/3-arm-snippet.png" alt-text="Visual Studio Code azuredeploy.json file showing the snippet choices for Azure Resource Manager templates." border="true":::

1. Your file will now look like this:

    ```json
    {
    "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
    "contentVersion": "1.0.0.0",
    "apiProfile": "",
    "parameters": {},
    "variables": {},
    "functions": [],
    "resources": [],
    "outputs": {}
    }
    ```

      Notice that this file has all of the sections of an ARM template that we discussed in the last unit.

1. Save the changes to the file.

## Deploy the ARM template to Azure

::: zone pivot="cli"

To deploy this template to Azure, you need to sign in to your Azure account from the Visual Studio Code terminal. Be sure you have the [Azure CLI](https://docs.microsoft.com/cli/azure/install-azure-cli?view=azure-cli-latest) tools installed, and sign in with the same account you used to activate the sandbox.

1. Open a terminal window by using the **Terminal** menu.
1. If the drop-down menu on the right of the terminal window says **bash**, you have the right shell to work from and you can skip to the next section.

      :::image type="content" source="../media/3-bash.png" alt-text="The Visual Studio Code terminal window with bash in the drop-down." border="true":::

1. If not, select the drop-down and choose **Select Default Shell**.
1. Select **bash**.

      :::image type="content" source="../media/3-select-shell.png" alt-text="The Visual Studio Code terminal window showing the select shell drop-down." border="true":::

1. Select the **+** in the terminal to create a new terminal with *bash* as the shell.

### Sign in to Azure

1. From the terminal in Visual Studio Code, run this command to sign in to Azure. A browser opens so you can sign in to your account.

    ```azurecli
    az login
    ```

1. After you've signed in, you see a list of the subscriptions associated with this account in the terminal. If you activated the sandbox, you see one called *Concierge Subscription*. Use this one for the rest of the exercise.
1. Set the default subscription for all of the Azure CLI commands you run in this session.

    ```azurecli
    az account set --subscription "Concierge Subscription"
    ```

   > [!NOTE]
   > If you've used more than one sandbox recently, there might be more than one *Concierge Subscription* listed. In this case, use the next two steps to set the default subscription. If the previous command was successful, skip the next two steps.

1. Get the *Concierge Subscription* IDs.

   ```azurecli
    az account list \
      --refresh \
      --query "[?contains(name, 'Concierge Subscription')].id" \
      --output table
    ```

1. Set the default subscription by using the subscription ID. Replace *{your subscription ID}* with the latest Concierge Subscription ID.

    ```azurecli
    az account set --subscription {your subscription ID}
    ```

### Set the default resource group

When you set the default resource group as the same one created for you in the sandbox environment, you can omit that parameter from the rest of the Azure CLI commands in this exercise.

```azurecli
az configure --defaults group=<rgn>[sandbox resource group name]</rgn>
```

### Deploy the template to Azure

The following code deploys the ARM template to Azure. The ARM template doesn't have any resources yet, so you won't see resources created. You will see a successful deployment.

Deploy the template by using Azure CLI commands in the Visual Studio Code terminal.

```azurecli
templateFile="azuredeploy.json"
today=$(date +"%d-%b-%Y")
DeploymentName="blanktemplate-"$today

az group deployment create \
 --name $DeploymentName \
 --template-file $templateFile
```

The top section of the preceding code sets the Azure CLI variables, which include the path to the template file to deploy and the name of the deployment. The command ```az group deployment create``` deploys the template to Azure. Notice that the deployment name is **blanktemplate** with the date as a suffix.

You see ```Running...``` in the terminal.

::: zone-end

::: zone pivot="powershell"

To deploy this template to Azure, you need to sign in to your Azure account from the Visual Studio Code terminal. Be sure you have [installed Azure PowerShell](https://docs.microsoft.com/powershell/azure/install-az-ps?view=azps-4.3.0&azure-portal=true), and sign in to the same account that activated the sandbox.

1. Open a terminal window by using the **Terminal** menu.
1. If the drop-down menu on the right of the terminal window says **pwsh**, you have the right shell to work from and you can skip to the next section.

      :::image type="content" source="../media/3-pwsh.png" alt-text="The Visual Studio Code terminal window with pwsh in the drop-down." border="true":::

1. If not, select the drop-down and choose **Select Default Shell**.
1. Select **pwsh**.

      :::image type="content" source="../media/3-select-shell.png" alt-text="The Visual Studio Code terminal window showing the select shell drop-down." border="true":::

1. Select the **+** in the terminal to create a new terminal with *pwsh* as the shell.

### Sign in to Azure by using Azure PowerShell

1. From the terminal in Visual Studio Code, run the following command to sign in to Azure. A browser opens so you can sign in to your account. Use the code in the prompt.

    ```azurepowershell
    Connect-AzAccount
    ```

1. After you've signed in, you see a list of the subscriptions associated with this account in the terminal. If you activated the sandbox, you see one called *Concierge Subscription*. Use this one for the rest of the exercise.

1. Set the default subscription for all of the Azure PowerShell commands you run in this session.

1. Get the subscription ID. The command will list your subscriptions and their IDs. The subscription ID is the second column. Look for *Concierge Subscription*, and copy the second column. It will look something like *cf49fbbc-217c-4eb6-9eb5-a6a6c68295a0*

    ```azurepowershell
    Get-AzSubscription
    ```

1. Change your active subscription to the Concierge Subscription. Be sure to substitute *{Your subscription ID}* with the one you copied.

    ```azurepowershell
    $context = Get-AzSubscription -SubscriptionId {Your subscription ID}
    Set-AzContext $context
    ```

1. Set the default resource group to the resource group created for you in the sandbox environment. This action lets you omit that parameter from the rest of the Azure PowerShell commands in this exercise.

    ```azurepowershell
    Set-AzDefault -ResourceGroupName <rgn>[sandbox resource group name]</rgn>
    ```

### Deploy the template to Azure

The following code deploys the template to Azure. The ARM template doesn't have any resources yet, so you won't see resources created. You will see a successful deployment.

Deploy the template by using Azure PowerShell commands in the terminal.

```azurepowershell
$templateFile = "azuredeploy.json"
$today=Get-Date -Format "MM-dd-yyyy"
$deploymentName="blanktemplate-"+"$today"
New-AzResourceGroupDeployment `
  -Name $deploymentName `
  -TemplateFile $templateFile
```

The top section of the preceding code sets Azure PowerShell variables, which include the path to the deployment path and the name of the deployment. Then the ```New-AzResourceGroupDeployment``` command deploys the template to Azure. Notice that the deployment name is *blanktemplate* with the date as a suffix.

::: zone-end

When you've deployed your ARM template to Azure, go to the [Azure portal](https://portal.azure.com?azure-portal=true) and make sure you're in the sandbox subscription. To do that, select your avatar in the upper-right corner of the page. Select **Switch directory**. In the list, choose the **Microsoft Learn Sandbox** directory.

1. On the left side panel, select **Resource groups**.
1. Select the <rgn>[sandbox resource group name]</rgn>.
1. In the **Overview**, you see that one deployment succeeded.

    :::image type="content" source="../media/3-deployment-succeeded.png" alt-text="Azure portal interface for the resource group overview with the deployments section showing that one succeeded." border="true":::

1. Select **1 Succeeded** to see the details of the deployment.

    :::image type="content" source="../media/3-blanktemplate.png" alt-text="Azure portal interface for the deployments with the one deployment listed and a succeeded status." border="true":::

1. Select **blanktemplate** to see what resources were deployed. In this case, it will be empty because you didn't specify any resources in the template yet.

    :::image type="content" source="../media/3-no-results.png" alt-text="Azure portal interface for the specific deployment with no resources listed." border="true":::

1. Leave the page open in your browser. You'll check on deployments again.

## Add a resource to the ARM template

In the previous task, you learned how to create a blank template and deploy it. Now, you're ready to deploy an actual resource. In this section, you add an Azure storage account resource to the ARM template by using a snippet from the Azure Resource Manager Tools for Visual Studio Code extension.

1. In the *azuredeploy.json* file in Visual Studio Code, place your curser inside the brackets in the resources block ```"resources":[],```.
1. Enter **storage** inside the brackets. A list of related snippets appears. Select **arm-storage**.

    :::image type="content" source="../media/3-arm-storage.png" alt-text="Visual Studio Code arm-storage snippet shown under the typed word storage." border="true":::

1. Your file will look like this:

    [!code-json[](code/parameter1.json)]

      Values that you should edit are highlighted in the new section of your file and can be navigated by using the <kbd>tab</kbd> key.

    Notice the ```tags:``` and ```location:``` attributes are filled in. The ```location:``` attribute uses a function to set the location of the resource to the location of the resource group. You learn about tags and functions in the next module.

1. Change the values of the resource *name:* and *displayName:* to something unique. For example, **learnexercise12321**. This name must be unique across all of Azure, so choose something unique to you.
1. Change the value of the sku *name* from **Premium_LRS** to **Standard_LRS**. Change the value of *tier* to **Standard**. Notice that Visual Studio Code gives you the proper choices for your attribute values in IntelliSense. Delete the default value including the quotation marks and type quotation marks to see this work.

    :::image type="content" source="../media/3-vs-code-intellisense.png" alt-text="Visual Studio Code showing the IntelliSense choices for the name attribute of the storage SKU." border="true":::

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

az group deployment create \
  --name $DeploymentName \
  --template-file $templateFile
```

::: zone-end

::: zone pivot="powershell"

Run the following Azure PowerShell commands in the terminal. This snippet is the same code you used previously, but the name of the deployment is changed.

```azurepowershell
$templateFile = "azuredeploy.json"
$today=Get-Date -Format "MM-dd-yyyy"
$deploymentName="addstorage-"+"$today"
New-AzResourceGroupDeployment `
  -Name $deploymentName `
  -TemplateFile $templateFile
```

::: zone-end

### Check your deployment

1. In your browser, go back to Azure. Go to your resource group, and you'll see that there are now **2 Succeeded** deployments. Select this link.
1. Notice that both deployments are in the list.

    :::image type="content" source="../media/3-addstorage-deployment.png" alt-text="Azure portal interface for the deployments with the two deployments listed and succeeded statuses." border="true":::

1. Select **addstorage**.

    :::image type="content" source="../media/3-show-resource-deployed.png" alt-text="Azure portal interface for the specific deployment with one resource listed." border="true":::

1. Notice that the storage account has been deployed.
