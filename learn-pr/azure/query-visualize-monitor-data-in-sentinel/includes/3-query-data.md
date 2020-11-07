### Write and run basic queries

The following query retrieves all records from the  **Event**  table:

```kusto

Event
```

You can use the pipe (|) character to separate commands. Then the output of the first command is the input of the next command. You can add any number of commands to a single query. The following query retrieves the records from the  **Event**  table, and then searches them for the term  **error**  in any property:

```kusto

Event

| search error;
```

By default, Log Analytics limits queries to a time range of the past 24 hours. To set a different time range, you can add an explicit  **TimeGenerated**  filter to the query, or use the  **Time range**  control.

If you want to try some of the examples you can use [this demo environment](https://ms.portal.azure.com/#blade/Microsoft_Azure_Monitoring_Logs/DemoLogsBlade),.
