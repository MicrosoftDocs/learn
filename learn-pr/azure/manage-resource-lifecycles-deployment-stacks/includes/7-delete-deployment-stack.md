You are nearing the end of sprint 3 for the new deposits application. You recently learned about how to detach and delete resources from a deployment stack. As you plan for the next sprint, you want to learn about how to delete a deployment stack and what that means for your managed and unmanaged resources.

In this unit, you learn about deleting deployment stacks.

[!INCLUDE [Note - don't run commands](../../../includes/dont-run-commands.md)]

## Delete a deployment stack

A deployment stack is a native Azure resource that acts as a series of pointers to the resources that the stack manages. The resources, also known as managed resources, are defined in a Bicep file, ARM JSON template, or template spec.

When a deployment stack is no longer needed, you can delete it. But, why delete a deployment stack? Maybe you are deploying a new version of the application and need to removed the previous version. Maybe you are working in an ephemeral environment and use deployment stacks to deploy and tear down the environment in a single command.

As discussed in the intro module, one of the benefits of deployment stacks is reliable resource cleanup. Deployment stacks allow you to delete the stack and all of its managed resources through a single API call, without needing to understand dependencies. This single operation removes the resources in a reliable way, and improves the speed of removal.

What happens to the stack's resources when it is deleted? As with the deployment stack create and update commands, the value of the _action on unmanage_ parameter determines what happens to the stack's resources.

Consider the deposits application. In the last unit, we initially detached resources using a deployment stack update command and the `detach all` value of the _action on unmanage_ parameter. Then we deleted the detached resources using the `delete all` value. We were left with the original app service plan and app service as managed resources. We can use a deployment stack delete command to delete the stack and the remaining managed resources. If the `detach all` value of the _action on unmanage_ parameter is used when deleting the stack, then the app service plan and app service will detach and remain in the resource group. If the `delete all` value is used, then the resources are deleted along with the stack.

> [!NOTE]
> When working with resource group scoped deployment stacks, the `delete all` value for the _action on unmanage_ parameter doesn't detele the detached resources or the resource group where the stack exists. If you want to remove the detached resources and resource group, they must manually be deleted.

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
