After filtering content in a review set, it's common to run multiple keyword searches or KeyQL queries to isolate relevant items. But reviewing the results one by one doesn't give you the full picture. That's where the Query Report comes in.

The **Query Report (preview)** helps legal and compliance teams compare the results of multiple saved queries in one place. You can see which queries return the most items, how large those items are, and how many different locations they come from. This helps prioritize review and supports early case assessment.

## Generate a query report

To create a query report:

1. Open your case and go to the **Review sets** tab.

1. Select the review set you want to analyze, then select **Open review set**.

1. From the command bar, select **Actions** > **Query Report (preview)**.

1. In the search box, enter your queries, one per line.

   You can use simple keywords or full KeyQL expressions. For example:

    `confidential`<br>
    `confidential AND Project Infinity`<br>
    `(((FileClass="Email") AND (InclusiveType=2 OR InclusiveType=1)) OR ((FileClass="Attachment") AND (UniqueInEmailSet="true")) OR ((FileClass="Document") AND (MarkAsRepresentative="Unique")) OR (FileClass="Conversations"))`

1. Select **Generate report**.

Each line of the report shows:

- **Query**: The keyword or KeyQL expression used
- **Locations with hits**: How many data sources contained matches
- **Count**: Number of items returned
- **Percentage**: Portion of the review set those items represent
- **Size**: Total size of the matching items

## View and download results

Double-click a query line to open the filtered results. You can review individual items, view metadata, and see the plain text content. While you can't annotate or export from this view, it helps you understand what matched and why.

To save the summary, select **Download report**. The report is saved as a .csv file with one row per query. This file can be shared with stakeholders or included in case documentation.

:::image type="content" source="../media/query-report.png" alt-text="Screenshot showing a query report run with the option to download the report." lightbox="../media/query-report.png":::

> [!NOTE]
> Queries aren't saved when you exit the Query Report. If you plan to reuse the queries, save them in a separate document for reference.
