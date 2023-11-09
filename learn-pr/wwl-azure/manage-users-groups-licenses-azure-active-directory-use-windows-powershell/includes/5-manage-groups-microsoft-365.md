Microsoft 365 has multiple types of groups that you can use to provide access to resources or send email. Each group type serves a different purpose, and you should select the correct type for your needs. The group types available in Microsoft 365 are listed in the following table.

*Table 1: Types of groups in Microsoft 365*

| Group type                  | Description                                                  |
| --------------------------- | ------------------------------------------------------------ |
| Microsoft 365 group         | Microsoft 365 groups are used for collaboration between users, both  inside and outside your company. With each Microsoft 365 group, members get a group email and shared workspace for conversations, files, and  calendar events, Microsoft Stream, and Microsoft Planner. |
| Distribution group          | Distribution groups are used for sending notifications to a group of people. They can receive external email if enabled by the administrator. |
| Security group              | Security groups are used for granting access to Microsoft 365 resources, such as SharePoint. They can make administration easier because you only need to administer the group rather than adding users to each resource individually. |
| Mail-enabled security group | A mail-enabled security group has the same functionality as a security group for assigning permissions, but it can also be used to send email messages just as you can with a distribution group. |

> **Additional reading:** For a detailed comparison of group types, refer to [Compare groups](https://aka.ms/compare-groups).

> [!NOTE]
> There are no AzureAD or Msol cmdlets for managing Microsoft 365 groups. The cmdlets for managing Microsoft 365 groups are part of Exchange Online, because these groups include a mailbox. In the Exchange Online cmdlets, Microsoft 365 groups are referred to as *unified groups*.

## Managing groups with AzureAD cmdlets

You can create distribution groups, security groups, and mail-enabled security groups by using the **New-AzureADGroup** cmdlet. The type of group created depends on how you use the *-MailEnabled* and *-SecurityEnabled* parameters. The following example creates a mail-enabled security group:

```powershell
New-AzureADGroup -DisplayName "Marketing Group" -MailEnabled $true -SecurityEnabled $true -MailNickname MarketingGrp
```

When you create a new group, the group is assigned an ObjectID. The ObjectID is a unique identifier for the group. You need to use the ObjectID for the group with management cmdlets. You can't use a display name to refer to a group because it isn't guaranteed to be unique. Use the **Get-AzureADGroup** cmdlet to identify the ObjectID for a group that you want to manage.

Other AzureAD cmdlets that you can use to manage groups are listed in the following table.

*Table 2: AzureAD cmdlets for group management*

| Cmdlet                      | Description                                                  |
| --------------------------- | ------------------------------------------------------------ |
| **Get-AzureADGroup**          | Queries for distribution groups, security groups, and mail-enabled security groups. This cmdlet supports using a filter or search string. |
| **Set-AzureADGroup**          | Modifies the properties of distribution groups, security groups, and mail-enabled security groups. |
| **Remove-AzureADGroup**       | Deletes distribution groups, security groups, and mail-enabled security groups. |
| **Get-AzureADGroupMember**    | Queries the membership of distribution groups, security groups, and mail-enabled security groups. |
| **Add-AzureADGroupMember**    | Adds a member to distribution groups, security groups, and mail-enabled security groups. |
| **Remove-AzureADGroupMember** | Removes a member from distribution groups, security groups, and mail-enabled security groups. |
| **Get-AzureADGroupOwner**     | Queries the owners of distribution groups, security groups, and mail-enabled security groups. |
| **Add-AzureADGroupOwner**     | Adds an owner to distribution groups, security groups, and mail-enabled security groups. |
| **Remove-AzureADGroupOwner**  | Removes an owner from distribution groups, security groups, and mail-enabled security groups. |

## Managing groups with Msol cmdlets

You can use the **New-MsolGroup** cmdlet to create security groups. There are no Msol cmdlets to create distribution groups or mail-enabled security groups. The following example creates a new security group:

```powershell
New-MsolGroup -DisplayName "Marketing Group"
```

Other Msol cmdlets that you can use to manage groups are listed in the following table.

*Table 3: Msol cmdlets for managing groups*

| Cmdlet                 | Description                                                  |
| ---------------------- | ------------------------------------------------------------ |
| **Get-MsolGroup**          | Queries for distribution groups, security groups, and mail-enabled security groups. You can filter results based on group type or a search string for the display name. |
| **Set-MsolGroup**          | Modifies the properties of distribution groups, security groups, and mail-enabled security groups. |
| **Remove-MsolGroup**       | Deletes distribution groups, security groups, and mail-enabled security groups. |
| **Get-MsolGroupMember**    | Queries the membership of distribution groups, security groups, and mail-enabled security groups. |
| **Add-MsolGroupMember**    | Adds a member to distribution groups, security groups, and mail-enabled security groups. |
| **Remove-MsolGroupMember** | Removes a member from distribution groups, security groups, and mail-enabled security groups. |

## Synchronized groups

Groups that you create in Microsoft 365 with Windows PowerShell are cloud groups. Many organizations use Microsoft Entra Connect to synchronize users and groups from on-premises AD DS to Microsoft 365. These users and groups are created by Microsoft Entra Connect, and you can't them delete directly in Microsoft 365. Instead, you need to delete the object in AD DS, and the deletion is synchronized to Microsoft 365.

When objects are synchronized from AD DS to Microsoft 365, the value of some attributes in AD DS is authoritative. This means you can't modify the attribute value in Microsoft 365. Instead, you need to modify the value in AD DS, and the modified value synchronizes to Microsoft 365.  If you attempt to modify these attributes in Microsoft 365, an error is generated.

Group membership from on-premises AD DS is authoritative. You can't edit the membership of a synchronized group. Instead, you need to modify the membership in the on-premises AD DS group.
