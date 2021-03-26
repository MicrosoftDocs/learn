> [!NOTE]
> The first time you activate a sandbox and accept the terms, your Microsoft account is associated with a new Azure directory named Microsoft Learn Sandbox. You're also added to a special subscription named Concierge Subscription.

In this exercise, you create a Bicep template that provisions an Azure Storage account and an App Service app.

During the process, you:

> [!div class="checklist"]
> * Create a template that defines a single storage account resource, with hard-coded values.
> * Provision your infrastructure and verify the result.
> * Add an App Service plan and app to the template.
> * Provision the infrastructure again to see the new resources.

This exercise uses [Bicep for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-bicep). Be sure to install this extension in Visual Studio Code.

## Create a Bicep template with a storage account

1. Open Visual Studio Code, and create a new file called *main.bicep*.

1. Add the following content into the file:

   ```bicep
   resource storageAccount 'Microsoft.Storage/storageAccounts@2019-06-01' = {
     name: 'mystorageaccount'
     location: 'eastus'
     sku: {
       name: 'Standard_LRS'
     }
     kind: 'StorageV2'
     properties: {
       accessTier: 'Hot'
     }
   }
   ```

   > [!TIP]
   > Bicep is quite strict about where you put line breaks, so make sure you don't put line breaks in different places than what's listed here.

   Notice that, as you type, Visual Studio Code is automatically suggesting property names. The Bicep extension for Visual Studio Code understands the resources you're defining in your template, and it lists the available properties and values you can use.

1. Update the name of the storage account from `mystorageaccount` to something that is likely to be unique. Make sure the name you choose is all lowercase, without any special characters, and fewer than 24 characters in length.

1. Save the changes to the file.

## Deploy the Bicep template to Azure

::: zone pivot="cli"

To deploy this template to Azure, you need to sign in to your Azure account from the Visual Studio Code terminal. Be sure you have the [Azure CLI](https://docs.microsoft.com/cli/azure/install-azure-cli) tools installed, and sign in with the same account you used to activate the sandbox.

1. Open a terminal window by using the **Terminal** menu.
2. If the drop-down menu on the right of the terminal window says **bash**, you have the right shell to work from and you can skip to the next section.

      :::image type="content" source="../media/4-bash.png" alt-text="The Visual Studio Code terminal window with bash in the drop-down." border="true":::

3. If not, select the drop-down, and choose **Select Default Shell**.

4. Select **bash**.

      :::image type="content" source="../media/4-select-shell.png" alt-text="The Visual Studio Code terminal window showing the select shell drop-down." border="true":::

5. Select the **+** in the terminal to create a new terminal with *bash* as the shell.

### Check the version of the Azure CLI

1. From the terminal in Visual Studio Code, run this command to check the version of the Azure CLI:

   ```azurecli
   az -v
   ```

1. Look at the version number on the first line, which will start with `azure-cli`.

   - If the version number is version `2.20.0` or higher, proceed to the next section (_Install the Bicep tooling_).

   - If the version number is greater than `2.11.0` and less than version `2.20.0`, you will need to update your Azure CLI version:
  
      ```azurecli
      az upgrade
      ```

   - If the version number is less than `2.11.0`, you may need to [reinstall the Azure CLI](/cli/azure/install-azure-cli) to get the latest version.

### Install the Bicep tooling

Run the following command to install the Bicep template compilation support:

```azurecli
az bicep install
```

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

The following code deploys the Bicep template to Azure. You'll see a successful deployment.

Deploy the template by using Azure CLI commands in the Visual Studio Code terminal.

```azurecli
templateFile="main.bicep"
today=$(date +"%d-%b-%Y")
DeploymentName="storage-"$today

az deployment group create \
 --name $DeploymentName \
 --template-file $templateFile
```

The top section of the preceding code sets the Azure CLI variables, which include the path to the template file to deploy and the name of the deployment. The command ```az deployment group create``` deploys the template to Azure. Notice that the deployment name is **`storage`** with the date as a suffix.

You see ```Running...``` in the terminal.

::: zone-end

::: zone pivot="powershell"

To deploy this template to Azure, you need to sign in to your Azure account from the Visual Studio Code terminal. Be sure you have [installed Azure PowerShell](https://docs.microsoft.com/powershell/azure/install-az-ps), and sign in to the same account that activated the sandbox.

1. Open a terminal window by using the **Terminal** menu.

1. If the drop-down on the right of the terminal window says **pwsh**, you have the right shell to work from, and you can skip to the next section.

      :::image type="content" source="../media/4-pwsh.png" alt-text="The Visual Studio Code terminal window with pwsh in the drop-down." border="true":::

1. If not, select the drop-down, and choose **Select Default Shell**.

1. Select **pwsh**.

      :::image type="content" source="../media/4-select-shell.png" alt-text="The Visual Studio Code terminal window showing the select shell drop-down." border="true":::

1. Select the **+** in the terminal to create a new terminal with *pwsh* as the shell.

### Check the version of Azure PowerShell

1. From the terminal in Visual Studio code, run the following command check the version of Azure PowerShell that you have installed:

   ```azurepowershell
   (Get-InstalledModule Az).Version
   ```

   If the version number is `5.6.0` or higher, proceed to the next section (_Sign in to Azure by using Azure PowerShell_).

   Otherwise, you will need to [install the latest version of Azure PowerShell](/powershell/azure/install-az-ps).

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

The following code deploys the template to Azure. You'll see a successful deployment.

Deploy the template by using Azure PowerShell commands in the terminal.

```azurepowershell
$templateFile = 'main.bicep'
$today = Get-Date -Format 'MM-dd-yyyy'
$deploymentName = "storage-$today"
New-AzResourceGroupDeployment `
  -Name $deploymentName `
  -TemplateFile $templateFile
```

The top section of the preceding code sets Azure PowerShell variables, which include the path to the deployment path and the name of the deployment. Then the ```New-AzResourceGroupDeployment``` command deploys the template to Azure. Notice that the deployment name is *storage* with the date as a suffix.

::: zone-end

When you've deployed your Bicep template to Azure, go to the [Azure portal](https://portal.azure.com?azure-portal=true) and make sure you're in the sandbox subscription. To do that, select your avatar in the upper-right corner of the page. Select **Switch directory**. In the list, choose the **Microsoft Learn Sandbox** directory.

1. On the left side panel, select **Resource groups**.

1. Select the <rgn>[sandbox resource group name]</rgn>.

1. In the **Overview**, you see that one deployment succeeded.

    :::image type="content" source="../media/4-deployment-succeeded.png" alt-text="Azure portal interface for the resource group overview with the deployments section showing that one succeeded." border="true":::

1. Select **1 Succeeded** to see the details of the deployment.

    :::image type="content" source="../media/4-storage.png" alt-text="Azure portal interface for the deployments with the one deployment listed and a succeeded status." border="true":::

1. Select the deployment that begins with **`storage`** to see what resources were deployed, and then click **Deployment details** to expand it. In this case, there will be one storage account with the name you specified.

    :::image type="content" source="../media/4-storage-details.png" alt-text="Azure portal interface for the specific deployment with one storage account resource listed." border="true":::

2. Leave the page open in your browser. You'll check on deployments again.

## Add an App Service plan and app to your Bicep template

In the previous task, you learned how to create a template with a single resource and deploy it. Now you're ready to deploy more resources, including a dependency. In this task, you add an App Service plan and app to the Bicep template.

1. In the *main.bicep* file in Visual Studio Code, add the following to the bottom of the file:

   ```bicep
   resource appServicePlan 'Microsoft.Web/serverFarms@2020-06-01' = {
     name: 'MyAppServicePlan'
     location: 'eastus'
     sku: {
       name: 'F1'
       tier: 'Free'
     }
   }

   resource appServiceApp 'Microsoft.Web/sites@2020-06-01' = {
     name: 'toy-product-launch-1'
     location: 'eastus'
     properties: {
       serverFarmId: appServicePlan.id
       httpsOnly: true
     }
   }
   ```

1. Update the name of the App Service app from `toy-product-launch-1` to something that is likely to be unique. Make sure the name you choose is all lowercase, contains alphanumerics and hyphens, doesn't start or end with a hyphen, and is between 2 and 60 characters in length.

1. Save the changes to the file.

### Deploy the updated Bicep template

Here, you change the name of the deployment to better reflect what this deployment does.

::: zone pivot="cli"

Run the following Azure CLI commands in the terminal. This snippet is the same code you used previously, but the name of the deployment is changed.

```azurecli
templateFile="main.bicep"
today=$(date +"%d-%b-%Y")
DeploymentName="addapp-"$today

az deployment group create \
  --name $DeploymentName \
  --template-file $templateFile
```

::: zone-end

::: zone pivot="powershell"

Run the following Azure PowerShell commands in the terminal. This snippet is the same code you used previously, but the name of the deployment is changed.

```azurepowershell
$templateFile = 'main.bicep'
$today = Get-Date -Format 'MM-dd-yyyy'
$deploymentName = "addapp-$today"
New-AzResourceGroupDeployment `
  -Name $deploymentName `
  -TemplateFile $templateFile
```

::: zone-end

### Check your deployment

1. In your browser, go back to Azure. Go to your resource group, and you'll see that there are now **2 Succeeded** deployments. Select this link.

1. Notice that both deployments are in the list.

    :::image type="content" source="../media/4-addapp-deployment.png" alt-text="Azure portal interface for the deployments with the two deployments listed and succeeded statuses." border="true":::

2. Select the deployment that begins with **`addapp`**, then click **Deployment details** to expand the list of deployed resources.

    :::image type="content" source="../media/4-addapp-details.png" alt-text="Azure portal interface for the specific deployment with storage account App Service resources listed." border="true":::

3. Notice that the App Service plan and app have been deployed.
