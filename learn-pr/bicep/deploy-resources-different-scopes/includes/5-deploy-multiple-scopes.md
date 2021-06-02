Sometimes you need to deploy across multiple levels of your hierarchy from within one deployment. Here are some situations where you might want to do this:

- You need to deploy resources across two different resource groups. For example, you might want to create a network security group in a shared resource group and also deploy a network interface for a virtual machine in a resource group for your application.
- You're using a template to create a resource group, which is a subscription-scoped resource, and then want to deploy a storage account and other Azure resources into that resource group by using a resource group-scoped deployment.
- You're deploying a management group hierarchy, and want to also deploy some subscriptions, which are tenant-scoped resources.

Bicep enables you to create a deployment that works across different scopes by using the `scope` keyword.

## Specify the scope for a module

You can use Bicep modules to deploy a set of resources at a different scope from the `targetScope` specified in the file. Here's an example Bicep file that is deployed with a `targetScope` of a `subscription`, but uses a module to deploy some resources into a resource group:

:::code language="plaintext" source="code/5-sub-scope-rg-module.bicep" highlight="1,4" :::

Notice that the `scope` property uses a Bicep function to help to identify the scope to target. The example above uses the `resourceGroup()` function and specifies the name of the resource group to target. You can also use the `subscription()`, `managementGroup()`, and `tenant()` functions. By using the `targetScope` keyword on Bicep files, and the `scope` keyword on modules, it's possible to create lots of different combinations of scopes for your deployments.

> [!NOTE]
> One exception is that Bicep files with a `targetScope` of `resourceGroup` or `subscription` can't include a module with a `scope` of `managementGroup`.

> [!TIP]
> If you use a subscription-scoped Bicep file to create a resource group, you can use the resource group's symbolic name as the `scope` for a module. You'll see how to do this in the next exercise.

## Deploy across multiple resource groups

A common use of scopes is to deploy across multiple resource groups. While you can't set the `scope` property on most Azure resources, modules enable you to tell Bicep that a set of resources should be deployed to a different resource group.

For example, you might want to create a single set of Bicep files that deploys a virtual network and its associated resources into a shared resource group named *ToyNetworking*, and then deploy a network interface into a different resource group. Here's what the Bicep file looks like:

:::code language="plaintext" source="code/5-multiple-rgs.bicep" highlight="2, 15" :::

Notice that the resources to be deployed into the *ToyNetworking* resource group are defined in a module, and the `subnetResourceId` output is used in the network interface's resource definition.

When this file is deployed, you could target another resource group named *ProjectTeddybear*, like this:

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

Even though the deployment targets the *ProjectTeddybear* resource group, the virtual network resources will be deployed to the *ToyNetworking* resource group. The network interface will be deployed to the *ProjectTeddybear* resource group.

You can even deploy a resource group in another subscription by including the subscription ID in the `resourceGroup` scope:

:::code language="plaintext" source="code/5-multiple-rgs-different-sub.bicep" highlight="2" :::

Similarly, you can use the `subscription()` scope function to deploy resources across different subscriptions at the subscription scope, and the `managementGroup()` scope function to deploy across different management groups. However, you can't deploy across different tenants.

## Specify the scope for a single resource

The `scope` keyword can be used on a few other specific resource types, not just modules. Extension resources use the `scope` keyword to specify which resource they apply to. Additionally, tenant-scoped resources can use the `scope` keyword so that you can deploy them from any template.

For example, you might create a Bicep file to create a management group hierarchy, as in the following example:

:::code language="plaintext" source="code/5-create-mg-hierarchy.bicep" range="1-2, 6-25" highlight="1, 4, 12" :::

Notice that this example uses `targetScope = 'managementGroup'` in the template file, but then deploys the management groups within the `tenant()` scope.

> [!NOTE]
> The example above illustrates how you can create a management group hierarchy by using Bicep. The *NonProduction* management group will be a child of the root management group, and the *SecretRND* management group will be a child of the *NonProduction* management group.

You can use a similar approach to deploy a _subscription alias_, which is a tenant-scoped resource that creates a new Azure subscription:

:::code language="plaintext" source="code/5-create-mg-hierarchy.bicep" range="1-5, 27-33" highlight="1, 7" :::

> [!NOTE]
> When you create a subscription alias, you also specify some other properties like a billing scope. These have been omitted for clarity.

As you've seen, you can use all of the scopes and Bicep language features together to create sophisticated deployments of your entire Azure infrastructure.

<!-- NOTE TO EDITOR: the following section has to be removed temporarily because of a Bicep bug, but I'd really appreciate it if you could review it so I can add it in once the bug is fixed!

## Create a management group and subscription hierarchy

Now you know how to deploy all sorts of different resources at different scopes, and how to use Bicep modules and the `scope` keyword to deploy combinations of resources. Let's use all of this together to extend the management group hierarchy in the example above. Now, it will also include a _subscription alias_, which is a tenant-scoped resource that creates a new Azure subscription:

:::code language="plaintext" source="code/5-create-mg-hierarchy.bicep" range="27-33" :::

> [!NOTE]
> When you create a subscription alias, you also specify some other properties like a billing scope. These have been omitted for clarity.

You can then associate the subscription with a management group, which requires you deploy a resource type called `Microsoft.Management/managementGroups/subscriptions`. Due to the way this resource works, we declare it in a module:

:::code language="plaintext" source="code/5-mg-subscription-association.bicep" highlight="13-16" :::

Notice that the management group is referenced through the `existing` keyword.

The main Bicep file can then create the association by including the module. Here's the whole Bicep file:

:::code language="plaintext" source="code/5-create-mg-hierarchy.bicep" highlight="35-42" :::
		
As you've seen, you can use all of the scopes and Bicep language features together to create sophisticated deployments of your entire Azure infrastructure.

-->