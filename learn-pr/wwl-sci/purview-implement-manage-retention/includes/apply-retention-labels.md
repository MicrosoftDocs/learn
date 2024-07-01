In today's digital world, managing the vast amount of information that organizations handle daily is crucial. Retention labels in Microsoft Purview help manage this by setting rules on how long to keep documents, emails, and other content. These rules make sure that important information is kept as long as needed and that unnecessary information is deleted safely and efficiently. Before you can use these labels, they need to be created and published, ensuring they're correctly applied across your organization to meet both internal policies and legal requirements.

## Manually apply retention labels

Users can manually apply retention labels in these locations:

- Outlook
- OneDrive and SharePoint
- Teams group-connected sites

**In Outlook on desktop and on the web**:

1. Navigate to the item you want to label.
1. Right-click the item and select **Assign Policy**.

   :::image type="content" source="../media/outlook-retention-labels.png" alt-text="Screenshot showing how to assign a retention label in Outlook.":::

1. Select the appropriate retention label from the list.
1. Labels once applied appear on the item along with the expiry date if applicable.

**In OneDrive and SharePoint**:

1. Select the document or item.
1. Open the details pane by clicking on the information icon.
1. Under **Apply label**, choose the appropriate retention label from the dropdown.

   :::image type="content" source="../media/sharepoint-apply-retention-label.png" alt-text="Screenshot showing how to assign a retention label in SharePoint.":::

1. The label details can be viewed in the details pane once applied.

**In Microsoft Teams**:

1. Navigate to the **Files** tab within a Teams channel.
1. Select the file to which you want to apply the label.
1. Use the labeling options that appear to apply the desired retention label.

## Set default retention labels

A default retention label automatically applies a predefined retention or deletion rule to all new items within a designated container. This includes existing unlabeled items, such as those in a SharePoint document library or an Outlook folder. This feature simplifies data governance by ensuring every item in specified locations complies with organizational policies without manual intervention.

### Setting default labels in SharePoint

To set a default retention label in SharePoint:

1. Navigate to the **Library settings** of the document library you want to manage.
1. Select **Apply label to items in this list or library** under **Permissions and Management**.
1. Choose a retention label that aligns with the content type or regulatory requirements of the stored documents.
1. Optionally, apply the label to existing items to ensure all documents in the library adhere to the same retention policy.

   :::image type="content" source="../media/sharepoint-default-retention-label.png" alt-text="Screenshot showing how to set a default retention label in SharePoint.":::

#### Label behavior when you use a default label for SharePoint

1. **New items**: Automatically inherit the default label upon creation or addition to the library.
1. **Existing unlabeled items**: Can be retroactively labeled when setting the default, ensuring uniform policy enforcement.
1. **Inheritance**: The default label is inherited across all items within the container and any subfolders.
1. **Modifying or removing the default label**: Changes or removals only affect how new items are labeled unless explicitly applied to existing items.
1. **Moving items**: Items moved to a different library with a different default label inherits the new label. If moved to a library without a default label, they retain their original label unless manually changed.

### Setting default labels in Outlook

In Outlook, you can set a default label for each folder to manage emails efficiently:

- **Desktop client**: Right-click the folder, select **Properties**, and set the default label under the **Policy** tab.
- **Outlook on the web**: Right-click the folder and select **Assign policy** to set the default label.

#### Behavior of default labels in Outlook

- **Inheritance**: All emails in the folder, including new and existing unlabeled emails, automatically receive the default label.
- **Changing labels**: Updating the default label affects all emails that have inherited it unless they're individually labeled.
- **Moving emails**: Emails moved to another folder with a different default label inherits the new label settings.

By using default labels, organizations can ensure consistent data management practices across their digital environments, reducing the risk of noncompliance and enhancing operational efficiency.

## Automatically apply labels using Outlook rules

1. Create a rule by right-clicking an email, then selecting **Rules** > **Create Rule** > **Advanced Options**.
1. Set conditions that trigger the rule and select the action to apply a specific retention label to emails meeting these conditions.

   :::image type="content" source="../media/outlook-auto-retention-rule.png" alt-text="Screenshot showing how to automatically set a default retention using an Outlook rule.":::

Effective management of retention labels in Microsoft Purview is essential for compliance and organized data management. By familiarizing yourself with manual applications, default settings, and automation through Outlook rules, you ensure consistent adherence to your organization's data management policies. Regularly update and review your retention practices to align with evolving needs and regulations, optimizing your data lifecycle management.

## Apply a retention label interactive guide

Use the **Apply a retention label** interactive guide for a walkthrough on publishing and applying retention labels across workloads.

[:::image type="content" source="../media/apply-retention-label-interactive-guide-cover.png" alt-text="Cover for an interactive guide that says Apply a retention label." border="false":::](https://mslearn.cloudguides.com/guides/Apply%20a%20retention%20label%20in%20Microsoft%20Purview?azure-portal=true)
