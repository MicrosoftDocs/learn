In Microsoft 365, understanding how to recover content is essential for maintaining business continuity, protecting sensitive data, and supporting compliance. Accidental deletions, user error, and malicious activity can all disrupt operations. Recovery options built into Microsoft 365 help organizations minimize disruption and restore access quickly.

## Recovery options

Recovery tools help users manage and restore their data effectively, ensuring that operations can continue smoothly without significant data loss.

### OneDrive portal

The OneDrive Recycle Bin allows users to recover files they have accidentally deleted, minimizing downtime and maintaining productivity:

1. Go to the OneDrive website and sign in with the appropriate account.
1. Select **Recycle bin** from the left-side pane.

   :::image type="content" source="../media/onedrive-recycle-bin.png" alt-text="Screenshot showing the OneDrive Recycle bin.":::

1. Select the item you want to restore, then choose **Restore** from the top pane.

The item has been successfully restored to its original location.

### Restore the entire OneDrive

For scenarios involving extensive data changes, like after a ransomware attack or widespread accidental deletions, a complete restoration of OneDrive content might be necessary. To revert the entire OneDrive to an earlier state, perform these steps in OneDrive:

1. Go to your OneDrive, then select **Settings** > **Restore your OneDrive** from the left navigation pane.
1. On the Restore page, select a date from the dropdown list or select **Custom date and time**.

   :::image type="content" source="../media/onedrive-restore.png" alt-text="Screenshot showing the dialogue to restore an entire OneDrive.":::

1. Use the activity chart and activity feed to review the recent activities that you want to undo.

      :::image type="content" source="../media/onedrive-restore-activity-chart.png" alt-text="Screenshot showing the activity chart to restore an entire OneDrive.":::

### Restore items in the recycle bin that were deleted from SharePoint or Teams

Maintaining data consistency across collaboration platforms like SharePoint and Microsoft Teams is crucial for operational efficiency and regulatory compliance:

1. Go to the SharePoint site where the file was deleted.

   - If you're starting in Microsoft Teams, go to the channel's Files tab, select **More** > **Open in SharePoint** to open the corresponding document library in SharePoint.

1. To open the Recycle Bin in SharePoint, you can:

   - Select **Recycle bin** from the **Quick Launch bar**.
   - Or go to **Settings**, choose **Site contents**, then select **Recycle bin** at the top of the page:

   :::image type="content" source="../media/sharepoint-recycle-bin.png" alt-text="Screenshot showing the SharePoint Recycle bin.":::

1. On the Recycle bin page, select the checkbox to the left of the items or files you want to restore, then select **Restore**.

When an item is restored, it's restored to the same location from which it was deleted.

### Restore a previous version of an item or file in SharePoint

Use the SharePoint version history to restore earlier versions of documents and undo accidental changes or damage:

1. Go to the SharePoint site where the items are located, then open the list or library from the Quick Launch bar.

   If the name of your list or library doesn't appear, select **Site contents** or **View All Site Content**, then select the name of your list or library.

1. Right-click on the document name and select **Version History**. If **Version History** isn't visible, select the ellipses (...), then select **Version History**.

   A list of versions of the files appears.

   :::image type="content" source="../media/sharepoint-version-history.png" alt-text="Screenshot showing version history in SharePoint.":::

1. In the **Version History** dialog, hover over the version you want to restore, then select **Restore**.

   :::image type="content" source="../media/sharepoint-restore-version.png" alt-text="Screenshot showing the menu to restore a version in SharePoint.":::

1. To confirm restoring the current version as the latest version, select **OK**.

   :::image type="content" source="../media/sharepoint-restore-dialogue.png" alt-text="Screenshot showing the dialogue to restore a file in SharePoint over the current version.":::

The document has been successfully restored and has overwritten the last version. SharePoint doesn't remove the earlier version you just restored. It creates a copy and makes it the latest version.

### Versions from Microsoft 365 apps for enterprise

When precise version control is necessary, especially in collaborative environments, Microsoft 365 apps for enterprise provide tools to review and restore document versions meticulously. This ensures that only the most accurate and intended versions of documents are in use:

1. Go to SharePoint Online in your tenant.
1. Select the site collection that contains the file you want to compare.
1. Go to the document location in the document library.
1. Select the checkbox to the left of the item you want to compare and select **Open in app** from the top pane.
1. In Microsoft Word, select **Review** > **Compare** > **Specific Version...** on the navigation ribbon.

   :::image type="content" source="../media/sharepoint-compare-word-ribbon.png" alt-text="Screenshot showing how to access the Specific Version feature in Word's Review tab.":::

1. A dialogue window displays the version history, similar to what is seen in SharePoint.

   :::image type="content" source="../media/sharepoint-compare-versions.png" alt-text="Screenshot showing the version history dialogue in Word.":::

From here, select a version to view a side-by-side comparison and decide which version to keep.
