After you review and tag content in a review set, the next step is often to export it for further processing or handoff. Exporting helps legal and compliance teams prepare documents for handoff, archive data outside of Microsoft Purview, or work with a smaller subset of items in another review set.

Microsoft Purview eDiscovery gives you flexible export options, including ways to preserve redactions, include review tags, and control folder structure. You can also reuse selected content by moving it into another review set for separate review or analysis.

## Export content from a review set

To start an export:

1. Open your case and go to the **Review sets** tab.
1. Select the review set you want to export, then select **Open review set**.
1. Select one or more items you want to export.
1. From the command bar, select **Action** > **Export**.
1. On the **Export** flyout page, configure your export settings.
1. Select **Export** to begin the process.

   :::image type="content" source="../media/export-review-set-configuration.png" alt-text="Screenshot showing the export panel and full configuration options to export items from a review set." lightbox="../media/export-review-set-configuration.png":::

You can track the progress and download the exported content from **Process manager**.

> [!NOTE]
> Export jobs are retained for the life of the case, but you must download the content within 30 days of export completion.

## Choose what to include in your export

You can choose whether to export only selected items, items that match the current filter, or everything in the review set:

- **Selected documents only**: Export just the items you've manually selected
- **All filtered documents**: Export items based on your current search or filter
- **All documents in the review set**: Export everything, regardless of filter or selection

You can also expand the export to include related content:

- **Associated family items**: Items like attachments that share the same FamilyId
- **Associated conversation items**: Related messages from Teams or Viva Engage threads

## Select your export format and type

Depending on how you plan to use the exported data, choose from the following export types:

- **Export item report only**: Generates a summary report without the actual items
- **Export items with item report**: Exports documents along with a report

When exporting items with a report, you can choose more options:

- **Export redaction**: Includes redacted PDFs if redactions have been committed
- **Export text files**: Provides extracted text versions of the files
- **Export tags**: Includes review tags in the item report

For messages, select the preferred format:

- **Create PSTs for messages where possible**
- **Create .msg files for messages**

Choose PST if you're preparing content for Outlook review. Use MSG for more granular access to individual messages.

You can also organize how content is structured in the export:

- **Separate folders or PSTs by location**
- **Include original folder structure**
- **Condense paths to 259 characters**
- **Assign friendly names to each item**

Choose the export structure that works best for the review team or external recipients.

## Reuse items in another review set

Sometimes, you might want to isolate a group of reviewed items for further analysis. Instead of exporting and reimporting, you can send those items directly to another review set in the same case.

To do this:

1. In the original review set, select the items you want to reuse.
1. Select **Action** > **Add to another review set**.
1. Choose the target review set.
1. Select whether to include:

   - **Selected documents only**
   - **All filtered documents**
   - **All documents in the review set**
1. Decide whether to include the original **metadata** and **tags**.
1. Select **OK** to start the process.

The process appears in the **Process manager** of the destination review set, where you can track completion.

This approach is useful for running analytics on a smaller data set or separating different phases of review without duplicating effort.

## Export data interactive guide

Use the **Export data** interactive guide to walk through exporting search and review set data.

[:::image type="content" source="../media/guide-export-data.png" alt-text="Screenshot showing the opening page to the Export data interactive guide." lightbox="../media/guide-export-data.png":::](https://mslearn.cloudguides.com/guides/Export%20data%20with%20Microsoft%20Purview%20eDiscovery?azure-portal=true)
