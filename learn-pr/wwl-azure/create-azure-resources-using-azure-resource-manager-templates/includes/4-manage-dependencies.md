
For any given resource, other resources might need to exist before you can deploy the resource.

For example, a Microsoft SQL Server must exist before attempting to deploy a SQL Database.

You can define this relationship by marking one resource as dependent on the other.

You define a dependency with the **dependsOn** element or by using the **reference** function.

Resource Manager evaluates the dependencies between resources and deploys them in their dependent order.

When resources aren't dependent on each other, the Resource Manager deploys them in parallel.

You only need to define dependencies for resources that are deployed in the same template.

## The dependsOn element

Within your template, the **dependsOn** element enables you to define one resource dependent on one or more other resources.

Its value can be a comma-separated list of resource names.

:::image type="content" source="../media/dependson-e5a30e56.png" alt-text="Screenshot of Resource Manager template code with the dependsOn section highlighted.":::


## Circular dependencies

A **circular dependency** is a problem with dependency sequencing, resulting in the deployment going around in a loop and unable to continue.

As a result, the Resource Manager can't deploy the resources.

Resource Manager identifies circular dependencies during template validation.

If you receive an error stating that a circular dependency exists, evaluate your template to find whether any dependencies are unnecessary and can be removed.

If removing dependencies doesn't resolve the issue, you can move some deployment operations into child resources that are deployed after the resources with the circular dependency.
