TODO: Insert text here.

In this unit, you learn how to update a deployment stack by adding resources to your Bicep file. Additionaly, you learn how to delete a deployment stack and its managed resources.

[!INCLUDE [Note - don't run commands](../../../includes/dont-run-commands.md)]

## Managed resources revisited

When you create a deployment stack, the stack becomes responsible for the management of the resources described in the Bicep file, ARM JSON template, or template spec. Resources managed by the stack are known as managed resources, but those resources are still modified through the original template files.

![a graphic representing a deployment stack and managed resources](../media/deployment-stacks-scenario-2-and-5.png)

In the graphice above, the deposits deployment stack is managing 5 resources.

What happens to a resource that is no longer managed by the deployment stack? If a resource is no longer defined in a template file and the stack is updated, the resource can become detached or deleted. A detached resource is a resource that is no longer managed by the stack, but the resource continues to exist within Azure. A deleted resource is a resource that is no longer managed by the stack, and has been deleted from Azure.

You're able to control how Azure handles detached resources, resource groups, and management groups with a property known as the _action on unmanage_ parameter. The action on unmanage parameter can be set when creating, modifying, or deleting a deployment stack. All three operations have the ability to set the behavior of the _action on unmanage_ parameter. Keep in mind that the value set last takes precedence. There are three possible values for _action on unmanage_:

- Delete all - deletes resources, resource groups, and management groups
- Delete resources - deletes resources, but detaches resource groups and management groups
- Detach all - detaches all resources, resource groups, and management groups

In the next module, you work on managing resource lifecycles, including the _action on unmanage_ parameter.

## Updating a deployment stack

As an application evolves, so does its resources. How do we update a deployment stack and its managed resources when new services and features are added? What situations require us to update a deployment stack? Adding a new resource or changing the property of an existing managed resource would require that we update the deployment stack.

Let's say that our deposits application needs to add a new Azure SQL database, and we want the database to be managed by the deployment stack. To accomplish this, we update our Bicep file to define our new Azure SQL database.

:::code language="bicep" source="code/1-template.bicep" range="1-63" highlight="5-16, 44-63":::

The highlighted code defines our new Azure SQL database for our deposits application. With our new resource defined, we need to update the deployment stack.

::: zone pivot="cli"

To update a deployment stack using AZ CLI, use the `az stack group create` command.

```azurecli
az stack group create \
    --name stack-deposits \
    --resource-group rg-depositsApplication \
    --template-file ./main.bicep \
    --action-on-unmanage deleteAll \
    --deny-settings-mode none
```

> [!NOTE]
> AZ CLI does not have a dedicated command to update a deployment stack. Use the create command to update the stack.

When performing an update on the stack, you receive a message stating that the stack already exists in the current subscription. If the value of the _action on unmanage_ parameter has changed, the warning alerts you of the new values.

![a graphic representing an AZ CLI warning that the deployment stack already exists](../media/stack-exists-cli.png)

To verify that the new resources are managed by the stack, use the `az stack group show` command.

```azurecli
az stack group show \
    --resource-group rg-depositsApplication
    --name stack-deposits
```

:::code language="json" source="code/2-json.json" range="1-77" highlight="40-51":::

The highlighted code shows the new Azure SQL server and Azure SQL database as managed by the deployment stack.

::: zone-end

::: zone pivot="powershell"

To update a deployment stack using Azure PowerShell, use the `Set-AzResourceGroupDeploymentStack` command.

```azurepowershell
Set-AzResourceGroupDeploymentStack `
    -Name stack-deposits `
    -ResourceGroupName rg-depositsApplication `
    -TemplateFile ./main.bicep `
    -ActionOnUnmanage DeleteAll `
    -DenySettingsMode None
```

To verify that the new resources are managed by the stack, use the ``Get-AzResourceGroupDeploymentStack`` command.

```azurepowershell
Get-AzResourceGroupDeploymentStack `
    -ResourceGroupName rg-depositsApplication `
    -Name stack-deposits
```

:::code language="json" source="code/3-powershell.ps1" range="1-17" highlight="11-12":::

The highlighted code shows the new Azure SQL server and Azure SQL database as managed by the deployment stack.

::: zone-end

In the next module, you work on managing resource lifecycles, including adding, updating, detaching, and deleting managed resources.

## Deleting a deployment stack

TODO: Insert text here.

TODO: If you change the action on unmanage parameter, it will take precedence.

::: zone pivot="cli"

To delete a deployment stack using AZ CLI, use the `az stack group delete` command. The `--action-on-unmanaged` argument determines how Azure handles detached resources, resource groups, and management groups.

```azurecli
az stack group delete \
    --name stack-deposits \
    --resource-group rg-depositsApplication \
    --action-on-unmanage deleteAll
```

::: zone-end

::: zone pivot="powershell"

To delete a deployment stack using Azure PowerShell, use the `Remove-AzResourceGroupDeploymentStack` command. The `-ActionOnUnmanage` argument determines how Azure handles detached resources, resource groups, and management groups.

```azurepowershell
Remove-AzResourceGroupDeploymentStack `
    -Name stack-deposits `
    -ResourceGroupName rg-depositsApplication `
    -ActionOnUnmanage -DeleteAll
```

::: zone-end
