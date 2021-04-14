> [!NOTE]
> The first time you activate a sandbox and accept the terms, your Microsoft account is associated with a new Azure directory named *Microsoft Learn Sandbox*. You're also added to a special subscription named *Concierge Subscription*.

For your toy launch website, you decide to first create a proof of concept by creating a basic Bicep template. In this exercise, you'll create a storage account, Azure App Service plan, and app. Later, you'll modify the template to make it more reusable.

During the process, you'll:

> [!div class="checklist"]
> * Create a template that defines a single storage account resource that includes hard-coded values.
> * Provision your infrastructure and verify the result.
> * Add an App Service plan and app to the template.
> * Provision the infrastructure again to see the new resources.

This exercise uses [the Bicep extension for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-bicep). Be sure to install this extension in Visual Studio Code.

## Create a Bicep template that contains a storage account

1. Open Visual Studio Code, and create a new file called *main.bicep*. You'll deploy the template soon. Save the empty file so that Visual Studio Code loads the Bicep tooling.

1. Add the following content into the file. It's a good idea to type this in yourself instead of copying and pasting, so that you can see how the tooling helps you to write your Bicep files.

   ```bicep
   resource storageAccount 'Microsoft.Storage/storageAccounts@2019-06-01' = {
     name: 'toylaunchstorage'
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
   > Bicep is strict about where you put line breaks, so make sure you don't put line breaks in different places than what's listed here.

   Notice that Visual Studio Code automatically suggests property names as you type. The Bicep extension for Visual Studio Code understands the resources you're defining in your template, and it lists the available properties and values that you can use.

1. Update the name of the storage account from `toylaunchstorage` to something that's likely to be unique. Make sure the name is all lowercase, without any special characters, and fewer than 24 characters.

1. Save the changes to the file.

## Deploy the Bicep template to Azure

::: zone pivot="cli"

To deploy this template to Azure, you need to sign in to your Azure account from the Visual Studio Code terminal. Be sure you have the [Azure CLI](https://docs.microsoft.com/cli/azure/install-azure-cli) tools installed, and sign in with the same account that you used to activate the sandbox.

1. Open a terminal window by using the **Terminal** menu.
1. If the dropdown menu on the right of the terminal window says **bash**, you have the right shell to work from and you can skip to the next section.

    :::image type="content" source="../media/4-bash.png" alt-text="Screenshot of the Visual Studio Code terminal window, with bash in the dropdown menu." border="true":::

    If not, select the dropdown menu, and choose **Select Default Shell**. Then select **bash**.

    :::image type="content" source="../media/4-select-shell.png" alt-text="Screenshot of the Visual Studio Code terminal window, showing the select shell dropdown menu." border="true":::

1. Select the plus sign (**+**) in the terminal to create a new terminal with Bash as the shell.

1. Switch your terminal to the directory where you saved your Bicep template. For example, if you saved it in the *scripts* folder, you can use this command:

    ```azurecli
    cd scripts
    ```

### Check the version of the Azure CLI

1. From the terminal in Visual Studio Code, run this command to check the version of the Azure CLI:

   ```azurecli
   az -v
   ```

1. Look at the version number on the first line, which starts with `azure-cli`.

   - If the version number is version `2.20.0` or later, go to the next section ("Install the Bicep tooling").

   - If the version number is later than `2.11.0` and earlier than `2.20.0`, update your Azure CLI version by using this command:
  
      ```azurecli
      az upgrade
      ```

   - If the version number is earlier than `2.11.0`, you might need to [reinstall the Azure CLI](/cli/azure/install-azure-cli) to get the latest version.

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

1. Set the default subscription for all of the Azure CLI commands that you run in this session:

    ```azurecli
    az account set --subscription "Concierge Subscription"
    ```

   > [!NOTE]
   > If you've used more than one sandbox recently, there might be more than one Concierge Subscription listed. In this case, use the next two steps to set the default subscription. If the previous command was successful, skip the next two steps.

1. Get the Concierge Subscription IDs:

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

When you use the CLI, you can set the default resource group and omit the parameter from the rest of the Azure CLI commands in this exercise. Set the default to the resource group created for you in the sandbox environment.

```azurecli
az configure --defaults group=<rgn>[sandbox resource group name]</rgn>
```

### Deploy the template to Azure

Run the following code from the terminal in Visual Studio Code to deploy the Bicep template to Azure. This can take a minute or two to complete, and then you'll see a successful deployment.

```azurecli
az deployment group create --template-file main.bicep
```

You'll see ```Running...``` in the terminal.

::: zone-end

::: zone pivot="powershell"

To deploy this template to Azure, you need to sign in to your Azure account from the Visual Studio Code terminal. Be sure you've [installed Azure PowerShell](https://docs.microsoft.com/powershell/azure/install-az-ps), and sign in to the same account that activated the sandbox.

1. Open a terminal window by using the **Terminal** menu. This usually opens at the bottom of the screen.

1. If the dropdown menu on the right of the terminal window says **pwsh** or **PowerShell**, you have the right shell to work from, and you can skip to the next section.

    :::image type="content" source="../media/4-pwsh.png" alt-text="Screenshot of the Visual Studio Code terminal window, with pwsh in the dropdown menu." border="true":::

   If not, select the dropdown menu, and choose **Select Default Shell**. Then select **pwsh** or **PowerShell**.

    :::image type="content" source="../media/4-select-shell.png" alt-text="Screenshot of the Visual Studio Code terminal window, showing the select shell dropdown menu." border="true":::

1. Select the plus sign (**+**) in the terminal to create a new terminal with *pwsh* or *PowerShell* as the shell.

1. You might have to switch your terminal to the directory where you saved your Bicep template. For example, if you saved it in the *scripts* folder, you can use this command:

   ```azurepowershell
   cd scripts
   ```

### Check the version of Azure PowerShell

1. From the terminal in Visual Studio code, run the following command to check the version of Azure PowerShell that you've installed:

   ```azurepowershell
   (Get-InstalledModule Az).Version
   ```

   If the version number is `5.6.0` or later, go to the next section ("Sign in to Azure by using Azure PowerShell").

   Otherwise, you need to [install the latest version of Azure PowerShell](/powershell/azure/install-az-ps).

### Sign in to Azure

1. From the terminal in Visual Studio Code, run this command to sign in to Azure. A browser opens so you can sign in to your account.

    ```azurepowershell
    Connect-AzAccount
    ```

1. After you've signed in, you see a list of the subscriptions associated with this account in the terminal. If you activated the sandbox, you see one called *Concierge Subscription*. Use this one for the rest of the exercise.

1. Set the default subscription for all of the Azure PowerShell commands that you run in this session:

    ```azurepowershell
    $context = Get-AzSubscription -SubscriptionName 'Concierge Subscription'
    Set-AzContext $context
    ```

   > [!NOTE]
   > If you've used more than one sandbox recently, there might be more than one Concierge Subscription listed. In this case, use the next two steps to set the default subscription. If the previous command was successful, skip the next two steps.

1. Get the subscription ID. The command will list your subscriptions and their IDs. The subscription ID is the second column. Look for `Concierge Subscription`, and copy the second column. It looks something like `cf49fbbc-217c-4eb6-9eb5-a6a6c68295a0`.

    ```azurepowershell
    Get-AzSubscription
    ```

1. Change your active subscription to the Concierge Subscription. Be sure to substitute *{Your subscription ID}* with the one that you copied.

    ```azurepowershell
    $context = Get-AzSubscription -SubscriptionId {Your subscription ID}
    Set-AzContext $context
    ```

### Install the Bicep CLI

Azure PowerShell doesn't include the tooling to understand Bicep files, so you need to [install the Bicep CLI](/azure/azure-resource-manager/templates/bicep-install?tabs=azure-powershell#install-manually).

### Set the default resource group

You can set the default resource group and omit the parameter from the rest of the Azure PowerShell commands in this exercise. Set this to the resource group created for you in the sandbox environment.

```azurepowershell
Set-AzDefault -ResourceGroupName <rgn>[sandbox resource group name]</rgn>
```

### Deploy the template to Azure

Deploy the template to Azure by using the following Azure PowerShell command in the terminal. This can take a minute or two to complete, and then you'll see a successful deployment. 

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

1. In **Overview**, you can see that one deployment succeeded.

    :::image type="content" source="../media/4-deployment-succeeded.png" alt-text="Screenshot of the Azure portal interface for the resource group overview, with the deployments section showing that one succeeded." border="true":::

1. Select **1 Succeeded** to see the details of the deployment.

    :::image type="content" source="../media/4-deployment.png" alt-text="Screenshot of the Azure portal interface for the deployments, with the one deployment listed and a succeeded status." border="true":::

1. Select the deployment called **main** to see what resources were deployed, and then select **Deployment details** to expand it. In this case, there's one storage account with the name that you specified.

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

In the previous task, you learned how to create a template that contains a single resource and deploy it. Now you're ready to deploy more resources, including a dependency. In this task, you add an App Service plan and app to the Bicep template.

1. In the *main.bicep* file in Visual Studio Code, add the following code to the bottom of the file:

   ```bicep
   resource appServicePlan 'Microsoft.Web/serverFarms@2020-06-01' = {
     name: 'toy-product-launch-plan-starter'
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

1. Update the name of the App Service app from `toy-product-launch-1` to something that's likely to be unique. Make sure the name is all lowercase, contains only alphanumerics and hyphens, doesn't start or end with a hyphen, and has 2 to 60 characters.

1. Save the changes to the file.

### Deploy the updated Bicep template

::: zone pivot="cli"

Run the following command in the terminal. This is the same command you ran before.

```azurecli
az deployment group create --template-file main.bicep
```

::: zone-end

::: zone pivot="powershell"

Run the following Azure PowerShell command in the terminal. This is the same command you ran before.

```azurepowershell
New-AzResourceGroupDeployment -TemplateFile main.bicep
```

::: zone-end

### Check your deployment

1. Return to the Azure portal. Go to your resource group. You'll still see one successful deployment, because the deployment used the same name as the first deployment. 

1. Select the **1 Succeeded** link.

1. Select the deployment called **main**, and then select **Deployment details** to expand the list of deployed resources.

    :::image type="content" source="../media/4-addapp-details.png" alt-text="Screenshot that shows the Azure portal interface for the specific deployment, with storage account and App Service resources listed." border="true":::

1. Notice that the App Service plan and app have been deployed.
