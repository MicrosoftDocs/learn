Retention Tags and Retention Policies in Exchange Server and Exchange Online are a part of Messaging records management (MRM), which have formerly been used to manage the lifecycle of email messages stored in mailboxes. This functionality is now replaced by Retention Labels and Retention Policies. Messaging records management (MRM) is still being used for archiving purposes, which move messages between the primary mailbox and the archive mailbox of users and inside the various mailbox folders.

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
> Retention tags are assigned when a new message is created in a folder or when the user changes the tag manually. When the retention policy is changed, there is no automatic change of existing assigned tags!

## Create a new retention tag

To create new retention tags, adjust existing policies and tags, and assign policies to user mailboxes, administrators can use the Exchange admin center or the Exchange Online PowerShell module.

Follow these steps to create a new retention tag in the Exchange admin center:

1. Navigate to the **Exchange admin center** at [https://outlook.office365.com/ecp/](https://outlook.office365.com/ecp/?azure-portal=true) and sign in with a user with Exchange administrator permissions.

1. Open **compliance management** and **retention tags** from the top pane.

1. Select the **(+) plus** sign from above the list of tags and select if to create a RPT, a DPT or a personal tag.

1. Enter a **Name** for the new retention tag, the **Retention action** and **Retention period**.

1. Enter the remaining information depending on the type of retention tag and select **Save**.

1. In the information window, select **OK**.

To perform the same operation via Exchange Online PowerShell, use the following cmdlet:

```powershell
New-RetentionPolicyTag <tag name> -Type Personal -Comment <tag comment> -RetentionEnabled $true -AgeLimitForRetention 2556 -RetentionAction PermanentlyDelete

```

This example will create a new personal retention tag which users can use for tagging messages that are removed after seven years (2556 days) automatically from the mailbox.

## Changing the default retention policy

To change existing retention policies, administrators can use the Exchange admin center or the Exchange Online PowerShell module.

Follow these steps to change the Default MRM Policy in the Exchange admin center:

1. Navigate to the **Exchange admin center** at [https://outlook.office365.com/ecp/](https://outlook.office365.com/ecp/?azure-portal=true) and sign in with a user with Exchange administrator permissions.

1. Open **compliance management** and **retention policies** from the top pane.

1. Select the **Default MRM Policy** and the pencil icon from above the list.

1. Use the **(+) plus** and **(-) minus** symbols to add or remove retention tags to the policy.

The changes are automatically applied to all users having the retention policy assigned.

Changing the default retention policy can also be done using the Exchange Online PowerShell module. The following cmdlet is used to show the default retention policy:

```powershell
Get-RetentionPolicy -Identity "Default MRM Policy"

```

The following cmdlet provides an overview about all retention tags linked to a policy:

```powershell
(Get-RetentionPolicy -Identity "Default MRM Policy").RetentionPolicyTagLinks

```

Using the following cmdlet provides an overview about all existing retention tags:

```powershell
Get-RetentionPolicyTag

```

To assign only a subset of retention tags to the default retention policy, use the cmdlet form the following example:

```powershell
Set-RetentionPolicy -Identity "Default MRM Policy" -RetentionPolicyTagLinks "1 Year Delete","5 Year Delete","Recoverable Items 14 days move to archive"

```

> [!NOTE]
> Using the RetentionPolicyTagLinks parameter overwrites all existing retention tags in a retention policy.

## Activating archive mailboxes

To provide users an archive mailbox in addition to their primary mailbox, administrators can use the Exchange admin center or the Exchange Online PowerShell module. Perform the following steps to activate the archive mailbox for a user:

1. Navigate to the **Exchange admin center** at [https://outlook.office365.com/ecp/](https://outlook.office365.com/ecp/?azure-portal=true) and sign in with a user with Exchange administrator permissions.

1. Open **recipients** and select a user mailbox.

1. On the left side, below **In-Place Archive**, check the archive mailbox status for a user and select **Enable** to activate the archive mailbox.

The same operation can also be performed with the Exchange Online PowerShell module by using the following cmdlet:

```powershell
Enable-Mailbox -Identity <username> -Archive

```

