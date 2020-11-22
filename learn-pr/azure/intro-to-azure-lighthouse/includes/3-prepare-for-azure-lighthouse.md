Now you have a better understanding of the benefits and capabilities of using Azure Lighthouse; you're beginning to see how to apply Azure Lighthouse to Lamna Healthcare.

Contoso has existing customer management processes and roles you use for other customers. You'd like to understand what's needed to get ready to onboard Lamna Healthcare, your first Azure Lighthouse customer.

In this unit, you'll take a close look at tenants and how they work with Azure Lighthouse, and the use of roles and users in the day-to-day management of customers. Finally, you'll learn about security recommendations about access to, and using, Azure Lighthouse.

## Getting started

Using Azure Lighthouse fundamentally changes the way you interact with, and manage, your new and future Azure customer tenants. With your existing Azure customers, each of your service provider users needed to have an account in your customer's tenant to do management tasks. Under Azure Lighthouse, there's only one tenant for your Contoso staff to use. That's your own.

Through Azure delegated resource management, Lamna Healthcare's Azure subscriptions or resource groups are logically mapped to Contoso's Azure tenant. Which means the assigned Contoso managed service users only access and manage those specific resources for Lamna Healthcare.

This logical mapping is automatically created when the customer accepts a Service Management offering on the Azure Marketplace. It also occurs when they deploy one of your Azure Resource Manager templates on their Azure tenant.

Before we get to onboarding Lamna Healthcare, there are a few more things you'll need to take care of at Contoso first. Next, you need to think about roles and authorizations.

## Roles and authorizations

When you make a managed service offer to Lamna Healthcare, one of the things you'll need to decide is which roles are required to manage that offering. These roles will be based on the type of tasks you'll perform. The roles needed to align with the built-in role-based access control (RBAC) list.

Lamna Healthcare has requested that we manage and administer their subscription. Also, they've mentioned they're interested in the management and security of their database systems within that subscription. The **Contributor** role would seem to be the obvious choice since this role does have the broadest scope for use across the Lamna Healthcare subscription. The Contributor role is better suited to managing administrative needs for the subscription rather than focused access. If the demand for a Contributor role is high, limit the group to senior Contoso managed service users. For Lamna Healthcare, we'll create a limited-access user group called Lamna Subscription Management.

For the other Contoso managed service users, you'll create specific, tightly focused roles to meet Lamna Healthcare's database management needs. For example, **SQL DB Contributor**, and **SQL Security Manager**.

Your managed service users will need to be assigned the **Reader** role (or another built-in role, which includes reader access) to view Lamna Healthcare's subscription, in the **My Customers** page.

When selecting roles for your Lamna Healthcare offering, you should consider that these roles have to work within the Azure delegated resource management framework. At this time, that means there are a few roles that aren't supported. You can't use custom roles or the Owner role. You'll also need to avoid using any built-in roles that have **DataAction** permissions.

When applying these roles to your service offer, you need to think of them differently. So, when presenting a managed service offer, you need to create authorizations. Each authorization defines a user and the role they'll be granted for the delegated resources.

## Best practices

If you're thinking about users and roles, especially for  Azure delegated resource management, there are guidelines you should try to adhere to:

- Avoid assigning an individual Contoso user to a role. It's better to appoint an Azure AD user group or a service principal. Which mitigates the need to update the offer each time you change a Contoso service manager user allocation.
- Ensure that at least one Contoso user in your tenant has the **Managed Services Registration Assignment Delete** role. Otherwise, removing delegated resources from your tenant can only be done by Lamna Healthcare from their Azure AD tenant.

## Permission structures

Contoso already uses Azure AD user groups and roles to control access to your systems. To simplify the authorizations you assign to your managed service offers, it's a good idea to create a dedicated suite of Azure AD user groups and associated roles.

For Lamna Healthcare, you already know the roles needed and, by following the good practice guide, you'll be using user groups. The table shows the permissions table you'll use for Lamna Healthcare.

| **Group name**                     | **Type**   | **Role definition**                             |
| ---------------------------------- | ---------- | ----------------------------------------------- |
| Lamna_Subscription_Management      | User group | Contributor                                     |
| Lamna_Database_Management          | User group | SQL DB Contributor & SQL Security Manager       |
| Lamna_Managed_Service_Registration | User group | Managed Services Registration Assignment Delete |
| Lamna_Policy_Automation_Account    | User group | User Access Administrator                       |
| Manage_Lighthouse_Customers        | User group | Reader                                          |

> [!NOTE]
> When you create each of these user groups in your Contoso Azure Active Directory, please make a note of the principal IDs. You'll need them for the onboarding process.

As Contoso onboards more Azure customers, the permissions structure will become more generic. For instance, you might want to use a single user group with the Contributor role to manage all your Azure customers' subscriptions, not just Lamna Healthcare.

With your permission structure defined, you need to assign users to these groups. It's essential to ensure you only add those Contoso users who will be responsible for managing Lamna Healthcare. When allocating users, bear in mind that, if you reuse the Lamna Healthcare permission structure for new managed service customers. The Contoso managed service users in those user groups will also gain access to the new customers' subscriptions or resource groups.

## Security considerations

Security is a constant consideration for any Azure Active Directory. When you introduce Azure delegated resource management into your tenant, you should also consider the security of your customers, including Lamna Healthcare.

When you prepare to onboard Lamna Healthcare, and for scaling Azure Lighthouse to all your other Azure customers later, there are a few things to do:

- Implement Azure AD Multi-Factor Authentication for all users in your service provider tenant, including any users with responsibility for managing Lamna Healthcare's subscription. This authentication method reduces the likelihood of attackers gaining access to Lamna Healthcare's systems or databases from the Contoso Azure AD tenant
- Apply the **principle of least privilege** when giving permissions to your users;  Contoso users should have enough permissions to do their job and no more