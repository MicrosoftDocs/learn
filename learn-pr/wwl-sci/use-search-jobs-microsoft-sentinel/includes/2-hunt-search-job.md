One of the primary activities of a security team is to search logs for specific events. For example, you might search logs for the activities of a specific user within a given time-frame.

In Microsoft Sentinel, you can search across long time periods in large datasets by using a search job. While you can run a search job on any type of log, search jobs are ideally suited to search archived logs. If you need to do a full investigation on archived data, you can restore that data into the hot cache to run high performing queries and analytics.

## Search large datasets

Use a search job when you start an investigation to find specific events in logs within a given time frame. You can search all your logs to find events that match your criteria and filter through the results.

Search in Microsoft Sentinel is built on top of search jobs. Search jobs are asynchronous queries that fetch records. The results are returned to a search table that's created in your Log Analytics workspace after you start the search job. The search job uses parallel processing to run the search across long time spans, in large datasets. So search jobs don't impact the workspace's performance or availability.

Search results remain in a search results table that has a ***_SRCH** suffix.

## Supported log types

Use search to find events in any of the following log types:

- Analytics logs (no charges apply)
- Basic logs
- Auxiliary logs

## Limitations of a search job

Before you start a search job, be aware of the following limitations:

- Optimized to query one table at a time.
- Search date range is up to one year.
- Supports long running searches up to a 24-hour timeout.
- Results are limited to one million records in the record set.
- Concurrent execution is limited to five search jobs per workspace.
- Limited to 100 search results tables per workspace.
- Limited to 100 search job executions per day per workspace.

## Start a search job

Go to Microsoft Sentinel in the Azure portal, or in the Microsoft Defender portal, to enter your search criteria. Depending on the size of the target dataset, search times vary. While most search jobs take a few minutes to complete, searches across massive data sets that run up to 24 hours are also supported.

1. For Microsoft Sentinel in the [Defender portal](https://security.microsoft.com/), select **Microsoft Sentinel** > **Data lake exploration** > **Search & restore**. For Microsoft Sentinel in the [Azure portal](https://portal.azure.com), under **General**, select **Search**.

1. Select the **Table** menu and choose a table for your search.

1. In the **Search** box, enter a search term.

   ### [Defender portal](#tab/defender-portal)

   :::image type="content" source="../media/search-job-defender-portal.png" alt-text="Screenshot of search page with search criteria of administrator, time range last 90 days, and table selected." lightbox="../media/search-job-defender-portal.png":::

   ### [Azure portal](#tab/azure-portal)

   :::image type="content" source="../media/search-job-criteria.png" alt-text="Screenshot of search page with search criteria of administrator, time range last 90 days, and table selected." lightbox="../media/search-job-criteria.png":::

   ---

1. Enter a **keyword** for your search.

   > [!NOTE]
   > A keyword is a word or phrase that you want to search for in the selected table. You can use operators such as AND, OR, and NOT to refine your search. For example, if you want to search for events related to a specific user, you can enter the user's name as the keyword.

1. Select the **Start**  to open the advanced Kusto Query Language (KQL) editor and preview of the results for a set time range.

    > [!NOTE]
    > This opens the advanced KQL editor in the Azure portal.

1. Change the KQL query as needed and select **Run** to get an updated preview of the search results.

   :::image type="content" source="../media/search-job-advanced-kql-edit.png" alt-text="Screenshot of KQL editor with revised search.":::

1. When you're satisfied with the query and the search results preview, select the ellipses **...** and toggle  **Search job mode** on.

   :::image type="content" source="../media/search-job-advanced-kql-ellipsis.png" alt-text="Screenshot of KQL editor with revised search with ellipsis highlighted for Search job mode." lightbox="../media/search-job-advanced-kql-ellipsis.png":::

1. Specify the search job date range using the **Time range** selector. If your query also specifies a time range, Microsoft Sentinel runs the search job on the union of the time ranges.

1. When you're ready to start the search job, select **Search job**.

1. Enter a new table name to store the search job results.

1. Select **Run a search job**.

1. Wait for the notification **Search job is done** to view the results.

## View search job results

View the status and results of your search job by going to the **Saved Searches** tab.

### [Defender portal](#tab/defender-portal)

1. In Microsoft Sentinel in the Defender portal, select **Data lake exploration** > **Search & restore**> **Saved Searches**.

1. On the search card, select **View search results**.

   :::image type="content" source="../media/view-search-results.png" alt-text="Screenshot that shows the link to view search results at the bottom of the search job card." lightbox="../media/view-search-results.png":::

1. This takes you to the Advanced Hunting page with the KQL query prepopulated.

   :::image type="content" source="../media/search-results-hunting-page.png" alt-text="Screenshot that shows search results displayed in the Advanced Hunting page." lightbox="../media/search-results-hunting-page.png":::

1. Select **Run query** to see all the results that match your original search criteria.

1. To refine the list of results returned from the search table, select **Add filter**.

### [Azure portal](#tab/azure-portal)

1. In Microsoft Sentinel, select **Search** > **Saved Searches**.

1. On the search card, select **View search results**.

   :::image type="content" source="../media/view-search-results-azure.png" alt-text="Screenshot that shows the link to view search results at the bottom of the search job card." lightbox="../media/view-search-results-azure.png":::

   By default, you see all the results that match your original search criteria.

1. To refine the list of results returned from the search table, select **Add filter**.

1. As you're reviewing your search job results, select **Add bookmark**, or select the bookmark icon to preserve a row. Adding a bookmark allows you to tag events, add notes, and attach these events to an incident for later reference.

   :::image type="content" source="../media/search-results-add-bookmark.png" alt-text="Screenshot that shows search job results with a bookmark in the process of being added." lightbox="../media/search-results-add-bookmark.png":::

1. Select the **Columns** button and select the checkbox next to columns you'd like to add to the results view.

1. Add the **Bookmarked** filter to only show preserved entries.
1. Select **View all bookmarks** to go the **Hunting** page where you can add a bookmark to an existing incident.

---
