The management infrastructure includes Azure resources and resource groups, subscriptions, and accounts. Understanding this hierarchy helps you organize resources, control who can access what, and manage costs as your Azure usage grows.

## Azure resources and resource groups

A resource is the basic building block of Azure. Anything you create, provision, or deploy is a resource. VMs, virtual networks, databases, and Azure AI services are all examples of resources.

:::image type="content" source="../media/resource-group-rules.png" alt-text="Diagram showing three resource group rules: a resource belongs to one group at a time (with move option), groups cannot be nested or renamed, and deleting a group deletes all resources inside it.":::


Resource groups are groupings of resources. Every resource must belong to exactly one resource group. You can move some resources between groups, but a resource is only associated with one group at a time. Resource groups can't be nested, and they can't be renamed after creation, so choose a clear naming convention from the start.

Actions you apply to a resource group affect all resources inside it. Deleting a resource group deletes everything in it. Granting or denying access applies to all its resources.

For example, if you're setting up a temporary dev environment, grouping all the resources together lets you delete the entire group when you're done. If you're running multiple projects, create a separate resource group for each so each team only sees and manages its own resources.

There are no hard rules for structuring resource groups — choose the approach that works best for your situation.

## Azure subscriptions

In Azure, subscriptions are a unit of management, billing, and scale. Subscriptions let you organize resource groups and control billing separately from access.

:::image type="content" source="../media/subscription-boundaries.png" alt-text="Diagram showing two subscription boundary types: billing boundary where each subscription generates a separate invoice, and access control boundary where dev and prod subscriptions have different access policies and spending limits.":::


Using Azure requires an Azure subscription. A subscription provides access to Azure products and services and serves as a billing unit. An Azure subscription links to an Azure account, which is an identity in Microsoft Entra ID or in a directory that Microsoft Entra ID trusts.

An account can have multiple subscriptions, but only one is required. In a multi-subscription account, you can configure different billing models and access policies. There are two types of subscription boundaries:

 -  **Billing boundary**: Determines how an Azure account is billed. You can create multiple subscriptions for different billing requirements. Azure generates separate billing reports and invoices for each subscription.
 -  **Access control boundary**: Azure applies access-management policies at the subscription level. For example, you might create one subscription for your development work and another for production, each with different spending limits and access rules.

### Create additional Azure subscriptions

You might create additional subscriptions to separate:

 -  **Environments**: Subscriptions for lifecycle stages such as sandbox, development, test, and production. Access control occurs at the subscription level, making this a natural boundary.
 -  **Team and workload boundaries**: Give each project its own subscription so costs are easy to track, or separate sandbox environments from production.
 -  **Billing**: Create subscriptions to track costs separately — for instance, one for production workloads and another for development and testing.

## Azure management groups

Resources go into resource groups, and resource groups go into subscriptions. For a small environment, that's enough. But when you have many subscriptions across multiple teams or geographies, you need a way to manage access and policies at a higher level.

Azure management groups sit above subscriptions. You organize subscriptions into management groups and apply governance conditions — like access policies or compliance rules — to the group. All subscriptions in a management group automatically inherit those conditions, just as resources inherit settings from their resource group. Management groups can be nested up to six levels deep (not counting the root level or the subscription level), letting you build a hierarchy that mirrors your organization.

Every Microsoft Entra tenant has a single top-level Tenant Root Group. All other management groups and subscriptions fold up to this root group, which lets you apply governance policies globally.

## Management group, subscriptions, and resource group hierarchy

You can build a flexible structure of management groups and subscriptions to organize your resources into a hierarchy for unified policy and access management.

:::image type="content" source="../media/management-group-hierarchy.png" alt-text="Diagram showing a management group hierarchy from Tenant Root Group down through management groups (Marketing, IT) to subscriptions (Web, Mobile, Apps, Servers), resource groups, and individual resources, with policies and access inheriting downward.":::


Examples of how you could use management groups:

 -  **Apply a policy across subscriptions**. You could limit VM locations to the US West Region in a group called Production. This policy inherits to all subscriptions under that management group and applies to all VMs in those subscriptions. The resource or subscription owner can't override it, which strengthens governance.
 -  **Grant access to multiple subscriptions at once**. By placing subscriptions under a management group, you can create one Azure RBAC assignment on the group. All sub-management groups, subscriptions, resource groups, and resources underneath inherit those permissions — no need to script Azure RBAC across individual subscriptions.

Important facts about management groups:

 -  A single directory supports up to 10,000 management groups.
 -  Each management group and subscription can have only one parent.

