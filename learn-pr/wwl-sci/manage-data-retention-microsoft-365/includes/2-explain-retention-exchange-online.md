Microsoft Exchange Online is a solution to transport and deliver messages, sensitive information flows through and are stored in Exchange Online mailboxes. This makes Exchange an important location for retaining and deleting messages to fulfill various data protection and compliance requirements.

## Hidden Recoverable Items folders

Any Exchange mailbox consists of the visible folders for the users, such as the Inbox, Sent Items and Deleted Items, and hidden folders not accessible by the mailbox owner. These hidden folders retain mailbox items to provide features like single item recovery for users to restore deleted items, for storing mailbox audit logs, and to apply compliance features.

The following image shows the principal of hidden folders in a mailbox and describes an example process from the delivery of a message until its final purge from the mailbox by the Managed Folder Assistant (MFA).

![process flow of mailbox](../media/mailbox-hidden-folders.png)

Description for the steps in the image:

- (1) New messages are delivered to the visible folders of a mailbox, in this example to the **Inbox**.

- (2) When a user deletes a message or the message is moved to the **Deleted Items** folder, it still exists in the visible folder structure.

- (3) When the **Deleted Items** folder is emptied, the messages are moved to the hidden folder structure, in this example to **Deletions**. The user can still restore the message using the Single Item Recovery feature.

- (4a) When the message expired under the Single Item Recovery hold time, it is moved to the **Purges** folder.

- (4b) When the message is subject to an eDiscovery hold, it is moved to the **DiscoveryHolds** folder.

- (5) When a mailbox is subject to a retention policy or a litigation hold is activated, any version of an edited message is moved to the **Versions** folder in the hidden folder structure and it is retained.

- (6a) When the Mailbox Folder Assistant (MFA) processes a mailbox, all expired items in **Deletions**, **Versions, and **Purges** are deleted, if no other feature holds the messages.

- (6b) Messages subject to an eDiscovery hold are moved instead of being deleted by the MFA.

- (6c) All items are matched against possible holds before being permanently deleted by the MFA.

> [!NOTE]
> The Managed Folder Assistant (MFA) processes all mailboxes continuously and runs about every 30 minutes against a mailbox in Exchange Online.

## Accessing Recoverable Items folders

To access these hidden folders, administrators can use different methods, such as compliance searches and eDiscovery cases. Before they can gain access to this potentially compliance relevant email communication, administrators and compliance officers need special permissions that are not assigned to any administrator by default.

> [!WARNING]
> By default, even the Global Administrator of a tenant does not have the required permission to search through all user data. If they did it would violate the data protection policies of several regulatory bodies. Before administrators or compliance officers are assigned permissions to discover user data, you must ensure no compliance polices are violated in the process.

The permissions to perform a compliance search, create eDiscovery cases and use Advanced eDiscovery are managed via built-in RBAC roles in the Security or Compliance Center in Microsoft 365. The following table lists which role group contains which permissions:

| Role| Compliance Administrator| eDiscovery Manager & Administrator| Organization Management| Reviewer|
| :--- | :--- | :--- | :--- | :--- |
| Case Management| ✓| ✓| ✓||
| Communication|| ✓|||
| Compliance Search| ✓| ✓| ✓||
| Custodian|| ✓|||
| Export|| ✓|||
| Hold| ✓| ✓| ✓||
| Preview|| ✓|||
| Review|| ✓|| ✓|
| RMS Decrypt|| ✓|||
| Search and Purge||| ✓||

Additional information for the permission overview:

- While the eDiscovery Managers can only manage all settings in their own cases, the eDiscovery Administrator can access and modify all existing cases.

- The Reviewers cannot create own searches or modify the search settings and locations, but they can see the results of an eDiscovery case they are assigned to.

- The Search and Purge role is the only role that can remove actively remove content from multiple locations, but this role cannot search for data or see content.

> [!NOTE]
> eDiscovery is not limited to mailbox content only, it includes documents and files stored in other locations too.

The eDiscovery roles are often assigned to Compliance or Data Protection Officers, which are responsible to ensure the company does comply with all required policies in their location and industry sector. Administrators should not own eDiscovery roles that allow them to search or export content. They are responsible for the mailboxes and services. Too many permissions to access user content can lead to violations of compliance policies.

When the non-technical compliance users require support creating an eDiscovery case, it may be a best to have a Compliance Administrator create the case, holds, and searches. Then assign Reviewer permissions to users that are legally allowed to see the content, while the administrator cannot see the results of the searches. Even if users are missing deleted content and they require an Administrator to recover it from a location they cannot access it themselves, like a message in a hidden folder, the recovery and export should be performed under the four-eyes principal together with the compliance or data protection personal of an organization.

> [!TIP]
> Administrators should always consider the legal and regulatory restrictions when assigning permissions to search and recover user data in an organization!

## Exchange-specific retention features

Besides using retention policies and labels, Exchange provides more features to protect messages in mailboxes, which have their origin in retention features of the Exchange Server on-premises:

| Feature| Scope| Description|
| :--- | :--- | :--- |
| Litigation Hold| All mailbox contents.| Litigation hold is activated on the mailbox level and retains all mailbox content.|
| eDiscovery Hold| Mailbox content matching the search filter.| Created in eDiscovery cases to retain all content matching the keyword search. Was formerly also available outside eDiscovery cases and called in-place hold.|
| Retention Tags| Single email messages stored in mailboxes.| Formerly used to manage retention and deletion of mailbox content.|
| Journaling| All mails sent to a single recipient.| Journaling creates a copy of all messages sent to a specific recipient and stores it in a dedicated mailbox, which cannot be another Exchange Online mailbox but only an on-premises or third-party target.|

> [!NOTE]
> Some organizations use journaling to store copies of all messages for important recipients in third-party locations, to comply with regulatory requirements.

