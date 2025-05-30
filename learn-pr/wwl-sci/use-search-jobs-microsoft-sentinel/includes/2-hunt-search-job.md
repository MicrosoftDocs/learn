One of the primary activities of a security team is to search logs for specific events. For example, you might search logs for the activities of a specific user within a given time-frame.

In Microsoft Sentinel, you can search across long time periods in large datasets by using a search job. While you can run a search job on any type of log, search jobs are ideally suited to search archived logs. If you need to do a full investigation on archived data, you can restore that data into the hot cache to run high performing queries and analytics.

## Search large datasets
Use a search job when you start an investigation to find specific events in logs within a given time frame. You can search all your logs to find events that match your criteria and filter through the results.

Search in Microsoft Sentinel is built on top of search jobs. Search jobs are asynchronous queries that fetch records. The results are returned to a search table that's created in your Log Analytics workspace after you start the search job. The search job uses parallel processing to run the search across long time spans, in large datasets. So search jobs don't impact the workspace's performance or availability.

Search results remain in a search results table that has a ***_SRCH** suffix.

## Supported log types
Use search to find events in any of the following log types:

- Analytics logs
- Basic logs 

## Limitations of a search job
Before you start a search job, be aware of the following limitations:

- Optimized to query one table at a time.
- Search date range is up to one year.
- Supports long running searches up to a 24-hour time-out.
- Results are limited to one million records in the record set.
- Concurrent execution is limited to five search jobs per workspace.
- Limited to 100 search results tables per workspace.
- Limited to 100 search job executions per day per workspace.



## Start a search job
Go to Search in Microsoft Sentinel to enter your search criteria.

1. In the Azure portal, go to Microsoft Sentinel and select the appropriate workspace.

1. Under General, select Search.

1. In the Search box, enter the search term.

1. Select the appropriate Time range.

1. Select the Table that you want to search.

1. When you're ready to start the search job, select Search.

    When the search job starts, a notification and the job status show on the search page.

1. Wait for your search job to complete. Depending on your dataset and search criteria, the search job may take a few minutes or up to 24 hours to complete. If your search job takes longer than 24 hours, it times out. If that happens, refine your search criteria and try again.

## View search job results

View the status and results of your search job by going to the Saved Searches tab.

1. In your Microsoft Sentinel workspace, select Search > Saved Searches.
1. On the search card, select View search results.
1. By default, you see all the results that match your original search criteria.
    In the search query, notice the time columns referenced.
    - TimeGenerated is the date and time the data was ingested into the search table.
    - _OriginalTimeGenerated is the date and time the record was created.
1. To refine the list of results returned from the search table, edit the KQL query.

1. As you're reviewing your search job results, bookmark rows that contain information you find interesting so you can attach them to an incident or refer to them later.



