A Kusto query can be used to explore datasets and gain insights. We have used a meteorological dataset to compare the number of certain kinds of storm events in different US states for the year 2007, and visualized the results. Here, you'll explore additional aggregate functions to describe the data.

## Characterize storm types using the `avg()` operator

In the last unit, you looked at the number of storms as a function of time and the damage caused by these storms. This doesn't tell us anything about the individual storms. Let's look at other statistics that can help characterize the storms.

First, you'll use the `avg()` operator to calculate the average damage caused by storms.

The following query creates a calculated column using the `extend` operator to add all values of damage, in this case *DamageProperty* and *DamageCrops*. The query then filters for events which caused damage greater than zero. Next, the query summarizes the average damage created by each type of storm. Finally, the results are sorted by the new average damage column.

1. Run the following query: 

    <a href="https://dataexplorer.azure.com/clusters/help/databases/Samples?query=H4sIAAAAAAAAAwsuyS/KdS1LzSsp5qpRSK0oSc1LUUhJzE1MT1WwVXABMwKK8gtSi0oqFbShAs5AAZDy8ozUolSYajsFA6BQcWlubmJRZlWqQmJZugZESlMhqVIBbEdIZUEqSFF+UQlIDKgkHqIEALtwQu2HAAAA" target="_blank"> Click to run query</a>
    
    ```kusto
    StormEvents
    | extend damage = DamageProperty + DamageCrops
    | where damage > 0
    | summarize avg(damage) by EventType
    | sort by avg_damage
    ```

    You should get results that look like the following image:

    :::image type="content" source="../media/6-avg.png" alt-text="Screenshot of avg aggregate function results.":::

1. Take a look at the results. Do they meet your expectations? Of the types of events listed in the left column, what would you expect to cause the most damage on average?

## Find extremes using `min()` and `max()`

There are still more possible ways to describe the distribution of damage from each type of storm. Instead of looking at the average damage done by each type of storm, let's look at the extremes. There are 

<a href="https://dataexplorer.azure.com/clusters/help/databases/Samples?query=H4sIAAAAAAAAAwsuyS/KdS1LzSsp5qpRSK0oSc1LUUhJzE1MT1WwVXABMwKK8gtSi0oqFbShAs5AAZDy8ozUolSYajsFA6BQcWlubmJRZlWqQm5ihQZESlNHITczD8FJLEuHcRSSKhXAtodUFqSCtOcXlYDEgJrjIUoAF4POAqEAAAA=" target="_blank"> Click to run query</a>

```kusto
StormEvents
| extend damage = DamageProperty + DamageCrops
| where damage > 0
| summarize max(damage), min(damage), avg(damage) by EventType
| sort by max_damage
```

:::image type="content" source="../media/6-max.png" alt-text="Screenshot of max aggregate function results.":::

<a href="https://dataexplorer.azure.com/clusters/help/databases/Samples?query=H4sIAAAAAAAAAwsuyS/KdS1LzSsp5qpRSK0oSc1LUUhJzE1MT1WwVXABMwKK8gtSi0oqFbShAs5AAZDy8ozUolSYajsFA6BQcWlubmJRZlWqAlBLMtDYzJzUYg2IEh0FUx0FIwMgBcQWQGxpqqmQVKkAtj6ksiAVpD+/qARFTCGxOBkAk1m5yaUAAAA=" target="_blank"> Click to run query</a>

## Use the `percentiles()` operator

```kusto
StormEvents
| extend damage = DamageProperty + DamageCrops
| where damage > 0
| summarize percentiles(damage, 5, 20, 50, 80, 95) by EventType
| sort by EventType asc
```

:::image type="content" source="../media/6-percentiles.png" alt-text="Screenshot of percentiles aggregate function results.":::