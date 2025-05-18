When you place a mailbox on hold in Microsoft Purview, it's not just the visible inbox and folders that are preserved. Hidden mailbox locations like the Recoverable Items folder are also included. This folder plays a critical role in maintaining mailbox integrity during investigations, ensuring that content remains available for eDiscovery even if the user deletes it.

## What is the Recoverable Items folder?

The **Recoverable Items** folder is a hidden mailbox location in Exchange Online used to store:

- Deleted items that haven't reached the end of their retention period
- Items retained by Litigation Hold, eDiscovery hold, or retention policies
- Metadata such as Bcc fields and expanded distribution group membership, if the mailbox is on hold

By default, users can't access this folder directly. It serves as a protected area for compliance and investigation purposes.

## How mailbox holds affect recoverable items

When a mailbox is placed on hold, the Recoverable Items folder acts as a safeguard against permanent deletion:

- If a user deletes a message, it moves to **Deletions**.
- If it's purged from **Deletions**, it might still be retained in **DiscoveryHolds** or **SubstrateHolds**, depending on the hold in place.
- Holds can preserve these items indefinitely or until the hold is removed.

This ensures mailbox content stays available for searches, exports, and investigation, even if it's been removed from the visible mailbox.

## Preserved metadata: Bcc and distribution groups

When mail is sent using Bcc or to a distribution group:

- **Bcc recipients** are preserved in the sender's mailbox and available through eDiscovery if that mailbox is on hold.
- **Distribution group members** are expanded at the time the message is sent. The membership list is stored with the message only if the sender's mailbox is on hold.

To preserve full recipient metadata:

- Place the sender's mailbox on hold.
- Apply an organization-wide retention policy or Litigation Hold to ensure consistency across all users.

## Verify preservation status with PowerShell

You can use Exchange Online PowerShell to verify hold and metadata preservation status for a mailbox.

To check if a mailbox is on hold and whether delay holds apply:

```powershell
Get-Mailbox <username> | FL LitigationHoldEnabled,InPlaceHolds,DelayHoldApplied,DelayReleaseHoldApplied
```

To check if content is being preserved due to retention labels:

```powershell
Get-Mailbox <username> | FL ComplianceTagHoldApplied
```

To confirm current size and item count of Recoverable Items folders:

```powershell
Get-MailboxFolderStatistics <username> -FolderScope RecoverableItems | FL Name,FolderAndSubfolderSize,ItemsInFolderAndSubfolders
```

These commands help validate whether preservation is working as expected, especially after a hold is applied or removed.

## What to know about delay holds

When you remove a hold from a mailbox, Microsoft Purview applies a **delay hold** to prevent immediate data loss:

- This hold lasts 30 days.
- It gives you time to verify or recover data before permanent deletion.
- You can remove a delay hold manually using PowerShell if needed.

Delay holds help avoid accidental data loss when changing hold configurations.

Mailbox holds preserve more than just inbox content—they include hidden folders and recipient metadata that are essential for compliance and investigation. Understanding how Purview preserves this data and how to check its status can help you manage cases more effectively. Knowing how metadata like Bcc recipients is retained also helps prevent accidental data loss when hold configurations change.
