A Kusto query can be used to explore datasets and gain insights. Recall that we have a meteorological dataset and want to compare events to gain insights from this data. Here, we'll see how many of a certain kind of events occurred in a particular area. 

## Use the `count` operator

The sample database we're using has an entry for each storm event in the US in 2007, for a total of about 60 thousand records. That's a lot of individual storms, and it can be difficult to gain meaningful insights by looking at individual events.

To group these events, we'll use the `summarize` operator. Summarize is used for all functions that aggregate groups of values of multiple rows to form a single summary value. Within each `summarize` operator, you have to specify the type of aggregation to perform, and the way you want to group the aggregation. For example, if you want to count the events by state, you'll write a query to `summarize` `count` by `state`. In fact, this is pretty much what the query looks like. The aggregation function you'll use is called `count()`, which does exactly what it says and counts the number of rows by group. This function generates a new column that gives the count of events grouped by state, which we have renamed within the query to *EventCount*. 

1. Copy and paste the query into your query editor. 


    [Click to run query](https://dataexplorer.azure.com/clusters/help/databases/Samples?query=H4sIAAAAAAAAAwsuyS/KdS1LzSsp5qpRKC7NzU0syqxKVQALOeeX5pXYJoNIDU2FpEqF4JLEklSQuvyiEhAfoQoAiCAatkgAAAA=)

    ```kusto
    StormEvents
    | summarize EventCount=count() by State
    | sort by EventCount
    ```
1. Run the query by either selecting the **Run** button above the query window or by pressing **Shift+Enter**
    
    You should get results that look like the following image:
    
    :::image type="content" source="../media/4-count-1.png" alt-text="Screenshot of count operator usage and results.":::
    

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