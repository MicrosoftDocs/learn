In Microsoft 365, roles are used to assign administrative permissions to user accounts. The Global Administrator role gives users permission to manage all aspects of Microsoft 365. Other roles allow users to manage only a subset of Microsoft 365 features. The following table lists some of the Microsoft 365 roles that can be assigned to users.

*Table 1: Microsoft 365 roles*

| Role                     | Description                                                  |
| ------------------------ | ------------------------------------------------------------ |
| Global Reader            | Can review settings for all aspects of Microsoft 365.                   |
| Exchange Administrator   | Can review and manage settings for Exchange Online.            |
| Helpdesk admin           | Can reset passwords for non-administrative accounts, force non-administrative users to sign out, manage service requests, and monitor service health. |
| Service support admin    | Can open and manage service requests, review and share message center posts, and monitor service health. |
| SharePoint Administrator | Can review and manage settings for SharePoint Online.          |
| Teams Administrator      | Can review and manage settings for Microsoft Teams.            |
| User Administrator       | Can review and manage user accounts.                           |

> [!NOTE]
> Role names can vary depending on whether you review them in the web-based admin consoles, AzureAD cmdlets, or Msol cmdlets.

## Managing roles with Microsoft Entra PowerShell

Microsoft Entra PowerShell requires you to identify whether a role is already in use before you can assign it to a user. If no users have been assigned to a role, then it exists only as a template, and you need to enable the role before you can add users to it. You can use the `Get-EntraDirectoryRole` cmdlet to review the roles that are enabled. Use the `Get-EntraDirectoryRoleTemplate` cmdlet to review the roles that aren't yet enabled.

The following example depicts how to enable the User Administrator role. When you enable the role, you need to refer to the object ID of the template:

```powershell
$roleTemplate = Get-EntraDirectoryRoleTemplate | Where-Object {$_.DisplayName -eq 'User Administrator'}
Enable-EntraDirectoryRole -RoleTemplateId $roleTemplate.Id
```

After you enable the role, you can add a role member to assign administrative permissions by using the `Add-EntraDirectoryRoleMember` cmdlet. The following example depicts how to add an account to the User Administrator role. The `-ObjectId` parameter refers to the object ID of the role. The `-RefObjectId` parameter refers to the object ID of the user account:

```powershell
$user = Get-EntraUser -UserId AbbieP@adatum.com
$role = Get-EntraDirectoryRole | Where-Object {$_.DisplayName -eq 'User Administrator'}
Add-EntraDirectoryRoleMember -ObjectId $role.Id -RefObjectId $user.Id
```

To list existing members of a role, use `Get-EntraDirectoryRoleMember`. To remove a member from a role, use `Remove-EntraDirectoryRoleMember`.
