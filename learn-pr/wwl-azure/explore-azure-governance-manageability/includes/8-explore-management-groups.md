If your organization has several subscriptions, you might need a way to efficiently manage access, policies, and compliance for those subscriptions. Azure management groups provide a level of scope above subscriptions. You organize subscriptions into containers called **management groups** and apply your governance conditions to the management groups. Management groups enable:

- Organizational alignment for your Azure subscriptions through custom hierarchies and grouping.
- Targeting of policies and budgets across subscriptions and inheritance down the hierarchies.
- Compliance and cost reporting by organization (business/teams).

:::image type="content" source="../media/management-groups-hierarchy-5e484a98.png" alt-text="Diagram showing how Azure management groups are used to organize subscriptions in a hierarchy of unified policy and access management.":::

All subscriptions within a management group automatically inherit the conditions applied to the management group. For example, you can apply policies to a management group that limits the regions available for virtual machine (VM) creation. This policy would be applied to all management groups, subscriptions, and resources under that management group by only allowing VMs to be created in that region.

> [!NOTE]
> Management groups is a relatively new concept in Azure. For more information, see [Organize your resources with Azure management groups](/azure/azure-resource-manager/management-groups-overview).
