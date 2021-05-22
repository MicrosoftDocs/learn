> [!NOTE]
> This exercise requires an Azure subscription. If you don't have an Azure subscription, you can get a [free subscription](https://azure.microsoft.com/free/?azure-portal=true).

Project Teddybear is in full swing and the R&D team is waiting for you to give them access to their new Azure subscription. You've created the subscription already, but before you give them access you need to ensure they only deploy virtual machines that comply with their team's policies. They've told you that they don't want to deploy F or G series virtual machines. In this exercise, you'll create a Bicep template that configures the subscription based on the team's policies.

During the process, you'll:

> [!div class="checklist"]
> * Create a Bicep template to be deployed to a subscription scope.
> * Add an Azure Policy definition and assignment.
> * Deploy the template and verify the result.

## Create a subscription-scoped template

1. Open Visual Studio Code.

1. Create a new file called *main.bicep*.

1. Save the empty file so that Visual Studio Code loads the Bicep tooling. You can select File > Save, or use the <kbd>Ctrl+S</kbd> keyboard shortcut (<kbd>⌘+S</kbd> on macOS). Make sure you remember where you save the file - for example, you might want to create a **scripts** folder to save it in.

1. Add the following content into the file. You'll deploy the template soon. It's a good idea to type this in yourself instead of copying and pasting, so that you can see how the tooling helps you to write your Bicep files.

   :::code language="bicep" source="code/4-template.bicep" range="1" :::

   This line of code tells Bicep that your template is going to be deployed to a subscription scope.

## Add a policy definition

1. Underneath the line you just added, add the following variable definition:

   :::code language="bicep" source="code/4-template.bicep" range="3" :::

1. At the bottom of the file, add the following Azure Policy definition:

   :::code language="bicep" source="code/4-template.bicep" range="6-38" :::

   Notice that the policy definition only applies to resources where:

   * The resource type is equal to `Microsoft.Compute/virtualMachines`; and
   * The `sku.name` property *either* begins with `Standard_F` or `Standard_G`.
  
   When you try to create a resource that matches these conditions, Azure will deny the resource creation.

   You're creating the policy definition at the scope of the subscription. This means that the, once deployed, the policy definition will be available throughout all resource groups in the subscription.

## Assign the policy

A policy definition doesn't do anything until it's applied. In this step, you deploy a second subscription-scoped resource that applies the policy definition to the subscription.

1. Underneath the `policyDefinitionName` variable definition, add the following variable definition:

   :::code language="bicep" source="code/4-template.bicep" range="4" :::

1. At the bottom of the file, under the policy definition resource, add the following policy assignment:

   :::code language="bicep" source="code/4-template.bicep" range="40-45" :::

   Notice that you don't explicitly configure the policy assignment to apply to the whole subscription. Bicep understands this because the template will be deployed to the subscription scope.

1. Save the changes to the file.

## Verify your template

Your template should look like the following:

:::code language="bicep" source="code/4-template.bicep" :::

If it doesn't, either copy the example or adjust your template to match the example.

## Deploy the template

::: zone pivot="cli"

To deploy this template to Azure, you need to sign in to your Azure account from the Visual Studio Code terminal. Be sure you have the [Azure CLI](/cli/azure/install-azure-cli) tools installed.

1. Open a terminal window by using the **Terminal** menu. This usually opens at the bottom of the screen.

1. If the dropdown menu on the right of the terminal window says **bash**, you have the right shell to work from and you can skip to the next section.

    :::image type="content" source="../../shared/media/bash.png" alt-text="Screenshot of the Visual Studio Code terminal window, with bash in the dropdown menu." border="true":::

    If not, select the dropdown menu, and choose **Select Default Shell**. Then select **bash**.

    :::image type="content" source="../../shared/media/select-shell.png" alt-text="Screenshot of the Visual Studio Code terminal window, showing the select shell dropdown menu." border="true":::

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

1. After you've signed in, you see a list of the subscriptions associated with this account in the terminal. Find the subscription that you want to use for this exercise. If you missed the list from the sign-in, you can use the following snippet to list your subscriptions again.

    ```azurecli
    az account list --output table
    ```

1. Set the default subscription for all of the Azure CLI commands that you run in this session.

    ```azurecli
    az account set --subscription "Your Subscription Name or ID"
    ```

::: zone-end

::: zone pivot="powershell"

To deploy this template to Azure, you need to sign in to your Azure account from the Visual Studio Code terminal. Be sure you've [installed Azure PowerShell](/powershell/azure/install-az-ps).

1. Open a terminal window by using the **Terminal** menu. This usually opens at the bottom of the screen.

1. If the dropdown menu on the right of the terminal window says **pwsh** or **PowerShell**, you have the right shell to work from, and you can skip to the next section.

    :::image type="content" source="../../shared/media/pwsh.png" alt-text="Screenshot of the Visual Studio Code terminal window, with pwsh in the dropdown menu."  border="true":::

   If not, select the dropdown menu, and choose **Select Default Shell**. Then select **pwsh** or **PowerShell**.

    :::image type="content" source="../../shared/media/select-shell.png" alt-text="Screenshot of the Visual Studio Code terminal window, showing the select shell dropdown menu." border="true":::

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

1. Get the ID of the subscription that you want to use for this exercise. The following command will list your subscriptions and their IDs. 

    ```azurepowershell
    Get-AzSubscription
    ```
    The subscription ID is the second column. Copy the second column. It looks something like *cf49fbbc-217c-4eb6-9eb5-a6a6c68295a0*. 

1. Set the default subscription for all of the Azure PowerShell commands that you run in this session.

    ```azurepowershell
    Set-AzContext -SubscriptionId {Your subscription ID}
    ```

### Install the Bicep CLI

Azure PowerShell doesn't include the tooling to understand Bicep files, so you need to [install the Bicep CLI](/azure/azure-resource-manager/templates/bicep-install?tabs=azure-powershell#install-manually).

::: zone-end

### Deploy the template to Azure

::: zone pivot="cli"

Deploy the template by using Azure CLI commands in the Visual Studio Code terminal.

```azurecli
templateFile="main.bicep"
today=$(date +"%d-%b-%Y")
deploymentName="sub-scope-"$today

az deployment sub create \
    --name $deploymentName \
    --location westus \
    --template-file $templateFile
```

Notice that you're creating a subscription-scoped deployment by using the `az deployment sub create` command, instead of the `az deployment group create` command you might be used to.

::: zone-end

::: zone pivot="powershell"

Deploy the template by using Azure PowerShell commands in the terminal.

```azurepowershell
$templateFile = 'main.bicep'
$today = Get-Date -Format 'MM-dd-yyyy'
$deploymentName = "sub-scope-$today"

New-AzSubscriptionDeployment `
  -Name $deploymentName `
  -Location westus `
  -TemplateFile $templateFile
```

Notice that you're creating a subscription-scoped deployment by using the `New-AzSubscriptionDeployment` cmdlet, instead of the `New-AzResourceGroupDeployment` cmdlet you might be used to.

::: zone-end

Also, notice that you're explicitly specifying a name and location for the deployment. Azure uses this information to store the deployment metadata. You're creating a name with today's date so that you are less likely to accidentally use the same name as another deployment.

The deployment might take a minute or two to complete, and then you'll see a successful deployment.

## Verify the deployment

You can view subscription-scoped deployments in the Azure portal. This can be helpful to verify that the deployment has finished successfully and to inspect the results.

1. Go to the [Azure portal](https://portal.azure.com?azure-portal=true).

1. On the side panel, select **Subscriptions**.

1. Select your subscription.

1. In the **Search** box, enter **Deployments** and select the **Deployments** menu item.

    :::image type="content" source="../media/4-search.png" alt-text="Screenshot of the Azure portal interface showing the search field and the Deployments menu item." border="true":::

1. Select the deployment beginning with **sub-scope** to see what resources were deployed.

   :::image type="content" source="../media/4-deployment-list.png" alt-text="Screenshot of the Azure portal interface showing the list of deployments." border="true":::

1. Select **Deployment details** to expand it. In this case, the two Azure Policy resources are listed.

    :::image type="content" source="../media/4-deployment-details.png" alt-text="Screenshot of the Azure portal interface for the specific deployment." border="true":::

### Clean up the resources

You've successfully deployed subscription-scoped resources. You can remove the policy resources that you've created.

::: zone pivot="cli"

```azurecli
subscriptionId=$(az account show --query 'id' --output tsv)

az policy assignment delete --name 'DenyFandGSeriesVMs' --scope "/subscriptions/$subscriptionId"
az policy definition delete --name 'DenyFandGSeriesVMs' --subscription $subscriptionId
```

::: zone-end

::: zone pivot="powershell"

```azurepowershell
$subscriptionId = (Get-AzContext).Subscription.Id

Remove-AzPolicyAssignment -Name 'DenyFandGSeriesVMs' -Scope "/subscriptions/$subscriptionId"
Remove-AzPolicyDefinition -Name 'DenyFandGSeriesVMs' -SubscriptionId $subscriptionId
```

::: zone-end

In the next exercise unit, you'll redeploy the same policy resources and they'll be recreated, but you can clean them up again afterwards.
