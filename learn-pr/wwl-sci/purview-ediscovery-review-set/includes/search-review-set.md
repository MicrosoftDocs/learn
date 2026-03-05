After content is added to a review set in Microsoft Purview eDiscovery, the next step is reviewing that content in a meaningful and efficient way. With large amounts of data, it's not enough to scroll through a list of documents. You need ways to search, filter, and focus on the items that matter most to your case.

Review sets support advanced filtering, document grouping, and several viewer modes that help you organize and examine content during an investigation. These capabilities make it easier to focus on the most relevant items, apply tags, and prepare content for further review or export.

## Filter review set content

Use the **advanced filter** panel to narrow down which items appear in the list and focus your review.

You can filter by:

- **Date** fields like last modified time
- **People** fields like sender or author
- **Text content** using keyword conditions
- **File type or metadata** like document extension or review tags

Filters support complex conditions. You can build filter queries using **AND**, **OR**, and nested subgroups. You can also use "Is empty" and "Isn't empty" filters to find untagged items or items missing metadata.

After applying a filter, the review set refreshes to display only the matching items. You can save your filter query to use later or share it with others reviewing the case.

### Add a filter to a review set

Select **Filter** at the top of the list view to open the **Condition builder**. This panel helps you define the criteria for the items you want to view.

:::image type="content" source="../media/review-set-filter-button.png" alt-text="Screenshot showing the list view of a review set, highlighting the filter button." lightbox="../media/review-set-filter-button.png":::

In the **Condition builder**:

1. Use the **Search** box to find a condition type such as Keywords, Sender/Author, Tags, or Native file extension.
1. Choose an operator, such as _Equals_, _Contains_, _Is empty_, or _Between_.
1. Enter or select a value. Some filters allow multiple values, while others are limited to one.
1. To add another filter, select **Add conditions**.
1. If needed, select **Add subgroup** to nest filters and build more complex queries.
1. When ready, select **Run query** in the bottom right corner to apply the filters.

   :::image type="content" source="../media/review-set-condition-builder.png" alt-text="Screenshot showing a query in the condition builder for a review set." lightbox="../media/review-set-condition-builder.png":::

The list refreshes to show only the items that match your query. You can save your query by selecting **Save** from the command bar. Saved filters appear under **Saved filters**, so you can reuse or share them later.

If you need to clear your filters, select **Clear all** in the Condition builder or select the **X** next to the _Filter_ label above the item list.

## Use keyword queries

When you apply a **keyword** filter, you can search across document content using search terms or even structured KQL-like syntax. Use Boolean operators such as **AND**, **OR**, **NOT**, and **NEAR**, and wildcards like `?` and `*` to find partial matches. Keyword filters work well for narrowing down to items that mention specific terms in the body of emails or documents.

> [!NOTE]
> Wildcards only work on single words. Phrase searches with wildcards aren't supported.

## Example filters

Here are a few examples of what filtering can help you do in a review set:

- **Find untagged items**: Filter by the **Tags** field and use the _Is empty_ operator.
- **Review certain file types**: Filter by **Native file extension** and select .pdf, .msg, .csv, or others.
- **Identify partially indexed items**: Use load sets to isolate items added with partial indexing.
- **Search by topic**: Filter by **Dominant theme** to find content that matches specific subjects, if themes are available.

These options help streamline review by focusing attention where it matters.

## Group items by relationship

To make content easier to navigate, you can group items in a review set. Grouping helps connect related files, such as a parent email and its attachments or messages in the same chat conversation.

There are two ways review sets can group content depending on your case settings.

- **Group ID and Thread ID** are used for new cases when grouping is enabled

  - Group by **families** to nest related documents, such as a Word file and its embedded images
  - Group by **conversations** to group emails or chats by thread

- **Family ID and Conversation ID** are used for older cases or when grouping is turned off

  - Group family attachments or Teams and Viva Engage conversations using metadata identifiers

   :::image type="content" source="../media/group-options.png" alt-text="Screenshot showing the group options for a review set." lightbox="../media/group-options.png":::

These grouping options give structure to your review list and make it easier to understand relationships between items.

## View items with different viewers

Once you've filtered or grouped content, you can select an item to view it in detail. Review sets support several viewing modes based on content type:

- **Source view** shows a near-native rendering of the document or email. This is the most complete view and includes comments, attachments, and formatting.
- **Plain text view** displays extracted text without formatting. This is useful for quick reading or focusing on keyword hits.
- **Annotate view** lets you mark up the document with highlights, redactions, and comments
- **Metadata view** shows document properties such as file name, size, authorship, and processing details
- **Copilot activity view** displays prompts and responses for Microsoft 365 Copilot content

   :::image type="content" source="../media/review-set-view-options.png" alt-text="Screenshot showing the list view with the view options highlighted in a review set." lightbox="../media/review-set-view-options.png":::

You can switch between these views as needed using the viewer toolbar.

## Summarize with Microsoft Security Copilot

If your organization is licensed for Microsoft Security Copilot and the item meets content requirements, you can generate a contextual summary of the item.

To summarize:

1. Select an item in the review set
1. Choose **Summarize** from the command bar
1. Use a preset prompt such as _Identify key participants_ or ask a custom question
1. Review the summary in the Copilot pane

   :::image type="content" source="../media/copilot-summarize-item.png" alt-text="Screenshot showing Security Copilot summarization of an item in a review set." lightbox="../media/copilot-summarize-item.png":::

Summarization helps reduce time spent reviewing lengthy documents and can highlight key terms, participants, or intent.

> [!NOTE]
> Items must contain at least 100 words and support the plain text view to be summarized. Only English-language content is currently supported.

## Work with selected content

After selecting an item, the viewer toolbar gives you access to several tools:

- Add or edit **notes**
- Open the item in a new window
- Download as PDF
- Move to the next or previous item
- Maximize or close the viewer

   :::image type="content" source="../media/viewer-toolbar.png" alt-text="Screenshot highlighting the viewer toolbar in a review set item." lightbox="../media/viewer-toolbar.png":::

These tools support focused, efficient review and help you document your findings.
