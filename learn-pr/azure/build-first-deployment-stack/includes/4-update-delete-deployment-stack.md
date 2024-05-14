Insert text here.

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

Let's take a look at the json output when using the AZ CLI `az stack group show` command with values set for the `--action-on-unmanage` parameter. Notice the set behavior for resources, resource groups, and management groups.

1. `--action-on-unmanage deleteAll`

    ```json
    "actionOnUnmanage": {
        "managementGroups": "delete",
        "resourceGroups": "delete",
        "resources": "delete"
    },
    ```

1. `--action-on-unmanage deleteResources`

    ```json
    "actionOnUnmanage": {
        "managementGroups": "detach",
        "resourceGroups": "detach",
        "resources": "delete"
    },
    ```

1. `--action-on-unmanage detachAll`

```json
"actionOnUnmanage": {
    "managementGroups": "detach",
    "resourceGroups": "detach",
    "resources": "detach"
},
```

In the next module, you work on managing resource lifecycles, including the _action on unmanage_ parameter.

## Updating a deployment stack

As an application evolves, so does its resources. How do we update a deployment stack and its managed resources when new services and features are added? Updating a deployment stack and its resources includes different activites related to its resources, including:

- Adding a new managed resource
- Adding an existing resource
- Adding, removing, or modifying a property of a managed resource
- Detaching a managed resource
- Deleting a managed resource

To update a deployment stack, make the appropriate changes to the template file used to define your resources.

After making the appropriate changes to the template file used 

::: zone pivot="cli"

To update a deployment stack using AZ CLI, use the `az stack group create` command.

```azurecli
az stack group create \
    --name stack-deposits \
    --resource-group rg-depositsApplication \
    --template-file ./main.bicep \
    --deny-settings-mode none
```

> [!NOTE]
> AZ CLI does not have a dedicated command to update a deployment stack. Use the create command to update the stack.

::: zone-end

::: zone pivot="powershell"

To update a deployment stack using Azure PowerShell, use the `Set-AzResourceGroupDeploymentStack` command.

```azurepowershell
Set-AzResourceGroupDeploymentStack `
    -Name stack-deposits `
    -ResourceGroupName rg-depositsApplication `
    -TemplateFile ./main.bicep `
    -DenySettingsMode none
```

::: zone-end

## Deleting a deployment stack

Insert text here.

If a resource no longer needs to be managed by the deployment stack, you can modify the stack to no longer include the resource. The action on unmanage behavior of a deployment stack determines what happens to a resource that is removed from the deployment stack's definition. This behavior, discussed later in the unit, determines if a resource, resource group, or management groups is detached or deleted from the stack.

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

