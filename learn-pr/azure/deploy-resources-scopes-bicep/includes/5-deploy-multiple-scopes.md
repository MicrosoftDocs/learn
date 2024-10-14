Sometimes you need to deploy resources across multiple levels of your hierarchy from within one deployment. Here are some situations where you might want to do this:

- You need to deploy resources across two different resource groups. For example, you might want to create a network security group in a shared resource group and also deploy a network interface for a virtual machine in a resource group for your application.
- You're using a template to create a resource group, which is a subscription-scoped resource, and then want to deploy a storage account and other Azure resources to that resource group by using a resource group-scoped deployment.
- You're deploying a management group hierarchy and also want to deploy some subscriptions, which are tenant-scoped resources.

With Bicep, you can create a deployment that works across a range of scopes by using the `scope` keyword.

[!include[Note - don't run commands](../../../includes/dont-run-commands.md)]

## Specify the scope for a module

You can use Bicep modules to deploy a set of resources at a scope that's different from the `targetScope` specified in the file. Here's an example Bicep file that's deployed with a `targetScope` of a `subscription`, but uses a module to deploy some resources to a resource group:

:::code language="bicep" source="code/5-sub-scope-rg-module.bicep" highlight="1,4" :::

Notice that the `scope` property uses a Bicep function to help identify the scope to be targeted. The preceding example uses the `resourceGroup()` function and specifies the name of the resource group to target. You can also use the `subscription()`, `managementGroup()`, and `tenant()` functions. By using the `targetScope` keyword on Bicep files and the `scope` keyword on modules, it's possible to create lots of different combinations of scopes for your deployments.

> [!NOTE]
> One exception is that Bicep files with a `targetScope` of `resourceGroup` or `subscription` can't include a module with a `scope` of `managementGroup`.

> [!TIP]
> If you use a subscription-scoped Bicep file to create a resource group, you can use the resource group's symbolic name as the `scope` for a module. You'll see how to do this in the next exercise.

## Deploy across multiple resource groups

A common use of scopes is to deploy resources across multiple resource groups. Although you can't set the `scope` property on most Azure resources, you can use modules to tell Bicep that a set of resources should be deployed to a different resource group.

For example, you might want to create a single set of Bicep files that deploys a virtual network and its associated resources to a shared resource group named *ToyNetworking*, and then deploy a network interface to a different resource group. Here's what the Bicep file looks like:

:::code language="bicep" source="code/5-multiple-rgs.bicep" highlight="2, 15" :::

Notice that the resources to be deployed to the *ToyNetworking* resource group are defined in a module, and the `subnetResourceId` output is used in the network interface's resource definition.

After you deploy this file, you could target another resource group named *ProjectTeddybear*, like this:

::: zone pivot="cli"

```azurecli
az deployment group create --resource-group ProjectTeddybear ...
```

::: zone-end

::: zone pivot="powershell"

```azurepowershell
New-AzResourceGroupDeployment -ResourceGroupName ProjectTeddybear ...
```

::: zone-end

Although the deployment targets the *ProjectTeddybear* resource group, the virtual network resources are deployed to the *ToyNetworking* resource group. The network interface is deployed to the *ProjectTeddybear* resource group.

You can even deploy a resource group in another subscription by including the subscription ID in the `resourceGroup` scope:

:::code language="bicep" source="code/5-multiple-rgs-different-sub.bicep" highlight="2" :::

Similarly, you can use the `subscription()` scope function to deploy resources across multiple subscriptions at the subscription scope, and you can use the `managementGroup()` scope function to deploy the resources across multiple management groups. However, you can't deploy them across multiple tenants.

## Specify the scope for a single resource

You can use the `scope` keyword on a few other specific resource types, not just modules. Extension resources use the `scope` keyword to specify which resource they apply to. Additionally, tenant-scoped resources can use the `scope` keyword so that you can deploy them from any template.

For example, you might use a Bicep file to create a management group hierarchy, as shown in the following example:

:::code language="bicep" source="code/5-create-mg-hierarchy.bicep" range="1-2, 6-25" highlight="1, 4, 12" :::

Notice that this example uses `targetScope = 'managementGroup'` in the template file, but it then deploys the management groups within the `tenant()` scope.

> [!NOTE]
> The preceding example illustrates how you can use Bicep to create a management group hierarchy. The *NonProduction* management group will be a child of the root management group, and the *SecretRND* management group will be a child of the *NonProduction* management group.

## Create a management group and subscription hierarchy

Now you know how to deploy many different resources at a variety of scopes, and you know how to use Bicep modules and the `scope` keyword to deploy combinations of resources. Let's apply all this new knowledge to extending the management group hierarchy in the preceding example. Now, the hierarchy will also include a _subscription alias_, which is a tenant-scoped resource that creates a new Azure subscription:

:::code language="bicep" source="code/5-create-mg-hierarchy.bicep" range="27-33" :::

> [!NOTE]
> When you create a subscription alias, you also specify some other properties like a billing scope. We've omitted them for clarity.

You can then associate the subscription with a management group, which requires you deploy a resource type called `Microsoft.Management/managementGroups/subscriptions`. Because of the way this resource works, you would declare it in a module. For example, here's a file named *modules/mg-subscription-association.bicep*:

:::code language="bicep" source="code/5-mg-subscription-association.bicep" highlight="9-16" :::

Notice that the management group is referenced through the `existing` keyword.

The main Bicep file can then create the association by including the module. Here's the whole Bicep file:

:::code language="bicep" source="code/5-create-mg-hierarchy.bicep" highlight="35-42" :::

As you've seen, you can use all of the scopes and Bicep language features together to create sophisticated deployments of your entire Azure infrastructure.
