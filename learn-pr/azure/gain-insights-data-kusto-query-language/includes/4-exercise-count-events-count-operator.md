A Kusto query can be used to explore datasets and gain insights. Recall that we have a meteorological dataset and want to compare events to gain insights from this data. Here, we'll see how many of a certain kind of events occurred in a particular area. 

## Use the `count` operator

[Click to run query](https://dataexplorer.azure.com/clusters/help/databases/Samples?query=H4sIAAAAAAAAAy1NSw5AMBDdO8UsSSxcgA1OQGIpxaCLGmmHhDg87Xi792+YrKlP3NhFD7jDGGX1jTDSsXGcpBF8EL/TvFbKqAVbKi3tDnKJ6TkWXdQCsr83yUqot9eOCQwXNKwY/RdZ9jxk+hdcHcMviAAAAA==)

```kusto
StormEvents
| summarize count(),
    EventsWithDamageToCrops = countif(DamageCrops > 0),
    dcount(EventType) by State
| sort by count_
```

You should get results that look like the following image:

:::image type="content" source="../media/4-count.png" alt-text="Screenshot of Kusto query that counts events by state.":::

Whoa that’s a lot of different kinds of storms. Let’s look at them individually.


## Use the `distinct` operator

[Click to run query](https://dataexplorer.azure.com/clusters/help/databases/Samples?query=H4sIAAAAAAAAAwsuyS/KdS1LzSsp5qpRSMksLsnMSy5RAIuEVBakAgWL84tKFJIqEWIKicXJAGL0i684AAAA)

```kusto
StormEvents
| distinct EventType
| sort by EventType asc
```

You should get results that look like the following image:

:::image type="content" source="../media/4-distinct.png" alt-text="Screenshot of Kusto query using the distinct operator.":::