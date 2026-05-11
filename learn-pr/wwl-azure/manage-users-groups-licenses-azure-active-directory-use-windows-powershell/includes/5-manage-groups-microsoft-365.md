Microsoft 365 has multiple types of groups that you can use to provide access to resources or send email. Each group type serves a different purpose, and you should select the correct type for your needs. The group types available in Microsoft 365 are listed in the following table.

*Table 1: Types of groups in Microsoft 365*

| Group type                  | Description                                                  |
| --------------------------- | ------------------------------------------------------------ |
| Microsoft 365 group         | Microsoft 365 groups are used for collaboration between users, both  inside and outside your company. With each Microsoft 365 group, members get a group email and shared workspace for conversations, files, and  calendar events, Microsoft Stream, and Microsoft Planner. |
| Distribution group          | Distribution groups are used for sending notifications to a group of people. They can receive external email if enabled by the administrator. |
| Security group              | Security groups are used for granting access to Microsoft 365 resources, such as SharePoint. They can make administration easier because you only need to administer the group rather than adding users to each resource individually. |
| Mail-enabled security group | A mail-enabled security group has the same functionality as a security group for assigning permissions, but it can also be used to send email messages just as you can with a distribution group. |

> **Additional reading:** For a detailed comparison of group types, refer to [Compare groups](/microsoft-365/admin/create-groups/compare-groups).

> [!NOTE]
> There are no AzureAD or Msol cmdlets for managing Microsoft 365 groups. The cmdlets for managing Microsoft 365 groups are part of Exchange Online, because these groups include a mailbox. In the Exchange Online cmdlets, Microsoft 365 groups are referred to as *unified groups*.

## Managing groups with Microsoft Entra PowerShell

You can create distribution groups, security groups, and mail-enabled security groups by using the `New-EntraGroup` cmdlet. The type of group created depends on how you use the `-MailEnabled` and `-SecurityEnabled` parameters. The following example creates a mail-enabled security group:

```powershell
New-EntraGroup -DisplayName "Marketing Group" -MailEnabled $true -SecurityEnabled $true -MailNickname MarketingGrp
```

When you create a new group, Microsoft Entra ID assigns the group an object ID. The object ID is a unique identifier for the group. You need to use the object ID with management cmdlets. You can't use a display name to refer to a group because it isn't guaranteed to be unique. Use the `Get-EntraGroup` cmdlet to identify the object ID for a group that you want to manage.

The following table lists other Microsoft Entra PowerShell cmdlets that you can use to manage groups.

*Table 2: Microsoft Entra PowerShell cmdlets for group management*

| Cmdlet                      | Description                                                  |
| --------------------------- | ------------------------------------------------------------ |
| `Get-EntraGroup`          | Queries for distribution groups, security groups, and mail-enabled security groups. This cmdlet supports using a filter or search string. |
| `Set-EntraGroup`          | Modifies the properties of distribution groups, security groups, and mail-enabled security groups. |
| `Remove-EntraGroup`       | Deletes distribution groups, security groups, and mail-enabled security groups. |
| `Get-EntraGroupMember`    | Queries the membership of distribution groups, security groups, and mail-enabled security groups. |
| `Add-EntraGroupMember`    | Adds a member to distribution groups, security groups, and mail-enabled security groups. |
| `Remove-EntraGroupMember` | Removes a member from distribution groups, security groups, and mail-enabled security groups. |
| `Get-EntraGroupOwner`     | Queries the owners of distribution groups, security groups, and mail-enabled security groups. |
| `Add-EntraGroupOwner`     | Adds an owner to distribution groups, security groups, and mail-enabled security groups. |
| `Remove-EntraGroupOwner`  | Removes an owner from distribution groups, security groups, and mail-enabled security groups. |

## Synchronized groups

Groups that you create in Microsoft 365 with PowerShell are cloud groups. Many organizations use Microsoft Entra Connect to synchronize users and groups from on-premises AD DS to Microsoft 365. Microsoft Entra Connect creates these users and groups, and you can't delete them directly in Microsoft 365. Instead, you need to delete the object in AD DS, and Microsoft Entra Connect synchronizes the deletion to Microsoft 365.

When objects are synchronized from AD DS to Microsoft 365, the value of some attributes in AD DS is authoritative. This authoritative status means you can't modify the attribute value in Microsoft 365. Instead, you need to modify the value in AD DS, and Microsoft Entra Connect synchronizes the modified value to Microsoft 365. If you attempt to modify these attributes in Microsoft 365, you receive an error.

Group membership from on-premises AD DS is authoritative. You can't edit the membership of a synchronized group. Instead, you need to modify the membership in the on-premises AD DS group.
