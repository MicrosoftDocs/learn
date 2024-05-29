In Microsoft 365, ensuring legal and regulatory compliance often requires preserving email content that could be relevant to litigation or investigations. This preservation is accomplished through mechanisms known as Litigation Holds and In-Place Holds. Both play crucial roles but are suited to different scenarios depending on the specifics of the legal requirements and organizational policies.

As the Data Protection Officer at the bank, you now need to focus on implementing and managing Litigation Holds and In-Place Holds within Microsoft 365. These holds are essential to preserving email content that might be relevant to litigation or investigations. Your role is to ensure that the bank’s email data is retained according to legal and regulatory requirements, preventing unauthorized deletions and ensuring data availability for compliance checks. Understanding how to effectively use these holds will help you protect sensitive information and manage compliance risks.

Here you learn to:

- Describe the purpose and functionality of Litigation Holds and In-Place Holds in Microsoft 365.
- Implement Litigation Holds using the Exchange Admin Center and Exchange Management Shell.
- Create In-Place Holds using the Exchange Admin Center and Exchange Management Shell.
- Manage and monitor holds to ensure compliance with legal and regulatory requirements.
- Assess strategies for preserving email content during litigation or investigations.

## What are In-Place and Litigation Holds?

**In-Place Holds** and **Litigation Holds** are features in Microsoft 365 that prevent permanent deletion of emails and other mailbox items to meet compliance or legal requirements. Here's what they entail:

- **Litigation Hold**: When enabled, this hold preserves all content in a mailbox indefinitely or for a specified period. This is crucial when a company anticipates litigation and is required to preserve electronic stored information (ESI) as evidence.
- **In-Place Hold**: More flexible than Litigation Hold, it allows for the preservation of items based on specific criteria, such as keywords, senders, recipients, and date ranges. It can be applied to individual items and is useful for targeted legal cases.

## Why use holds?

Holds are essential for several reasons:

- **Legal compliance**: They help organizations comply with legal obligations to preserve electronically stored information (ESI) when facing litigation or investigations.
- **Information governance**: Allows organizations to manage data systematically, ensuring important information is preserved and disposable data is deleted in accordance with company policies and legal requirements.
- **Risk management**: Reduces the risk of penalties, legal sanctions, or adverse judgments by ensuring data relevant to litigation or audits isn't destroyed.

These holds are used to meet legal requirements, but they also help protect the organization from possible fines or penalties that could result from improperly deleting evidence. They ensure that even if users try to delete their emails, the information is kept safe and can be presented during legal examinations.

## Implement holds in Microsoft 365

Here's how you can apply these holds within your organization:

### Use the Exchange Admin Center (EAC) to place a mailbox on Litigation Hold

1. Navigate to the Exchange Admin Center at [https://admin.exchange.microsoft.com]( https://admin.exchange.microsoft.com?azure-portal=true) and sign in as Exchange administrator.
1. Select **Recipients** > **Mailboxes**.
1. In the list of user mailboxes, select the mailbox that you want to place on Litigation Hold, and then select **Edit**.
1. On the mailbox properties page, select **Mailbox features**.
1. Under **Litigation hold: Disabled**, select **Enable** to place the mailbox on Litigation Hold.
1. On the **Litigation Hold** page, enter the optional information:

   - **Litigation hold duration (days)**: Specify the duration in days to retain items. Leave blank for indefinite hold.
   - **Note**: Optional message to inform the user their mailbox is on hold. Visible in the File tab in Outlook 2010 or later.
   - **URL**: Provide a URL for more information about the Litigation Hold. This appears in the File tab in Outlook 2010 or later.

   If you leave the **Note** and **URL** values blank, the user isn't notified that you placed a litigation hold on their mailbox.

1. Select **Save** on the **Litigation Hold** page, and then select **Save** on the mailbox properties page to apply the settings.

### Use the Exchange Management Shell to place a mailbox on Litigation Hold

You can also use the Exchange Management Shell to place a mailbox on Litigation Hold.

To place a mailbox on Litigation Hold indefinitely or until the hold is removed:

```powershell
Set-Mailbox <user email address> -LitigationHoldEnabled $true
```

To place a mailbox on Litigation Hold for a set number of days:

```powershell
Set-Mailbox <user email address> -LitigationHoldEnabled $true -LitigationHoldDuration <number of days>
```

### Use the EAC to create an In-Place Hold

1. Navigate to the Exchange Admin Center at [https://admin.exchange.microsoft.com]( https://admin.exchange.microsoft.com?azure-portal=true) and sign in as Exchange administrator.
1. Navigate to **Compliance management** > **In-Place eDiscovery & Hold**, and select **New**.
1. On the **Name and description** page, enter a name for the hold and an optional description, then select **Next**.
1. On the **Mailboxes and Public folders page**, select the content sources:

   - Select **Don't search any mailboxes** to exclude mailboxes and hold public folders only.
   - Select **Specify mailboxes to search** to include specific mailboxes, then add the desired mailboxes.
   - Select **Search all public folders** to place all public folders on hold.

1. On the **Search query** page:
   - Select **Include all content** to place all content in selected sources on hold.
   - Select **Filter based on criteria** to specify search criteria, such as keywords, dates, sender and recipient addresses, and message types.

1. On the In-Place Hold settings page, select the checkbox for **Place content matching the search query in selected sources on hold**,  then select one of these options:
   - Select **Hold indefinitely** to preserve items indefinitely.
   - Select **Specify number of days to hold items relative to their received date** to hold items for a specified period, like seven years.

1. Select **Finish** to create the In-Place Hold.

### Use the Exchange Management Shell to create an In-Place Hold

You can also use the Exchange Management Shell to create an In-Place Hold.

Use this cmdlet to create an In-Place Hold:

```PowerShell
New-MailboxSearch "<Name of hold>" -SourceMailboxes "<mailbox address>" -InPlaceHoldEnabled $true
```

If you don't specify any search parameters for an In-Place Hold, all items in the specified source mailboxes are placed on hold. If you don't specify the _ItemHoldPeriod_ parameter, items are placed on hold indefinitely or until the mailbox is either removed from hold or the hold is deleted.

This example places an In-Place Hold on all public folders in the organization, and holds content for seven years. The hold doesn't include any mailboxes.

```PowerShell
New-MailboxSearch -Name "Hold for Public Folders" -AllPublicFolderSources $true -AllSourceMailboxes $false -ItemHoldPeriod 2555 -InPlaceHoldEnabled $true
```
