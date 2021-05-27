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

:::code language="plaintext" source="code/5-multiple-rgs.bicep" highlight="2" :::

Notice that the resources to be deployed into the *ToyNetworking* resource group are defined in a module.

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

Even though the deployment targets the *ProjectTeddybear* resource group, the networking resources will be deployed to the *ToyNetworking* resource group.

You can even deploy a resource group in another subscription by including the subscription ID in the `resourceGroup` scope:

:::code language="plaintext" source="code/5-multiple-rgs-different-sub.bicep" highlight="2" :::

Similarly, you can use the `subscription()` scope function to deploy resources across different subscriptions at the subscription scope, and the `managementGroup()` scope function to deploy across different management groups. However, you can't deploy across different tenants.

## Specify the scope for a single resource

The `scope` keyword can be used on a few other specific resource types, not just modules. Extension resources use the `scope` keyword to specify which resource they apply to. Additionally, tenant-scoped resources can use the `scope` keyword so that you can deploy them from any template. For example, you might create a Bicep file to create all of your management group hierarchy, and use `targetScope = 'managementGroup'` in the template file, but then deploy child management groups and Azure subscriptions within the `tenant()` scope.

Here's an example Bicep file that is deployed to a management group scope. The deploy creates a _subscription alias_, which is a tenant-scoped resource that creates a new Azure subscription:

:::code language="plaintext" source="code/5-mg-scope-tenant-resource.bicep" highlight="1,6" :::

Notice that the template is deployed with a `targetScope` of `managementGroup`, but the subscription alias resource targets the `tenant()` scope.

