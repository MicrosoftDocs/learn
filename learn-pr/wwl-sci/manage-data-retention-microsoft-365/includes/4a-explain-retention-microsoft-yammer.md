Yammer connects leaders, communicators, and employees to build communities, share knowledge, and engage everyone. Yammer helps you connect and engage across your organization, so you can discuss ideas, share updates, and network with others.

Retention policies can be used to retain data from community messages and user messages in Yammer and delete those messages. Exchange mailboxes are used to store the data copied from these messages. Data from Yammer user messages is stored in a hidden folder in each user's mailbox that is included in the user message. For community messages, a similar hidden folder is used in a group mailbox.

Copies of community messages can also be stored in the hidden folder of user mailboxes if they mention @ user or inform the user of a reply. Although these messages originated as community messages, a retention policy for Yammer user messages will often include copies of community messages. As a result, user messages aren't limited to private messages.
These hidden folders aren't intended to be accessed directly by users or administrators, but store data that compliance administrators can search with eDiscovery tools.

>[!NOTE]
>Although Yammer messages are stored in Exchange, they are only included in a retention policy configured for the locations of Yammer community messages or Yammer user messages.

## Yammer retention functionality
After a retention policy is configured for Yammer messages, a timer job from the Exchange service periodically evaluates items in the hidden folder where these Yammer messages are stored. The timer job takes up to seven days to run. When these items have expired their retention period, they're moved to the SubstrateHolds folder—a hidden folder that's in every user or group mailbox to store "soft-deleted" items before they're permanently deleted.
After a retention policy is configured for Yammer messages, the paths the content takes depend on whether the retention policy is to **retain and then delete**, to **retain only**, or **delete only**.

![Graphical diagram of retention period processing for Yammer messages.](../media/yammer-retention-lifecycle.png)

The following table provides an overview of the different ways content is held or removed by retention policies for Yammer:

| Step| (1) **If a Yammer message is edited or deleted** by the user during the retention period…| (2) **If a Yammer message is not modified or deleted** during the retention period…|
| :--- | :--- | :--- |
| **retain and delete**| The original message is immediately copied (if edited) or moved (if deleted) to the SubstrateHolds folder. The message is stored there until the retention period expires and then the message is immediately permanently deleted.| The message is moved to the SubstrateHolds folder after the retention period expires. This action takes up to seven days from the expiry date. When the message is in the SubstrateHolds folder, it's then immediately permanently deleted.|
| **retain-only**| A copy of the original message is immediately created in the SubstrateHolds folder and retained there until the retention period expires. Then the message is immediately permanently deleted from the SubstrateHolds folder. | Nothing happens before and after the retention period; the message remains in its original location.|
| **delete-only**| The item is immediately moved to the SubstrateHolds folder where it's immediately permanently deleted.| At the end of the retention period, the message is moved to the SubstrateHolds folder. This action takes up to seven days from the expiry date. Then the message is immediately permanently deleted from the SubstrateHolds folder.

## Important considerations

There are several aspects to consider when configuring retention policies for Yammer:

- By default, a retention policy for Yammer user messages applies to all users in your organization, but not external users. You can apply a retention policy to external users if you use the Edit option for users included, and specify their account.

- When you select Edit for the Yammer user messages location, you might see guests and non-mailbox users. Retention policies aren't designed for these users, so don't select them.

- Files that you use with Yammer aren't included in retention policies for Yammer. These items have their own retention policies.

It's also important to know what happens to the data of users, when they leave the organization:

| Documents and Files| Yammer user messages| Yammer community messages|
| :--- | :--- | :--- |
| Because files and documents stored Yammer are located on SharePoint Online sites, the same behavior as for SharePoint Online and OneDrive applies.| When a user leaves the organization and their Microsoft 365 account is removed, their Yammer user messages that are subject to retention are retained in an inactive mailbox. These messages are still subject to the retention policies that were set for the user before their mailbox became inactive. This content is visible to an eDiscovery search. | Yammer community messages posted by a user are stored in the Azure database and the group mailbox. When a user leaves the organization, those data remains unaffected.|