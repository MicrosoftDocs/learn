The search operator provides a multi-table/multi-column search experience. Although the search operator is easy to use, when  compared to the where operator it's inefficient.  Even with this inefficiency, you can use search to find data when unsure which table or column to filter.

The first statement will search for "err" across all tables. The second statement will search for "err" in tables SecurityEvent, SecurityAlert, and tables starting with A. 

Try each of these queries separately to see the results. 


> [!TIP]
> For the first search query, you may need to adjust the Time range to "Last hour" in the query window to avoid an error.  


```kusto
search "err"

search in (SecurityEvent,SecurityAlert,A*) "err"

```

