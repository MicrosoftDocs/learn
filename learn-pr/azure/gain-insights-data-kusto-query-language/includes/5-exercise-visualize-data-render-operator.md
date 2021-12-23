A Kusto query can be used to explore datasets and gain insights. We have used a meteorological dataset to aggregate and compare the number of certain kinds of storm events in different US states for the year 2007. Here, you'll visualize these results with the aid of time-binned graphs. 

## Use the `render` operator

Recall that you have used the `summarize` operator to group events by a common field such as *State*. In the last query of the previous unit, you used different versions of the `count` operator to compare the number and types of events by state. Visualizing these results can be a helpful aid in comparing activity across states. 

To visualize results, you'll use the `render` operator. This operator comes at the end of a query. Within the `render` operator, you'll specify which type of visualization to use, such as `columnchart`, `piechart`, `scatterchart`, `pivotchart`, and others. You can also optionally define different properties of the visualization, such as the x-axis or y-axis.

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
 
    :::image type="content" source="../media/5-column-chart.png" alt-text="Screenshot of query with column chart results. There is a red box around the legend." lightbox="../media/5-column-chart.png":::

1. Notice the legend to the right of the column chart. Each value in the legend represents a different column of data that has been summarized by *State* in the query. Try selecting one of the values, such as *count_*, to toggle the display of this column in the visualization. You should get a graph that looks like the following image:

    :::image type="content" source="../media/5-column-chart-toggle.png" alt-text="Screenshot of column chart results with count_ field toggled off." lightbox="../media/5-column-chart-toggle.png":::

## Group values using the `bin` operator

Recall that you've used aggregate functions to group events by *State*. Now you'll look at the distribution of storms throughout the year, by grouping data by time. However, it wouldn't be very meaningful to plot the number of storms against a scattered start time value. Instead, let's group the events by week, so we can see how many storms happened each week during the year 2007.

You'll use the `bin` operator, which groups values into certain bin sizes. The syntax of this operator is:

> `bin(`*value*`,`*roundTo*`)`

The *value* you want to group is be the *StartTime* of the event, with the *roundTo* bin size of *7d*. You'll aggregate the count using the above bin to give you a counts of events per week. Finally, you'll *render* the data as a *columnchart* to create a histogram.

1. Run the following query:

    <a href="https://dataexplorer.azure.com/clusters/help/databases/Samples?query=H4sIAAAAAAAAAwsuyS/KdS1LzSsp5qpRKC7NzU0syqxKVUjOL80r0dBUSKpUSMrM0wguSSwqCcnMTdVRME/RBKosSs1LSS0CKsspzc1LzgDKAgAcJKS1SgAAAA==" target="_blank"> Click to run query</a>
    
    ```kusto
    StormEvents
    | summarize count() by bin(StartTime, 7d)
    | render columnchart
    ```
    
    You should get results that look like the following image:
    
    :::image type="content" source="../media/5-bin-1.png" alt-text="Screenshot of binned results graph.":::

1. Take a look at the resulting histogram. Hover over one of the bars to see the bin start time (x-value) and event count (y-value).

## Use the `sum` operator

In the previous query, you looked at the number of storm events over time. Now let's take a look at the damage caused by these storms. For this, you'll use the `sum` aggregate, because you want to see the total amount of damage caused in each time interval. The dataset you're working with has two columns related to damage: *DamageProperty* and *DamageCrops*. In the following query, you'll first create a calculated column that adds these two damage sources together. Then you'll create an aggregate of total damage binned by week. Finally, you'll render a column chart representing the weekly damage caused by all storms.

1. Run the following query:

    <a href="https://dataexplorer.azure.com/clusters/help/databases/Samples?query=H4sIAAAAAAAAAy2MwQ5EQBBE7/sVdSTcnZysu4QfGKZjJ9Ez0pog+/E72Fvl1atqNQjXG3ldXl/QruQtrGEzEkq879BImEn0QPYHVQSXvqzMRtxJV0qeVYr+QO980qoR7RxTjsKm0ZZ4TYIhTCv74RPbH8PaQ9t9AAAA" target="_blank"> Click to run query</a>
    
    ```kusto
    StormEvents
    | extend damage = DamageProperty + DamageCrops
    | summarize sum(damage) by bin(StartTime, 7d) 
    | render columnchart 
    ```

    You should get results that look like the following image:
    
    :::image type="content" source="../media/5-bin-2.png" alt-text="Screenshot of damage column chart binned by week.":::

1. Take a look at the results. These damage values represent storms in all states. How could you write a query that would represent only select states?  