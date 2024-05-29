As an application evolves, so does its resources. How do we update a deployment stack and its managed resources when new services and features are added? What situations require us to update a deployment stack?

You're planning how to add, modify, and delete resources from the deposit application's deployment stack. You need to learn more about how resources are handled when update operations occur.

In this unit, you learn about what situations call for an update to a deployment stack. You also learn how to modify resources managed by a deployment stack.

[!INCLUDE [Note - don't run commands](../../../includes/dont-run-commands.md)]

## Updating a deployment stack

Over time, the resources that make up an application change. Properties of existing resources need to be updated, resources need to be added or deleted, or an appliction needs to integrate existing resources. A deployment stack can be updated to implement the changes in our applications. What situations require us to update a deployment stack?

- Adding, removing, or modifying a property of a managed resource
- Adding a new managed resource
- Adding an existing resource as a managed resource
- Detaching a managed resource
- Deleting a managed resource

How are these changes implemented? As we discussed in the last module, deployment stacks manage resources that are defined in a ARM JSON template, Bicep file, or template spec. When you create a deployment stack, you reference one of these files to deploy your resources. The same holds true for updating a deployment stack. To update resources managed by a deployment stack, simply update the underlying template file.
