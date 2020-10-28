Access management occurs at the Azure subscription level. This control allows an organization to configure each division of the company in a specific fashion based on their responsibilities and requirements. Planning and keeping rules consistent across subscriptions can be challenging without a little help.

## Manage subscriptions by using management groups

Azure Management Groups are containers for managing access, policies, and compliance across _multiple_ Azure subscriptions. Management groups allow you to order your Azure resources hierarchically into collections, which provide a further level of classification that is above the level of subscriptions. All subscriptions within a management group automatically inherit the conditions applied to the management group. Management groups give you enterprise-grade management at a large scale no matter what type of subscriptions you might have.

The following diagram shows an example of creating a hierarchy for governance using management groups.

:::image type="complex" source="../media/4-management-groups-tree.png" alt-text="Tree diagram showing Azure Management Groups as a tree graph of relationships." border="false":::
Tree starts at root management group containing the human resources, IT, and marketing groups as well as two enterprise agreement subscriptions. Each of the groups also split into sub-groups and enterprise and free trial subscriptions.
:::image-end:::

You might create a hierarchy so you can apply a policy that, for example, limits VM locations to the US West Region for the "Geo Region 1" group. This policy will inherit onto both Enterprise Agreement (EA) subscriptions under that management group and will apply to all VMs under those subscriptions. This security policy cannot be altered by the resource or subscription owner allowing for improved governance.

Another scenario where you would use management groups is to provide user access to multiple subscriptions. By moving many subscriptions under that management group, you can create one role-based access control (RBAC) assignment on the management group that will allow that access to all the subscriptions. One assignment on the management group can enable users to have access to everything they need instead of scripting RBAC rules over different subscriptions.

You can manage your Azure subscriptions more effectively by using Azure Policy and Azure role-based access controls (RBACs). These provide distinct governance conditions that you can apply to each management group. The resources and subscriptions you assign to a management group automatically inherit the conditions that you apply to that management group.

> [!TIP]
> If you continue in the Azure Fundamentals learning path, you'll learn more about RBAC in the [Control and organize Azure resources with Azure Resource Manager](https://docs.microsoft.com/learn/modules/control-and-organize-with-azure-resource-manager/) module.

## Start using management groups

You can create management groups by using the Azure portal, Azure PowerShell, or Azure CLI.

The first time your organization creates a management group, there is an initial setup process. To get started in the portal, search for Management groups and select **Start using management groups**.

:::image type="content" source="../media/4-start-using-management-groups.png" alt-text="Screenshot of the management groups page in the Azure portal where there aren't any management groups yet. The button Start using management groups is enabled.":::

Create your first management group by entering a management group ID and display name. The management group ID is the directory unique identifier and isn't editable after the group is created. The management group display name is displayed within the Azure portal and can be changed at any time.

:::image type="content" source="../media/4-add-management-group.png" alt-text="Screenshot of the Add management groups page in the Azure portal. Select create new, and enter a management group ID and display name.":::


## Root management group for each organization

After you select **Save** on your first management group, a root management group is created in the Azure Active Directory (Azure AD) organization. By default, the root management group's display name is **Tenant root group**. The ID is the Azure AD ID. After this group is created, all existing subscriptions in the Azure AD organization are made children of the root management group. So there's only one management group hierarchy within an organization.

Having a single hierarchy within the organization allows administrators to apply global access and policies that other users within the organization can't bypass. Anything assigned on the root applies to the entire hierarchy, which includes all management groups, subscriptions, resource groups, and resources within that Azure AD organization.

The management group you create appears under the **Tenant root group**.

:::image type="content" source="../media/4-tenant-root-group.png" alt-text="Screenshot of the management groups page in the Azure portal with the tenant root group and the new management group displayed underneath.":::

Create additional management groups by selecting **Add management group**.

## Important facts about management groups

- Any Azure AD user in the organization can create a management group. The creator is given an Owner role assignment.
- A single Azure AD organization can support 10,000 management groups.
- A management group tree can support up to six levels of depth not including the Root level or subscription level.
- Each management group can have many children.
- When your organization creates subscriptions, they are automatically added to the root management group.
