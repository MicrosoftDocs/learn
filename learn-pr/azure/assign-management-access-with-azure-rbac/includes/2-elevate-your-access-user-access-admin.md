
The administrator for the marketing department's Azure subscription recently left the organization. You now need to give management access for the subscription to another person in the marketing department.

In this unit, you'll explore when you may need to elevate access. You'll also discover how you can manage access to Azure subscriptions, either through the Azure portal or, through Azure PowerShell.

## When to elevate management access

Azure Active Directory (Azure AD) and role-based access control (RBAC) for Azure have independent permission schemes. RBAC is for managing access to Azure resources like virtual machines, key vaults, storage and much more. Azure AD administrator roles are for managing Azure AD resources such as user accounts and passwords.

By default, the Global Administrator doesn't have access to Azure resources. The global administrator for Azure AD can temporarily elevate their permissions to the RBAC role of *User Access Administrator*. This action grants the RBAC permissions needed to manage Azure resources, even at a subscription level. The User Access Administrator is assigned at the scope of root. The role can view all resources, and assign access, in any subscription or management group in that Azure AD organization.

The following diagram shows what resources the Global Administrator has access to when their permissions are elevated to User Access Administrator.

![Diagram that shows User Access Admin elevated privilege relationships](../media/2-globaladmin-user-access-admin.png)

A global administrator may need to elevate their permissions to:

- Regain lost access to a Azure subscription or management group
- Grant a user access to a Azure subscription or management group
- View an organization's Azure subscriptions or management groups
- Give rights to an automation app, so it can access Azure subscriptions or management groups

After the global administrator elevates their permissions to User Access Administrator, they can then grant others the RBAC permissions that they need to control and manage Azure resources. The global administrator should revoke the elevated permissions when the task is done.

## Manage access to Azure subscriptions

You can grant a user management access to a subscription in the Azure portal or by using Azure PowerShell or the REST API.

The following example shows how you can view roles assignments for a user by using Azure PowerShell.

```PowerShell
Get-AzRoleAssignment -ResourceGroupName testRG -SignInName bala.shandu@contoso.com
```
The following example shows how to remove a role assignment for a user by using Azure PowerShell.
```PowerShell
Remove-AzRoleAssignment -ResourceGroupName testRG -SignInName bala.shandu@contoso.com -RoleDefinitionName Reader
```

