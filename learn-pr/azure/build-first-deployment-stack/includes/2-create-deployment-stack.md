An Azure deployment stack is a collection of Azure resources that can be managed as a single unit even if they span multiple resource groups or subscriptions.

You are planning for the deployment of the test version of the new deposits application. You need to learn more about how to create a deployment stack and verify its managed resources.

In this unit, you learn how to create a deployment stack, verify its deployment, and list all deployment stacks in your environment.

[!INCLUDE [Note - don't run commands](../../../includes/dont-run-commands.md)]

## Deployment stacks revisited

Deployment stacks change how you think about resource organization across resource groups and subscriptions. A deployment stack allows you to group all the resources that make up your application, regardless of where they're in your Azure resource organizational hierarchy. You can manage them as a single unit. With deployment stacks, you're able to perform lifecycle operations on the collection of resources that make up the stack.

![a graphic representing an application managed by a resource group scoped deployment stack](../media/depolyment-stack-resource-group-scope.png)

Think of deployment stacks as a series of pointers that groups your application's resources into a single unit. Deployment stacks can be created at different scopes, such as resource groups, subscriptions, and management groups.

## Define resources

Deployment stacks support the use of Bicep files, ARM JSON templates, or template specs for defining resources in a stack. When deploying a deployment stack using the Azure CLI or Azure PowerShell, you're able to point to the specific template file (bicep file or ARM JSON template) or template spec. It isn't necessary to change how you define your resources.

We'll use the following bicep file for our first deployment stack. The file defines an app service plan and a web app. These resources become managed resources when we create the deployment stack.

:::code language="bicep" source="code/1-template.bicep" range="1-4, 18-42":::

> [!NOTE]
> You may notice the `${uniqueString(resourceGroup().id)}` syntax on the `webApplicationName` parameter. The uniqueString function creates a string based on the id of the resource group and adds it as a suffix to `webapp-deposits`. Many Azure services require unique names. This function helps generate a unique name.

## Creating a deployment stack

Creating and deploying a deployment stack and its resources is nearly identical to a standard Azure deployment. Whether you are using AZ CLI, Azure PowerShell, or an infrastructure as code pipeline, the process feels the same. For example:

The AZ CLI command to deploy a bicep file to a resource group is:

```azurecli
az deployment group create \
    --resource-group rg-depositsApplication \
    --template-file ./main.bicep
```

The AZ CLI command to create a deployment stack at the resource group scope is:

```azurecli
az stack group create \
    --name stack-deposits \
    --resource-group rg-depositsApplication \
    --template-file ./main.bicep
```

Notice that the only changes in the command are the words `deployment` and `stack`, and there's a small difference in the parameters used. The same is true for deployments to subscriptions and management groups. In later modules, we explore how to manage resources in a deployment stack and how to configure deny settings.

Lets take a look at creating a deployment stack at the resource group scope.

::: zone pivot="cli"

To create a deployment stack using AZ CLI, use the `az stack group create` command. The following commands first create a resource group called `rg-depositsApplication` then creates the deployment stack at the scope of the resource group.

```azurecli
az group create \
    --name rg-depositsApplication \
    --location eastus

az stack group create \
    --name stack-deposits \
    --resource-group rg-depositsApplication \
    --template-file ./main.bicep
    --deny-settings-mode none
```

::: zone-end

::: zone pivot="powershell"

To create a deployment stack using Azure PowerShell, use the `New-AzResourceGroupDeploymentStack` command. The following commands first create a resource group called `rg-depositsApplication` then creates the deployment stack at the scope of the resource group.

```azurepowershell
New-AzResourceGroup `
    -Name rg-depositsApplication `
    -Location eastus

New-AzResourceGroupDeploymentStack `
    -Name stack-deposits `
    -ResourceGroupName rg-depositsApplication `
    -TemplateFile ./main.bicep
    -DenySettingsMode none
```

::: zone-end

## Showing deployment stacks

Resource groups may have multiple deployment stacks scoped to them. You can show details about a specific deployment stack scoped to a resource group.

::: zone pivot="cli"

To show a specific deployment stack resource scoped to a resource group using AZ CLI, use the `az stack group show` command, specifying the name of the deployment stack and the target resource group.

```azurecli
az stack group show \
    --resource-group rg-depositsApplication
    --name stack-deposits
```

The results include the properties of the deployment stack and the status of the managed resources. The output should appear familiar to the following section:

:::code language="json" source="code/2-json.json" range="1-39, 52-77":::

Take notice of the resources section of the output. For each resource, it shows its status as `managed`, its resource group, its resource id, and its deny settings.

::: zone-end

::: zone pivot="powershell"

To show a specific deployment stack resource scoped to a resource group using Azure PowerShell, use the `Get-AzResourceGroupDeploymentStack` command, specifying the name of the deployment stack and the target resource group.

```azurepowershell
Get-AzResourceGroupDeploymentStack \
    -ResourceGroupName rg-depositsApplication
    -Name stack-deposits
```

The results include the properties of the deployment stack and the status of the managed resources. The output should appear familiar to the following section:

```azurepowershell
Id                          : /subscriptions/.../deploymentStacks/stack-deposits
Name                        : stack-deposits
ProvisioningState           : succeeded
ResourcesCleanupAction      : detach
ResourceGroupsCleanupAction : detach
DenySettingsMode            : none
CreationTime(UTC)           : 1/01/2024 00:00:00 AM
DeploymentId                : /subscriptions/.../deployments/stack-deposits-24051017g2k8i
Resources                   : /subscriptions/.../serverfarms/plan-deposits
                              /subscriptions/.../sites/webapp-brpdm7iotbwjm
```

Take notice of the resources section of the output. it defines the resources managed by the deployment stack. You see the full resource ID of each resource.

::: zone-end

You can also view deployment stacks in the Azure portal. They're available at their respective scopes. For a resource group, navigate to the resource group where the deployment stack is scoped. Under settings, you see an option for deployment stacks.

![a graphic representing the properties of a resource group and where to find deployment stacks](../media/rg-deployment-stack-portal-1.png)

When you click on deployment stacks, it lists any stacks scoped to the resource group. Clicking on a deployment stack takes you to the property page of the deployment stacks.

![a graphic representing the properties of a deployment stack, including its managed resources](../media/rg-deployment-stack-portal-2.png)

## Listing deployment stacks

You can also list all deployment stacks scoped to a specific resource group.

::: zone pivot="cli"

To list all deployment stack resources scoped to a resource group using AZ CLI, use the `az stack group list` command, specifying the target resource group.

```azurecli
az stack group list \
    --resource-group rg-depositsApplication
```

::: zone-end

::: zone pivot="powershell"

To list all deployment stack resources scoped to a resource group using Azure PowerShell, use the `Get-AzResourceGroupDeploymentStack` command, specifying the target resource group.

```azurepowershell
Get-AzResourceGroupDeploymentStack `
    -ResourceGroupName rg-depositsApplication
```

> [!NOTE]
> Azure PowerShell uses the same command, `Get-AzResourceGroupDeploymentStack` for both the show and list operations.

::: zone-end
