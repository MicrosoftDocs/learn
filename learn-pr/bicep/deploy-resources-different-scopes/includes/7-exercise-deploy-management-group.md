Project Teddybear was a success, and now the secretive R&D development at your toy company is ready to research even more new toys. They've started to ask you for new subscriptions on a near-daily basis, and they need to apply their policies across all of them. Rather than duplicating your policy definitions and assignments in each subscription, you've decided that you'll put all of their subscriptions within a management group, and then apply a policy to the management group instead of each subscription individually. In this exercise, you'll create a new Bicep template to apply policy definitions and assignments to a management group.

During the process, you'll:

> [!div class="checklist"]
> * Create a new management group.
> * Create a new management group-scoped Bicep file.
> * Add the Azure Policy resources to the file.
> * Link the policy assignment to the policy definition by manually constructing the resource ID.
> * Deploy the template and verify the result.

> [!NOTE]
> There are some prerequisites for this exercise:
>
> - [Management groups must be enabled](/azure/governance/management-groups/overview) on your Azure tenant.
> - You need permission to create a new management group within your hierarchy.
> - You need permission to deploy Azure Policy resources to the management group.
> 
> If you can't meet these requirements with your Azure account, you can get a [free trial](https://azure.microsoft.com/free/?azure-portal=true) and create a new Azure subscription and tenant. Or, you can skip this exercise.

## Create a management group

You'll create a new management group for this exercise so that you don't accidentally affect any resources in another part of your Azure environment.

::: zone pivot="cli"

Execute the following Azure CLI commands in the Visual Studio Code terminal.

```azurecli
az account management-group create \
  --name SecretRND \
  --display-name "Secret R&D Projects"
```

By default, the new management group will be created as a direct child of the tenant root management group. If you need to place the management group into a specific place in your existing management group hierarchy, use the `--parent-id` parameter, and specify the name of the management group to use as the parent.

::: zone-end

::: zone pivot="powershell"

Execute the following Azure PowerShell commands in the Visual Studio Code terminal.

```azurepowershell
New-AzManagementGroup `
  -GroupName 'SecretRND' `
  -DisplayName 'Secret R&D Projects'
```

By default, the new management group will be created as a child of the tenant root management group. If you need to place the management group into a specific place in your existing management group hierarchy, use the `-ParentId` parameter, and specify the name of the management group to use as the parent.

::: zone-end

In a real deployment, you'd [move the R&D team's subscriptions into the management group](/azure/governance/management-groups/manage). For this exercise, you'll deploy the policies even though the management group doesn't contain any subscriptions. The same deployment process applies even if the management group is empty.

## Create a Bicep file to deploy to a management group

1. Open Visual Studio Code.

1. Delete your *main.bicep* file and create a new empty file with the same name.

1. Save the empty file.

1. Add the following content into the file.

   :::code language="bicep" source="code/7-template.bicep" range="1" :::

   Note that this line of code tells Bicep that your template is going to be deployed to a management group scope.

## Add a policy definition

Like before, you will create a policy definition in the Bicep file.

1. Underneath the line you just added, add the following variable definition:

   :::code language="bicep" source="code/7-template.bicep" range="5" :::

1. At the bottom of the file, add the following Azure Policy definition:

   :::code language="bicep" source="code/7-template.bicep" range="8-40" :::

   The policy definition is the same as the one you previously applied to your subscription. This time, though, you're deploying it to a management group. 

## Add a policy assignment

Now you will apply the policy to the management group. This means that it will apply to all subscriptions that are children of this management group.

In order to create a policy assignment, you need to refer to the policy definition. Azure Resource Manager doesn't currently have a way to obtain a full resource ID for resources deployed into management groups, so you will manually construct a resource ID.

1. At the top of the file, underneath the `targetScope` definition, add a blank line and then the following parameter:

   :::code language="bicep" source="code/7-template.bicep" range="3" :::

   You need to have the management group's name as a parameter because you'll use it when you construct the resource ID shortly.

1. Below the `policyDefinitionName` variable definition, add the following variable:

   :::code language="bicep" source="code/7-template.bicep" range="6" :::

1. At the bottom of the file, under the policy definition resource, add the following policy assignment:

   :::code language="bicep" source="code/7-template.bicep" range="42-47" :::

   Notice that the `policyDefinitionId` is a resource ID. It contains the management group's name, and the policy definition's name. Because you've reference the policy definition's name using the `policyDefinition.name` property, Bicep understands there's a dependency between the two resources. It will deploy the policy definition before the policy assignment.

   In future, Azure will support a simpler syntax.

1. Save the changes to the file.

## Verify your template

Your template should look like the following:

:::code language="bicep" source="code/7-template.bicep" :::

If it doesn't, either copy the example or adjust your template to match the example.

### Deploy the template to Azure

::: zone pivot="cli"

Deploy the template by using Azure CLI commands in the Visual Studio Code terminal.

```azurecli
managementGroupId="SecretRND"
templateFile="main.bicep"
today=$(date +"%d-%b-%Y")
deploymentName="mg-scope-"$today

az deployment mg create \
  --management-group-id $managementGroupId \
  --name $deploymentName \
  --location westus \
  --template-file $templateFile \
  --parameters managementGroupName=$managementGroupId
```

Notice that you have to provide the management group ID twice. The `--management-group-id` parameter helps Azure PowerShell send the deployment to the correct management group. The `-parameters managementGroupName=` parameter value is sent into the deployment and becomes the value for the `managementGroupName` parameter.

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
  -TemplateFile $templateFile `
  -managementGroupName $managementGroupId
```

Notice that you have to provide the management group ID twice. The `-ManagementGroupId` parameter helps Azure PowerShell send the deployment to the correct management group. The `-managementGroupName` parameter value is sent into the deployment and becomes the value for the `managementGroupName` parameter.

::: zone-end

Also notice that, like with subscription deployments, you're explicitly specifying a name and location for the deployment metadata.

The deployment might take a minute or two to complete, and then you'll see a successful deployment.

## Verify the deployment

Like subscription-scoped deployments, you can view management group-scoped deployments in the Azure portal.

1. Go to the [Azure portal](https://portal.azure.com?azure-portal=true).

1. On the side panel, select **All services**.

1. In the **Search** box, enter **Management groups** and select the **Management groups** menu item.

   :::image type="content" source="../media/7-portal-search.png" alt-text="Screenshot of the Azure portal interface showing the service list with management groups highlighted." border="true":::

1. Select the **Secret R&D Projects** management group.

   :::image type="content" source="../media/7-management-group-list.png" alt-text="Screenshot of the Azure portal interface showing the list of management groups." border="true":::

1. In the **Search** box, enter **Deployments** and select the **Deployments** menu item.

   :::image type="content" source="../media/7-management-group-details.png" alt-text="Screenshot of the Azure portal interface showing the management group details." border="true":::

1. Select the deployment beginning with **mg-scope** to see what resources were deployed.

   :::image type="content" source="../media/7-deployment-list.png" alt-text="Screenshot of the Azure portal interface showing the list of deployments." border="true":::

1. Select **Deployment details** to expand it. In this case, the two Azure Policy resources are listed.

    :::image type="content" source="../media/7-deployment-details.png" alt-text="Screenshot of the Azure portal interface for the specific deployment." border="true":::

### Clean up the resources

You've successfully deployed management group-scoped resources. You can remove the policy resources and management group that you've created.

::: zone pivot="cli"

```azurecli
az account management-group delete --name SecretRND
```

::: zone-end

::: zone pivot="powershell"

```azurepowershell
Remove-AzManagementGroup -GroupName SecretRND
```

::: zone-end
