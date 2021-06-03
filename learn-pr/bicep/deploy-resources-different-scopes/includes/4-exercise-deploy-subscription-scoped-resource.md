> [!NOTE]
> This exercise requires an Azure subscription. If you don't already have one, you can get a [free subscription](https://azure.microsoft.com/free/?azure-portal=true).

Project Teddybear is in full swing, and the R&D team is waiting for you to give it access to the new Azure subscription. You've created the subscription already, but before you give the team access, you need to ensure that it deploys only virtual machines that comply with the team's policies. The team has told you that it doesn't want to deploy F or G series virtual machines. 

In this exercise, you'll create a Bicep template that configures the subscription based on the team's policies.

During the process, you'll:

> [!div class="checklist"]
> * Create a Bicep template to be deployed at a subscription scope.
> * Add an Azure Policy definition and assignment.
> * Deploy the template and verify the result.

## Create a subscription-scoped template

1. Open Visual Studio Code.

1. Create a new file called *main.bicep*.

1. Save the empty file so that Visual Studio Code loads the Bicep tooling. You can select **File** > **Save** or select <kbd>Ctrl+S</kbd> (Windows) or <kbd>⌘+S</kbd> (Mac). Remember where you've saved the file. For example, you might want to create a *scripts* folder to save it in.

1. Add the following content to the *main.bicep* file. You'll deploy the template soon. It's a good idea to type it in manually instead of copying and pasting, so that you can see how the tooling helps you to write your Bicep files.

   :::code language="bicep" source="code/4-template.bicep" range="1" :::

   This line of code tells Bicep that your template is going to be deployed at a subscription scope.

## Add a policy definition

1. Below the line you just added, add the following variable definition:

   :::code language="bicep" source="code/4-template.bicep" range="3" :::

1. At the bottom of the file, add the following Azure Policy definition:

   :::code language="bicep" source="code/4-template.bicep" range="6-38" :::

   Notice that the policy definition applies only to resources where:

   * The resource type is equal to `Microsoft.Compute/virtualMachines`.
   * The `sku.name` property *either* begins with `Standard_F` or `Standard_G`.
  
   When you try to create a resource that matches these conditions, Azure will deny the resource creation.

   > [!WARNING]
   > Be careful when you use the *deny* policy effect for your policy definitions, especially at wide scopes such as subscriptions and management groups. If the definition isn't created correctly, it can have unexpected effects that can lead to outages. It's better to start with the *audit* policy effect, and then switch to the *deny* effect only after you've seen it work well over a period of time.

   You're creating the policy definition at the scope of the subscription. This means that, after the definition is deployed, it will be available throughout all resource groups in the subscription.

## Apply the policy

A policy definition has no effect until it's applied. In this step, you deploy a second subscription-scoped resource that applies the policy definition to the subscription.

1. Below the `policyDefinitionName` variable definition, add the following variable definition:

   :::code language="bicep" source="code/4-template.bicep" range="4" :::

1. At the bottom of the file, under the policy definition resource, add the following policy assignment:

   :::code language="bicep" source="code/4-template.bicep" range="40-45" :::

   Notice that you don't explicitly configure the policy assignment to apply to the whole subscription. Bicep understands this because the template will be deployed at the subscription scope.

1. Save the changes to the file.

## Verify your template

Your template should look like the following:

:::code language="bicep" source="code/4-template.bicep" :::

If it doesn't, either copy the example or adjust your template to match the example.

## Deploy the template

::: zone pivot="cli"

To deploy this template to Azure, you need to sign in to your Azure account from the Visual Studio Code terminal. Be sure you've installed the [Azure CLI](/cli/azure/install-azure-cli) tools.

1. Open a Visual Studio Code terminal window by selecting **Terminal** > **New Terminal**. The window usually opens at the bottom of the screen.

1. If the dropdown control at the right displays **bash**, you have the right shell to work from, and you can skip to the next section.

    :::image type="content" source="../../shared/media/bash.png" alt-text="Screenshot of the Visual Studio Code terminal window, with 'bash' displayed in the dropdown control." border="true":::

    If **bash** isn't displayed, select the dropdown control, choose **Select Default Shell**, and then select **bash**.

    :::image type="content" source="../../shared/media/select-shell.png" alt-text="Screenshot of the Visual Studio Code terminal window, displaying the 'Select your preferred terminal shell' dropdown list." border="true":::

1. Select the plus sign (**+**) in the terminal to create a new terminal with Bash as the shell.

1. Change to the directory where you saved your Bicep template. For example, if you saved it in the *scripts* folder, you can use this command:

    ```azurecli
    cd scripts
    ```

### Check the version of the Azure CLI

1. In the Visual Studio Code terminal, check your version of the Azure CLI by running the following command:

   ```azurecli
   az -v
   ```

1. Look at the version number on the first line, which starts with `azure-cli`.

   - If the version number is version `2.20.0` or later, skip to the next section, "Install the Bicep tooling."

   - If the version number is `2.11.0` or later and earlier than `2.20.0`, update your Azure CLI version by using this command:
  
      ```azurecli
      az upgrade
      ```

   - If the version number is earlier than `2.11.0`, you might need to [reinstall the Azure CLI](/cli/azure/install-azure-cli) to get the latest version.

### Install the Bicep tooling

To install the Bicep template compilation support, run the following command:

```azurecli
az bicep install
```

### Sign in to Azure

1. In the Visual Studio Code terminal, sign in to Azure by running the following command: 

    ```azurecli
    az login
    ```

1. In the browser that opens, sign in to your Azure account.

   The Visual Studio Code terminal displays a list of the subscriptions associated with this account. 

1. In the list, find the subscription that you want to use for this exercise. 
 
   If you missed the list from the sign-in, you can use the following snippet to list your subscriptions again.

    ```azurecli
    az account list --output table
    ```

1. Set the default subscription for all the Azure CLI commands that you run in this session.

    ```azurecli
    az account set --subscription "Your Subscription Name or ID"
    ```

::: zone-end

::: zone pivot="powershell"

To deploy this template to Azure, you need to sign in to your Azure account from the Visual Studio Code terminal. Be sure you've [installed Azure PowerShell](/powershell/azure/install-az-ps).

1. Open a Visual Studio Code terminal window by selecting **Terminal** > **New Terminal**. The window usually opens at the bottom of the screen.

1. If the dropdown control at the right displays **pwsh** or **PowerShell**, you have the right shell to work from, and you can skip to the next section.

    :::image type="content" source="../../shared/media/pwsh.png" alt-text="Screenshot of the Visual Studio Code terminal window, with 'pwsh' displayed in the dropdown control."  border="true":::

   If **pwsh** isn't displayed, select the dropdown control, choose **Select Default Shell**, and then select **pwsh** or **PowerShell**.

    :::image type="content" source="../../shared/media/select-shell.png" alt-text="Screenshot of the Visual Studio Code terminal window, displaying the 'Select your preferred terminal shell' dropdown list." border="true":::

1. Select the plus sign (**+**) in the terminal to create a new terminal with pwsh or PowerShell as the shell.

1. You might have to change to the directory where you saved your Bicep template. For example, if you saved it in the *scripts* folder, you can use this command:

   ```azurepowershell
   cd scripts
   ```

### Check the version of Azure PowerShell

1. In the Visual Studio Code terminal, check the version of Azure PowerShell you've installed by running the following command:

   ```azurepowershell
   (Get-InstalledModule Az).Version
   ```

   If the version number is `5.6.0` or later, skip to the next section, "Sign in to Azure by using Azure PowerShell."

   If the version is earlier than `5.6.0`, you need to [install the latest version of Azure PowerShell](/powershell/azure/install-az-ps).

### Sign in to Azure by using Azure PowerShell

1. In the Visual Studio Code terminal, sign in to Azure by running the following command:

    ```azurepowershell
    Connect-AzAccount
    ```

1. In the browser that opens, sign in to your Azure account.

1. Get the ID of the subscription that you want to use for this exercise by running the following command: 

    ```azurepowershell
    Get-AzSubscription
    ```
    The subscription ID is the second column. Copy the second column. It looks something like *cf49fbbc-217c-4eb6-9eb5-a6a6c68295a0*. 

1. Set the default subscription for all the Azure PowerShell commands that you run in this session.

    ```azurepowershell
    Set-AzContext -SubscriptionId {Your subscription ID}
    ```

### Install the Bicep CLI

Azure PowerShell doesn't include the tooling for understanding Bicep files, so you need to [install the Bicep CLI](/azure/azure-resource-manager/templates/bicep-install?tabs=azure-powershell#install-manually).

::: zone-end

### Deploy the template to Azure

::: zone pivot="cli"

In the Visual Studio Code terminal, deploy the template by using the following Azure CLI commands:

```azurecli
templateFile="main.bicep"
today=$(date +"%d-%b-%Y")
deploymentName="sub-scope-"$today

az deployment sub create \
    --name $deploymentName \
    --location westus \
    --template-file $templateFile
```

Notice that you're creating a subscription-scoped deployment by using the `az deployment sub create` command, instead of the `az deployment group create` command that you might be used to.

::: zone-end

::: zone pivot="powershell"

In the Visual Studio Code terminal, deploy the template by using the following Azure PowerShell commands:

```azurepowershell
$templateFile = 'main.bicep'
$today = Get-Date -Format 'MM-dd-yyyy'
$deploymentName = "sub-scope-$today"

New-AzSubscriptionDeployment `
  -Name $deploymentName `
  -Location westus `
  -TemplateFile $templateFile
```

Notice that you're creating a subscription-scoped deployment by using the `New-AzSubscriptionDeployment` cmdlet, instead of the `New-AzResourceGroupDeployment` cmdlet that you might be used to.

::: zone-end

Also notice that you're explicitly specifying a name and location for the deployment. Azure uses this information to store the deployment metadata.

> [!TIP]
> Your deployment name includes today's date. This makes it less likely that you'll accidentally use the same name as another deployment.

The deployment might take a minute or two to finish, and then you'll see a successful deployment.

## Verify the deployment

You can view subscription-scoped deployments in the Azure portal. This can be helpful to verify that the deployment has finished successfully and to inspect the results.

1. Go to the [Azure portal](https://portal.azure.com?azure-portal=true).

1. On left pane, select **Subscriptions**.

1. Select your subscription.

1. In the **Search** box, enter **Deployments**, and then select the **Deployments** menu item.

    :::image type="content" source="../media/4-search.png" alt-text="Screenshot of the Azure portal Search box and the Deployments menu item." border="true":::

1. In the **Deployment name** column, select the deployment beginning with **sub-scope** to see what resources were deployed.

   :::image type="content" source="../media/4-deployment-list.png" alt-text="Screenshot of the Azure portal interface showing the list of deployments." border="true":::

1. Select **Deployment details** to expand it. In this case, the two Azure Policy resources are listed.

    :::image type="content" source="../media/4-deployment-details.png" alt-text="Screenshot of the Azure portal overview pane for the selected deployment." border="true":::

### Clean up the resources

You've successfully deployed subscription-scoped resources. You can remove the policy resources that you've created by running the following commands:

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

In the next exercise unit, you'll redeploy the same policy resources. They'll be re-created, but you can clean them up again afterward.
