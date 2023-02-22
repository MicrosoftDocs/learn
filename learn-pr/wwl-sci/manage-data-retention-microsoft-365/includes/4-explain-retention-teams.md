Teams is a solution with content stored across the different Microsoft 365 services and Azure subsystems that provide instant messaging, conversations, and calling features. How retention works for Teams is therefore dependent on the type of content to preserve or delete:

- **Items can be retained and deleted by using retention policies for Teams**: Chat messages and channel messages, including embedded images, tables, hypertext links and links to other Teams messages and files. Chat messages include all the names of the people in the chat, and channel messages include the team name and the message title (if supplied).

- **Teams messages in private channels are not included in retention policies for Teams channels**, if you want to retain private channel messages you need to create a designated retention policy for private channel messages only. You can't create a retention policy for both regular and private channel messages.

- **Reactions from others in the form of emoticons are not included.**

- **Emails and files that you use with Teams are not included in retention policies for Teams**. These items require a separate retention policy configured for Exchange locations to protect the group mailbox.

- **Shared channels are only subject to retention in the originating tenant**. Messages in shared channels are stored in a hidden folder in a mailbox that is created in the originator tenant of the channel specifically for this purpose. Unlike private channel messages these shared channels inherit retention settings from the parent team and don't need designated retention policies.

Retention policies with Teams locations can retain chats and channel messages in Teams, which are ingested from the original storage location in an Azure Cosmos DB into a hidden folder in the group mailbox. To retain other email messages sent to a Teams retention policy with Exchange locations and the group mailbox in scope is required.

> [!TIP]
> It is important to understand where the various content of a Team is stored to create the right Retention Policies. When using Retention Labels, the storage location of the labeled elements does not matter.

## Teams retention functionality

After a retention policy is configured for chat and channel messages, a timer job from the Exchange service periodically evaluates items in the hidden folder where these Teams messages are stored. The timer job takes up to seven days to run. When these items have expired their retention period, they're moved to the SubstrateHolds folder—another hidden folder that's in every user or group mailbox to store "soft-deleted" items before they're permanently deleted.

After a retention policy is configured for chat and channel messages, the paths the content takes depend on whether the retention policy is to **retain and then delete**, to **retain only**, or **delete only**.

![retention period processing for Teams channel chats.](../media/teams-retention-functionality.png)

The following table provides an overview of the different ways content is held or removed by retention policies for Teams:

| Step| (1) **If a chat or channel message is edited or deleted** by the user during the retention period…| (2) **If a chat or channel message is not deleted** during the retention period…|
| :--- | :--- | :--- |
| **retain and delete**| The original message is copied (if edited) or moved (if deleted) to the SubstrateHolds folder. The message is stored there for at least one day. When the retention period expires, the message is permanently deleted the next time the timer job runs.| The message is moved to the SubstrateHolds folder within seven days after the retention period expires and stays there for at least one day, and then the message is permanently deleted the next time the timer job runs.|
| **retain-only**| A copy of the original message is created in the SubstrateHolds folder and retained there for at least one day. If the retention policy is configured to retain forever, the item remains in the SubstrateHolds folder. If the retention policy has an end date and expires, the message is permanently deleted the next time the timer job runs. | Nothing happens before and after the retention period; the message remains in its original location.|
| **delete-only**| At the end of the retention period, the message is moved to the SubstrateHolds folder. The message is retained there for at least one day and is permanently deleted the next time the timer job runs.| The message is moved to the SubstrateHolds folder within seven days after the retention period expires and stays there for at least one day, and then the message is permanently deleted the next time the timer job runs.|

After a retention policy is configured for chat and channel messages, a timer job from the Exchange service periodically evaluates items in the hidden mailbox folder where these Teams messages are stored. The timer job typically takes 1-7 days to run.

## Important considerations

Because the Teams storage locations are complex, there are several other considerations to make, when configuring retention policies for Teams:

- Channel meeting messages are stored the same way as channel messages and Teams channel messages location is required for retention.

- Impromptu and scheduled meeting messages are stored in the same way as group chat messages, so for this data, select the Teams chats location when you configure your retention policy.

- For guest users in a meeting that your organization hosts, any messages from the meeting are stored in both your users mailbox and a shadow mailbox that's granted to the guest account. Retention policies aren't supported for shadow mailboxes but they can be reported as included in a "organization-wide" retention policy. 

- For external users joining by using an account from another Microsoft 365 organization, your retention policies can't delete messages for this user because they're stored in that user's mailbox in another tenant.

It's also important to know what happens to the data of users, when they leave the organization:

| Documents and Files| Chat messages| Channel messages|
| :--- | :--- | :--- |
| Because files and documents stored in a team are located on SharePoint Online sites, the same behavior as for SharePoint Online and OneDrive applies.| If a user leaves the organization and the according account is deleted, the chat messages that are subject to retention are stored in an inactive mailbox. The chat messages remain subject to any retention policy that was placed on the user before their mailbox was made inactive, and the contents are available to an eDiscovery search. | Channel messages posted by a user are stored in the Azure database and the mailbox of the teams. When a user leaves the organization, those data remains unaffected.|

