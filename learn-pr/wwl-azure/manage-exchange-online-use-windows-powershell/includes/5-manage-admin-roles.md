Just as there are varying roles that you can use to control management permissions for Microsoft 365, there are roles in Exchange Online as well. In Exchange Online, the preconfigured management roles are referred to a role group, because a group has been assigned the permissions. The following table lists some of the default role groups.

*Table 1: Role groups in Exchange Online*

| Role group                        | Description                                                  |
| --------------------------------- | ------------------------------------------------------------ |
| Organization Management           | Performs all Exchange Online management tasks.                |
| Recipient Management              | Manages recipients such as mailboxes and distribution groups. |
| View-only Management              | Reviews the configuration of all Exchange Online components but doesn't modify them. |
| Records Management                | Manages retention, journaling, and transport rules.           |
| Discovery Management              | Manages legal holds and mailbox searches.                         |

You can review information about role groups by using the **Get-RoleGroup** cmdlet. You can modify membership in role groups by using the **Add-RoleGroupMember** and **Remove-RoleGroupMember** cmdlets. The following example depicts how to add a user to the Recipient Management role group:

```powershell
Add-RoleGroupMember -Identity "Recipient Management" -Member AbbieP@adatum.com
```

The default roles groups are sufficient for many organizations. However, you can create customized role groups that allow you to define granular permissions, down to specific cmdlets that users are allowed to run. You can also define scopes that control which users or groups that administrators are allowed to manage.

> **Additional reading:** For more detailed information about role groups and permissions in Exchange Online, refer to [Permissions in Exchange Online](https://aka.ms/permissions-in-exchange-online).
