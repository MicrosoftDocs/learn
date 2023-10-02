Azure Virtual Desktop has a delegated access model that lets you define the amount of access a particular user is allowed to have by assigning them a role.

A role assignment has three components: security principal, role definition, and scope.

The Azure Virtual Desktop delegated access model is based on the Azure role-based access control (RBAC) model.

Azure Virtual Desktop delegated access supports the following values for each element of the role assignment:

**Security principal**

 -  Users
 -  User groups
 -  Service principals

**Role definition**

 -  Built-in roles
 -  Custom roles

**Scope**

 -  Host pools
 -  App groups
 -  Workspaces

## PowerShell cmdlets for role assignments

Azure Virtual Desktop uses Azure role-based access control (RBAC) while publishing app groups to users or user groups. The Desktop Virtualization User role is assigned to the user or user group and the scope is the app group. This role gives the user special data access on the app group.

Run the following cmdlet to add Azure Active Directory users to an app group:

```powershell
New-AzRoleAssignment -SignInName <userupn> -RoleDefinitionName "Desktop Virtualization User" -ResourceName <appgroupname> -ResourceGroupName <resourcegroupname> -ResourceType 'Microsoft.DesktopVirtualization/applicationGroups'
```

Run the following cmdlet to add Azure Active Directory user group to an app group:

```powershell
New-AzRoleAssignment -ObjectId <usergroupobjectid> -RoleDefinitionName "Desktop Virtualization User" -ResourceName <appgroupname> -ResourceGroupName <resourcegroupname> -ResourceType 'Microsoft.DesktopVirtualization/applicationGroups'
```
