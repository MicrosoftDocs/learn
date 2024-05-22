Viva Engage, part of the Microsoft Viva employee experience platform within Microsoft 365 and Microsoft Teams, enhances organizational connectivity by enabling employees to connect with leaders, coworkers, and communities. It offers a platform for crowdsourcing ideas, sharing work experiences, and fostering belonging at work. Effective retention policies in Viva Engage are crucial. They help organizations control and manage the lifecycle of digital content. This capability ensures all interactions comply with legal and regulatory standards while supporting the platform's collaborative and communicative functions.

## Overview of retention in Viva Engage

Retention policies in Viva Engage help organizations manage the lifecycle of digital content within their networks, ensuring compliance with legal and regulatory standards. These policies govern both the retention and deletion of various types of content, which include:

- **User messages**: These include private messages between individuals and any posts made on user storylines. All are stored in the individual mailboxes of the users involved, ensuring they're retained according to policy specifics.
- **Community messages**: These encompass messages posted within specific Viva Engage communities. They're stored in both the group mailboxes associated with the community. They're also stored in the mailboxes of users who receive notifications or are @ mentioned in these messages. Like user messages, community messages include the community name and any provided message title.

Emoticons used in reactions aren't retained under these policies. SharePoint and OneDrive retention policies govern files used within Viva Engage. Viva Engage-specific retention policies don't apply to these files.

## How retention works with Viva Engage

Viva Engage uses Exchange mailboxes to efficiently manage and store both user and community messages under its retention policies. These messages are securely kept in within their respective mailboxes, only accessible through eDiscovery tools for compliance checks. This practice ensures that regular users and administrators don't have visibility into these folders, maintaining privacy and security.

Initially, messages are stored in hidden folders within the Exchange system. Following the end of their retention period, they're transferred to the SubstrateHolds folder. This process serves as a temporary storage area where messages await their eventual permanent deletion, while still being accessible for legal and compliance reviews if necessary.

### Retention lifecycle for Viva Engage

When a user's mailbox is deleted under an active retention policy, it becomes an inactive mailbox, preserving the data for necessary compliance and discovery processes. A scheduled timer job evaluates the retention status of items every seven days, moving expired items to the SubstrateHolds folder, where they're prepared for permanent deletion. However, if there are legal holds or other eDiscovery requirements, the deletion process is paused, ensuring that all compliance needs are met.

Messages, once deleted from the user view in Viva Engage, remain discoverable through eDiscovery tools as long as they are in the SubstrateHolds folder, maintaining accessibility for compliance checks even after they're no longer visible within the application.

:::image type="content" source="../media/viva-engage-retention-lifecycle.png" alt-text="Diagram showing the content lifecycle for Viva Engage." lightbox="../media/viva-engage-retention-lifecycle.png":::

| Scenario | Modified or deleted content| Unmodified content|
| :--- | :--- | :--- |
| **Retain and delete**| If edited or deleted during the retention period, the message is immediately copied or moved to SubstrateHolds. It remains there for at least 1 day. After the retention period, it undergoes permanent deletion within 1-7 days. | The message moves directly to SubstrateHolds after the retention period and is permanently deleted within 1-7 days after at least 1 day of storage. |
| **Retain-only** | If edited or deleted, the message is immediately copied to SubstrateHolds and retained there indefinitely until the retention period ends. It's then permanently deleted within 1-7 days post-period. | The message stays indefinitely in its original location, unaffected by retention operations. |
| **Delete-only** | Upon deletion, the message is immediately moved to SubstrateHolds and stored for at least 1 day, then permanently deleted within 1-7 days. | At the end of the retention period, the message moves to SubstrateHolds, is stored for at least 1 day, and then permanently deleted within 1-7 days. |

## Messages from external users

Retention policies in Viva Engage are primarily designed for internal users within your organization. However, you can extend these policies to external users by modifying the policy settings:

- **Applying policies to external users**: Include external users in retention policies by selecting the **Edit** option and specifying their account details.
- **Limitation for Azure B2B guest users**: Viva Engage retention policies don't support Azure B2B guest users, which is crucial when collaborating externally.

### Limitations

There are specific limitations in how retention policies can be applied within Viva Engage, especially concerning external and guest users:

- **Editing user message policies**: Be careful when selecting **Edit** for the Viva Engage user messages. The interface might display guest and non-mailbox users, but retention policies don't cover these groups. Make sure you don't select them to avoid configuration errors.

## Handling employee departures

When an employee leaves your organization and their Microsoft 365 account is deactivated, their Viva Engage user messages subject to retention are securely stored in an inactive mailbox. This process ensures these messages remain accessible for eDiscovery searches, following any retention policies applied before deactivation. Retaining data in inactive mailboxes aids compliance with legal obligations and facilitates audits or investigations post-employee departure. Data remains in the inactive mailbox according to the retention policy, varying based on legal and regulatory requirements.

If the departing user stored files in Viva Engage, these files are subject to separate retention policies managed through SharePoint and OneDrive.
