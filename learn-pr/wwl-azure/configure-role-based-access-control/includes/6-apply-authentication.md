Built-in role definitions are defined for several categories of services, tasks, and users. You can assign built-in roles at different scopes to support various scenarios, and build custom roles from the base definitions.

Microsoft Entra ID also provides built-in roles to manage resources in Microsoft Entra ID, including users, groups, and domains. Microsoft Entra ID offers [administrator roles](/azure/active-directory/roles/permissions-reference) that you can implement for your organization, such as _Global admin_, _Application admin_, and _Application developer_.

The following diagram illustrates how you can apply Microsoft Entra administrator roles and Azure roles in your organization.

:::image type="content" source="../media/role-based-authentication-b3dda7ae.png" alt-text="Diagram that shows how Microsoft Entra admin roles and Azure roles can be used together to authenticate users and control access to resources." border="false":::

- **Microsoft Entra admin roles** are used to manage resources in Microsoft Entra ID, such as users, groups, and domains. These roles are defined for the Microsoft Entra tenant at the root level of the configuration.

- **Azure RBAC roles** provide more granular access management for Azure resources. These roles are defined for a requestor or resource and can be applied at multiple levels: the root, management groups, subscriptions, resource groups, or resources.
