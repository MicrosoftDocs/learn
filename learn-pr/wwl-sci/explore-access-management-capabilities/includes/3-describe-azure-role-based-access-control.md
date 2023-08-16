
Azure AD roles control permissions to manage Azure AD resources. For example, allowing user accounts to be created, or billing information to be viewed.  Azure AD supports built-in and custom roles. 

Managing access using roles is known as **role-based access control (RBAC)**. Azure AD built-in and custom roles are a form of RBAC in that Azure AD roles control access to Azure AD resources.  This is referred to as Azure AD RBAC.

### Built-in roles

There are many Azure AD built-in roles, which are roles with a fixed set of permissions. A few of the most common built-in roles are:

- *Global administrator*: users with this role have access to all administrative features in Azure Active Directory. The person who signs up for the Azure Active Directory tenant automatically becomes a global administrator.
- *User administrator*: users with this role can create and manage all aspects of users and groups. This role also includes the ability to manage support tickets and monitor service health.
- *Billing administrator*: users with this role make purchases, manage subscriptions and support tickets, and monitor service health.

All built-in roles are preconfigured bundles of permissions designed for specific tasks.  The fixed set of permissions included in the built-in roles can't be modified.

### Custom roles

Although there are many built-in admin roles in Azure AD, custom roles give flexibility when granting access. A custom role definition is a collection of permissions that you choose from a preset list. The list of permissions to choose from are the same permissions used by the built-in roles.  The difference is that you get to choose which permissions you want to include in a custom role.

Granting permission using custom Azure AD roles is a two-step process.  The first step involves creating a custom role definition, consisting of a collection of permissions that you add from a preset list.  Once you’ve created your custom role definition, the second step is to assign that role to users or groups by creating a role assignment. A role assignment grants the user the permissions in a role definition, at a specified scope.  A scope defines the set of Azure AD resources the role member has access to. 

Once you create a role definition and you can assign it many times at different scopes. A custom role can be assigned to one user at an organization-wide scope, meaning the role member has the role permissions over all resources. The same custom role can be assigned to another user at an object scope.  That object scope may be a single virtual machine or a single application, as an example.

Custom roles require an Azure AD Premium P1 or P2 license.

### Only grant the access users need

It's best practice, and more secure, to grant users the least privilege to get their work done. It means that if someone mostly manages users, you should assign the user administrator role, and not global administrator. By assigning least privileges, you limit the damage that could be done with a compromised account.

### Categories of Azure AD roles
As previously defined, Azure Active Directory (Azure AD) is Microsoft’s cloud-based identity and access management service.  Azure AD is an available service, if you subscribe to any Microsoft Online business offer, such as Microsoft 365 and Azure.

Available Microsoft 365 services include Azure AD, Exchange, SharePoint, Microsoft Defender, Teams, Intune, and many more.

Over time, some Microsoft 365 services, such as Exchange and Intune, have developed their own role-based access control systems, just like the Azure AD service has Azure AD roles to control access to Azure AD resources (Azure AD RBAC). Other services such as Teams and SharePoint don’t have separate role-based access control systems, they use Azure AD roles for their administrative access.

To make it convenient to manage identity across Microsoft 365 services, Azure AD has added some service-specific, built-in roles, each of which grants administrative access to a Microsoft 365 service. This means that Azure AD built-in roles differ in where they can be used.  There are three broad categories.

- Azure AD-specific roles: These roles grant permissions to manage resources within Azure AD only. For example, User Administrator, Application Administrator, Groups Administrator all grant permissions to manage resources that live in Azure AD.

- Service-specific roles: For major Microsoft 365 services, Azure AD includes built-in, service-specific roles that grant permissions to manage features within the service. For example, Azure AD includes built-in roles for Exchange Administrator, Intune Administrator, SharePoint Administrator, and Teams Administrator roles that can manage features with their respective services.

- Cross-service roles: There are some roles within Azure AD that span services. For example, Azure AD has security-related roles, like Security Administrator, that grant access across multiple security services within Microsoft 365.  Similarly, with the Compliance Administrator role you can manage compliance-related settings in Microsoft Purview Compliance Manager, Exchange, and so on.

:::image type="content" source="../media/role-overlap-diagram-v2.png" alt-text="Azure AD role categories":::

### Difference between Azure AD RBAC and Azure RBAC
As described above, Azure AD built-in and custom roles are a form of RBAC in that Azure AD roles control access to Azure AD resources.  This is referred to as Azure AD RBAC.  In the same way that Azure AD roles can control access to Azure AD resources, so too can Azure roles control access to Azure resources.  This is referred to as Azure RBAC.  Although the concept of RBAC applies to both Azure AD RBAC and Azure RBAC, what they control are different.

- Azure AD RBAC - Azure AD roles control access to Azure AD resources such as users, groups, and applications.
- Azure RBAC - Azure roles control access to Azure resources such as virtual machines or storage using Azure Resource Management.

There are different data stores where role definitions and role assignments are stored. Similarly, there are different policy decision points where access checks happen.

:::image type="content" source="../media/azure-roles-azure-ad-roles.png" alt-text="Azure AD roles are different than Azure roles":::
