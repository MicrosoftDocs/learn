You're evaluating whether deployment stacks might provide the right features for resource lifecycle management. You've spent some time learning about the features of deployment stacks and how you can use it to manage your applications and Azure resources. You want to learn more about why you should consider deployment stacks and its overall benefits.

In this unit, you learn about the benefits of deployment stacks.

## Benefits of deployment stacks

There are many benefits that deployment stacks can add to your resource provisioning process, including:

- Simplified provisioning
- Preventing unauthorized changes
- Reliable resource cleanup
- Standardized templates
- Enhancing existing processes

### Simplified provisioning

Consider an application that needs to be deployed across multiple resource groups across multiple subscriptions. In a standard deployment, it's necessary to issue multiple create operations at the scope of each resource group. Your deployment pipeline needs to be designed to handle resource dependencies and deployment sequence.

With deployment stacks, you're able to deploy the application with a single command. In this example, when scoping the deployment stack at the management group level, all resources are deployed to the appropriate subscriptions and resource groups at the time of execution. Updates to the application are handled in the same way, through a single deployment command.

This process significantly reduces the number of operations necessary to deploy or modify the application.

### Preventing unauthorized changes

Deployment stacks provide an extra layer of security and guardrails that help prevent unauthorized changes to your Azure resources.

When you create a deployment stack, you can specify a permission that is applied to the resources managed by the stack. These permissions, known as deny settings, are used to prevent modification or deletion from unauthorized users.

Deny settings may sound similar in concept to Azure role-based access control (RBAC) and Azure Locks. RBAC is used to assign specific roles to specific users at a specific scope. For example, assigning the contributor role to a user at the resource group scope. Locks are used to prevent modification or deletion of resources at specific scopes, regardless of the user performing the action. For example, placing a read-only lock at the subscription scope prevents any modifications or deletions to all resources even if the user has the RBAC permission to do so.

Deployment stack deny settings allow you to implement controls over a collection of resources across scopes, which supersede any RBAC assignments or locks that may be in place.

### Reliable resource cleanup

Consider a development environment for an application that is deployed across multiple resource groups in a subscription. To remove the environment and delete all of the resources, it's necessary to issue multiple delete operations against the resource groups and resources. If any dependencies exist between resources, it's possible that the delete operation fails. Resources deleted out of sequence can also cause the delete operation to fail.

Deployment stacks allow you to delete the stack and all of its resources through a single API call, without needing to understand dependencies. This single operation removes the resources in a reliable way, and improves the speed of removal.

Another advantage of deleting resources managed by a stack is the potential for cost savings. Deleting an application and its resources not managed by a deployment stack is many times a manual effort that is prone to error. It's possible to accidentally forget to delete certain resources, which continue to incur cost. Deployment stacks solve for this problem acting as a cost management tool, especially when dealing with ephemeral environments.

When deleting a deployment stack, you can use the `actionOnUnmanage` property to determine how Azure handles the resources, resource groups, and management groups contained in the stack. Azure can delete the resources, resource groups, and management groups, or it can *detach* them, which means the the resources aren't deleted but are no longer managed by the stack.

### Standardized process and templates

Creating and deploying a deployment stack and its resources is nearly identical to a standard Azure deployment. For example:

The Azure CLI command to deploy a Bicep file to a resource group is:

```azurecli
az deployment group create \
    --resource-group rg-depositsApplication \
    --template-file ./main.bicep
```

The Azure CLI command to create a deployment stack at the resource group scope is:

```azurecli
az stack group create \
    --name stack-deposits \
    --resource-group rg-depositsApplication \
    --template-file ./main.bicep \
    --action-on-unmanage detachAll \
    --deny-settings-mode none
```

Deployment stacks support the use of Bicep files, ARM JSON templates, or template specs for defining resources in a stack. When deploying a deployment stack using the Azure CLI or Azure PowerShell, you're able to point to the specific template file (Bicep file or ARM JSON template) or template spec. It isn't necessary to change how you define your resources.

### Enhancing existing processes

If you're already using infrastructure as code to manage the deployments of your resources to Azure, deployment stacks give you more control over the process. As discussed in the previous section, the process of creating a deployment stack isn't very different from creating a resource group based deployment. The ability to deploy across management groups, subscriptions, and resource groups with a single command is much simpler with deployment stacks. Resource security is now part of your deployment process with stacks.
