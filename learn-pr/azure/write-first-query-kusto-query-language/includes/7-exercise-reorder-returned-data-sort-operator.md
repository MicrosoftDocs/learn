Recall that in the storm events example, you've narrowed down events by time range, keywords, and values in a particular column. Now you want to organize these results to see the most damaging storm events first.

## Use the `sort` operator

It's difficult to make sense of unordered data. Let's make it a bit easier to understand by organizing the order in which the results are presented. You want to know which events caused the highest damage to property, so you'll order the results by the field `DamageProperty`.

1. Run the following query:

    <a href="https://dataexplorer.azure.com/clusters/help/databases/Samples?query=H4sIAAAAAAAAAwsuyS/KdS1LzSsp5qpRKM9ILUpVcEnMTUxPDSjKL0gtKqlUsFMwAEoVFOVnpSaXKASXJJak6iiAtYRUFgCZqMqBSovzi0oUkirRzUlJLU4GAC8Pmw5vAAAA" target="_blank">Run the query</a>

    ```kusto
    StormEvents
    | where DamageProperty > 0
    | project State, EventType, DamageProperty
    | sort by DamageProperty desc
    ```

1. You should get results that look like the following image:

    :::image type="content" source="../media/6-sort-1.png" alt-text="Screenshot of query results for the sort operator.":::

1. Notice that the results start from the highest property-damage value and decrease. In fact, the query sorts in descending order by default, so you can leave out the `desc` and get the same results. The state and event types aren't ordered in any way.

## Sort on more than one expression

Each region has unique weather patterns, so now you want to know which events in each state made the most damage. To answer this question, you'll sort first on the state name and then on the damage within each state. The `sort` operator sorts in descending order by default, so you'll use `asc` to indicate that you want to sort the state names in ascending order.

1. Run the following query:

    <a href="https://dataexplorer.azure.com/clusters/help/databases/Samples?query=H4sIAAAAAAAAAwsuyS/KdS1LzSsp5qpRKM9ILUpVcEnMTUxPDSjKL0gtKqlUsFMwAEoVFOVnpSaXKASXJJak6iiAtYRUFgCZqMqBSovzi0oUkiohShUSi5PR1QAA36YINHUAAAA=" target="_blank">Run the query</a>

    ```kusto
    StormEvents
    | where DamageProperty > 0
    | project State, EventType, DamageProperty
    | sort by State asc, DamageProperty
    ```

1. You should get results that look like the following image:

    :::image type="content" source="../media/6-sort-2.png" alt-text="Screenshot of query results for two sort operators.":::

1. Notice that now you've gotten a table with the same rows as the previous query, but sorted in a different order. Here, we first sort by the state name, starting with Alabama. Within results from the state of Alabama, the property-damage values are sorted in descending order.

## Use the `top` operator

Instead of sorting and scanning the top for a certain number of results, you can use the `top` operator to show a specific number of top results. In fact, the `top` operator is more performant, so it's the preferred choice when you just want a certain number of top results.

1. Run the following query:

    <a href="https://dataexplorer.azure.com/clusters/help/databases/Samples?query=H4sIAAAAAAAAAwsuyS/KdS1LzSsp5qpRKM9ILUpVCC5JLElVsLVVUHLz8Q/ydHFUAkqV5BcoGBooJFUquCTmJqanBhTlF6QWlVQCpQqK8rNSk0sg+nQUwKaFVBYAmahKAYKJ63RsAAAA" target="_blank">Run the query</a>

    ```kusto
    StormEvents
    | where State == "FLORIDA"
    | top 10 by DamageProperty
    | project State, EventType, DamageProperty
    ```

1. You should get results that look like the following image:

    :::image type="content" source="../media/6-sort-3.png" alt-text="Screenshot of query results for the top operator.":::
