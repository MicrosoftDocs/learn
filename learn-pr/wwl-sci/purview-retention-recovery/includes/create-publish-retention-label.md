Retention labels are a key part of data lifecycle management in Microsoft Purview. They define how long to keep content and what actions to take when that time ends. Labels support compliance, reduce risk, and provide control over how your organization manages data across Microsoft 365.

You can create retention labels to apply at the item level, then publish them so users can apply those labels in apps like SharePoint, Exchange, and OneDrive.

## What retention labels do

A retention label defines how long an item, such as an email, document, or Teams chat, should be retained and what happens afterward. Depending on how the label is configured, content might be:

- Retained for a specific period, then deleted.
- Retained for a specific period, with no action taken afterward.
- Labeled for classification only, with no retention or deletion.
- Marked as a record or regulatory record, which limits what actions can be taken on the content.

These settings help ensure that your organization meets compliance obligations and has a consistent approach to data management.

## Where retention labels can be used

Retention labels work across several Microsoft 365 services that support item-level retention and deletion. These include:

- Exchange mailboxes
- SharePoint sites
- OneDrive accounts
- Microsoft 365 Groups
- Teams files (through SharePoint)
- Loop and Copilot pages

Exchange public folders, Teams chats, and Viva Engage messages don't support retention labels. Use retention policies for managing data in those locations.

## Licensing and permissions

To create and manage retention labels, your account must be assigned one of these roles in Microsoft Purview:

- Records Management
- Retention Management
- Compliance Administrator

To use File plan, you need either the **Retention Management** or **View-Only Retention Management role**.

Some features, such as event-based retention and disposition review, require Microsoft 365 E5 or equivalent add-ons.

## Ways to apply retention labels

Retention labels can be:

- Applied manually by users or admins in apps like Outlook, SharePoint, or OneDrive.
- Published through retention label policies to make them available across supported locations.
- Applied automatically when content matches conditions like keywords, sensitive info types, or trainable classifiers.

## Create and publish a retention label

Retention labels can be created in the **Data lifecycle management** and **Records management** solutions in Microsoft Purview. Records management includes the **File plan** tool, which allows for bulk label creation and adds support for optional metadata like file plan descriptors. While not required, File plan can help streamline large-scale label management.

### Create a retention label

To create a new retention label:

1. In the [Microsoft Purview portal](https://purview.microsoft.com/?azure-portal=true), go to **Solutions** > **Data lifecycle management** > **Retention labels**.

1. Select **Create a label**.

1. On the **Name your retention label** page, enter a name and optional descriptions for admins and users.

   - The name can't be changed after the label is saved.

1. On the **Define label settings** page, choose how the label manages content:

   - **Retain items forever or for a specific period** to prevent permanent deletion during that time.

   - **Enforce actions after a specific period** to delete or relabel items after the retention period ends, without retaining them.

   - **Just label items** to classify content without applying any retention or deletion actions.

1. On the **Define the retention period** page, set the retention period and when it starts:

   - Options include when content is created, modified, labeled, or when a specific event occurs.

1. On the **Choose what happens after the retention period** page, choose what happens when the retention period ends:

   - **Delete items automatically** to permanently remove labeled content from storage.

   - **Start a disposition review** to have assigned reviewers decide what action to take.

   - **Change the label** to automatically replace it with another and extend the retention period.

   - **Run a Power Automate flow** to trigger a custom workflow, such as notifying users or moving items.

   - **Deactivate retention settings** to stop retaining or deleting content, leaving items unchanged unless manually handled.

1. Review your settings, then create the retention label.

### Publish a retention label

To make a retention label available for users to apply, include it in a retention label policy and publish it to supported locations.

To publish labels:

1. Go to **Data lifecycle management** or **Records management**, then select **Policies** > **Label policies**.

1. Select **Publish labels**.

1. On the **Choose labels to publish** page, add the retention label you'd like to publish.

1. On the **Policy scope** page, optionally add admin units.

1. On the **Choose the type of retention policy to create​** page, choose between an **Adaptive** or **Static** policy scope.

   - Adaptive scopes require separate setup and allow targeting by user, site, or group attributes.

1. On the **Choose where to apply this policy** page, select to publish the label to all locations or select specific locations for the label.

   :::image type="content" source="../media/retention-label-policy-locations.png" alt-text="Screenshot showing locations available to apply a retention label policy." lightbox="../media/retention-label-policy-locations.png":::

1. Name your retention label policy, then review and submit your settings to publish your retention label to a retention label policy.

## Edit or delete retention labels

You can edit certain parts of a retention label, such as its descriptions or retention period. However, some settings can't be changed after the label is created. These include the label name, the retention trigger type, and whether the label marks content as a record.

To delete a retention label, it must meet all of these conditions:

- It's not part of a published or auto-apply label policy
- It hasn't been applied to any items
- It isn't configured for event-based retention or as a regulatory record

## When retention labels become available to apply

The visibility of retention labels can vary based on the service:

- **SharePoint and OneDrive**: Labels usually appear within one day, but it can take up to seven days.
- **Exchange**: Labels can take up to seven days to appear and require the mailbox to have at least 10 MB of data.

:::image type="content" source="../media/retention-labels-published-timings.png" alt-text="Diagram illustrating when retention label policies are available to apply." lightbox="../media/retention-labels-published-timings.png":::

If labels don't appear as expected, check the policy status in the Microsoft Purview portal. You can also use PowerShell to troubleshoot or retry distribution.

## Apply labels in Microsoft 365 apps

Once published, users can apply labels manually in these locations:

- Outlook
- SharePoint and OneDrive
- Microsoft 365 Group-connected Teams sites
- Loop and Copilot pages

Admins can also set default labels in Outlook folders or SharePoint libraries to apply to all unlabeled content in that location.

Retention labels help organizations manage data based on business, regulatory, or operational needs. Creating and publishing labels ensures that users can consistently apply them across supported Microsoft 365 services.
