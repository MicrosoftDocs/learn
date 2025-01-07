[!INCLUDE [BYO subscription explanation](../../../includes/azure-exercise-subscription-prerequisite.md)]

Project Teddybear is in full swing, and the R&D team is waiting for you to give it access to the new Azure subscription. You've created the subscription already, but before you give the team access, you need to ensure that it deploys only virtual machines that comply with the team's policies. The team has told you that it doesn't want to deploy F or G series virtual machines.

In this exercise, you'll create a Bicep template that configures the subscription based on the team's policies.

During the process, you'll:

> [!div class="checklist"]
> * Create a Bicep template to be deployed at a subscription scope.
> * Add an Azure Policy definition and assignment.
> * Deploy the template and verify the result.

This exercise requires that you have permission to deploy subscription-scoped resources. If you can't meet this requirement with your current Azure account, you can get a [free trial](https://azure.microsoft.com/free/?azure-portal=true) and create a new Azure subscription and tenant. Alternatively, you can skip the deployment steps in this exercise.

[!INCLUDE [Install the Bicep extension for Visual Studio Code](../../includes/azure-template-bicep-exercise-vscode-extension.md)]

## Create a subscription-scoped template

1. Open Visual Studio Code.

1. Create a new file called *main.bicep*.

1. Save the empty file so that Visual Studio Code loads the Bicep tooling.

   You can either select **File** > **Save As** or select <kbd>Ctrl+S</kbd> in Windows (<kbd>⌘+S</kbd> on macOS). Be sure to remember where you've saved the file. For example, you might want to create a *scripts* folder to save it in.

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

## Assign the policy

A policy definition has no effect until it's applied. In this step, you'll deploy a second subscription-scoped resource that applies the policy definition to the subscription.

1. Below the `policyDefinitionName` variable definition, add the following variable definition:

   :::code language="bicep" source="code/4-template.bicep" range="4" :::

1. At the bottom of the file, under the policy definition resource, add the following policy assignment:

   :::code language="bicep" source="code/4-template.bicep" range="40-45" :::

   Notice that you don't explicitly configure the policy assignment to apply to the whole subscription. Bicep understands this, because the template will be deployed at the subscription scope.

1. Save the changes to the file.

## Verify your template

Your template should look like the following:

:::code language="bicep" source="code/4-template.bicep" :::

If it doesn't, either copy the example or adjust your template to match the example.

## Deploy the template

::: zone pivot="cli"

[!include[](../../includes/azure-template-bicep-exercise-nosandbox-deploy-cli.md)]

::: zone-end

::: zone pivot="powershell"

[!include[](../../includes/azure-template-bicep-exercise-nosandbox-deploy-powershell.md)]

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

> [!NOTE]
> If you receive an error message with the code **AuthorizationFailed**, you probably don't have permission to deploy subscription-scoped resources. Ask your Azure administrator to grant you permissions. Alternatively, if you can't meet this requirement with your current Azure account, you can get a [free trial](https://azure.microsoft.com/free/?azure-portal=true) and create a new Azure subscription and tenant.

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
