Azure AD roles control permissions to manage Azure AD resources. For example, allowing user accounts to be created, or billing information to be viewed.  Azure AD supports built-in and custom roles. 

Managing access using roles is known as **role-based access control (RBAC)**. Azure AD built-in and custom roles are a form of RBAC in that Azure AD roles control access to Azure AD resources.  This is referred to as Azure AD RBAC.

### Built-in roles

There are many Azure AD built-in roles, which are roles with a fixed set of role permissions. A few of the most common built-in roles are:

- *Global administrator*: users with this role have access to all administrative features in Azure Active Directory. The person who signs up for the Azure Active Directory tenant automatically becomes a global administrator.
- *User administrator*: users with this role can create and manage all aspects of users and groups. This role also includes the ability to manage support tickets and monitor service health.
- *Billing administrator*: users with this role make purchases, manage subscriptions and support tickets, and monitor service health.

All built-in roles are preconfigured bundles of permissions designed for specific tasks.

### Custom roles

Although there are many built-in admin roles in Azure AD, custom roles give flexibility when granting access.

Granting permission using custom Azure AD roles is a two-step process.  The first step involves creating a custom role definition, consisting of a collection of permissions that you add from a preset list. These permissions are the same ones used in the built-in roles.  Once you’ve created your custom role definition, the second step is to assign that role to users or groups by creating a role assignment.

A role assignment grants the user the permissions in a role definition, at a specified scope.  A scope defines the set of Azure AD resources the role member has access to.  A custom role can be assigned at organization-wide scope, meaning the role member has the role permissions over all resources. A custom role can also be assigned at an object scope. An example of an object scope would be a single application.  The same role can be assigned to one user over all applications in the organization and then to another user with a scope of only the Contoso Expense Reports app.

Unlike built-in roles, which are assigned at a tenant level and are preconfigured bundles of permissions designed for specific tasks, custom roles can be assigned at the resource level (such as a single application) and allow permissions to be added to a custom role definition.

Custom roles require an Azure AD Premium P1 or P2 license.

### Only grant the access users need

It's best practice, and more secure, to grant users the least privilege to get their work done. It means that if someone mostly manages users, you should assign the user administrator role, and not global administrator. This mitigates the risk of a user account being compromised, and a hacker locking you out of your account. By assigning least privileges, you limit the damage that could be done with a compromised account.

### Categories of Azure AD roles
As previously defined, Azure Active Directory (Azure AD) is Microsoft’s cloud-based identity and access management service.  Azure AD is an available service, if you subscribe to any Microsoft Online business offer, such as Microsoft 365 and Azure.

Available Microsoft 365 services include Azure AD, Exchange, SharePoint, Microsoft Defender, Teams, Intune, and many, many more.

Over time, some Microsoft 365 services, such as Exchange and Intune, have developed their own role-based access control systems, just like the Azure AD service has Azure AD roles to control access to Azure AD resources (Azure AD RBAC). Other services such as Teams and SharePoint don’t have separate role-based access control systems, they use Azure AD roles for their administrative access.

To make it convenient to manage identity across Microsoft 365 services, Azure AD has added some service-specific, built-in roles, each of which grants administrative access to a Microsoft 365 service. This means that Azure AD built-in roles differ in where they can be used.  There are three broad categories.

- Azure AD-specific roles: These roles grant permissions to manage resources within Azure AD only. For example, User Administrator, Application Administrator, Groups Administrator all grant permissions to manage resources that live in Azure AD.

- Service-specific roles: For major Microsoft 365 services (non-Azure AD), Azure AD includes built-in, service-specific roles that grant permissions to manage features within the service. For example, Azure AD includes built-in roles for Exchange Administrator, Intune Administrator, SharePoint Administrator, and Teams Administrator roles which can manage features with their respective services.

- Cross-service roles: There are some roles within Azure AD that span services. For example, Azure AD has security-related roles, like Security Administrator, that grant access across multiple security services within Microsoft 365.  Similarly the Compliance Administrator role you can manage Compliance-related settings in Microsoft 365 Compliance Center, Exchange, and so on.

:::image type="content" source="../media/role-overlap-diagram.png" alt-text="Azure AD role categories":::

### Difference between Azure AD RBAC and Azure RBAC
As described above, Azure AD RBAC controls access to Azure AD resources.  Azure has its own role-based access control system (Azure RBAC) to manage who has access to Azure resources, such as virtual machines, storage, and more.  Azure RBAC is not the same as Azure AD RBAC. There are different data stores where role definitions and role assignments are stored. Similarly, there are different policy decision points where access checks happen.

:::image type="content" source="../media/azure-roles-azure-ad-roles.png" alt-text="Azure AD roles are different than Azure roles":::
