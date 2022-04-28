If your organization has several subscriptions, you may need a way to efficiently manage access, policies, and compliance for those subscriptions. Azure management groups provide a level of scope above subscriptions. You organize subscriptions into containers called *management groups* and apply your governance conditions to the management groups. Management group enable:

 -  Organizational alignment for your Azure subscriptions through custom hierarchies and grouping.
 -  Targeting of policies and spend budgets across subscriptions and inheritance down the hierarchies.
 -  Compliance and cost reporting by organization (business/teams).

:::image type="content" source="../media/management-groups-aa92c04a.png" alt-text="Diagram showing how Azure management groups are used to organize subscriptions in a hierarchy of unified policy and access management. A single top-level management, or root group Contoso and every directory below is folded into it.":::


All subscriptions within a management group automatically inherit the conditions applied to the management group. For example, you can apply policies to a management group that limits the regions available for virtual machine (VM) creation. This policy would be applied to all management groups, subscriptions, and resources under that management group by only allowing VMs to be created in that region.

## Adding management groups

You can create the management group by using the portal, PowerShell, or Azure CLI. 

:::image type="content" source="../media/create-management-groups-66ff9f21.png" alt-text="Screenshot of the Add a Managment group page.":::


 -  The **Management Group ID** is the directory unique identifier that is used to submit commands on this management group. This identifier is not editable after creation as it is used throughout the Azure system to identify this group.
 -  **The Display Name** field is the name that is displayed within the Azure portal. A separate display name is an optional field when creating the management group and can be changed at any time.

> [!NOTE]
> Do you think you will use Management Groups? If so, how do you plan to implement them?
