Project Teddybear was a success, and now the secretive R&D development at your toy company is ready to research even more new toys. The team has started to ask you for new subscriptions on a near-daily basis, and it needs to apply its policies across all of them.

Rather than duplicate the policy definitions and assignments in each subscription, you've decided to put all the team's subscriptions within a management group. You can then apply the policy to the entire management group instead of to each subscription individually.

In this exercise, you'll create a new Bicep template to apply policy definitions and assignments to a management group.

During the process, you'll:

> [!div class="checklist"]
> * Create a new management group.
> * Create a new management group-scoped Bicep file.
> * Add the Azure Policy resources to the file.
> * Link the policy assignment to the policy definition by manually constructing the resource ID.
> * Deploy the template and verify the result.

This exercise requires the following prerequisites:

* [Management groups must be enabled](/azure/governance/management-groups/overview) on your Azure tenant.
* You need permissions for creating a new management group within your hierarchy.
* You need permissions for deploying Azure Policy resources to the management group.

If you can't meet these requirements with your current Azure account, you can get a [free trial](https://azure.microsoft.com/free/?azure-portal=true) and create a new Azure subscription and tenant. Alternatively, you can skip the deployment steps in this exercise.

## Create a management group

In this exercise, you'll create a new management group so that you don't accidentally affect any resources in another part of your Azure environment.

::: zone pivot="cli"

In the Visual Studio Code terminal, run the following Azure CLI commands:

```azurecli
az account management-group create \
  --name SecretRND \
  --display-name "Secret R&D Projects"
```

By default, the new management group is created as a direct child of the tenant root management group. If you need to place the management group in a specific place in your existing management group hierarchy, use the `--parent-id` parameter, and specify the name of the management group to use as the parent.

::: zone-end

::: zone pivot="powershell"

In the Visual Studio Code terminal, run the following Azure PowerShell commands:

```azurepowershell
New-AzManagementGroup `
  -GroupId 'SecretRND' `
  -DisplayName 'Secret R&D Projects'
```

By default, the new management group is created as a child of the tenant root management group. If you need to place the management group in a specific place in your existing management group hierarchy, use the `-ParentId` parameter, and specify the name of the management group to use as the parent.

::: zone-end

In a real deployment, you'd [move the R&D team's subscriptions into the management group](/azure/governance/management-groups/manage). For this exercise, you'll deploy the policies even though the management group contains no subscriptions. The same deployment process applies whether the management group is empty or contains subscriptions.

## Create a Bicep file to deploy to a management group

1. Open Visual Studio Code.

1. Delete your *main.bicep* file, and then create a new empty file with the same name.

1. Save the empty file.

1. Add the following content to the file.

   :::code language="bicep" source="code/7-template.bicep" range="1" :::

   Note that this line of code tells Bicep that your template will be deployed at the management group scope.

## Add a policy definition

As you did earlier, create a policy definition in the Bicep file.

1. Below the line you just added, add the following variable definition:

   :::code language="bicep" source="code/7-template.bicep" range="3" :::

1. At the bottom of the file, add the following Azure Policy definition:

   :::code language="bicep" source="code/7-template.bicep" range="6-38" :::

   The policy definition is the same as the one you previously applied to your subscription. This time, though, you're deploying it to a management group.

## Add a policy assignment

You'll now apply the policy to the management group. This means that the policy will apply to all subscriptions that are children of this management group.

1. Below the `policyDefinitionName` variable definition, add the following variable:

   :::code language="bicep" source="code/7-template.bicep" range="4" :::

1. At the bottom of the file, under the policy definition resource, add the following policy assignment:

   :::code language="bicep" source="code/7-template.bicep" range="40-45" :::

1. Save the changes to the file.

## Verify your template

Your template should look like the following:

:::code language="bicep" source="code/7-template.bicep" :::

If it doesn't, either copy the example or adjust your template to match the example.

### Deploy the template to Azure

::: zone pivot="cli"

In the Visual Studio Code terminal, deploy the template by using the following Azure CLI commands:

```azurecli
managementGroupId="SecretRND"
templateFile="main.bicep"
today=$(date +"%d-%b-%Y")
deploymentName="mg-scope-"$today

az deployment mg create \
  --management-group-id $managementGroupId \
  --name $deploymentName \
  --location westus \
  --template-file $templateFile
```

::: zone-end

::: zone pivot="powershell"

Deploy the template by using Azure PowerShell commands in the terminal.

```azurepowershell
$managementGroupId = 'SecretRND'
$templateFile = 'main.bicep'
$today = Get-Date -Format 'MM-dd-yyyy'
$deploymentName = "mg-scope-$today"

New-AzManagementGroupDeployment `
  -ManagementGroupId $managementGroupId `
  -Name $deploymentName `
  -Location westus `
  -TemplateFile $templateFile
```

::: zone-end

Notice that, as with subscription deployments, you're explicitly specifying a name and location for the deployment metadata. And you're using today's date to reduce the chance of using an existing deployment's name.

The deployment might take a minute or two to complete, and then you'll see a successful deployment.

## Verify the deployment

As with subscription-scoped deployments, you can view management group-scoped deployments in the Azure portal.

1. Go to the [Azure portal](https://portal.azure.com?azure-portal=true).

1. On left pane, select **All services**.

1. In the **Search** box, enter **management group**, then select **Management groups** in the results list.

   :::image type="content" source="../media/7-portal-search.png" alt-text="Screenshot of the Azure portal interface showing the service list with 'Management groups' highlighted." border="true":::

1. Select the **Secret R&D Projects** management group.

   :::image type="content" source="../media/7-management-group-list.png" alt-text="Screenshot of the Azure portal interface, highlighting 'Secret R&D Projects' in the list of management groups." border="true":::

1. On the left pane, in the **Search** box, enter **Deployments**, then select **Deployments** under **Governance**.

   :::image type="content" source="../media/7-management-group-details.png" alt-text="Screenshot of the Azure portal interface, showing the management group details." border="true":::

1. Select the deployment beginning with **mg-scope** to see what resources were deployed.

   :::image type="content" source="../media/7-deployment-list.png" alt-text="Screenshot of the Azure portal Deployments pane, highlighting the 'mg-scope-*' deployment in the list of deployments." border="true":::

1. On the **Overview** pane for the selected deployment, select **Deployment details** to expand it. The two Azure Policy resources are listed.

    :::image type="content" source="../media/7-deployment-details.png" alt-text="Screenshot of the Azure portal 'Overview' pane for the selected deployment." border="true":::

### Clean up the resources

You've successfully deployed your management group-scoped resources. You can remove the policy resources and management group that you've created.

::: zone pivot="cli"

```azurecli
az account management-group delete --name SecretRND
```

::: zone-end

::: zone pivot="powershell"

```azurepowershell
Remove-AzManagementGroup -GroupId SecretRND
```

::: zone-end
