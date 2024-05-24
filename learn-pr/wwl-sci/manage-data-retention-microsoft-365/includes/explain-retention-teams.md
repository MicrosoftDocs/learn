Retention policies in Microsoft Teams ensure that your organization can manage communications data in compliance with legal and regulatory standards. These policies help govern the retention and deletion of chats and channel messages, crucial for data lifecycle management within Teams.

As the Data Protection Officer at the bank, you now focus on Microsoft Teams, the platform for your organization’s daily communications. Your responsibility is to ensure that retention policies are correctly understood and applied across all aspects of Teams. This includes chats, meetings, and collaborations involving sensitive information. You must make sure these policies cover everything from messages to attached files, ensuring compliance with strict regulatory requirements.

Here you learn to:

- Understand retention policies in Microsoft Teams for different content types.
- Manage the data lifecycle in Teams, including retention, archiving, and deletion.
- Navigate compliance for external and guest user communications.
- Oversee data retention and deletion during employee transitions to secure sensitive information.

## Overview of retention in Microsoft Teams

When setting up retention policies in Teams, it's important to understand the types of content covered:

- **Teams chats and Microsoft Copilot for Microsoft 365 interactions**: All messages in Microsoft Teams, including interactions from Copilot for Microsoft 365, are covered under a unified retention policy. This policy ensures consistent handling of all chat interactions, whether or not users are actively using both applications.
- **Extended content types**: Retention policies in Teams not only cover text messages but also include video clips, embedded images, tables, hyperlinks, links to other messages and files within Teams, and card content used in messaging. This comprehensive coverage helps ensure that all aspects of a communication are retained for compliance purposes.
- **Other elements in chats**: The policy also covers the names of all participants in private and group chats, as well as the team names and titles of messages in channel communications.

While Teams retention policies are comprehensive, they don't cover:

- Code snippets, voice memos, thumbnails, announcement images, and emoticons, which aren't retained.
- Call data records and certain types of control messages, which although retained, are treated differently under compliance operations.
- Emails and documents shared within Teams are subject to separate retention policies. These policies apply to Microsoft 365 Group mailboxes, SharePoint sites, or the user's OneDrive, depending on where the files are stored.

Retention policies are automatically applied to both shared channels and personal chats in Teams. They use settings from either the parent team or the individual's settings to ensure consistent compliance across all communication types. For meeting recordings and transcripts stored in SharePoint or OneDrive linked to Teams channels, you must set up specific retention policies separately. To effectively manage these recordings and transcripts, use a targeted auto-apply retention label policy. This method ensures precise control over how long these specific types of files are kept or deleted, separate from the management of regular chats and documents.

## Dynamics of retention in Teams

Teams uses an Azure-powered chat service as primary storage for chat and channel messages. This system ensures that messages are managed efficiently and can be deleted based on your organization's compliance requirements. When a retention policy triggers the deletion of messages, they're removed from Exchange mailboxes and Azure's primary storage. This process ensures thorough data management and maintains compliance standards.

In managing chat and channel messages, Teams uses both Azure-powered services and Exchange mailboxes:

- **Data storage**: Messages are stored in hidden folders in user-specific and group mailboxes, accessible only to compliance administrators via eDiscovery tools.
- **Types of mailboxes**:
  - **UserMailbox**: Stores message data for private channels and cloud-based users.
  - **GroupMailbox**: Stores message data for standard and shared channels.
  - **MailUser**: Stores message data for on-premises Teams users.
  - **SubstrateGroup**: Stores message data for Teams shared channels.

Messages remain in these mailboxes until they meet the criteria set by the retention policies, after which they move to a stage called SubstrateHolds before permanent deletion.

### Considerations for retention policy management in Teams

- **Special mailbox types**: Certain mailbox types like the RoomMailbox, used for Teams conference rooms, don't support retention policies. It's important to be aware of these exceptions when setting up your data governance framework.
- **Retention policy configuration**: To effectively manage your Teams communications, it's crucial to configure retention policies specifically for **Teams channel messages** and **Teams chats**. These messages aren't covered under the general retention policies for Exchange user or group mailboxes and require specific settings to ensure proper data lifecycle management.
- **Handling new users in chats**: When a new user is added to an existing chat, all previously shared messages are copied into their mailbox, maintaining the original creation date. This practice ensures that all participants have access to the same historical data, regardless of when they joined the chat.

### Retention lifecycle in Teams

Here's how content is handled in Teams depending on the applied retention settings: retain and delete, retain-only, and delete-only. Each setting affects the content's path from its creation to its potential deletion, aligning with organizational data management and compliance protocols.

:::image type="content" source="../media/teams-retention-functionality.png" alt-text="Diagram of content lifecycle in Teams." lightbox="../media/teams-retention-functionality.png":::

| Scenario | Modified or deleted content| Unmodified content|
| :--- | :--- | :--- |
| **Retain and delete**| If edited or deleted during the retention period, the content is immediately moved to SubstrateHolds and is permanently deleted 1-7 days after the retention period.| Moves directly to SubstrateHolds post-retention period and is permanently deleted within 1-7 days after at least 1 day of storage.|
| **Retain-only**| Edited or deleted content is moved to SubstrateHolds and retained indefinitely until the end of the retention period, followed by deletion within 1-7 days.| Remains unchanged in its original location, unaffected by retention operations.|
| **Delete-only**| Content is immediately stored in SubstrateHolds for at least 1 day, then permanently deleted within 1-7 days.| After the retention period, it's moved to SubstrateHolds, retained for at least 1 day, and then permanently deleted within 1-7 days.|

Content in SubstrateHolds isn't visible in the Teams app but remains searchable by eDiscovery tools until permanently deleted. This process ensures compliance while the data is "soft-deleted" and awaiting permanent removal based on the set policies.

Messages visible in the Teams app don't accurately reflect their retention status. Messages are retained or deleted based on their creation date. Changes in a user's status, like leaving the organization, don't affect the established retention schedule.

## Messages from external users

When external users participate in meetings or chats hosted by your organization, the retention of these messages depends on the type of account they use:

- **Guest accounts**: If an external user joins using a guest account in your tenant, any messages they send are stored in both your users' mailboxes and a shadow mailbox assigned to the guest. However, retention policies don't apply to shadow mailboxes, even though these mailboxes might be included in an organization-wide retention policy.
- **External Microsoft 365 accounts**: Messages sent by external users from another Microsoft 365 organization are stored in their own mailboxes, not your organization's. Therefore, your retention policies can't delete these messages. Messages within the same chat or meeting sent by your organization's users are subject to your retention policies.

## Handling employee departures

When an employee with a mailbox in Exchange Online leaves your organization and their Microsoft 365 account is deleted, their chat messages remain preserved under retention. These messages are stored in an inactive mailbox. They continue to adhere to any retention policies applied before the mailbox was deactivated, ensuring that the data remains accessible for eDiscovery. Files uploaded to a channel are stored in your team's SharePoint folder. In contrast, files shared in one-on-one or group chats are saved in the _Microsoft Teams Chat Files_ in your OneDrive folder and are shared exclusively with the conversation's participants. SharePoint and OneDrive respectively govern the retention policies for these files.
