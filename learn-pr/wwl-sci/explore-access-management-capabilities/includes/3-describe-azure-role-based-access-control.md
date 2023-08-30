
Microsoft Entra roles control permissions to manage Microsoft Entra resources. For example, allowing user accounts to be created, or billing information to be viewed.  Microsoft Entra supports built-in and custom roles. 

Managing access using roles is known as **role-based access control (RBAC)**. Microsoft Entra built-in and custom roles are a form of RBAC in that Microsoft Entra roles control access to Microsoft Entra resources.  This is referred to as Microsoft Entra RBAC.

### Built-in roles

Microsoft Entra ID includes many built-in roles, which are roles with a fixed set of permissions. A few of the most common built-in roles are:

- *Global administrator*: users with this role have access to all administrative features in Microsoft Entra. The person who signs up for the Microsoft Entra tenant automatically becomes a global administrator.
- *User administrator*: users with this role can create and manage all aspects of users and groups. This role also includes the ability to manage support tickets and monitor service health.
- *Billing administrator*: users with this role make purchases, manage subscriptions and support tickets, and monitor service health.

All built-in roles are preconfigured bundles of permissions designed for specific tasks.  The fixed set of permissions included in the built-in roles can't be modified.

### Custom roles

Although there are many built-in admin roles in Microsoft Entra ID, custom roles give flexibility when granting access. A custom role definition is a collection of permissions that you choose from a preset list. The list of permissions to choose from are the same permissions used by the built-in roles.  The difference is that you get to choose which permissions you want to include in a custom role.

Granting permission using custom Microsoft Entra roles is a two-step process.  The first step involves creating a custom role definition, consisting of a collection of permissions that you add from a preset list.  Once you’ve created your custom role definition, the second step is to assign that role to users or groups by creating a role assignment.

A role assignment grants the user the permissions in a role definition, at a specified scope.  A scope defines the set of Microsoft Entra ID resources the role member has access to.  A custom role can be assigned at organization-wide scope, meaning the role member has the role permissions over all resources. A custom role can also be assigned at an object scope. An example of an object scope would be a single application.  The same role can be assigned to one user over all applications in the organization and then to another user with a scope of only the Contoso Expense Reports app.

Custom roles require an Microsoft Entra ID premium license.

### Only grant the access users need

It's best practice, and more secure, to grant users the least privilege to get their work done. It means that if someone mostly manages users, you should assign the user administrator role, and not global administrator. By assigning least privileges, you limit the damage that could be done with a compromised account.

### Categories of Microsoft Entra roles

Microsoft Entra ID is an available service if you subscribe to any Microsoft Online business offer, such as Microsoft 365 and Azure.

Available Microsoft 365 services include Microsoft Entra ID, Exchange, SharePoint, Microsoft Defender, Teams, Intune, and many more.

Over time, some Microsoft 365 services, such as Exchange and Intune, have developed their own role-based access control systems (RBAC), just like the Microsoft Entra ID service has Microsoft Entra roles to control access to Microsoft Entra resources. Other services such as Teams and SharePoint don’t have separate role-based access control systems, they use Microsoft Entra roles for their administrative access.

To make it convenient to manage identity across Microsoft 365 services, Microsoft Entra ID has added some service-specific, built-in roles, each of which grants administrative access to a Microsoft 365 service. This means that Microsoft Entra ID built-in roles differ in where they can be used.  There are three broad categories.

- Microsoft Entra ID specific roles: These roles grant permissions to manage resources within Microsoft Entra ID only. For example, User Administrator, Application Administrator, Groups Administrator all grant permissions to manage resources that live in Microsoft Entra ID.

- Service-specific roles: For major Microsoft 365 services, Microsoft Entra ID includes built-in, service-specific roles that grant permissions to manage features within the service. For example, Microsoft Entra ID includes built-in roles for Exchange Administrator, Intune Administrator, SharePoint Administrator, and Teams Administrator roles that can manage features with their respective services.

- Cross-service roles: There are some roles within Microsoft Entra ID that span services. For example, Microsoft Entra ID has security-related roles, like Security Administrator, that grant access across multiple security services within Microsoft 365.  Similarly, the Compliance Administrator role grants access to manage Compliance-related settings in Microsoft 365 Compliance Center, Exchange, and so on.

:::image type="content" source="../media/role-overlap-diagram-v4-inline.png" lightbox="../media/role-overlap-diagram-v4-expanded.png" alt-text="Diagram of Microsoft Entra role categories.":::

### Difference between Microsoft Entra RBAC and Azure RBAC
As described above, Microsoft Entra ID built-in and custom roles are a form of RBAC in that they control access to Microsoft Entra resources.  This is referred to as Microsoft Entra RBAC.  In the same way that Microsoft Entra roles can control access to Microsoft Entra resources, so too can Azure roles control access to Azure resources.  This is referred to as Azure RBAC.  Although the concept of RBAC applies to both Microsoft Entra RBAC and Azure RBAC, what they control are different.

- Microsoft Entra RBAC - Microsoft Entra roles control access to Microsoft Entra resources such as users, groups, and applications.
- Azure RBAC - Azure roles control access to Azure resources such as virtual machines or storage using Azure Resource Management.

There are different data stores where role definitions and role assignments are stored. Similarly, there are different policy decision points where access checks happen.
