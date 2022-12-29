[Governance](/azure/cloud-adoption-framework/govern/guides/) provides mechanisms and processes to maintain control over your applications and resources in Azure. Governance involves determining your requirements, planning your initiatives, and setting strategic priorities.

To effectively apply your governance strategies, you must first create a hierarchical structure for your organizational environment. This structure lets you apply governance strategies exactly where they're needed. The governance strategies we cover in this module are Azure policy and resource tags. 

:::image type="content" source="../media/governance-strategies.png" alt-text="Diagram of the Azure hierarchy that shows the tenant root group, management groups, subscriptions, resource groups, and resources." border="false":::

A typical Azure hierarchy has four levels: management groups, subscriptions, resource groups, and resources. We examine the details of these levels later in this module.

- **Management groups** help you manage access, policy, and compliance for multiple subscriptions.

- **Subscriptions** are logical containers that serve as units of management and scale. Subscriptions are also billing boundaries.

- **Resource groups** are logical containers into which Azure resources are deployed and managed.

- **Resources** are instances of services that you create. For example, virtual machines, storage, and SQL databases.

> [!NOTE]
> The **tenant root group** contains all the management groups and subscriptions. This group allows global policies and Azure role assignments to be applied at the directory level.