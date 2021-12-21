A Kusto query can be used to explore datasets and gain insights. We have used a meteorological dataset to aggregate and compare the number of certain kinds of storm events in different US states for the year 2007. Here, you'll visualize these results with the aid of time-binned graphs. 

## Use the `render` operator

Recall that you have used the `summarize` operator to group events by a common field such as *State*. In the last query of the previous unit, you used different versions of the `count` operator to compare the number and types of events by state. Visualizing these results can be a helpful aid in comparing activity across states. 

To visualize results, you'll use the `render` operator. This operator comes at the end of a query. Within the `render` operator, specify which type of visualization to use, such as `columnchart`, `piechart`, `scatterchart`, `pivotchart`, and others. You can also optionally define different properties of the visualization, such as the x-axis, y-axis, or others.

In this example, you'll visualize the previous query using a column chart. 

1. Run the following query.

    <a href="https://dataexplorer.azure.com/clusters/help/databases/Samples?query=H4sIAAAAAAAAAwsuyS/KdS1LzSsp5qpRKC7NzU0syqxKVUjOL80r0dDU4VIAAoh8eGZJhktibmJ6aki+c1F+QbGCLURZZpoGRBwiaqdgANWXAjEFrD2ksiBVUyGpUiG4JLEkFWRXflEJiA9WEw8UKErNS0ktAvJzSnPzkjMSi0oAuLzqp50AAAA=" target="_blank"> Click to run query</a>
    
    ```kusto
    StormEvents
    | summarize count(),
        EventsWithDamageToCrops = countif(DamageCrops > 0),
        dcount(EventType) by State
    | sort by count_
    | render columnchart 
    ```

    You should get results that look like the following image:
 
    :::image type="content" source="../media/5-column-chart.png" alt-text="Screenshot of query with column chart results. There is a red box around the legend.":::

1. Notice the legend to the right of the column chart. Each value in the legend represents a different column of data that has been summarized by *State* in the query. Try selecting one of the values, such as *count_*, to toggle the display of this column in the visualization. You should get a graph that looks like the following image:

    :::image type="content" source="../media/5-column-chart-toggle.png" alt-text="Screenshot of column chart results with count_ field toggled off.":::

## Group values using the `bin` operator

When during the year were these storms? Group by week from start time represent visually.

Explain: bin
render
columnchart

<a href="https://dataexplorer.azure.com/clusters/help/databases/Samples?query=H4sIAAAAAAAAAwsuyS/KdS1LzSsp5qpRKC7NzU0syqxKVUjOL80r0dBUSKpUSMrM0wguSSwqCcnMTdVRME/RBKosSs1LSS0CKsspzc1LzgDKAgAcJKS1SgAAAA==" target="_blank"> Click to run query</a>

```kusto
StormEvents
| summarize count() by bin(StartTime, 7d)
| render columnchart
```

:::image type="content" source="../media/5-bin-1.png" alt-text="Screenshot of binned results graph.":::

That’s the number of storms per week, what about the damage they did?

<a href="https://dataexplorer.azure.com/clusters/help/databases/Samples?query=H4sIAAAAAAAAAy2MwQ5EQBBE7/sVdSTcnZysu4QfGKZjJ9Ez0pog+/E72Fvl1atqNQjXG3ldXl/QruQtrGEzEkq879BImEn0QPYHVQSXvqzMRtxJV0qeVYr+QO980qoR7RxTjsKm0ZZ4TYIhTCv74RPbH8PaQ9t9AAAA/?azure-portal=true" target="_blank"> Click to run query</a>

```kusto
StormEvents
| extend damage = DamageProperty + DamageCrops
| summarize sum(damage) by bin(StartTime, 7d)
| render columnchart 
```

:::image type="content" source="../media/5-bin-2.png" alt-text="Screenshot of damage column chart binned by week.":::
