After you've confirmed that your search results contain the content you need, you can export those results directly from Microsoft Purview eDiscovery. Exporting creates a downloadable package of items and metadata that can be used for legal review, investigation documentation, or external handoff.

Exporting is often the final step in the eDiscovery search process. If your organization performs deeper analysis before exporting, you might add results to a review set first. But if you're ready to hand off data or archive results, exporting is the most direct approach.

## Choose what to export

When you're ready to export:

1. Go to the **Searches** tab in your case.
1. Select a completed search.
1. Select **Export**.

In the export pane, you'll provide a name for your export and decide what types of items to include. You can export:

- **Only indexed items** that matched your search query
- **Indexed items and partially indexed items** (useful if you're concerned about items that couldn't be fully processed)
- **Only partially indexed items** (useful in special cases, such as if you're following up on indexing issues)

   :::image type="content" source="../media/ediscovery-export.png" alt-text="Screenshot showing the index options for an eDiscovery export." lightbox=" ../media/ediscovery-export.png":::

These choices control how comprehensive your export will be. For most investigations, the first or second option is appropriate.

## Configure export settings

Depending on the types of content in your search results, you can configure additional export options.

### OneDrive and SharePoint

If your search includes sites or document libraries, you can customize how much document history or folder context to include. You can choose:

- How many document versions to include (latest, recent 10 or 100, or all versions)
- Whether to include subfolder items that didn't match the query
- Whether to include attachments from SharePoint lists

   :::image type="content" source="../media/ediscovery-export-onedrive-sharepoint.png" alt-text="Screenshot showing the OneDrive and SharePoint export options for eDiscovery." lightbox=" ../media/ediscovery-export-onedrive-sharepoint.png":::

These options are helpful if you're dealing with collaborative content or list-based business processes.

### Mailboxes and Teams

These options help preserve conversational context, especially for Teams chats or messages with cloud attachments. For Exchange and Teams content, you can:

- **Thread conversations** into HTML transcripts (especially useful for chat review)
- **Include contextual Teams and Viva Engage messages** (up to 12 hours of related conversation)
- **Include cloud attachments** from SharePoint or OneDrive, and choose the version range to include

   :::image type="content" source="../media/ediscovery-export-mailbox-teams.png" alt-text="Screenshot showing the message and mailbox export options for eDiscovery." lightbox=" ../media/ediscovery-export-mailbox-teams.png":::

These settings help ensure that the content you export preserves its original context and includes linked documents when applicable.

## Select format and structure

Next, choose how your exported items are packaged:

- Export mailbox content as **PST** files or **MSG files**
- Organize data by **source location**
- Include or condense the **original folder path**
- Generate **friendly names** for items to make them easier to reference

   :::image type="content" source="../media/ediscovery-export-type-format.png" alt-text="Screenshot showing the type and format export options for eDiscovery." lightbox=" ../media/ediscovery-export-type-format.png":::

These options help shape the output to meet your internal or legal team's requirements.

## Start the export and track progress

Once you've configured your export, select Export to begin. A confirmation message appears, and the process starts in the background.

You can monitor the export from the **Process manager**, where you'll see:

- Export status and completion time
- Number of items and locations
- Export options used

This helps you keep track of multiple exports and ensures you know when everything is ready for download.

## Download the export package

After the export finishes, go to the **Exports** tab in your case to view the results. Completed exports appear in the table with their name, status, search name, and creation details.

To download the export package:

1. Select the export to open its **Overview**.
1. In the **Export packages** section, review the list of downloadable files, including message content, reports, and item metadata.
1. Select the checkboxes next to the files you want to download.
1. Select Download.

:::image type="content" source="../media/download-export.png" alt-text="Screenshot showing the download packages view in eDiscovery." lightbox=" ../media/download-export.png":::

The download includes all exported content along with reports that summarize what was included.
