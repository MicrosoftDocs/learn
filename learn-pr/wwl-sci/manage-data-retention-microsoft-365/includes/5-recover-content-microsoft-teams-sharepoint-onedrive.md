Understanding how to retain and recover documents is crucial for maintaining business continuity, compliance with data protection regulations, and mitigating accidental data loss.

## Recovery options

Users have several methods to recover deleted files, using tools like the SharePoint Online recycle bin, OneDrive recycle bin, and document versioning.

### OneDrive portal

Recover files you've accidentally deleted in OneDrive to minimize disruption and prevent data loss:

1. Navigate to the OneDrive website and sign in with the appropriate account.
1. Select **Recycle bin** from the left-side pane.

   :::image type="content" source="../media/onedrive-recycle-bin.png" alt-text="Screenshot showing the OneDrive Recycle bin.":::

1. Select the checkmark to the left of left the item to restore and select **Restore** from the top pane.

The item has been successfully restored to its original location.

### Restore the entire OneDrive

Reverse large-scale changes like ransomware attacks or accidental bulk deletions:

To revert the entire OneDrive to an earlier state, perform the following steps in the Office 365 portal:

1. Navigate to your OneDrive, then select **Settings** > **Restore your OneDrive** from the left navigation pane.
1. On the Restore page, select a date from the dropdown list or select **Custom date and time**.

   :::image type="content" source="../media/onedrive-restore.png" alt-text="Screenshot showing the dialogue to restore an entire OneDrive.":::

1. Use the activity chart and activity feed to review the recent activities that you want to undo.

      :::image type="content" source="../media/onedrive-restore-activity-chart.png" alt-text="Screenshot showing the activity chart to restore an entire OneDrive.":::

### Restore items in the recycle bin that were deleted from SharePoint or Teams

Recover items deleted from SharePoint or Microsoft Teams to maintain data consistency across platforms:

1. Navigate to SharePoint site that the items were deleted from. In Microsoft Teams, from the **Files** tab at the top of your channel, select **More** > **Open in SharePoint**.
1. In the Quick Launch bar navigation on the bottom left of the screen, select **Recycle bin**.
1. Select **Settings**, then select **Site contents**.
1. The recycle bin is in the top right portion of the Site Contents page.

   :::image type="content" source="../media/sharepoint-recycle-bin.png" alt-text="Screenshot showing the SharePoint Recycle bin.":::

1. On the Recycle bin page, select the checkbox to the left of the items or files you want to restore, then select **Restore**.

When an item is restored, it's restored to the same location that it was deleted from.

### Restore a previous version of an item or file in SharePoint

Protect against unintended changes or corruptions by restoring previous document versions:

1. Navigate to SharePoint site that the items are located then open the list or library from the Quick Launch bar.

   If the name of your list or library doesn't appear, select **Site contents** or **View All Site Content**, then select the name of your list or library.

1. Right click on the document name and select **Version History**. To see Version History, you might need to scroll the menu.

   If you don't see Version History, select the ... (ellipses), then select **Version History**.

   A list of versions of the files appears.

   :::image type="content" source="../media/sharepoint-version-history.png" alt-text="Screenshot showing version history in SharePoint.":::

1. In the **Version History** dialog, hover next to the version you want, and to get a list of options, on the right side, select the down arrow. Select **Restore**.

   :::image type="content" source="../media/sharepoint-restore-version.png" alt-text="Screenshot showing the menu to restore a version in SharePoint.":::

1. To restore the current version as the latest version, select **OK**.

   :::image type="content" source="../media/sharepoint-restore-dialogue.png" alt-text="Screenshot showing the dialogue to restore a file in SharePoint over the current version.":::

The document has been successfully restored and has overwritten the last version. SharePoint doesn't remove the earlier version you just restored. It creates a copy and makes it the latest version.

### Versions from Microsoft 365 apps for enterprise

Make informed decisions before restoring documents by comparing different versions:

1. Navigate to SharePoint Online in your tenant.
1. Select the site collection containing the file for which a version should be restored.
1. Navigate to the document location in the document library.
1. Select the checkmark left from the item to restore and select **Open in app** from the top pane.
1. In the Word client, select **File** from the upper left-side and **Info** from the left-side pane.
1. Select **Version History** to open the right-side pane with all previously saved versions.
1. Select **Open version** from below the version you want to restore.
1. In the previous version of the document, select **File** from the upper left-side and **Save** **As** from the left-side pane.
1. Save the document version to new location.

You could also use the Compare and Restore buttons from the top pane in the older version of a document or spreadsheet to compare the versions side by side or restore it directly to the original location by overwriting the newer version.
