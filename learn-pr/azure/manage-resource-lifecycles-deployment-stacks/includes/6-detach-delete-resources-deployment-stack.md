Changes continue with the deposits application. The team decided to remove resources from the application. Some of the resources need to continue to exist in Azure, while others are safe to delete. You need to learn more about how Azure handles resources that a deployment stack no longer manages.

In this unit, you learn how to use control how Azure handles resources detached from a deployment stack using the _action on unmanage_ parameter.

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

A detached resource, also known as an unmanaged resource, is a resource that is no longer tracked or managed by a deployment stack, but the resource still exists in Azure. The default behavior of deployment stacks is to detach resources rather than delete. For example, you might need to keep the resource so that you can use it in another deployment stack in the future, or you might need to manually verify that its data is safe to delete. 

There are two values of the _action on unmanage_ parameter that set resources, resource groups, and management groups to detach when the deployment stack no longer manages them.

::: zone pivot="cli"
Deployment stacks can't delete Key vault secrets. If you're removing key vault secrets from a template, make sure to also execute the deployment stack update/delete command with detach mode.
- `deleteResources` - deletes resources, but detaches resource groups and management groups
- `detachAll` - detaches all resources, resource groups, and management groups

Using either `deleteResources` or `detachAll` when creating, modifying, or deleting your deployment stacks offers some additional protection against accidental deletion. Consider our scenario from the last unit. We added an existing Log Analytics workspace to our deployment stack. The workspace is used by other applications, not just the deposits application. It needs to persist past the life of the application. By using `detachAll` as the _action on unmanage_ parameter, needed resources continue to exist in Azure.

::: zone-end

::: zone pivot="powershell"

- `DeleteResources` - deletes resources, but detaches resource groups and management groups
- `DetachAll` - detaches all resources, resource groups, and management groups

Using either `DeleteResources` or `DetachAll` when creating, modifying, or deleting your deployment stacks offers some additional protection against accidental deletion. Consider our scenario from the last unit. We added an existing Log Analytics workspace to our deployment stack. The workspace is used by other applications, not just the deposits application. It needs to persist past the life of the application. By using `DetachAll` as the _action on unmanage_ parameter, needed resources continue to exist in Azure.

::: zone-end

Let's consider our Bicep file from the last unit. The template file defines an app service plan, a web app, an Azure SQL server and database, a Log Analytics workspace, and an Application Insights instance. Let's say that we need to remove the Log Analytics workspace and Application Insights instance we created in the last unit. We edit our Bicep file, removing the highlighted code that references our web app.

:::code language="bicep" source="code/1b-template.bicep" range="1-100" highlight="22-23,28-29,47-54,79-100":::

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

After the update operation is complete, the deployment stack no longer manages the Log Analytics workspace and Application Insights instance. In our command, we used `--action-on-unmanage detachAll` to specify how Azure handles resources that a deployment stack no longer manages. In this case, the resources are detached from the deployment stack, but they still exist in the resource group.

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

After the update operation is complete, the deployment stack no longer manages the Log Analytics workspace and Application Insights instance. In our command, we used `-ActionOnUnmanage DetachAll` to specify how Azure handles resources that a deployment stack no longer manages. In this case, the resources are detached from the deployment stack, but they still exist in the resource group.

::: zone-end

## Delete a managed resource

Deployment stacks provide for reliable resource cleanup. When you update or delete a deployment stack, you can also delete the managed resources, resource groups, and management groups. There are two values of the _action on unmanage_ parameter that set resources, resource groups, and management groups to delete when the deployment stack no longer manages them.

::: zone pivot="cli"

- `deleteAll` - deletes resources, resource groups, and management groups
- `deleteResources` - deletes resources, but detaches resource groups and management groups

Consider our deposits application. Let's say that the development team decides to use an Azure Database for PostgreSQL instead of Azure SQL Database. We need to first update our deployment stack to remove and fully delete the Azure SQL server and database from Azure. To accomplish this behavior, use the `deleteAll` or `deleteResources` _action on unmanage_ parameter when updating or deleting the deployment stack.

::: zone-end

::: zone pivot="powershell"

- `DeleteAll` - deletes resources, resource groups, and management groups
- `DeleteResources` - deletes resources, but detaches resource groups and management groups

Consider our deposits application. Let's say that the development team decides to use an Azure Database for PostgreSQL instead of Azure SQL Database. We need to first update our deployment stack to remove and fully delete the Azure SQL server and database from Azure. To accomplish this behavior, use the `DeleteAll` or `DeleteResources` _action on unmanage_ parameter when updating or deleting the deployment stack.

::: zone-end

Let's consider our Bicep file from the previous section. The template file defines an app service plan, a web app, and an Azure SQL server and database. Let's say that we need to remove the Azure SQL server and database. We edit our Bicep file, removing the highlighted code that references our web app.

:::code language="bicep" source="code/1a-template.bicep" range="1-63" highlight="5-16,44-63":::

We're left with the following code in our file:

:::code language="bicep" source="code/1a-template.bicep" range="1-4,18-42":::

::: zone pivot="cli"

To apply the changes, we need to update the deployment stack. To update a deployment stack using Azure CLI, use the `az stack group create` command. This time, we use `--action-on-unmanage deleteAll` instead of `--action-on-unmanage detachAll`

```azurecli
az stack group create \
    --name stack-deposits \
    --resource-group rg-depositsApplication \
    --template-file ./main.bicep \
    --action-on-unmanage deleteAll \
    --deny-settings-mode none
```

After the update operation is complete, the only resources that remain are the app service plan and web app. In our command, we used `--action-on-unmanage deleteAll` to specify how Azure handles resources that the deployment stack no longer manages. In this case, the resources are deleted from the deployment stack and from Azure.

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

After the update operation is complete, the only resources that remain are the app service plan and web app. In our command, we used `-ActionOnUnmanage DeleteAll` to specify how Azure handles resources that the deployment stack no longer manages. In this case, the resources are deleted from the deployment stack and from Azure.

::: zone-end
