Azure role-based access control (RBAC) is a system that enables granular access management of Azure resources. Azure Administrators use Azure RBAC to segregate duties within a team, and grant users the specific access they need to perform their jobs.

In this module, you identified the features and use cases for RBAC. You discovered how to create role definitions and role assignments, and find and use built-in Azure RBAC roles. You explored how to use RBAC to manage access to subscriptions with RBAC. You reviewed the differences between Azure RBAC and Microsoft Entra roles. 

The main takeaways from this module are:
- Azure RBAC is a system that enables granular access management of Azure resources. It allows you to segregate duties within a team and grant users specific access based on their job requirements.
- Role definitions in Azure RBAC define sets of permissions that list the allowed operations. You can use built-in role definitions or create custom role definitions to meet the specific requirements of your organization.
- Role assignments attach role definitions to security principals at a particular scope. This assignment determines the level of access granted to the requestor. Access can be revoked by removing a role assignment.
- Azure RBAC roles can be assigned at different scopes, including management groups, subscriptions, resource groups, and resources. The scope limits the permissions available to the assigned requestor.
- Azure RBAC roles and Entra ID administrator roles can be used together to manage access to both Azure resources and Entra ID resources.

## Learn more with Azure documentation

- [Understand Microsoft Entra role-based access control](/azure/active-directory/roles/custom-overview#understand-microsoft-entra-role-based-access-control). This article describes how to understand Microsoft Entra role-based access control.

- [Understand roles in Microsoft Entra ID](/azure/active-directory/roles/concept-understand-roles?source=recommendations). This article explains what Microsoft Entra roles are and how they can be used.

- [Azure built-in roles](/azure/role-based-access-control/built-in-roles). This article lists the Azure built-in roles. If you are looking for administrator roles visit [Microsoft Entra built-in roles](/azure/active-directory/roles/permissions-reference).

- [Understand Azure role assignments](/azure/role-based-access-control/role-assignments). This article describes the details of role assignments.

## Learn more with optional hands-on exercises

- [Secure your Azure resources with RBAC (subscription required)](/training/modules/secure-azure-resources-with-rbac/).

- [Create custom roles for Azure resources with RBAC](/training/modules/create-custom-azure-roles-with-rbac/).


