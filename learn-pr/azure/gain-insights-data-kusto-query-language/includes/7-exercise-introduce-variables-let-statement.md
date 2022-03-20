We've used a meteorological dataset to aggregate and visualize data. Here, you'll learn how to use `let` statements to introduce variables and organize complex queries.

`let` statements are useful for breaking up a complex expression into multiple parts, defining constants outside of the query body for readability, or defining a variable once and using it multiple times within a query. `let` statements can be used to create well-organized complex queries. You can use multiple let statements; each statement must be followed by a semicolon (`;`).

`let` statements can be used in different kinds of situations. On the simplest level, you can define scalar values that will later be referenced in a query, such as an integer, string, datetime, or any other value. You can create a tabular filtered view of a table that will be used as the tabular input for the query. You can also create a function using a `let` statement.

## Define a scalar with a `let` statement

Recall that previous queries filtered on locations or minimum damage. Let's define these boundary values using a `let` statement at the beginning of the query.

The following query uses two `let` statements to define scalar values that will later be used as input parameters in the query. The first defined value is a number and the second is a string. The two `let` statements and the following tabular query statement are each separated by a semicolon.

Notice the commented-out portions of the query that begin with double forward slashes (`//`). These are comments that are ignored when running queries.

1. Run the following query:

    <a href="https://dataexplorer.azure.com/clusters/help/databases/Samples?query=H4sIAAAAAAAAA8tJLVHwzcxzScxNTE9VsFUwtFbQ11fIK81NSi3iygFKFuQkJoMklByDPKP8/RyVrBVAKopLijLz0rmCS/KLcl3LUvNKihW4ahTKM1KLUhWCSxJLgFpsoXrh4hBLnIvyC4q1IewAIDu1qKRSwc4W4Qqg+uLS3NzEoswqmB7bxLJ0DVQt2kimaSokVSqAXRFSWZAKAC4bJzfTAAAA" target="_blank"> Click to run query</a>

    ```kusto
    let MinDamage = 1; // number
    let place = "ARIZONA";  // string
    StormEvents
    | where State == place
    | where DamageCrops+DamageProperty >= MinDamage
    | summarize Damage=avg(DamageProperty+DamageCrops) by EventType
    ```

    You should get results that look like the following image:

    :::image type="content" source="../media/7-let-1.png" alt-text="Screenshot of query using the let statement and its results.":::

1. Try changing the state name or the minimum damage numbers and rerunning the query. How do the results change?

## Convert a tabular answer to scalar input using a `let` statement

Next, let's look at a count of the most frequent event type as a function of time. First, you need to figure out which is the most frequent event type. Then, you'll use this value in a query. Use the *StormEvents* table to find the top *EventType* by counting the number of events within each type. Use the `project` operator to return only the *EventType* column.

Before starting to construct the `let` statement, let's find out what this event actually is.

<a href="https://dataexplorer.azure.com/clusters/help/databases/Samples?query=H4sIAAAAAAAAAwsuyS/KdS1LzSsp5qopLs3NTSzKrEpVSM4vzSvR0FRIqlQAS4ZUFqRy1SiU5BcoGIIEwfLxQJGCovys1OQShCoA5j76MVEAAAA=" target="_blank">Click to run query</a>

```Kusto
StormEvents
|summarize count() by EventType
| top 1 by count_
| project EventType
```

You should get results that look like the following image:

:::image type="content" source="../media/7-let-2-preview.png" alt-text="Screenshot of preview of let query using complicated scalar and results.":::

Now that you know what the most frequent event is, let's construct a `let` statement that uses this output in a query. First, define the variable name we want to introduce as *MostFrequentEventType*. Next, you want to convert the tabular result with one column and one row to a scalar value to be used as an input into the query. Change the data type by putting the whole query inside the `toscalar()` function.

The previous steps are summarized in the following `let` statement:

```kusto
let MostFrequentEventType = toscalar(
    StormEvents
    | summarize count() by EventType
    | top 1 by count_
    | project EventType);
```

Notice that this statement by itself isn't a valid query, because a valid query must contain at least one statement that's not a `let` statement. You can, however, use this stored scalar value in a query. Recall that you want to look at a count of the most frequent event time as a function of time. You'll filter on *MostFrequentEventType*, and then summarize the count by a certain time bin.

In this case, let's look at the results per month. You'll use the `startofmonth()` function, which returns a datetime representing the start of the month for the given date value. In this query, you'll use the *StartTime* column as the input for the `startofmonth()` function.

Finally, render the results as a column chart to get a histogram of the count of the most frequent event type binned by month.

1. Run the following query:

    <a href="https://dataexplorer.azure.com/clusters/help/databases/Samples?query=H4sIAAAAAAAAA22OsQ7CMAxE936Fx2ZkRh1hY2p3FIJRi5o4OE5RUT8etyDoUA+Wzvd8uh4FTpTkyPjIGOQw6GrGiFCBUHK2t1wWoFMLsV/stOgpZe8tdy8ERzlIaeAywu//w2hGhN1sLMz5e41Md3Typ82+WOdP8GyREVZtqu2aim72SGJZ6OYpSFvWs2g6j0ZxxnBFVrbPPrhWnTda2jGXBAEAAA==" target="_blank">Click to run query</a>

    ```kusto
    let MostFrequentEventType = toscalar(
        StormEvents
        | summarize count() by EventType
        | top 1 by count_
        | project EventType);
    StormEvents
    | where EventType == MostFrequentEventType
    | summarize count() by startofmonth(StartTime)
    | render columnchart
    ```

    You should get results that look like the following image:

    :::image type="content" source="../media/7-let-2.png" alt-text="Screenshot of let query using complicated scalar and results." lightbox="../media/7-let-2.png":::

1. Try changing the query to show a histogram of the least frequent event type binned by month and rerunning the query.

## Construct a `let` statement with tabular output

The previous examples created a stored scalar value to be used as an input parameter in a query. However, it's also possible to use a `let` statement to create a tabular output that's then used as the input to a query.

1. Filter the *StormEvents* table on events that indirectly or directly caused deaths. Then, return a subset of the columns using the `project` operator. This statement gives a tabular output called *KillerStorms*. Use this `let` statement as the beginning input for your query.

    ```kusto
        let KillerStorms=StormEvents
        | where DeathsDirect+DeathsIndirect > 0
        | project State, EventType, Deaths=DeathsDirect+DeathsIndirect;
    ```

1. Then, you can use some of the aggregate functions you've learned in previous units. Run the following query:

    <a href="https://dataexplorer.azure.com/clusters/help/databases/Samples?query=H4sIAAAAAAAAA32OPQ6DMAyF95zCI6gM3Ss60aHqCBdIgyVS5Qc5phUVh29CEGKqF/tZz9+zQYaHNgapZU821Gu7vdFxEBBrgc+AhNCg5CE0mlDxKYu761cJVzhv3pH8K21alowVrJxuHuOYT+o/mIs4PiIWCJO1kvQ3huvA2inOhp0a6l75yXGxb8oKOs/SbGmRUOSxhOecv0pgT5z0wfoD28P5cwgBAAA=" target="_blank">Click to run query</a>

    ```kusto
    let KillerStorms=StormEvents
        | where DeathsDirect+DeathsIndirect > 0
        | project State, EventType, Deaths=DeathsDirect+DeathsIndirect;
    KillerStorms
    | summarize DistinctKillerEventTypes=dcount(EventType), TotalDeaths=sum(Deaths) by State
    | sort by TotalDeaths
    ```

    You should get results that look like the following image:

    :::image type="content" source="../media/7-let-3.png" alt-text="Screenshot of tabular let statement and results.":::

1. Look at the results. Are all events summarized in the *DistinctKillerEventTypes* column so-called "killer storms"?

## Create a user-defined function with the `let` statement

You can also use `let` statements to define user-defined functions, which are reusable subqueries. Suppose you want to figure out what percent of each event type caused damage. You'll create a user-defined function that will calculate percentages, and later call this function and specify which columns are to be used to calculate percentage.

Within a `let` statement, you'll declare function name, schema, and body using the following general syntax:

```Kusto
let function=(variable1:datatype, variable2:datatype) {functionbody};
```

Specifically, you'll use a user-defined function to calculate percentages. First, define the data type and input variables, for this example you'll use the decimal data type. Let's use *val1* as the count of some portion of events, and *val2* is the total count of all events. We'll round the answer to give two digits after the decimal point using the `round()` function.

Taken altogether, the user-defined function described by the `let` statement is:

```kusto
let pcent=(val1:decimal, val2:decimal){round(100 * val1 / val2, 2)};
```

1. Use this `let` statement in the following query:

    <a href="https://dataexplorer.azure.com/clusters/help/databases/Samples?query=H4sIAAAAAAAAA4WQyw6CMBBF93zFLFttIrLU4Ebdk8gP1DIaDG1JGYj4+HcLjRETE1fzuDPnTqZCglqhoZR1sloVqEotKwG+SN4VvzvbmoIt4xhmgwKLUReQ8Oc6OpB1et95RhM9AK+EpoCd1PKMaQhbZ+tmHvLM5+io96NNq7V05Q0htySrgEiV9yLGRWiOS6U5T8XyxAJrE3M49jBqeV+jZ9bOXlDRp/eTI6aOAjJ0wwuGg8dfsH8rfLjeOvpyB9moF+R08iBPAQAA" target="_blank">Click to run query</a>

    ```kusto
    let pcent=(val1:decimal, val2:decimal){round(100 * val1 / val2, 2)};
    StormEvents
    | extend Damage=DamageCrops+DamageProperty
    | summarize TotalEvents=count(), TotalDamagingEvents=countif(Damage>0) by EventType
    | project EventType, TotalDamagingEvents, TotalEvents, Percentage=pcent(TotalDamagingEvents, TotalEvents)
    | sort by EventType asc
    ```

    You should get results that look like the following image:

    :::image type="content" source="../media/7-let-percentage.png" alt-text="Screenshot of let statement with results.":::

1. Take a moment to understand the results. Try modifying the query to show a breakdown of the percentage by damage type and rerunning the query.

Take a look at the results. What does the percentage mean? Notice that the query calls the *pcent* function, which we defined in the `let` statement. The inputs used in this function are *TotalDamagingEvents* and *TotalEvents*, meaning you're looking for the percent of events that caused damage. Note that the percent of events that caused damage shouldn't be confused with a sum of the actual damage done by any particular event or type.
