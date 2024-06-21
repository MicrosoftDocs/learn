Retention labels help manage the lifecycle of documents, emails, and other digital content by specifying retention or deletion timelines. These labels must be created and published before they can be applied. This ensures that only approved and relevant labels are used in managing data.

## Manually apply retention labels

Users can manually apply retention labels in these locations:

- Outlook
- OneDrive and SharePoint
- Teams site that's group-connected

**In Outlook on desktop and on the web**:

- Navigate to the item you want to label.

- Right-click the item and select **Assign Policy**.

   :::image type="content" source="../media/outlook-retention-labels.png" alt-text="Screenshot showing how to assign a retention label in Outlook.":::

- Select the appropriate retention label from the list.

- Labels once applied will show on the item along with the expiry date if applicable.

**In OneDrive and SharePoint**:

- Select the document or item.

- Open the details pane by clicking on the information icon.

- Under **Apply label**, choose the appropriate retention label from the dropdown.

   :::image type="content" source="../media/sharepoint-apply-retention-label.png" alt-text="Screenshot showing how to assign a retention label in SharePoint.":::

- The label details can be viewed in the details pane once applied.

**In Microsoft Teams**:

- Navigate to the **Files** tab within a Teams channel.

- Select the file to which you want to apply the label.

- Use the labeling options that appear to apply the desired retention label.

## Set default retention labels

A default retention label in Microsoft Purview automatically applies a retention or deletion rule to all new and existing unlabeled items within a specific location like a SharePoint document library or an Outlook folder. This automatic application ensures that all items are covered by a retention policy, streamlining management by eliminating the need to label each item individually.

**Set default retention labels in SharePoint document libraries**:

- Navigate to the settings of the document library where you want to apply the default label.

- Find and configure the default retention label option under the document library settings.

- Select the label that best fits the content type or compliance requirements of the documents stored in this library.

- Optionally, apply this label to all existing items in the library to ensure uniform policy application.

   :::image type="content" source="../media/sharepoint-default-retention-label.png" alt-text="Screenshot showing how to set a default retention label in SharePoint.":::

**Set default retention labels in Outlook folders**:

In the Outlook desktop client:

- Right-click the folder you want to set a default retention label.

- Select **Properties**, then navigate to the **Policy** tab.

- Choose a default retention label from the options available. This label will automatically apply to all incoming and currently unlabeled emails in this folder.

In Outlook on the web:

- Right-click the folder you want to set a default retention label.

- Select **Assign policy**, then change the **User parent folder policy** to the retention label you want to use.