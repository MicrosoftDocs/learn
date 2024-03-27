Recall that you've filtered certain columns in or out of the displayed results. In this unit, you'll learn how to answer questions about what kinds of meteorological events took place in different regions or timespans, and which types of events caused damage.

## Use the `where` operator

Up to this point, all the operators you've used have returned selected columns. Now, let's take a look at specific rows of the data.

The `where` operator filters results that satisfy a certain condition. In this first example, you'll compare an integer column to a minimum value by using the numerical operator *greater than* (`>`). Specifically, you only want to see storms that damaged property, so you'll look at rows of data where the damage to property is greater than zero.

1. Run the following query:

    <a href="https://dataexplorer.azure.com/clusters/help/databases/Samples?query=H4sIAAAAAAAAAwsuyS/KdS1LzSsp5qpRKM9ILUpVcEnMTUxPDSjKL0gtKqlUsFMwAEoVFOVnpSaXKASXJJak6iiAtYRUFgCZqMqBSksSs1MVDA0AnGdDg1sAAAA=" target="_blank">Run the query</a>

    ```kusto
    StormEvents
    | where DamageProperty > 0
    | project State, EventType, DamageProperty
    | take 10
    ```

1. You should get results that look like the following image:

    :::image type="content" source="../media/5-where-1.png" alt-text="Screenshot of query results of a where operator with a numerical operator of greater than zero.":::

1. Notice that all rows returned do, in fact, have **DamageProperty** values greater than zero.

1. Similarly, you can filter where the time of an event occurred more than a certain number of days ago. For example, run the following query, where `365d` means 365 days:

    <a href="https://dataexplorer.azure.com/clusters/help/databases/Samples?query=H4sIAAAAAAAAAwsuyS/KdS1LzSsp5qpRKM9ILUpVcEnMTUxPDSjKL0gtKqlUsFMwgEsFlyQWlYRk5qYCRRPT8zWMzUxTNIGyBUX5WanJJSD5klQdBbCBIZUFQCaqYQC5Vx5sbwAAAA==" target="_blank">Run the query</a>

    ```kusto
    StormEvents
    | where DamageProperty > 0
    | where StartTime > ago(365d)
    | project State, EventType, DamageProperty
    ```

1. Notice that this query returns no results. Because the data is from 2007, there are no records from the past year.

## Filter by using a string value

It looks like quite a few types of storms have caused damage all over the US. Let's narrow that down to storms that happened in a certain location, like the state of Florida.

1. Run the following query, which uses a second `where` operator with the string value `"FLORIDA"`:

    <a href="https://dataexplorer.azure.com/clusters/help/databases/Samples?query=H4sIAAAAAAAAAwsuyS/KdS1LzSsp5qpRKM9ILUpVcEnMTUxPdS7KLyhWsFMwgIsHlySWpCrY2iooufn4B3m6OCoBpQqK8rNSk0sgkjoKYKNCKguATCRjAF6MrQhmAAAA" target="_blank">Run the query</a>

    ```kusto
    StormEvents
    | where DamageCrops > 0
    | where State == "FLORIDA"
    | project State, EventType, DamageCrops
    ```

1. You should get results that look like the following image:

    :::image type="content" source="../media/5-where-2.png" alt-text="Screenshot of query results for two where operators.":::

1. Notice that all records returned from this query are from Florida and have crop damage greater than zero.

## Filter by using the `has` operator

One of the event types in the last query's results is called **Thunderstorm Wind**. Let's see if there are any other kinds of wind that caused property damage in Florida. We'll search on a string match of `wind` by using the `has` operator. The `has` operator is a case-insensitive search that matches on a full [term](/azure/data-explorer/kusto/query/datatypes-string-operators#what-is-a-term).

1. Run the following query:

    <a href="https://dataexplorer.azure.com/clusters/help/databases/Samples?query=H4sIAAAAAAAAAwsuyS/KdS1LzSsp5qpRKM9ILUpVcEnMTUxPDSjKL0gtKqlUsFMwgEsFlySWpCrY2iooufn4B3m6OCrBpcCGhFQWpCpkJBYrKJVn5qWAJAuK8rNSk0tAOotKQjJzU3UQKnXQrAIAa+mmro0AAAA=" target="_blank">Run the query</a>

    ```kusto
    StormEvents
    | where DamageProperty > 0
    | where State == "FLORIDA"
    | where EventType has "wind"
    | project StartTime, EventType, DamageProperty
    ```

1. You should get results that look like the following image:

    :::image type="content" source="../media/5-where-has.png" alt-text="Screenshot of query results for where and has operators.":::

1. Notice in the results that events such as tornadoes no longer appear, but **Thunderstorm Wind** and **Strong Wind** event types do appear.

The `contains` operator is similar to `has`, but it matches on any substring. For example, the following query will return results such as *Freezing fog* and *Frost/Freeze*.

```kusto
StormEvents | where EventType contains "free"
```

The `has` operator is more performant than the `contains` operator, so you should use `has` wherever you have a choice between the two.

## Filter on `datetime` values

Let's look more closely at the damage done in the first half of the calendar year. It can be useful to limit your search to events within a specific time range. Some interfaces with Kusto Query Language have a dropdown time picker, but others require you to incorporate the date filter into the query itself.

Because time ranges are bounded by two extremes, it's most efficient to construct a query where you choose a value that's between these two times.

The syntax for constructing this date range is as follows:

> `where` *time* `between` `(datetime(`*value*`)..datetime(`*value*`))`

1. Let's incorporate this `datetime` range into a kind of query you've already seen. Run the following query:

    <a href="https://dataexplorer.azure.com/clusters/help/databases/Samples?query=H4sIAAAAAAAAAwsuyS/KdS1LzSsp5qpRKM9ILUpVCC5JLCoJycxNVUhKLSlPTc1T0EhJLEktAYpoGBkYmOsaGAKRpp4emqgZSFQTboxLYm5iempAUX5BalFJpYKdggGyDSWpCra2CkpuPv5Bni6OSkCpgqL8rNTkEoT1Ogpgh4VUFgCZqKYBlZckZqcqmBoAABGBmQnBAAAA" target="_blank">Run the query</a>

    ```kusto
    StormEvents
    | where StartTime between (datetime(2007-01-01)..datetime(2007-06-01))
    | where DamageProperty > 0
    | where State == "FLORIDA"
    | project StartTime, EventType, DamageProperty
    | take 50
    ```

1. You should get results that look like the following image:

    :::image type="content" source="../media/5-where-3.png" alt-text="Screenshot of query results for where operators that include a time range.":::

1. Notice that all the dates are within the first half of the year, months one to six. You might also notice that even though you've selected events from the state of Florida, the state doesn't appear as an output column, because it wasn't specified in the `project` operator.
