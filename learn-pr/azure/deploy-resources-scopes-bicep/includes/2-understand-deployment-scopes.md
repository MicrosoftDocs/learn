Virtual machines, Azure SQL logical servers and databases, storage accounts, virtual networks, and most other Azure resources need to be placed in a resource group. However, some resources can―or must―be deployed in a different way. These resources are ordinarily used to control your Azure environment's behavior.

In this unit, you'll review the Azure resource-organization hierarchy, and you'll look at how certain resources might be deployed at various scopes.

## The Azure resource hierarchy

Azure has a hierarchical resource structure with multiple levels of management. Here's a diagram showing how your toy company might organize its Azure environment:

:::image type="content" source="../media/2-hierarchy.png" alt-text="Diagram showing an Azure tenant, three management groups, three subscriptions, and four resource groups." border="false":::

:::image type="icon" source="../media/callout-01.png"::: Your *tenant* corresponds to your Microsoft Entra instance. An organization ordinarily has only one Microsoft Entra instance. This instance acts as the root of the resource hierarchy.

:::image type="icon" source="../media/callout-02.png"::: *Management groups* provide a way to organize Azure subscriptions. Each tenant has a single root management group, and you can establish your own hierarchy of management groups under it. You might create separate management groups for the various parts of your organization, or for subscriptions that have their own security or governance requirements. You can apply policy and access-control restrictions to management groups, and all subscriptions below that management group in the hierarchy inherit these restrictions. Management groups aren't deployed to regions, and they have no impact on your resources' locations.

:::image type="icon" source="../media/callout-03.png"::: *Subscriptions* act as billing accounts, and they contain resource groups and resources. Like management groups, subscriptions have no location and don't restrict where your resources are deployed.

:::image type="icon" source="../media/callout-04.png"::: *Resource groups* are logical containers for your resources. With resource groups, you can manage and control related resources as a single unit. Resources such as virtual machines, Azure App Service plans, storage accounts, and virtual networks must be put into a resource group. Resource groups are created in a location so that Azure can track the metadata for the resources in the group, but resources inside the group can be deployed to other locations.

The previously illustrated example is a fairly basic scenario that shows how you can use management groups. Your organization might also consider implementing a _landing zone_, which is a set of Azure resources and configuration you need to get started with a production Azure environment. The _enterprise-scale landing zone_ is a proven approach to using management groups and subscriptions to effectively manage your Azure resources:

:::image type="content" source="../media/2-hierarchy-eslz.png" alt-text="Diagram of an enterprise-scale landing-zone architecture, with four management groups and four subscriptions." border="false":::

Whichever model you follow, by understanding the various levels of the hierarchy, you can start to apply flexible controls on how your Azure environment is used and managed. By using Bicep, you can manage these controls with all the benefits of infrastructure as code.

> [!NOTE]
> There are also some other resources that are deployed at specific scopes. *Extension resources* are deployed at the scope of another Azure resource. For example, a resource lock is an extension resource, which is deployed to a resource such as a storage account.

You're already familiar with deploying resources to resource groups, so let's look at the other scopes for deployment.

## Subscription-scoped resources

You might deploy resources to a subscription when:

- You need to create a new resource group. A resource group is really only a subscription-scoped resource.
- You need to grant access to all the resources within a subscription. For example, if your HR department has an Azure subscription that contains all the department's Azure resources, you might create role assignments to allow everybody in the HR department to read the contents of the subscription.
- You're using Azure Policy, and you want to define or apply a policy to all resources within the subscription. For example, your toy company's R&D department has asked you to deploy a policy that restricts the list of virtual machine SKUs that can be created within the team's subscription.

## Management group-scoped resources

You might deploy resources to a management group when:

- You need to grant access to all the resources within any subscriptions that fall under the management group hierarchy. For example, your cloud operations team might require access to every subscription in your organization. You can create a role assignment at your root management group, which grants your cloud operations team access to everything in Azure.

  > [!CAUTION]
  > Be extremely careful when you grant access to resources by using management groups, and especially the root management group. Remember that every resource under the management group in the hierarchy inherits the role assignment. Make sure that your organization follows best practices for identity management and authentication, and that it follows the principle of least privilege; that is, don't grant any access that isn't required.

- You need to apply policies across your entire organization. For example, your organization might have a policy that resources can't be created in certain geographic regions, under any circumstances. You might apply a policy to your root management group that will block the creation of resources in that region.

> [!NOTE]
> Before you use management groups for the first time, [set them up for your Azure environment](/azure/governance/management-groups/overview#initial-setup-of-management-groups).

## Tenant-scoped resources

You might deploy resources to your tenant when:

- You need to create Azure subscriptions. When you use management groups, subscriptions sit under management groups in the resource hierarchy, but a subscription is deployed as a tenant-scoped resource.

  > [!NOTE]
  > Not all Azure customers can create subscriptions by using infrastructure as code. Depending on your billing relationship with Microsoft, this might not be possible. For more information, see [Create Azure subscriptions programmatically](/azure/cost-management-billing/manage/programmatically-create-subscription).

- You're creating or configuring management groups. Azure creates single root management group when you enable management groups for your tenant, and you can create multiple levels of management groups under it. You can use Bicep to define your whole management group hierarchy. You can also assign subscriptions to management groups.

    With Bicep, you can submit deployments to the tenant scope. [Tenant-scoped deployments require special permission](/azure/azure-resource-manager/templates/deploy-to-tenant#required-access). However, in practice, you don't need to submit tenant-scoped deployments. It's simpler to instead deploy tenant-scoped resources by using a template at a different scope. You'll see how to do that later in this module.

    > [!TIP]
    > You can't create policies or role assignments at the tenant scope. However, if you need to grant access or apply policies across your whole organization, you can deploy these resources to the root management group.

## Resource IDs

By now, you're familiar with resource IDs for resources that live inside subscriptions. For example, here's a resource ID that represents a resource group, which is a subscription-scoped resource:

```
/subscriptions/f0750bbe-ea75-4ae5-b24d-a92ca601da2c/resourceGroups/ToyDevelopment
```

Here's a visual representation of the same information:

:::image type="content" source="../media/2-subscription-resource-id.png" alt-text="Screenshot of a Resource ID for a resource group." border="false":::

Subscriptions themselves have their own IDs, like this:

```
/subscriptions/f0750bbe-ea75-4ae5-b24d-a92ca601da2c
```

> [!NOTE]
> Although subscriptions are considered children of management groups, their resource IDs don't include a management group ID. Azure tracks the relationship between subscriptions and management groups in a way that's different from other resource relationships. This gives you the flexibility to move subscriptions between management groups without having to change all the resource IDs.

When you're working with resources at a management group or tenant scope, resource IDs can look a bit different than normal. They mostly follow the standard pattern of interleaving the resource type with the information about your specific resources. However, the specific format depends on the resource with which you're working.

Here's an example resource ID for a management group:

```
/providers/Microsoft.Management/managementGroups/ProductionMG
```

Here's what that looks like:

:::image type="content" source="../media/2-mg-resource-id.png" alt-text="Screenshot of a Resource ID for a management group." border="false":::

> [!NOTE]
> Management groups have both an identifier and a display name. The display name is a human-readable description of the management group. You can change the display name without affecting the management group's ID.

When a resource is deployed at a management group scope, its resource ID includes the management group ID. Here's an example resource ID for a role definition that has been created at a management group scope:

```
/providers/Microsoft.Management/managementGroups/ProductionMG/providers/Microsoft.Authorization/roleDefinitions/d79b8492-6f38-49f9-99e6-b2e667d4f3ca
```

Here's a visual representation of the same ID:

:::image type="content" source="../media/2-role-mg-scope-resource-id.png" alt-text="Screenshot of a Resource ID for a role definition that's deployed at a management group scope." border="false":::

Another role definition might be defined at a subscription scope, so its resource ID looks a little different:

```
/subscriptions/f0750bbe-ea75-4ae5-b24d-a92ca601da2c/providers/Microsoft.Authorization/roleDefinitions/d79b8492-6f38-49f9-99e6-b2e667d4f3ca
```

Here's a visual representation of the same ID:

:::image type="content" source="../media/2-role-subscription-scope-resource-id.png" alt-text="Screenshot of a Resource ID for a role definition that's deployed at a subscription scope." border="false":::

Now that you understand the Azure resource hierarchy and the types of resources that you can deploy at each scope, you can make decisions about the scopes at which to deploy your resources. For example, you can make an informed choice about whether you should create a policy definition at the scope of a resource group, subscription, or management group. In the next unit, you'll learn how to create Bicep files that target each of these scopes.
