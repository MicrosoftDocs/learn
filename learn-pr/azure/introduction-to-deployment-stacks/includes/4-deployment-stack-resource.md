You've developed an understanding of deployment stacks and the benefits it provides for lifecycle management. Before you begin the process of building deployment stacks for your deployments, you want to learn more about the deployment stack resource.

In this unit, you review the core concepts of Azure Resource Manager and learn about the deployment stacks resource.

## Azure Resource Manager concepts

Azure Resource Manager (ARM) is the service that deploys and manages resources in Azure. You can use Resource Manager to create, update, and delete resources in your Azure subscription. You can interact with Resource Manager by using many tools, including the Azure portal, Azure CLI, Azure PowerShell, and the Azure SDK.

### Terminology

As you begin to work with deployment stacks, it's important to understand some terms and concepts:

- **Resource** - A manageable item that is available on the Azure platform. For example, a virtual network.
- **Resource group** - A logical container that holds related resources for an Azure solution.
- **Subscription** - A logical container and billing boundary for your resources and resource groups.
- **Management group** - A logical container that you use to manage more than one subscription. You can define a hierarchy of management groups, subscriptions, resource groups, and resources.
- **Resource provider** - A resource provider is a collection of REST operations that enable features for a particular Azure service. For example, the Azure SQL Database service consists of a resource provider named `Microsoft.Sql` and its full resource type is `Microsoft.Sql/servers/databases`.

## The deployment stacks resource

A deployment stack is a navite Azure resource, which allows for typical ARM operations to be performed on the stack.  A deployment stack can inherit an Azure policy assignment, and Azure role-based access control (RBAC) (RBAC) assignment, or even a Microsoft Defender for Cloud security recommendation. Within a deployment stack are pointers to all of the resources, resource groups, and management groups that are managed by the stack.

Deployment stacks are part of the `Microsoft.Resources` resource provider and its full resource type is `Microsoft.Resources/deploymentStacks`. Its REST operations include creating a new stack, listing a stack, updating an existing stack, or deleting a stack. For it's resources, you're able the view the resources in the stack, add and remove resources, and protect resources from deletion.

Each of these operations has a few key properties that control the behavior of the stack.

### Deny settings options

Deny settings are a specific type of permission that are assigned to a deployment stack and it's managed resources. These deny settings supersede any Azure role-based access control (RBAC) permissions that may be in place. Options for deny settings include applying deny settings to child scopes, excluding specific RBAC roles, and excluding specific principal IDs.

::: zone pivot="cli"

The following Azure CLI parameters are used to customize the deny settings:

- The `deny-settings-mode` parameter defines which operations are denies on resources managed by the stack. There are three allowed values: `denyDelete`, `denyWriteAndDelete`, and `none`.
- The `deny-settings-apply-to-child-scopes` parameter applies the deny settings mode to child scopes and nested resources.
- The `deny-settings-excluded-actions` parameter defines a list of role-based access control operations excluded from the deny settings mode.
- The d`eny-settings-excluded-principals` parameter defines a list of Microsoft Entra ID principal IDs excluded from the deny settings mode.

Here's an example of an AZ CLI command with deny settings on a deployment stack scoped to a resource group.

```azurecli
az stack group create \
    --name '<deployment-stack-name>' \
    --resource-group '<resource-group-name>' \
    --template-file '<bicep-file-name>' \
    --deny-settings-mode 'denyDelete' \
    --deny-settings-excluded-actions 'Microsoft.Compute/virtualMachines/write Microsoft.StorageAccounts/delete' \
    --deny-settings-excluded-principals '<object-id> <object-id>'
```

::: zone-end

::: zone pivot="powershell"

The following Azure PowerShell parameters are used to customize the deny settings:

- The `DenySettingsMode` parameter defines which operations are denies on resources managed by the stack. There are three allowed values: `DenyDelete`, `DenyWriteAndDelete`, and `None`.
- The `DenySettingsApplyToChildScopes` parameter applies the deny settings mode to child scopes and nested resources.
- The `DenySettingsExcludedAction` parameter defines a list of role-based access control operations excluded by the deny settings mode.
- The `DenySettingsExcludedPrincipal` parameter defines a list of Microsoft Entra ID principal IDs excluded from the deny settings mode.

Here's an example of an Azure PowerShell command with deny settings on a deployment stack scoped to a resource group.

```azurepowershell
New-AzResourceGroupDeploymentStack `
    -Name "<deployment-stack-name>" `
    -ResourceGroupName "<resource-group-name>" `
    -TemplateFile "<bicep-file-name>" `
    -DenySettingsMode "DenyDelete" `
    -DenySettingsExcludedAction "Microsoft.Compute/virtualMachines/write Microsoft.StorageAccounts/delete" `
    -DenySettingsExcludedPrincipal "<object-id> <object-id>"
```

::: zone-end

### Resource detachment and deletion

A resource that is no longer managed by a deployment stack and still exists within Azure, is known as a detached resource. You can use the `actionOnUnmanage` property to determine how Azure handles detached resources, resource groups, and management groups. This property can be defined in either a deployment stack create or delete operation.

::: zone pivot="cli"

The following Azure CLI parameters are used to customize the `actionOnUnmange` property:

- The `--actionOnUnmanage DeleteResources` parameter deletes resources and detaches resource groups and management groups.
- The `--actionOnUnmanage DeleteAll` parameter deletes resources, resource groups, and management groups.
- The `--actionOnUnmanage DetachAll` parameter detaches resources, resource groups, and management groups.

Here's an example of an AZ CLI command with `actionOnUnmanage` on a deployment stack scoped to a resource group.

```azurecli
az stack group create \
    --name '<deployment-stack-name>' \
    --resource-group '<resource-group-name>' \
    --template-file '<bicep-file-name>' \
    --actionOnUnmanage DeleteResources
```

::: zone-end

::: zone pivot="powershell"

The following Azure PowerShell parameters are used to customize the `actionOnUnmange` property:

- The `-ActionOnUnmanage DeleteResources` parameter deletes resources and detaches resource groups and management groups.
- The `-ActionOnUnmanage DeleteAll` parameter deletes resources, resource groups, and management groups.
- The `-ActionOnUnmanage DetachAll` parameter detaches resources, resource groups, and management groups.

Here's an example of an Azure PowerShell command with `actionOnUnmanage` on a deployment stack scoped to a resource group.

```azurepowershell
New-AzResourceGroupDeploymentStack `
    -Name "<deployment-stack-name>" `
    -ResourceGroupName "<resource-group-name>" `
    -TemplateFile "<bicep-file-name>" `
    -ActionOnUnmanage DeleteResources
```

::: zone-end
