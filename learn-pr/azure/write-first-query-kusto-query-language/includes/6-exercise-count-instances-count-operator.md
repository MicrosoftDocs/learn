Kusto queries can be used to filter data and return specific information.
Recall that in the storm events example, we've been able to narrow down events by time range, keywords, and values in a particular column. Here, you'll learn how to count the number of events that satisfy a certain set of conditions.

## Use the count operator

```kusto
StormEvents
| count 
```

:::image type="content" source="../media/6-count-1.png" alt-text="Screenshot of count operator.":::