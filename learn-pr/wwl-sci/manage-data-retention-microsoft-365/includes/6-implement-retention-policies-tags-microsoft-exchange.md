Retention Tags and Retention Policies in Exchange Server and Exchange Online are a part of Messaging records management (MRM), which have formerly been used to manage the lifecycle of email messages stored in mailboxes. This functionality is now replaced by Retention Labels and Retention Policies in Microsoft 365. Messaging records management (MRM) is still being used for archiving purposes, which move messages between the primary mailbox and the archive mailbox of users and inside the various mailbox folders.

Messaging records management (MRM) consists of the following features:

- **Retention policies** for applying sets of retention tags to user mailboxes.

- **Retention policy tags (RPTs)** for default folders, such as Deleted Items and Junk Email with a default setting of "30 days delete".

- **Default policy tags (DPTs)** for mailboxes to manage the retention of all untagged items, such as the setting "Default 2-year move to archive".

- **Personal tags** for custom folders and individual items, that are assigned by end users.

By default, all mailboxes have assigned an MRM retention policy named Default MRM Policy, which includes the following retention tags:

| Retention Tag| Type| Description|
| :--- | :--- | :--- |
| 1 Month Delete, 1 Week Delete, 1 Year Delete, 5 Year Delete, 6 Month Delete, Never Delete, Personal 1-year move to archive, Personal 5-year move to archive, Personal never move to archive| Personal tags| Can be assigned by users and applies the assigned action to messages.|
| Junk Email, Recoverable Items 14 days move to archive| Retention policy tags (RPTs)| Automatically assigned tags for the default folders "Junk" and "Recoverable items". Deletes messages automatically from Junk and moves messages in Recoverable Items to the archive mailbox.|
| Default 2-year move to archive| Default policy tags (DPTs)| Automatically assigned when no other tag applies to a message.|

> [!NOTE]
> To proactively retain or delete mailbox content for information governance in Microsoft 365, we recommend that you use retention policies and retention labels from the Microsoft 365 compliance center, instead of messaging records management that's described on this page. However, you should continue using messaging records management to move messages to archive mailboxes.  If you currently use messaging records management, this older feature will continue to work side-by-side with retention policies and retention labels. However, we recommend that going forward, you use retention policies and retention labels instead. They provide you with a single mechanism to centrally manage both retention and deletion of content across Microsoft 365.

## Activating archive mailboxes

To provide users an archive mailbox in addition to their primary mailbox, administrators can use the Exchange admin center or the Exchange Online PowerShell module. Perform the following steps to activate the archive mailbox for a user:

1. Navigate to the **Exchange admin center** at [https://outlook.office365.com/ecp/](https://outlook.office365.com/ecp/?azure-portal=true) and sign in with a user with Exchange administrator permissions.

1. Open **recipients** and select a user mailbox.

1. On the left side, below **In-Place Archive**, check the archive mailbox status for a user and select **Enable** to activate the archive mailbox.

The same operation can also be performed with the Exchange Online PowerShell module by using the following cmdlet:

```powershell
Enable-Mailbox -Identity <username> -Archive

```

