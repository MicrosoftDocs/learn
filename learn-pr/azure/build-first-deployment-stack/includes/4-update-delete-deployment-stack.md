Deployment stacks enable you to manage your Azure resources using standard processes and templates. As your application changes, so does the resources that make up the application. Adding and removing managed resources is a critical part of lifecycle management.

You completed sprint 1 and the initial deployment of the deposits application using deployment stacks. Now, you need to prepare for sprint 2 introduces new services to the application. You want to learn more about how to update and delete deployment stacks and managed resources.

In this unit, you learn how to update a deployment stack by adding resources to your Bicep file. Additionally, you learn how to delete a deployment stack and its managed resources.

[!INCLUDE [Note - don't run commands](../../../includes/dont-run-commands.md)]

## Updating a deployment stack

As an application evolves, so does its resources. How do we update a deployment stack and its managed resources when new services and features are added? What situations require us to update a deployment stack? Adding a new resource or changing the property of an existing managed resource would require that we update the deployment stack.

Updating a stack means updating the resources defined in our ARM JSON template, Bicep file, or template spec. Once the change is made to the template file, we update the deployment stack using the appropriate command.

Let's say that our deposits application needs to add a new Azure SQL database, and we want the deployment stack to manage the database. To add the new database, we update our Bicep file to define a new Azure SQL server and database.

:::code language="bicep" source="code/1-template.bicep" range="1-63" highlight="5-16, 44-63":::

The highlighted code defines our new Azure SQL database for our deposits application. With our new resource defined, we need to update the deployment stack.

::: zone pivot="cli"

To update a deployment stack using Azure CLI, use the `az stack group create` command.

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

:::image type="content" source="../media/stack-exists-cli.png" alt-text="{a graphic representing an Azure CLI command line warning that the deployment stack already exists}":::

To verify that the stack is managing the new resources, use the `az stack group show` command.

```azurecli
az stack group show \
    --resource-group rg-depositsApplication
    --name stack-deposits
```

:::code language="json" source="code/2-json.json" range="1-81" highlight="44-55":::

The highlighted code shows the new Azure SQL server and Azure SQL database as managed by the deployment stack.

::: zone-end

::: zone pivot="powershell"

To update a deployment stack using Azure PowerShell, use the `Set-AzResourceGroupDeploymentStack` command.

```azurepowershell
Set-AzResourceGroupDeploymentStack `
    -Name stack-deposits `
    -ResourceGroupName rg-depositsApplication `
    -TemplateFile ./main.bicep `
    -ActionOnUnmanage DetachAll `
    -DenySettingsMode None
```

To verify that the stack is managing the new resources, use the ``Get-AzResourceGroupDeploymentStack`` command.

```azurepowershell
Get-AzResourceGroupDeploymentStack `
    -ResourceGroupName rg-depositsApplication `
    -Name stack-deposits
```

:::code language="json" source="code/3-powershell.ps1" range="1-19" highlight="13-14":::

The highlighted code shows the new Azure SQL server and Azure SQL database as managed by the deployment stack.

::: zone-end

In the next module, you work on managing resource lifecycles, including adding, updating, detaching, and deleting managed resources.

## Deleting a deployment stack

Reliable resource cleanup is a key feature of deployment stacks. When you delete a deployment stack, you can also delete the managed resources, resource groups, and management groups. Using a single API call eliminates the need to understand dependencies. As with creating and updating deployment stacks, the _action on unmanage_ parameter determines how Azure handles detached resources.

> [!NOTE]
> In this module, we are working with resrouce group scoped deployment stacks. In this situation, the resource group is not managed by the stack. The 'delete all' value for the _action on unmanage_ parameter doesn't detele the resource group where the stack exists. It is necessary to delete the resource group after the stack and its resources are deleted.

::: zone pivot="cli"

To delete a deployment stack using Azure CLI, use the `az stack group delete` command. The `--action-on-unmanaged` argument determines how Azure handles detached resources, resource groups, and management groups.

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
