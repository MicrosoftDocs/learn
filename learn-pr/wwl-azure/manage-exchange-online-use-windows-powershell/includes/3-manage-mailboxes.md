Mailboxes are created automatically for users who are assigned a license that includes an Exchange Online service plan. As such, there's no need to manually create mailboxes for users. Mailboxes are also deleted automatically when the license is removed or the Exchange Online service plan is disabled.

You can also create specialized mailboxes such as:

- Room mailboxes. These are scheduled when you book meetings.
- Equipment mailboxes. These are scheduled to help ensure that users have access to equipment such as cars or portable display units.
- Shared mailboxes. These are used for generic email addresses, such as `info@adatum.com`, where multiple users need access to the mailbox and respond to the messages.

## Creating mailboxes

When you use the **New-Mailbox** cmdlet to create a mailbox, it creates a user account at the same time. For resource mailboxes and shared mailboxes, the user account is disabled and doesn't require a license.

When you create one of these mailboxes, you only need to indicate which type of mailbox you're creating and the name of the mailbox. The following example creates a room mailbox:

```powershell
New-Mailbox -Room -Name BoardRoom
```

After creating a resource or shared mailbox, you still need configured permissions. By default, no one has access to those mailboxes. Configuring permissions is covered later in this unit. Configuring calendar booking for resources is covered in the next unit, **Managing resources in Exchange Online**.

## Modifying mailboxes

To modify a mailbox's configuration, you use the **Set-Mailbox** cmdlet. There are some mailbox properties that you can configure using **Set-Mailbox**, which you can't configure using the web-based administrative tool. When you review the help information for **Set-Mailbox**, pay careful attention to the parameter descriptions. Some parameters aren't available for managing mailboxes in Exchange Online.

The following table lists some of the parameters for **Set-Mailbox**.

*Table 1: Parameters for mailbox configuration*

| Parameter                        | Description                                                  |
| -------------------------------- | ------------------------------------------------------------ |
| -AuditDelegate                 | Specifies actions on a mailbox that are audited when a delegate performs them, such as **SendOnBehalf** or **UpdateInboxRules**. |
| -AuditEnabled                  | Turns on auditing for a mailbox. This is disabled by default. |
| -AuditOwner                    | Specifies actions on a mailbox that are audited when the user performs them, such as **SendOnBehalf** or **UpdateInboxRules**. |
| -DeliverToMailboxAndForward    | When a forwarding SMTP address is configured and this parameter is `$true`, this parameter configures the mailbox to both retain and forward a copy of the messages. |
| -EmailAddresses                | Configures email addresses for a mailbox. The email addresses are stored as an array and typically start with **smtp:**. The primary email address will have the prefix capitalized as **SMTP:**. |
| -ForwardingSmtpAddress         | Specifies an SMTP address for forwarding. To stop forwarding messages, set this value to `$null`. |
| -GroupMailbox                  | Required to modify the mailbox associated with a Microsoft 365 group. |
| -HiddenFromAddressListsEnabled | Specifies whether the mailbox is available in address lists.   |
| -MailboxRegion                 | Specifies the geographic region in which the mailbox should be stored. Used by organizations with a worldwide presence. |
| -Type                          | Changes the type of mailbox. Specifies whether a mailbox is regular or used for a special purpose. Special-purpose mailboxes include both shared and resource mailboxes. |

The following syntax configures forwarding on a mailbox:

```powershell
Set-Mailbox AbbieP@adatum.com -ForwardingSmtpAddress DoraM@adatum.com -DeliverToMailboxAndForward $true
```

## Querying mailboxes in Exchange Online

To query a list of mailboxes, you can use the **Get-Mailbox** or **Get-EXOMailbox** cmdlets. The primary difference between them is how the data is returned. The **Get-Mailbox** cmdlet returns all properties for the mailboxes. The **Get-EXOMailbox** cmdlet returns only a small set of properties, although you can specify additional properties. This makes **Get-EXOMailbox** much more efficient when working with large data sets.

To obtain additional properties when using the **Get-EXOMailbox** cmdlet, you can use either the *-Properties* parameter or the *-PropertySets* parameter. When using the *-Properties* parameter, you provide a list of properties to return. When you use the *-PropertySets* parameter, you provide a list of predefined property groups that pertain to a specific category. Some property sets that you can specify are:

- All
- Minimum (default value)
- Audit
- Delivery
- Moderation
- Resource

Both cmdlets support using the *-Filter* parameter to select mailboxes matching specific criteria. There are also additional specific parameters that you can use. The following table list some parameters that are available for both cmdlets.

*Table 2: Parameters for the Get-Mailbox and Get-EXOMailbox cmdlets*

| Parameter               | Description                                                  |
| ----------------------- | ------------------------------------------------------------ |
| -Archive              | Returns mailboxes with an archive enabled.                   |
| -GroupMailbox         | Returns only mailboxes associated with Microsoft 365 groups. |
| -Identity             | Identifies a specific mailbox to return properties for.      |
| -RecipientTypeDetails | Returns mailboxes of a specific type such as UserMailbox, TeamMailbox, or RoomMailbox. |
| -SoftDeletedMailbox   | Returns soft-deleted mailboxes that are still available for recovery. |

The following syntax queries all of the room mailboxes and returns resource-related properties:

```powershell
Get-EXOMailbox -RecipientTypeDetails RoomMailbox -PropertySets Resource
```

## Managing mailbox permissions

You can configure permissions to provide users with access to other mailboxes or individual folders within a mailbox. For example, you might want to give users full mailbox permission to a shared mailbox. Or you might want to change the default permissions assigned to the **Calendar** folder of a specific user mailbox. The following table lists cmdlets that you can use to manage mailbox and mailbox folder permissions.

*Table 3: Cmdlets for managing mailbox and mailbox folder permissions*

| Cmdlet                         | Description                                                  |
| ------------------------------ | ------------------------------------------------------------ |
| **Add-MailboxPermission**          | Adds permissions for a user to a mailbox.                     |
| **Get-MailboxPermission**          | Lists user permissions that are assigned to a mailbox.        |
| **Remove-MailboxPermission**       | Removes a user's permissions assignment from a mailbox.   |
| **Get-EXOMailboxPermission**       | Lists user permissions that are assigned to a mailbox.        |
| **Add-MailboxFolderPermission**    | Adds permissions for a user to a folder in a mailbox.         |
| **Get-MailboxFolderPermission**    | Lists user permissions that are assigned to a folder in a mailbox. |
| **Remove-MailboxFolderPermission** | Removes a user's permissions assignment from a folder in a mailbox. |
| **Set-MailboxFolderPermission**    | Sets permissions on a folder in a mailbox and overwrites all exiting permissions. |
| **Get-EXOMailboxFolderPermission** | Lists user permissions that are assigned to folder in a mailbox. |

The following example assigns full mailbox permissions for a user to the **Info** shared mailbox:

```powershell
Add-MailboxPermission -Identity Info -User AbbieP@adatum.com -AccessRights FullAccess -InheritanceType All
```
