You are nearing the end of sprint 3 for the new deposits application. You recently learned about how to detach and delete resources from a deployment stack. As you plan for the next sprint, you want to learn about how to delete a deployment stack and what that means for your managed and unmanaged resources.

In this unit, you learn about deleting deployment stacks.

[!INCLUDE [Note - don't run commands](../../../includes/dont-run-commands.md)]

## Delete a deployment stack

A deployment stack is a native Azure resource that acts as a series of pointers to the resources that the stack manages. The resources, also known as managed resources, are defined in a Bicep file, ARM JSON template, or template spec.

When a deployment stack is no longer needed, you can delete it. But, why delete a deployment stack? Maybe you're working in an ephemeral environment and use deployment stacks to deploy and tear down the environment in a single command. Maybe you're deploying a new version of the application and need to remove the previous version.

As discussed in the intro module, one of the benefits of deployment stacks is reliable resource cleanup. Deployment stacks allow you to delete the stack and all of its managed resources through a single API call, without needing to understand the dependencies between resources within the stack. This single deletion operation removes the resources in a reliable way, and improves the speed of removal. Resources in the stack are deleted from wherever they are, even if they span multiple resource groups or subscriptions.

What happens to the stack's resources when it's deleted? As with the deployment stack create and update commands, the value of the _action on unmanage_ parameter determines what happens to the stack's resources. This parameter's value can be set when creating, modifying, or deleting a deployment stack. All three operations have the ability to set the behavior of the action on unmanage parameter. Keep in mind that the value set most recently takes precedence.

Consider the deposits application. In the previous unit, we removed some resources from our Bicep files, then we updated the deployment stack to use the revised Bicep file. This action had the consequence of removing some of our resources. Now, we can delete the whole stack, which removes all of the resources that the stack manages.

Typically, when deleting a deployment stack, you set the _action on unmanage_ parameter to `delete all`, which deletes the resources. But sometimes, you want to delete the stack without deleting the resources. Maybe you no longer need the features that deployment stacks offer, but the resources need to remain. Or, you're moving a resource from one stack to another. To detach the resources, set the _action on unmanage_ parameter to `detach all` instead.

> [!NOTE]
> When working with resource group scoped deployment stacks, the `delete all` value for the _action on unmanage_ parameter doesn't detele the detached resources or the resource group where the stack exists. If you want to remove the detached resources and resource group, they must manually be deleted.

::: zone pivot="cli"

To delete a deployment stack using Azure CLI, use the `az stack group delete` command.

```azurecli
az stack group delete \
    --name stack-deposits \
    --resource-group rg-depositsApplication \
    --action-on-unmanage deleteAll
```

::: zone-end

::: zone pivot="powershell"

To delete a deployment stack using Azure PowerShell, use the `Remove-AzResourceGroupDeploymentStack` command.

```azurepowershell
Remove-AzResourceGroupDeploymentStack `
    -Name stack-deposits `
    -ResourceGroupName rg-depositsApplication `
    -ActionOnUnmanage -DeleteAll
```

::: zone-end
