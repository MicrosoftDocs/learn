Changes continue with the deposits application. The team has decided to remove resources from the application. Some of the resources need to continue to exist in Azure, while others are safe to delete. You need to learn more about how Azure handles resources that are no longer managed by a deployment stack.

In this unit you learn how to use control how Azure handles resources detached from a deployment stack using the _action on unmanage_ parameter.

[!INCLUDE [Note - don't run commands](../../../includes/dont-run-commands.md)]

## Action on unmanage revisited

With deployment stacks, the _action on unmanage_ parameter is used to control how Azure handles detached resources, resource groups, and management groups. You can set the _action on unmanage_ parameter when creating, modifying, or deleting a deployment stack. All three operations have the ability to set the behavior of the _action on unmanage_ parameter. Keep in mind that the value set last takes precedence.

::: zone pivot="cli"

There are three possible values for the `--action-on-unmanage` parameter:

- `deleteAll` - deletes resources, resource groups, and management groups
- `deleteResources` - deletes resources, but detaches resource groups and management groups
- `detachAll` - detaches all resources, resource groups, and management groups

::: zone-end

::: zone pivot="powershell"

There are three possible values for the `-ActionOnUnmanage` parameter:

- `DeleteAll` - deletes resources, resource groups, and management groups
- `DeleteResources` - deletes resources, but detaches resource groups and management groups
- `DetachAll` - detaches all resources, resource groups, and management groups

::: zone-end

## Detach a managed resource

A detached resource, also known as a managed resource, is a resource that is no longer tracked or managed by a deployment stack, but the resource still exists in Azure. There are two values of the _action on unmanage_ parameter that set resources, resource groups, and management groups to detach when they are no longer managed by the deployment stack.

::: zone pivot="cli"

- `deleteResources` - deletes resources, but detaches resource groups and management groups
- `detachAll` - detaches all resources, resource groups, and management groups

Using either `deleteResources` or `detachAll` when creating, modifying, or deleting your deployment stacks offers some additional protection against accidental deletion. Consider our scenario from the last unit. We added an existing log analytics workspace to our deployment stack. The workspace is used by other applications, not just the deposits application. It needs to persist past the life of the application. By using `detachAll` as the _action on unmanage_ parameter we won't accidently delete a resource that needs to remain.

::: zone-end

::: zone pivot="powershell"

- `DeleteResources` - deletes resources, but detaches resource groups and management groups
- `DetachAll` - detaches all resources, resource groups, and management groups

Using either `DeleteResources` or `DetachAll` when creating, modifying, or deleting your deployment stacks offers some additional protection against accidental deletion. Consider our scenario from the last unit. We added an existing log analytics workspace to our deployment stack. The workspace is used by other applications, not just the deposits application. It needs to persist past the life of the application. By using `DetachAll` as the _action on unmanage_ parameter we won't accidently delete a resource that needs to remain.

::: zone-end

Let's consider our Bicep file from the last unit.

:::code language="bicep" source="code/1b-template.bicep" range="1-100":::

The template file defines an app service plan, a web app, an Azure SQL server and database, a log analytics workspace, and an application insights instance. Let's say that we need to remove the log analytics workspace and application insights instance we created in the last unit. We edit our Bicep file, removing the highlighted code that references our web app.

:::code language="bicep" source="code/1b-template.bicep" range="1-100" highlight="22-23,28-29,47-54,79-100":::

We are left with the following code in our file:

:::code language="bicep" source="code/1b-template.bicep" range="1-21,25-26,31-46,55-77":::

::: zone pivot="cli"

To apply the changes, we need to update the deployment stack. To update a deployment stack using Azure CLI, use the `az stack group create` command.

```azurecli
az stack group create \
    --name stack-deposits \
    --resource-group rg-depositsApplication \
    --template-file ./main.bicep \
    --action-on-unmanage detachAll \
    --deny-settings-mode none
```

> [!NOTE]
> Azure CLI does not have a dedicated command to update a deployment stack. Use the create command to update the stack.

When performing an update on the stack, you receive a message stating that the stack already exists in the current subscription. If the value of the _action on unmanage_ parameter changes, the warning alerts you of the new values.

After the update operation is complete, the log analytics workspace and application insights instance are no longer managed by the deployment stack. In our command, we used `--action-on-unmanage detachAll` to specify how Azure handles resources that are no longer managed by a deployment stack. In this case, the resources are detached from the deployment stack, but they still exist in the resource group.

::: zone-end

::: zone pivot="powershell"

To apply the changes, we need to update the deployment stack. To update a deployment stack using Azure PowerShell, use the `Set-AzResourceGroupDeploymentStack` command.

```azurepowershell
Set-AzResourceGroupDeploymentStack `
    -Name stack-deposits `
    -ResourceGroupName rg-depositsApplication `
    -TemplateFile ./main.bicep `
    -ActionOnUnmanage DetachAll `
    -DenySettingsMode None
```

After the update operation is complete, the log analytics workspace and application insights instance are no longer managed by the deployment stack. In our command, we used `-ActionOnUnmanage DetachAll` to specify how Azure handles resources that are no longer managed by a deployment stack. In this case, the resources are detached from the deployment stack, but they still exist in the resource group.

::: zone-end

## Delete a managed resource

Deployment stacks provide for reliable resource cleanup. When you update or delete a deployment stack, you can also delete the managed resources, resource groups, and management groups. There are two values of the _action on unmanage_ parameter that set resources, resource groups, and management groups to delete when they are no longer managed by the deployment stack.

::: zone pivot="cli"

- `deleteAll` - deletes resources, resource groups, and management groups
- `deleteResources` - deletes resources, but detaches resource groups and management groups

Consider our deposits application. Let's say that the development team has decided to use an Azure Database for PostgreSQL instead of Azure SQL Database. We need to first update our deployment stack to remove and fully delete the Azure SQL server and database from Azure. To accomplish this, use the `deleteAll` or `deleteResources` _action on unmanage_ parameter when updating or deleting the deployment stack.

::: zone-end

::: zone pivot="powershell"

- `DeleteAll` - deletes resources, resource groups, and management groups
- `DeleteResources` - deletes resources, but detaches resource groups and management groups

Consider our deposits application. Let's say that the development team has decided to use an Azure Database for PostgreSQL instead of Azure SQL Database. We need to first update our deployment stack to remove and fully delete the Azure SQL server and database from Azure. To accomplish this, use the `DeleteAll` or `DeleteResources` _action on unmanage_ parameter when updating or deleting the deployment stack.

::: zone-end

Let's consider our Bicep file from the previous section.

:::code language="bicep" source="code/1a-template.bicep" range="1-77":::

The template file defines an app service plan, a web app, and an Azure SQL server and database. Let's say that we need to remove the Azure SQL server and database. We edit our Bicep file, removing the highlighted code that references our web app.

:::code language="bicep" source="code/1a-template.bicep" range="1-63" highlight="5-16,44-63":::

We are left with the following code in our file:

:::code language="bicep" source="code/1a-template.bicep" range="1-4,18-42":::

::: zone pivot="cli"

To apply the changes, we need to update the deployment stack. To update a deployment stack using Azure CLI, use the `az stack group create` command. This time, we will use `--action-on-unmanage deleteAll` instead of `--action-on-unmanage detachAll`

```azurecli
az stack group create \
    --name stack-deposits \
    --resource-group rg-depositsApplication \
    --template-file ./main.bicep \
    --action-on-unmanage deleteAll \
    --deny-settings-mode none
```

> [!NOTE]
> Azure CLI does not have a dedicated command to update a deployment stack. Use the create command to update the stack.

When performing an update on the stack, you receive a message stating that the stack already exists in the current subscription. If the value of the _action on unmanage_ parameter changes, the warning alerts you of the new values.

After the update operation is complete, the only resources that remain are the app service plan and web app. In our command, we used `--action-on-unmanage deleteAll` to specify how Azure handles resources that are no longer managed by a deployment stack. In this case, the resources are deleted from the deployment stack and from Azure.

::: zone-end

::: zone pivot="powershell"

To apply the changes, we need to update the deployment stack. To update a deployment stack using Azure PowerShell, use the `Set-AzResourceGroupDeploymentStack` command.

```azurepowershell
Set-AzResourceGroupDeploymentStack `
    -Name stack-deposits `
    -ResourceGroupName rg-depositsApplication `
    -TemplateFile ./main.bicep `
    -ActionOnUnmanage DeleteAll `
    -DenySettingsMode None
```

After the update operation is complete, the only resources that remain are the app service plan and web app. In our command, we used `-ActionOnUnmanage DeleteAll` to specify how Azure handles resources that are no longer managed by a deployment stack. In this case, the resources are deleted from the deployment stack and from Azure.

::: zone-end
