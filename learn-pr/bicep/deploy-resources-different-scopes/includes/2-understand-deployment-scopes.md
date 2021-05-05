Most Azure resources are deployed into resource groups. Virtual machines, SQL servers and databases, storage accounts, virtual networks, and the majority of other resource types need to be placed in a resource group. However, there are a few resources that can, or must, be deployed in a different way. Typically these resources are used to control the behavior of Azure itself. In this unit, you'll review the hierarchy of Azure resource organization, and look at how certain resources might be deployed at different scopes.

## Azure's resource hierarchy

Azure has a hierarchical resource structure with multiple levels of management.

:::image type="content" source="../media/2-hierarchy.png" alt-text="Diagram that shows an Azure tenant, three management groups, three subscriptions, and four resource groups." border="false":::

- Your **tenant** (:::image type="icon" source="../media/callout-01.png":::) corresponds to your Azure Active Directory instance. Typically an organization only has one Azure AD instance. This acts as the root of the resource hierarchy.
- **Management groups** (:::image type="icon" source="../media/callout-02.png":::) provide a way to organize your Azure subscriptions. Every tenant has a single root management group, and then you can establish your own hierarchy of management groups. You might create different management groups for different parts of your organization, or for subscriptions that need to have different types of management. You can apply Azure Policies and access control restrictions to management groups, and these are inherited by all subscriptions within that management group's hierarchy.
- **Subscriptions** (:::image type="icon" source="../media/callout-03.png":::) act as a billing account, and contain resource groups and resources.
- **Resource groups** (:::image type="icon" source="../media/callout-04.png":::) logically group resources together, and let you manage and control them as a single unit.

By understanding these levels of the hierarchy, you can start to apply flexible controls on how your Azure environment is used and managed. Bicep enables you to manage these controls with all the benefits of infrastructure as code. Let's look at some examples where you might deploy resources to each of these levels.

> [!NOTE]
> *Extension resources* are a special class of resources that are deployed into the scope of another Azure resource. For example, a resource lock is deployed onto a resource like a storage account. There is a learning module that discusses extension resources. TODO can we link to the module?

## Subscription-scoped resources

You might deploy to a subscription for these kinds of use cases:

- You need to create a new resource group.
- You are using Azure Policy, and you want to define or apply a policy to all resources within the subscription. For example, if you've got an Azure subscription for a project your team is working on, you might consider creating a policy to restrict the list of virtual machine SKUs that can be created.
- You need to grant access to all of the resources within a subscription. For example, if your HR department has an Azure subscription that contains all of their Azure resources, you might create role assignments to allow everybody in your HR department to read the contents of the subscription.

## Management group-scoped resources

You might deploy to a management group for these kinds of use cases:

- You need to create Azure subscriptions.
  > [!NOTE]
  > Depending on your billing agreement with Microsoft, you may not be able to create subscriptions using infrastructure as code. TODO link
- You need to grant access to all of the resources within any subscriptions that are within the management group hierarchy. For example, your cloud operations team might need to have some level of access to every subscription in your organization. You can create a role assignment at your root management group, which grants your cloud operations team access to everything in your environment.
  > [!CAUTION]
  > Be extremely careful when you grant access across a management group. Make sure your organization follows best practices regarding identity management and authentication, and don't grant access that isn't required.
- You need to apply policies across your entire organization. For example, your organization might have a policy that resources cannot be created in certain geographic regions, under any circumstances. You might apply a policy to your root management group that will block creation of resources in that region.

TODO note that MGs have to be initialized

## Tenant-scoped resources

Tenant-scoped deployments can be used to create management groups. A single root management group is created by Azure, but you can create multiple levels of management groups underneath it. You can use Bicep to define your whole management group hierarchy. You can also assign subscriptions to management groups.

TODO confirm - are MGs created using MG scoped deployments or tenant scoped deployments?

TODO check if you can create subscriptions at tenant scope or if that has to be done at MG scope

TODO note that tenant deployments require special permission

> [!TIP]
> You can't create policies or role assignments at the tenant scope. However, if you need to grant access or apply policies across your whole organization, you can deploy these resources to the root management group.

## Resource IDs

When you're working with resources at subscription, management group, and tenant scope, resource IDs look a bit different to normal.

A subscription-scoped resource ID looks like this:

```
TODO
```

This is similar to a normal resource, but it doesn't include the resource group name, unless you are actually referring to a resource group:

```
TODO
```

At a management group scope, TODO

At a tenant scope, TODO

In the next unit, you'll learn how to create Bicep files that target each of these scopes.
