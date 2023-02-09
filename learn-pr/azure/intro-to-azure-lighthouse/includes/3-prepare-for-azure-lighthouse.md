Now you have a better understanding of the benefits and capabilities of using Azure Lighthouse; you're beginning to see how Azure Lighthouse can help you deliver services to your three new customers.

Contoso has existing customer onboarding and management processes. You'd like to understand what's needed to onboard a customer using Azure Lighthouse.

In this unit, you'll take a close look at Azure tenants and how they work with Azure Lighthouse, and the use of roles and users in the day-to-day management of customers. Finally, you'll learn security recommendations about access to, and using, Azure Lighthouse. These concepts and associated decisions will be used regardless of whether you deploy Azure Lighthouse via Azure Resource Manager templates or through private or global Azure Marketplace offers.

## Getting started

Using Azure Lighthouse fundamentally changes the way you interact with, and manage, your new and future Azure customer tenants. With your existing Azure customers, each of your service provider users needed to have an account in your customer's tenant to do management tasks. Under Azure Lighthouse, there's only one tenant for your Contoso staff to use. That's your own.

Through Azure delegated resource management, your customer's Azure subscriptions or resources are logically mapped to Contoso's Azure tenant, relevant to the service provider user who is logged in.  It means the assigned Contoso managed service user only has access to view and manage those specific resources that they have delegated access to. With this in mind, you can segregate your team to include, for example:

- A group of Helpdesk staff with access to view the status of the customers' virtual machines
- A group of Backup Management staff with access to manage Azure Backup for your customers
- A group of project staff with a higher level of access to all of the resources inside particular resource groups in your customer's environment

This logical mapping is automatically created when the customer accepts a Service Management offering on the Azure Marketplace. It also occurs when they deploy one of your Azure Resource Manager templates on their Azure tenant, where you'll specify these access levels and the scope of their application.

These access levels are defined and enforced using Azure's role-based access control. Let's take a deeper look at those roles and authorizations.

## Roles and authorizations

Once you've confirmed how the service teams at Contoso are structured, to deliver the requirements of the customer's service contracts, you need to identify which roles in Azure best provide those access levels. The roles need to exist in the list of built-in Azure role-based access control (RBAC) definitions.

- **Customer 1** has requested that we manage and administer their entire Azure subscription and all of its resources. The **Contributor** role would be the best choice here, since this role has the broadest scope for use across a customer subscription. As this role has a high level of access, you'll limit it to a small group of senior technical staff at Contoso.

> [!TIP]
> You can apply roles to a group name in your Azure resource manager templates to onboard your customer to Azure Lighthouse. Then during the life of that services contract, you can add and remove your Contoso staff to that group as required within your own Azure tenant, without needing to make any changes to your customer's delegated resource access.  

- **Customer 2's** service contract is limited to resources inside one particular resource group called "cust2-rg1". Your Contoso staff only needs **Reader** access to this resource group and its resources, so the Reader role and it's associated permissions are appropriate here.

> [!TIP]
> Authorizations applied at a resource group level will apply to all existing resources in that resource group and will be inherited by all new resources created in that resource group.

- For **Customer 3**, the staff at Contoso also need read access but for two different resource groups. Again, the **Reader** role is the most appropriate choice.

When applying these roles to your service offer, you don't use the Identity and Access Management blade in the Azure portal as you usually would for granting role-based access control. Instead, you create an authorization. Each authorization defines a user (or group) and the role they'll be granted for the delegated resources. It also forms a required part of Azure Resource Manager templates, if you're using them to onboard a customer to Azure Lighthouse.

## Best practices

If you're thinking about users and roles, especially for  Azure delegated resource management, there are guidelines you should try to adhere to:

- Avoid assigning an individual Contoso user to a role. It's better to appoint an Azure AD user group or a service principal. It mitigates the need to update the offer each time your Contoso staff change.
- Ensure that at least one Contoso user is granted the **Managed Services Registration Assignment Delete** role. It allows you to remove the delegated access at the completion of your service contract, otherwise the customer has to remove it from their Azure tenant.
- You can't use custom role definitions or the Owner role. For a list of the current built-in roles and their IDs, visit [Azure built-in roles](/azure/role-based-access-control/built-in-roles).
- You also need to avoid using any built-in roles that have **DataAction** permissions.

## Permission structures

Contoso already uses Azure AD user groups and roles to control access to its own Azure resources. To simplify the authorizations you'll assign to your managed service offers, you've decided to create a dedicated suite of Azure AD user groups and associated roles in your tenant.

| **Group name**                     | **Type**   | **Role definition**                             |
| ---------------------------------- | ---------- | ----------------------------------------------- |
| Customer_Helpdesk                  | User group | Reader                                          |
| Customer_Backup_Management         | User group | Backup Contributor                                     |
| Customer_Subscription_Management   | User group | Contributor                                     |

> [!NOTE]
> When you create each of these user groups in your Contoso Azure Active Directory, make a note of their Object ID. You'll need that for the onboarding process.

With your permission structure defined, you need to assign users to these groups. Remember, Contoso staff in these groups will have access to all customers where this group has been used in an authorization. If you have a customer with a specific security requirement where you need to limit access to only certain Contoso staff (for example, people who have done certain accredited training), consider creating groups just for this customer and using only those groups in their authorization.

## Security considerations

Security is a constant consideration for any Azure Active Directory environment. When you introduce Azure delegated resource management into your tenant, you should also consider the security of your customers. Considerations should include:

- Implementing Azure AD Multi-Factor Authentication for all users in your Contoso tenant, including any users with responsibility for managing customers with Azure Lighthouse. This authentication method reduces the likelihood of attackers gaining access to your customers' resources via your Contoso Azure AD tenant.
- Apply the **principle of least privilege** when giving permissions to your users - Contoso users should have enough permissions to do their job and no more.
