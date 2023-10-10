After an organization runs a Content search or a search associated with a Microsoft Purview eDiscovery (Standard) case, it can preview a sample of the results returned by the search. Previewing items returned by the search query can help an organization determine if the search is returning the results it hoped for. If not, the organization can change the search query and rerun the search.

To preview a sample of results returned by a search:

1.  In the **Microsoft Purview compliance** portal, on the navigation pane:
     -  Select **Content search**, and then on the **Content search** page, select a search that you want to review.
        
        OR
     -  Select **eDiscovery**, select **Standard**, select a case on the **eDiscovery (Standard)** page, and then on the **Searches** tab, select a search associated with the case that you want to review.
1.  On the detail pane that appears for the selected search, the **Summary** tab is displayed by default. Review the summary information that pertains to the search.
1.  At the bottom of the **Summary** tab, select the **Review sample** button.
    
    :::image type="content" source="../media/preview-search-results-1-def5b00c.png" alt-text="Screenshot of the detail pane for a search that shows the review sample button highlighted.":::
    
1.  A page is displayed containing a sample of the search results. In the list of search results, select an item to view its contents in the reading pane.
    
    :::image type="content" source="../media/preview-search-results-2-fb06bc8f.png" alt-text="Screenshot showing a sample of the search results, with an item selected and displaying its contents in the detail pane." lightbox="../media/preview-search-results-2-fb06bc8f.png":::
    
    
    > [!NOTE]
    > In the previous screenshot, notice that keywords from the search query are highlighted when you preview items.

### How the search result samples are selected

A maximum of 1,000 randomly selected items are available to preview. In addition to being randomly selected, the items available for preview must also meet the following criteria:

 -  A maximum of 100 items from a single content location (a mailbox or a site) can be previewed. As a result, it's possible that less than 1,000 items may be available for preview. For example, if you search four mailboxes and the search returns 1,500 estimated items, only 400 will be available for preview. Why? Because only 100 items from each mailbox can be previewed.
 -  For mailbox items, only email messages are available to preview. Items like tasks, calendar items, and contacts can't be previewed.
 -  For site items, only documents are available to preview. Items like folders, lists, or list attachments can't be previewed.

### File types supported when previewing search results

You can preview supported file types in the preview pane. If a file type isn't supported, you must download a copy of the file to your local computer (by selecting **Download original item**). For .aspx Web pages, the URL for the page is included, although you may not have permissions to access the page. Unindexed items aren't available for previewing.

The following file types are supported and can be previewed in the search results pane.

 -  .txt, .html, .mhtml
 -  .eml
 -  .doc, .docx, .docm
 -  .pptm, .pptx
 -  .pdf

Also, the following file container types are supported. You can view the list of files in the container in the preview pane.

 -  .zip
 -  .gzip

### View statistics for eDiscovery search results

After an organization creates and runs either a Content search or a search associated with a Microsoft Purview eDiscovery (Standard) case, it can view statistics about the estimated search results. These statistics include:

 -  **A summary of the search results**. This summary is similar to the summary of the estimated search results displayed on the search detail page.
 -  **The query statistics**. For example:
     -  The number of content locations with items that match the search query.
     -  The identity of content locations that have the most matching items.

Additionally, an organization can use the keywords list to configure a search to return statistics for each keyword. By doing so, an organization can compare the number of results returned by each keyword in a query.

Search statistics can also be downloaded to a CSV file. Doing so enables an organization to use the filtering and sorting features in Excel to compare results and prepare reports for its search results.

To display statistics for a Content search or a search associated with a eDiscovery (Standard) case, you should complete the following steps:

1.  In the **Microsoft Purview compliance** portal, on the navigation pane:
     -  Select **Content search**, and then on the **Content search** page, select a search that you want to review.
        
        OR
     -  Select **eDiscovery** and then **Standard**, and then on the **eDiscovery (Standard)** page, select a case, and then on the **Searches** tab, select a search associated with the case that you want to review.
2.  On the detail pane that appears for the selected search, select the **Search statistics** tab.
    
    :::image type="content" source="../media/search-statistics-1-15d9219c.png" alt-text="Screenshot of an eDiscovery Standard case showing the Search statistics tab and the details of a selected search.":::
    

The **Search statistics** tab contains for following sections that contain different types of statistics about the search.

#### Search content

This section displays a graphical summary of the estimated items returned by the search. The summary indicates the number of items that match the search criteria. This information gives you an idea about the estimated number of items returned by the search.

:::image type="content" source="../media/search-content-report-82c80768.png" alt-text="Screenshot of an eDiscovery Standard case showing the Search statistics tab for a search, and the Search content option highlighted.":::


This report displays the following information:

 -  **Estimated items by locations**. The total number of estimated items returned by the search. The specific number of items located in mailboxes and located in sites is also displayed.
 -  **Estimated locations with hits**. The total number of content locations that contain items returned by the search. The specific number of mailbox and site locations is also displayed.
 -  **Data volume by location (in MB)**. The total size of all estimated items returned by the search. The specific size of mailbox items and site items is also displayed.

#### Condition report

This section displays statistics about:

 -  the search query.
 -  the number of estimated items that matched different parts of the search query.

An organization can use these statistics to analyze the number of items that match each component of the search query. This information can help an organization refine the search criteria. It can also help to narrow the scope of the scope. An option also appears that enables the organization to download a copy of the report in CSV format.

:::image type="content" source="../media/search-content-report-no-keyword-list-ea2e9ad1.png" alt-text="Screenshot of an eDiscovery Standard case showing the Search statistics tab for a search, and the Condition report option highlighted.":::


This report displays the following information:

 -  **Location type**. The type of content location the query statistics are applicable to. A value of:
     -  **Exchange** indicates a mailbox location.
     -  **SharePoint** indicates a site location.
 -  **Part**. The part of the search query the statistics are applicable to. A value of:
     -  **Primary** indicates the entire search query.
     -  **Keyword** indicates the statistics in the row are for a specific keyword.

    If you use a keyword list for search query, statistics for each component of the query are included in this table. For more information, see [Get keyword statistics for searches](/microsoft-365/compliance/view-keyword-statistics-for-content-search?azure-portal=true).

 -  **Condition**. The actual component (keyword or condition) of the search query. This condition returned the statistics displayed in the corresponding row.
 -  **Locations with hits**. The number of the content locations (specified by the **Location type** column) that contain items that match the primary or keyword query listed in the **Condition** column.
 -  **Items**. The number of items (from the specified content location) that match the query listed in the **Condition** column. As previously explained, if an item contains multiple instances of a keyword that's being searched for, it's only counted once in this column.
 -  **Size (MB)**. The total size of all items that were found (in the specified content location) that match the search query in the **Condition** column.

#### Top locations

This section displays statistics about the specific content locations with the most items returned by the search. The top 1,000 locations are displayed. You can also download a copy of this report in CSV format.

 -  The name of the location name (the email address of mailboxes and the URL for sites).
 -  Location type (a mailbox or site).
 -  Estimated number of items in the content location returned by the search.
 -  The total size of estimated items in each content location.

### Get keyword statistics for searches

As previous explained, the **Condition** report section shows the search query and the number (and size) of items that match the query. If an organization uses a keyword list when it creates or edits a search query, it can get enhanced statistics that show how many items match each keyword or keyword phrase. These statistics can help it quickly identify which parts of the query are the most (and least) effective. For example, if a keyword returns a large number of items, you might choose to refine the keyword query to narrow the search results.

To create a keyword list and view keyword statistics for a search:

1.  In the **Microsoft Purview compliance** portal, create a new **Content search** or a search associated with an **eDiscovery (Standard) case**.
2.  On the **Conditions** page of the search wizard, select the **Show keyword list** checkbox.
3.  Type a keyword or keyword phase in a row in the **Keywords** table. For example, type **budget** in the first row, type **security** in the second row, and type **FY2021** in the third row. This example is displayed in the following screenshot.
    
    :::image type="content" source="../media/search-keywords-list-2-858e4dec.png" alt-text="Screenshot of the Define your search conditions window showing a list of keywords and keyword phrases that were entered by a user.":::
    
    
    > [!NOTE]
    > To help reduce issues caused by large keyword lists, you're limited to a maximum of 20 rows in the keyword list of a search query.
4.  At this point, you've added the keywords to the list that you want to search and get statistics for. Run the search.
5.  When the search is completed, select it to display the detail page for the search.
6.  On the **Search statistics** tab, select the **Condition report** option to display the keyword statistics for the search.
    
    :::image type="content" source="../media/search-keywords-list-3-58cda97e.png" alt-text="Screenshot of a detail pane for a search showing the Search statistics tab and the Condition report.":::
    
    
    As shown in the previous screenshot, the statistics for each keyword are displayed. These statistics includes:
    
    
     -  The keyword statistics for each type of content location included in the search.
     -  The number of unindexed mailbox items.
     -  The actual search query and results for each keyword (identified as **Keyword** in the **Part** column), which includes any conditions from the search query.
     -  The complete search query (identified as **Primary** in the **Part** column) and the statistics for the complete query for each location type. These statistics are the same ones displayed on the **Summary** tab.

## Knowledge check

Choose the best response for the following question. Then select “Check your answers.”