A Kusto query can be used to explore datasets and gain insights. Recall that we have a meteorological dataset and want to compare events to gain insights from this data. Here, we'll see how many of a certain kind of events occurred in a particular area. 

## Use the `count` operator

The sample database we're using has an entry for each storm event in the US in 2007, for a total of about 60 thousand records. That's a lot of individual storms, and it can be difficult to gain meaningful insights by looking at individual events.

To group these events, we'll use the `summarize` operator. Summarize is used for all functions that aggregate groups of values of multiple rows to form a single summary value. Within each `summarize` operator, you have to specify the type of aggregation to perform, and the way you want to group the aggregation. For example, to count events by state, you'll write a query to `summarize` `count` by `state`. In fact, the previous sentence is very similar to the actual query. The aggregation function you'll use is called `count()`, which counts the number of rows by group. This function generates a new column that gives the count of events grouped by state, which we have renamed within the query to *EventCount*.

1. Copy and paste the query into your query editor. 

    [Click to run query](https://dataexplorer.azure.com/clusters/help/databases/Samples?query=H4sIAAAAAAAAAwsuyS/KdS1LzSsp5qpRKC7NzU0syqxKVQALOeeX5pXYJoNIDU2FpEqF4JLEklSQuvyiEhAfoQoAiCAatkgAAAA=)

    ```kusto
    StormEvents
    | summarize EventCount=count() by State
    | sort by EventCount
    ```
1. Run the query by either selecting the **Run** button above the query window or by pressing **Shift+Enter**.
    
    You should get results that look like the following image:
    
    :::image type="content" source="../media/4-count-1.png" alt-text="Screenshot of count operator usage and results.":::
    

## Use the `dcount` and `countif` operators

The above query returned the number of events per state. There are, however, more sophisticate ways to count events. For example, we could count only certain types of events. The `countif()` operator counts records for which a predicate is true. You can use it to count the number of events that cause damage to crops.

You may want to count distinct types of events by using the `dcount()` operator. This operator gives an estimation of the cardinality of the specified set. 

The following query incorporates both operator types within the `summarize` operator. Notice that all elements within the summarize operator are separated by commas, and must be grouped by the same column, in this case *State*.

1. Run the following query:

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

1. Notice the column names in the results. Which part of the query corresponds to each column? How many different kinds of storms occurred in Texas?

## Use the `distinct` operator

The above query returned a distinct count of 27 different types of storms in Texas during the time period covered by this data. That's quite a few different kinds of storms. To see a list of each different type of event, use the `distinct` operator to list the distinct values of a particular column.

1. Run the following query: 

    [Click to run query](https://dataexplorer.azure.com/clusters/help/databases/Samples?query=H4sIAAAAAAAAAwsuyS/KdS1LzSsp5qpRSMksLsnMSy5RAIuEVBakAgWL84tKFJIqEWIKicXJAGL0i684AAAA)
    
    ```kusto
    StormEvents
    | distinct EventType
    | sort by EventType asc
    ```
    
    You should get results that look like the following image:
    
    :::image type="content" source="../media/4-distinct.png" alt-text="Screenshot of Kusto query using the distinct operator.":::

1. Take a look at the resulting list. How many types of storms are related to some kind of wind? Can you construct a query that could answer this question?