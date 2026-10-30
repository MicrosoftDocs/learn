> [!NOTE]
> This exercise is optional. If you want to complete it, you'll need an Azure subscription before you begin. If you don't have an Azure account or don't want to create one now, you can read through the instructions to understand the concepts.
>
> You'll also need a resource group. You can use an existing group or create one specifically for this exercise. A dedicated resource group makes cleanup easier. For instructions on creating a group with the Azure portal or Azure CLI, see the resource group management links in the More info section of the Summary unit.

For your toy-launch website, you decide to first create a proof of concept by creating a basic Bicep file. In this exercise, you'll create a storage account, Azure App Service plan, and app. Later, you'll modify the file to make it more reusable.

During the process, you'll:

> [!div class="checklist"]
>
> - Create a Bicep file that defines a single storage account resource that includes hard-coded values.
> - Provision your infrastructure and verify the result.
> - Add an App Service plan and app to the Bicep file.
> - Provision the infrastructure again to see the new resources.

This exercise uses the Bicep extension for Visual Studio Code. Be sure to install it before you begin. You'll find the extension link in the More info section of the Summary unit.

> [!IMPORTANT]
> These optional exercises create resources in your subscription and may incur charges. Prefer a new resource group dedicated to this module. The sample uses `eastus`; if you select another supported region before starting, use it for each resource as you add that resource in this exercise, and use it in the later `location` parameter defaults. If deployment is rejected because of subscription restrictions, policy, quota, or regional capacity, resolve the reported restriction before continuing. Don't switch to a paid App Service tier merely to bypass a deployment error without reviewing the cost.

## Create a Bicep file that contains a storage account

Start by defining a storage account in a new Bicep file:

1. Open Visual Studio Code.

1. Create a new Bicep file called _main.bicep_.

1. Save the empty file so that Visual Studio Code loads the Bicep tooling.

   You can either select **File** > **Save As** or select <kbd>Ctrl+S</kbd> in Windows (<kbd>⌘+S</kbd> on macOS). Be sure to remember where you've saved the file. For example, you might want to create a _files_ folder in which to save the file.

1. Add the following Bicep code into the Bicep file. You'll deploy the file soon. It's a good idea to type the code yourself instead of copying and pasting so you can see how the tooling helps you to write your Bicep files.

   :::code language="bicep" source="code/4-template.bicep" range="1-11":::

   > [!TIP]
   > Bicep is strict about where you put line breaks, so make sure you don't put line breaks in different places than listed here.

   Notice that Visual Studio Code automatically suggests property names as you type. The Bicep extension for Visual Studio Code understands the resources you're defining in your Bicep file, and it lists the available properties and values that you can use.

1. Update the name of the storage account from `toylaunchstorage` to something that's likely to be unique, because every storage account needs a globally unique name. Make sure the name is 3 to 24 characters and includes only lowercase letters and numbers.

   > [!IMPORTANT]
   > Don't skip this step. If you do, your Bicep file won't deploy successfully.

1. Save the changes to the file.

## Deploy the Bicep file to Azure

::: zone pivot="cli"

To deploy this template to Azure, you'll sign in to your Azure account from the Visual Studio Code terminal. Be sure you've installed the Azure CLI tools. Installation links are in the More info section of the Summary unit.

Open a Bash terminal for the Azure CLI commands:

1. On the **Terminal** menu, select **New Terminal**. The terminal window usually opens in the lower half of your screen.

1. If the terminal displays **bash** on the right side, the correct shell is already open. If you see a Bash shell icon on the right, you can select it to use that terminal.

   :::image type="content" source="../media/4-terminal-bash.png" alt-text="Screenshot of the Visual Studio Code terminal with the Bash shell label and icon highlighted.":::

   If another shell appears, select the shell dropdown arrow, then select **Git Bash** on Windows or **bash** on macOS or Linux.

   :::image type="content" source="../media/4-select-shell-bash.png" alt-text="Screenshot of the Visual Studio Code terminal shell menu with Git Bash selected.":::

1. In the terminal, go to the directory where you saved your template. For example, if you saved it in a _templates_ folder under the current directory, run:

   ```azurecli
   cd templates
   ```

### Install Bicep

Run the following command to install or update the Azure CLI-managed Bicep CLI:

```azurecli
az bicep install && az bicep upgrade
```

### Sign in to Azure by using Azure CLI

Sign in and select the subscription you'll use for this exercise:

1. In the Visual Studio Code terminal, run:

   ```azurecli
   az login
   ```

1. Complete the sign-in prompts in the browser or sign-in window that opens. If the terminal prompts you to choose a subscription, select the one you'll use for this exercise.

1. List the subscriptions associated with your account and find the name or ID of the subscription you want to use:

   ```azurecli
   az account list --output table
   ```

1. Select the subscription for the following Azure CLI commands. Replace `Your Subscription Name or ID` with the value from the previous step:

   ```azurecli
   az account set --subscription "Your Subscription Name or ID"
   ```

### Select the resource group

Use the resource group you selected or created at the beginning of this exercise. Replace `YOUR_RESOURCE_GROUP_NAME` below with its actual name. Keep using this group in the remaining exercises. If you open a new terminal, sign in and select the intended subscription as needed, then set the variable again.

```azurecli
resourceGroupName='YOUR_RESOURCE_GROUP_NAME'
```

### Deploy the Bicep file to Azure

Run the following command from the terminal in Visual Studio Code to deploy the Bicep file to Azure. The command can take a minute or two to complete.

A linter warning about a hard-coded location doesn't itself prevent deployment. In a later exercise, you'll make the location configurable. Deployment also depends on permissions, policy, quota, and resource availability in the selected region; inspect any deployment error before proceeding.

```azurecli
az deployment group create --resource-group "$resourceGroupName" --name main --template-file main.bicep
```

You'll see `Running...` in the terminal.

::: zone-end

::: zone pivot="powershell"

To deploy this template to Azure, you'll sign in to your Azure account from the Visual Studio Code terminal. Be sure you've installed Azure PowerShell. Installation links are in the More info section of the Summary unit.

Open a PowerShell terminal for the Azure PowerShell commands:

1. On the **Terminal** menu, select **New Terminal**. The terminal window usually opens in the lower half of your screen.

1. If the terminal displays **pwsh** or **powershell** on the right side, the correct shell is already open. If you see a PowerShell shell icon on the right, you can select it to use that terminal.

   :::image type="content" source="../media/4-terminal-powershell.png" alt-text="Screenshot of the Visual Studio Code terminal with the pwsh label and PowerShell icon highlighted.":::

   If another shell appears, select the shell dropdown arrow, then select **PowerShell**.

   :::image type="content" source="../media/4-select-shell-powershell.png" alt-text="Screenshot of the Visual Studio Code terminal shell menu with PowerShell selected.":::

1. In the terminal, go to the directory where you saved your template. For example, if you saved it in a _templates_ folder under the current directory, run:

   ```azurepowershell
   Set-Location -Path templates
   ```

### Install the Bicep CLI

Azure PowerShell doesn't automatically install the Bicep CLI. Follow the Bicep installation for Azure PowerShell instructions in the More info section of the Summary unit. The standalone `bicep` executable must be available on your `PATH`; the Azure CLI-managed installation isn't added to `PATH`.

After installation, reopen your terminal if needed for the `PATH` change to take effect, then confirm that Bicep is available:

```azurepowershell
bicep --version
```

### Sign in to Azure by using Azure PowerShell

Sign in and select the subscription you'll use for this exercise:

1. In the Visual Studio Code terminal, run:

   ```azurepowershell
   Connect-AzAccount
   ```

1. Complete the sign-in prompts in the browser or sign-in window that opens.

1. List your subscriptions and copy the ID of the subscription you want to use:

   ```azurepowershell
   Get-AzSubscription
   ```

   The ID looks something like `aaaa0a0a-bb1b-cc2c-dd3d-eeeeee4e4e4e`.

1. Select the subscription for the following Azure PowerShell commands. Replace `YOUR_SUBSCRIPTION_ID` with the ID from the previous step:

   ```azurepowershell
   Set-AzContext -SubscriptionId 'YOUR_SUBSCRIPTION_ID'
   ```

### Select the resource group

Use the resource group you selected or created at the beginning of this exercise. Replace `YOUR_RESOURCE_GROUP_NAME` below with its actual name. Keep using this group in the remaining exercises. If you open a new terminal, sign in and select the intended subscription as needed, then set the variable again.

```azurepowershell
$resourceGroupName = 'YOUR_RESOURCE_GROUP_NAME'
```

### Deploy the Bicep file to Azure

Deploy the Bicep file to Azure by using the following Azure PowerShell command in the terminal. The command can take a minute or two to complete.

A linter warning about a hard-coded location doesn't itself prevent deployment. In a later exercise, you'll make the location configurable. Deployment also depends on permissions, policy, quota, and resource availability in the selected region; inspect any deployment error before proceeding.

```azurepowershell
New-AzResourceGroupDeployment -ResourceGroupName $resourceGroupName -Name main -TemplateFile main.bicep
```

::: zone-end

## Verify the deployment

The first time you deploy a Bicep file, you might want to use the Azure portal to verify that the deployment has finished successfully and to inspect the results.

1. Go to the Azure portal and make sure you're in the correct subscription. The portal link is in the More info section of the Summary unit.

1. On the left-side panel, select **Resource groups**.

1. Select your resource group name.

1. In **Overview**, locate the **Deployments** information. You might need to expand **Essentials**. The displayed totals depend on the resource group's existing deployment history.

    :::image type="content" source="../media/4-deployment-succeeded.png" alt-text="Screenshot of the Azure portal resource group overview showing one successful deployment." border="true":::

1. Select the **Deployments** link to open the deployment history.

    :::image type="content" source="../media/4-deployment.png" alt-text="Screenshot of Azure portal deployment history showing one successful deployment." border="true":::

    > [!NOTE]
    > The screenshots show an example deployment history. Your totals can differ if the resource group already contains deployments or you repeat exercises. Identify the deployment by its name, latest operation time, and status instead of relying on a particular number of succeeded deployments.

1. Select the deployment called **main**. Confirm that its latest operation succeeded and corresponds to the command you just ran, then select **Deployment details** to expand it. In this case, there's one storage account with the name that you specified.

    :::image type="content" source="../media/4-deployment-details.png" alt-text="Screenshot of Azure portal deployment details listing a storage account." border="true":::

1. Leave the page open in your browser. You'll check on deployments again later.

::: zone pivot="cli"

You can also verify the deployment from the command line. To do so, run the following Azure CLI command:

```azurecli
az deployment group list --resource-group "$resourceGroupName" --output table
```

::: zone-end

::: zone pivot="powershell"

You can also verify the deployment from the command line. To do so, run the following Azure PowerShell command:

```azurepowershell
Get-AzResourceGroupDeployment -ResourceGroupName $resourceGroupName | Format-Table
```

::: zone-end

## Add an App Service plan and app to your Bicep file

In the previous task, you learned how to create a Bicep file that contains a single resource and deploy it. Now you're ready to deploy more resources, including a dependency. In this task, you'll add an App Service plan and app to the Bicep file.

1. In the _main.bicep_ file in Visual Studio Code, add the following code to the bottom of the file:

   :::code language="bicep" source="code/4-template.bicep" range="13-29":::

1. Update the name of the App Service app from `toy-product-launch-1` to something that's likely to be unique. Make sure the name is 2 to 60 characters with uppercase and lowercase letters, numbers, and hyphens, and doesn't start or end with a hyphen.

1. Save the changes to the file.

### Deploy the updated Bicep file

::: zone pivot="cli"

Deploy the updated file using the same subscription, resource group, and resource location. A hard-coded-location linter warning isn't itself a deployment error.

```azurecli
az deployment group create --resource-group "$resourceGroupName" --name main --template-file main.bicep
```

::: zone-end

::: zone pivot="powershell"

Deploy the updated file using the same subscription, resource group, and resource location. A hard-coded-location linter warning isn't itself a deployment error.

```azurepowershell
New-AzResourceGroupDeployment -ResourceGroupName $resourceGroupName -Name main -TemplateFile main.bicep
```

::: zone-end

### Check your deployment

Confirm that the updated deployment includes the App Service resources:

1. Return to the Azure portal and go to your resource group. Reusing the name `main` updates that deployment's history entry; other deployment entries can still be present.

1. Open the resource group's **Deployments** history.

1. Select the deployment called **main**. Confirm that its latest operation succeeded and corresponds to the command you just ran, then select **Deployment details** to expand the list of deployed resources.

    :::image type="content" source="../media/4-addapp-details.png" alt-text="Screenshot of Azure portal deployment details listing storage account and App Service resources." border="true":::

1. Notice that the App Service plan and app were deployed.
