Microsoft Exchange Online is a cloud-based service that manages emails, calendars, contacts, and tasks, playing a critical role in business environments by ensuring the secure and legal management of information. Effective retention policies in Exchange keep communications data compliant with legal standards and ensure that information is available when needed, preventing data overload.

## Overview of retention in Exchange

Retention policies in Exchange are designed to help organizations manage their communications data. These policies cover a wide range of data types within Exchange, including:

- **Mail messages** include all received messages, drafts, and sent messages, along with any attachments.
- **Tasks** with end dates are included under retention policies.
- **Calendar items** are also supported as long as they have an end date.
- **Notes** consist of simple text items that are often used for quick reminders.

However, it's important to note that some items, like contacts and tasks without end dates, aren't covered by these policies. Public folders are included under retention policies but not under retention labels.

## How retention works in Exchange

Exchange Online uses the Recoverable Items folder to manage the retention and deletion of items, ensuring data is retained securely and only accessible by individuals with eDiscovery permissions. Knowledge of these terms helps you understand how retention works in Exchange:

- **Delete**: Refers to the action when an item is moved to the **Deleted Items** folder but not permanently deleted, allowing users the opportunity to recover accidentally deleted items.
- **Soft Delete**: Occurs when an item is removed from the **Deleted Items** folder, either through manual deletion or by pressing _Shift + Delete_. This action moves the item directly to the **Recoverable Items** folder, specifically into the **Deletions** subfolder.
- **Hard Delete**: Refers to the final removal of an item from the mailbox database, termed as a _store hard delete_. These items are marked for purging and await permanent deletion according to retention policies, making recovery by standard user means impossible.

Deleted items first move to the Deleted Items folder unless bypassed by a soft delete. A timer job checks the Recoverable Items folder regularly to evaluate if items should be kept or deleted. Items not under retention or past their retention period are permanently deleted, ensuring compliance with organizational policies.

### Understand the Recoverable Items workflow in Exchange Online

The diagram illustrates the workflow within the Recoverable Items folder, critical for ensuring compliance and managing data effectively:

:::image type="content" source="../media/mailbox-hidden-folders.png" alt-text="Diagram showing the workflow for the Recoverable Items folder in Exchange Online.":::

1. **Initial message delivery**: Messages arrive in the recipient's Inbox or other designated folders within their mailbox.
1. **Deletion to Deleted Items**: When a user deletes a message, it moves to the **Deleted Items** folder. The user can easily restore messages in this first stage of deletion.
1. **Soft deletion**: If a message is further deleted from the Deleted Items folder, it's considered "soft deleted" and moved to the **Recoverable Items** folder, specifically into the **Deletions** subfolder.
1. **Message purging under holds**:

   1. **Litigation Hold/Single Item Recovery (SIR)**: Messages under Litigation Hold or protected by Single Item Recovery are moved to the **Purges** subfolder when they're purged by the user.
   1. **In-Place Hold**: Similarly, messages under an In-Place Hold are moved to the **DiscoveryHold** subfolder when purged.
1. **Message editing**: Edits to any message result in the original version being saved in the **Versions** subfolder to ensure that all changes are properly logged.
1. **Managed Folder Assistant (MFA) actions**:

   1. **MFA purge or Litigation Hold retention**: MFA purges or retains messages depending on whether they're under a Litigation Hold, aligning with legal retention requirements.
   1. **Single Item Recovery and eDiscovery Hold management**: Messages in mailboxes under SIR or eDiscovery Hold are preserved past their retention period for legal discovery purposes.
   1. **MFA hold query review**: MFA checks if mailbox items correspond to any active hold queries, ensuring compliance with legal and policy requirements.

#### Accessing the Recoverable Items Folder

The Recoverable Items folder, which is important for compliance and legal holds, is stored inside each mailbox's non-IPM subtree. This part of the mailbox contains operational data and is invisible in standard email clients like Outlook. Access is restricted to authorized personnel through tools such as eDiscovery or Content Search in the Microsoft Purview compliance portal. This access is crucial for managing legal holds and ensuring secure data retention, especially during mailbox migrations.

### Retention lifecycle for Exchange Online

In Exchange Online, the management of emails and other mailbox items under retention policies involves the movement and storage of these items in the Recoverable Items folder. The handling of these items depends on whether they're modified, deleted, or remain unchanged during the retention period, and what the specific retention policy dictates.

:::image type="content" source="../media/exchange-online-retention-lifecycle.png" alt-text="Diagram showing the content lifecycle for Exchange Online." lightbox="../media/exchange-online-retention-lifecycle.png":::

| Scenario | Modified or deleted content | Unmodified content |
| :--- | :--- | :--- |
| **Retain and delete** | If modified or permanently deleted (via SHIFT+DELETE or from Deleted Items) during the retention period, the item is copied or moved to the Recoverable Items folder. After the retention period, it's permanently deleted within 14 days by a timer job. 14 days is the default setting, but it can be configured for up to 30 days. | A timer job runs periodically on all folders to identify items whose retention period expired, permanently deleting them within 14-30 days. |
| **Retain-only** | If modified or deleted, the original item is copied to the Recoverable Items folder and retained until the end of the retention period. Afterwards, it's permanently deleted within 14 days of the item expiring by a timer job. | The item remains in its original location indefinitely, unaffected by retention operations. |
| **Delete-only** | Upon deletion, the item is immediately moved to the Recoverable Items folder. After that it's permanently deleted within 14 days by a timer job, unless a retention policy specifies otherwise. | At the end of the retention period, the item is moved to the Recoverable Items folder and permanently deleted within 14 days by a timer job. |

## User notification of expiry dates

Exchange displays the retention policy name and expiry date at the top of each email, guiding users about the retention status. This feature is only visible if the policy involves deletion. The expiry date signifies when the email moves to the Recoverable Items folder, not its deletion date.

## Handling employee departures

When an employee leaves, their governed mailbox becomes inactive but remains subject to any pre-existing retention policies and accessible for eDiscovery searches. Once the retention period expires, Exchange admins can manually delete the inactive mailbox, ensuring compliance continues even after employee departure.
