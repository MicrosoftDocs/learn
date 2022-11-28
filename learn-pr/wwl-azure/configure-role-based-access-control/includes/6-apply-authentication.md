Built-in role definitions in Azure RBAC are defined for several categories of services, tasks, and users. You can assign built-in roles at different scopes to support various scenarios, and build custom roles from the base definitions.

Azure Active Directory (Azure AD) also provides built-in roles to manage resources in Azure AD, including users, groups, and domains. Azure AD offers [administrator roles](/azure/active-directory/roles/permissions-reference) that you can implement for your organization, such as _Global admin_, _Application admin_, and _Application developer_.

The following diagram illustrates how you can apply Azure AD administrator roles and Azure RBAC roles in your organization.

:::image type="content" source="../media/role-based-authentication-b3dda7ae.png" alt-text="Diagram that shows how Azure AD admin roles and Azure RBAC roles can be used together to authenticate users and control access to resources." border="false":::

- **Azure AD admin roles** are used to manage resources in Azure AD, such as users, groups, and domains. These roles are defined for the Azure AD tenant at the root level of the configuration.

- **Azure RBAC roles** provide more granular access management for Azure resources. These roles are defined for a requestor or resource and can be applied at multiple levels: the root, management groups, subscriptions, resource groups, or resources.
