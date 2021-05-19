Virtual machines, SQL servers and databases, storage accounts, virtual networks, and the majority of other Azure resources need to be placed in a resource group. However, there are a few resources that can, or must, be deployed in a different way. Typically these resources are used to control the behavior of Azure itself. In this unit, you'll review the hierarchy of Azure resource organization, and look at how certain resources might be deployed at different scopes.

## Azure's resource hierarchy

Azure has a hierarchical resource structure with multiple levels of management. Here's a diagram:

:::image type="content" source="../media/2-hierarchy.png" alt-text="Diagram that shows an Azure tenant, three management groups, three subscriptions, and four resource groups." border="false":::

:::image type="icon" source="../media/callout-01.png"::: Your **tenant** corresponds to your Azure Active Directory instance. Typically an organization only has one Azure AD instance. This acts as the root of the resource hierarchy.

:::image type="icon" source="../media/callout-02.png"::: **Management groups** provide a way to organize your Azure subscriptions. Every tenant has a single root management group, and then you can establish your own hierarchy of management groups underneath it. You might create different management groups for different parts of your organization, or for subscriptions that need to have different types of management. You can apply policy and access control restrictions to management groups, and these are inherited by all subscriptions below that management group in the hierarchy.

:::image type="icon" source="../media/callout-03.png"::: **Subscriptions** act as billing accounts, and contain resource groups and resources.

:::image type="icon" source="../media/callout-04.png"::: **Resource groups** are logical containers for your resources. Resource groups enable you to manage and control related resources as a single unit. Resources like virtual machines, App Service plans, storage accounts, and virtual networks all must be put into a resource group.

The example illustrated above is a fairly basic scenario showing how management groups can be used. You might also consider implementing an _enterprise-scale landing zone_, which is a proven approach to use management groups and subscriptions to effectively manage your Azure resources:

:::image type="content" source="../media/2-hierarchy-eslz.png" alt-text="Diagram that shows an enterprise-scale landing zone architecture, with four management groups and four subscriptions." border="false":::

Whichever model you follow, by understanding the different levels of the hierarchy, you can start to apply flexible controls on how your Azure environment is used and managed. Bicep enables you to manage these controls with all the benefits of infrastructure as code.

> [!NOTE]
> *Extension resources* are resources that are deployed to the scope of another Azure resource. For example, a resource lock is deployed onto a resource like a storage account.

Let's look at some examples where you might deploy resources to each of these levels. You're already familiar with deploying resources into resource groups, so let's look at the other scopes for deployment.

## Subscription-scoped resources

You might deploy to a subscription when:

- You need to create a new resource group. A resource group is really just a subscription-scoped resource itself.
- You're using Azure Policy and you want to define or apply a policy to all resources within the subscription. For example, your toy company's R&D department has asked you to deploy a policy that will restrict the list of virtual machine SKUs that can be created within their subscription.
- You need to grant access to all of the resources within a subscription. For example, if your HR department has an Azure subscription that contains all of their Azure resources, you might create role assignments to allow everybody in the HR department to read the contents of the subscription.

## Management group-scoped resources

You might deploy to a management group when:

- You need to grant access to all of the resources within any subscriptions that are within the management group hierarchy. For example, your cloud operations team might need to have access to every subscription in your organization. You can create a role assignment at your root management group, which grants your cloud operations team access to everything in Azure.

  > [!CAUTION]
  > Be extremely careful when you grant access to resources using management groups, and especially the root management group. Remember that every resource underneath the management group in the hierarchy will inherit the role assignment. Make sure your organization follows best practices regarding identity management and authentication, and don't grant access that isn't required.

- You need to apply policies across your entire organization. For example, your organization might have a policy that resources cannot be created in certain geographic regions, under any circumstances. You might apply a policy to your root management group that will block creation of resources in that region.

> [!NOTE]
> Before you use management groups for the first time, [you need to set them up for your Azure environment](/azure/governance/management-groups/overview#initial-setup-of-management-groups).

## Tenant-scoped resources

You might deploy to your tenant when:

- You need to create Azure subscriptions. Even though subscriptions will sit underneath management groups in the resource hierarchy, the creation of a subscription requires a tenant-scoped deployment.

  > [!NOTE]
  > Not all Azure customers can create subscriptions using infrastructure as code. [Depending on your billing relationship with Microsoft, this might not be possible.](/azure/cost-management-billing/manage/programmatically-create-subscription)

- You're creating or configuring management groups. A single root management group is created by Azure when you enable management groups for your tenant, but you can create multiple levels of management groups underneath it. You can use Bicep to define your whole management group hierarchy. You can also assign subscriptions to management groups.

Tenant-scoped deployments [require special permission](/azure/azure-resource-manager/templates/deploy-to-tenant#required-access).

> [!TIP]
> You can't create policies or role assignments at the tenant scope. However, if you need to grant access or apply policies across your whole organization, you can deploy these resources to the root management group.

## Resource IDs

By now, you're very familiar with resource IDs for resources that live inside subscriptions. For example, here's a resource ID that represents a resource group, which is a subscription-scoped resource:

```
/subscriptions/f0750bbe-ea75-4ae5-b24d-a92ca601da2c/resourceGroups/ToyDevelopment
```

Here's a visual representation of the same information:

:::image type="content" source="../media/2-subscription-resource-id.png" alt-text="Resource ID for a resource group." border="false":::

Subscriptions themselves have their own IDs, like this:

```
/subscriptions/f0750bbe-ea75-4ae5-b24d-a92ca601da2c
```

> [!NOTE]
> Even though subscriptions are considered to be children of management groups, their resource IDs don't include a management group ID. The relationship between subscriptions and management groups is tracked by Azure in a different way to other resource relationships. This gives you the flexibility to move subscriptions between management groups without all of the resource IDs changing.

When you're working with resources at a management group or tenant scope, resource IDs can look a bit different than normal. They mostly follow the standard pattern of interleaving the resource type with the information about your specific resources. However, the specific format depends on the resource you're working with.

Here's an example resource ID for a management group:

```
/providers/Microsoft.Management/managementGroups/ProductionMG
```

Here's what that looks like visually:

:::image type="content" source="../media/2-mg-resource-id.png" alt-text="Resource ID for a management group." border="false":::

When a resource is deployed to a management group's scope, its resource ID includes the management group's ID. Here's an example resource ID for a role definition that's been created at a management group scope:

```
/providers/Microsoft.Management/managementGroups/ProductionMG/providers/Microsoft.Authorization/roleDefinitions/d79b8492-6f38-49f9-99e6-b2e667d4f3ca
```

Here's a visual representation of the same ID:

:::image type="content" source="../media/2-role-mg-scope-resource-id.png" alt-text="Resource ID for a role definition deployed to a management group scope." border="false":::

> [!IMPORTANT]
> In Bicep, you normally use the `.id` property of a resource to access its resource ID. However, the `.id` property doesn't currently work for management group-scoped resources. It returns a partial resource ID instead of the full resource ID. This will be changed in the future, but in the meantime, you'll see how to work around this limitation later in this module.

Another role definition might be defined at a subscription scope, so its resource ID looks a little different:

```
/subscriptions/f0750bbe-ea75-4ae5-b24d-a92ca601da2c/providers/Microsoft.Authorization/roleDefinitions/d79b8492-6f38-49f9-99e6-b2e667d4f3ca
```

Here's a visual representation of the same ID:

:::image type="content" source="../media/2-role-subscription-scope-resource-id.png" alt-text="Resource ID for a role definition deployed to a subscription scope." border="false":::

In the next unit, you'll learn how to create Bicep files that target each of these scopes.
