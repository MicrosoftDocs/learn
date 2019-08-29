
The administrator for the marketing department's Azure subscription recently left the organization. You now need to give management access for the relevant subscription to another person in the marketing department.

In this unit, you'll explore which types of use cases may need you to elevate access. You'll also discover how you can manage access to Azure subscriptions either through the Azure portal or through Azure PowerShell.

## Use cases for elevated user access

Azure AD and Azure role-based access control (RBAC) are independent permission schemes. RBAC is for managing access to Azure resources like virtual machines, key vaults, storage and much more. Azure AD administrator roles are for managing directory resources such as user accounts and passwords.

![User Access Admin Elevated Privilege](../media/2-elevate-access.png)

However, the global administrator for Azure AD can temporarily elevate permissions to the RBAC role of *User Access Administrator*. This action grants the RBAC permissions needed to manage Azure resources, even at a subscription level. The User Access Administrator is assigned at root scope and can view all resources and assign access in any subscription or management group in that Azure AD directory.

Some typical use cases include:

- To regain lost access to a given Azure subscription or management group.
- To grant an administrator or another user access to a given Azure subscription or management group.
- To view an organization's Azure subscriptions or management groups.
- To give rights to an automation app, so it can access Azure subscriptions or management groups.

Although the two permission schemes are separate, there are many instances, particularly relating to employee churn, where the global AD administrator will need to elevate their permissions. The global AD administrator can then assign the User Access Administrator role to the relevant employee. This process hands off the controlling and assigning access to Azure resources at a granular level to someone responsible for that task. Equally, based on the security principle of least privilege, those elevated permissions should be revoked when the task is done.

## Manage access to Azure subscriptions

You can assign employee management access to a subscription with the Azure portal. Other methods you can use include Azure PowerShell, Azure CLI and use a REST API Elevate Access call.

Below is an example showing how you can view roles assignments set for a user using Azure PowerShell.

```PowerShell
Get-AzRoleAssignment -ResourceGroupName testRG -SignInName jenny.doe@contoso.com
```
Below is an example showing how to remove a role assignment for a user using Azure PowerShell.
```PowerShell
Remove-AzRoleAssignment -ResourceGroupName rg1 -SignInName jenny.doe@contoso.com -RoleDefinitionName Reader
```
It is important that you revoke permissions once the user has accomplished their tasks. You are able to easily and rapidly do this through any of the methods available to you in Azure.
