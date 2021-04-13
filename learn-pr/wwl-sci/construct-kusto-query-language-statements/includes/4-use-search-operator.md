The search operator provides a multi-table/multi-column search experience.  Although this statement is easy to use, it is inefficient compared to the where operator.  Even with this, use search to find data when unsure which table or column to filter.

The first statement will search for "err" across all tables. The second statement will search for "err" in tables SecurityEvent, SecurityAlert, and tables starting with A.

```kusto
search "err"

search in (SecurityEvent,SecurityAlert,A*) "err"

```

