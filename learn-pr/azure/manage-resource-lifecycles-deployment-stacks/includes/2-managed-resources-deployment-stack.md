Azure resources managed by a deployment stack are called _managed resources_. The resources are defined in the template file used in the creation of the stack.

As you prepare for the next sprint for the deposits application, you want to know more about how a deployment stack manages resources. You're expecting rapid and frequent changes to the application as features are tested in development. Before you add, modify, or delete resources from the application, you need to know how these resources are managed.

In this unit, you learn about managed resources and the _action on unmanage_ parameter. This parameter determines how Azure handles resources that the deployment stack no longer manages.

## Understand managed resources

Before we get into updating deployment stacks, let's take a look at how a stack manages resources. When you create a deployment stack, the stack becomes responsible for managing the resources described in the template file. These resources are known as managed resources. As long as a resource is defined in a deployment stack's template file, it's considered a managed resource. Think of deployment stacks as a series of pointers that groups your application's resources into a single logical unit, regardless of where those resources might be deployed.

Deployment stacks can be created at different scopes, such as resource groups, subscriptions, and management groups. The resources that a deployment stack can manage depends on the scope where the stack is created. For example, if you deploy a stack at the scope of a subscription, then the stack can manage resource groups within the subscription, as well as resources in any resource group inside that same subscription.

![a graphic representing a deployment stack and managed resources](../media/deployment-stacks-scenario-2-and-5.png)

What happens to a resource that is no longer managed by the deployment stack? If a resource is no longer defined in a template file and the stack is updated, the resource can become _detached_ or _deleted_. A detached resource is a resource that is no longer managed by the stack, but the resource continues to exist within Azure. A deleted resource is a resource that is deleted from Azure, and all of its data is lost.

## Action on unmanage

You're able to control how Azure handles detached resources, resource groups, and management groups with a property known as the _action on unmanage_ parameter. This parameter can be set when creating, modifying, or deleting a deployment stack.

All three operations have the ability to set the behavior of the _action on unmanage_ parameter. Keep in mind that the value set most recently takes precedence.

::: zone pivot="cli"

For example, if a deployment stack is created with the parameter set as `--action-on-unmanage detachAll`, Azure detaches any resources no longer managed by the stack. If a subsequent update operation is run and the parameter is set as `--action-on-unmanage deleteAll`, the behavior defaults to `deleteAll`.

There are three possible values for the `--action-on-unmanage` parameter:

- `deleteAll` - deletes resources, resource groups, and management groups
- `deleteResources` - deletes resources, but detaches resource groups and management groups
- `detachAll` - detaches all resources, resource groups, and management groups

> [!NOTE]
> In this module, we are working with resource group-scoped deployment stacks. In this situation, the resource group itself is not managed by the stack. The 'delete all' value for the _action on unmanage_ parameter doesn't delete the resource group where the stack exists. You need to delete the resource group after the stack and its resources are deleted.

Let's take a look at the JSON output when using the Azure CLI `az stack group show` command with values set for the `--action-on-unmanage` parameter. Notice the behavior for resources, resource groups, and management groups.

1. `--action-on-unmanage deleteAll`

    ```json
    "actionOnUnmanage": {
        "managementGroups": "delete",
        "resourceGroups": "delete",
        "resources": "delete"
    },
    ```

2. `--action-on-unmanage deleteResources`

    ```json
    "actionOnUnmanage": {
        "managementGroups": "detach",
        "resourceGroups": "detach",
        "resources": "delete"
    },
    ```

3. `--action-on-unmanage detachAll`

    ```json
    "actionOnUnmanage": {
        "managementGroups": "detach",
        "resourceGroups": "detach",
        "resources": "detach"
    },
    ```

::: zone-end

::: zone pivot="powershell"

For example, if a deployment stack is created with the parameter set as `-ActionOnUnmanage DetachAll`, Azure detaches any resources no longer managed by the stack. If a subsequent update operation is run and the parameter is set as `-ActionOnUnmanage DeleteAll`, the behavior defaults to `DeleteAll`.

There are three possible values for the `-ActionOnUnmanage` parameter:

- `DeleteAll` - deletes resources, resource groups, and management groups
- `DeleteResources` - deletes resources, but detaches resource groups and management groups
- `DetachAll` - detaches all resources, resource groups, and management groups

> [!NOTE]
> In this module, we are working with resrouce group scoped deployment stacks. In this situation, the resource group is not managed by the stack. > The 'delete all' value for the _action on unmanage_ parameter doesn't detele the resource group where the stack exists. Its necessary to delete the resource group after the stack and its resources are deleted.

Let's take a look at the json output when using the Azure PowerShell `Get-AzResourceGroupDeploymentStack` command with values set for the `-ActionOnUnmanage` parameter. Notice the behavior for resources, resource groups, and management groups.

1. `-ActionOnUnmanage DeleteAll`

    ```powershell
    resourcesCleanupAction        : delete
    resourceGroupsCleanupAction   : delete
    managementGroupsCleanupAction : delete
    ```

2. `-ActionOnUnmanage DeleteResources`

    ```powershell
    resourcesCleanupAction        : delete
    resourceGroupsCleanupAction   : detach
    managementGroupsCleanupAction : detach
    ```

3. `-ActionOnUnmanage DetachAll`

    ```powershell
    resourcesCleanupAction        : detach
    resourceGroupsCleanupAction   : detach
    managementGroupsCleanupAction : detach
    ```

::: zone-end
