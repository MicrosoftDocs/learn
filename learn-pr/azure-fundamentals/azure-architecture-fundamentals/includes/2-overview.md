As part of your research for Tailwind Traders, you need to learn the organizing structure for resources in Azure, which has four levels: management groups, subscriptions, resource groups, and resources.

The following image shows the top-down hierarchy of organization for these levels.

:::image type="content" source="../media/hierarchy-372fef74.png" alt-text="Screenshot of the hierarchy for objects in Azure.":::

Having seen the top-down hierarchy of organization, let's describe each of those levels from the bottom up:

- **Resources**: Resources are instances of services that you create, like virtual machines, storage, or SQL databases.
- **Resource groups**: Resources are combined into resource groups. Resource groups act as a logical container into which Azure resources like web apps, databases, and storage accounts are deployed and managed.
- **Subscriptions**: A subscription groups together user accounts and the resources that have been created by those user accounts. For each subscription, there are limits or quotas on the amount of resources that you can create and use. Organizations can use subscriptions to manage costs and the resources that are created by users, teams, or projects.
- **Management groups**: These groups help you manage access, policy, and compliance for multiple subscriptions. All subscriptions in a management group automatically inherit the conditions applied to the management group.

You'll examine each of these four organizational levels in the next few units.
