We've used a meteorological dataset to aggregation and visualize data. Here, you'll learn how to use `let` statements to introduce variables and organize complex queries.

`let` statements are useful for breaking up a complex expression into multiple parts, defining constants outside of the query body for readability, or defining a variable once and using it multiple times within a query. You can use `let` statements to create well-organized complex queries. You can use multiple `let` statements; each statement must be followed by a semicolon (`;`).

You can use `let` statements in different kinds of situations. On the simplest level, you can define scalar values that will later be referenced in a query, such as an int, string, date/time, or any other value. You can create a tabular filtered view of a table that will be used as the tabular input for the query. You can also create a function using a `let` statement.

## Define a scalar with a `let` statement

Recall that previous queries filtered on locations or minimum damage. Let's define these boundary values using a `let` statement at the beginning of the query.

The following query uses two `let` statements to define scalar values that'll later be used as input parameters in the query. The first defined value is a number and the second is a string. The `let` statements end with a semicolon.

Notice the commented-out portions of the query that begin with double forward slashes (`//`). Double forward slashes indicate a beginning of a comment until the end of the line. These are comments that are ignored when running queries.

1. Run the following query:

    <a href="https://dataexplorer.azure.com/clusters/help/databases/Samples?query=H4sIAAAAAAAAA12OzQrCMBCE74W+w9JTSw/Fs0Qo6kHwD+vJW9RQA01SNttKxYc3bZSqx9mZ+XYqQbCResEVLwUwmEwhy0BqCoPKWctWaFqbCydptLOj/LA67bZ5NMQsodRlGBRkUA1RGwZPuN8ECiiIkyOyX8bo+5dzNLWF9K32TgmkDmZsXNVXbKMUR/n41BiaRl9j3pbxXzP9BicJnDs/4NjVnmSQ+qNPvQAUhSpF/wAAAA==" target="_blank">Run the query</a>

    ```kusto
    let MinDamage = 1; // int
    let EventLocation = "ARIZONA"; // string
    StormEvents
    | where State == EventLocation
    | where DamageCrops + DamageProperty >= MinDamage
    | summarize Damage=round(avg(DamageProperty + DamageCrops)) by EventType
    | sort by Damage
    ```

    You should get results that look like the following image:

    :::image type="content" source="../media/7-let-1.png" alt-text="Screenshot of query using the let statement and its results.":::

1. Try changing the state name or the minimum damage numbers and rerunning the query. How do the results change?

## Convert a tabular result to a scalar value using `toscalar` within a `let` statement

Next, let's look at a count of the most frequent event type as a function of time. First, you need to figure out which is the most frequent event type. Then, you'll use this value in a query. Use the *StormEvents* table to find the top *EventType* by counting the number of events within each type. Use the `project` operator to return only the *EventType* column.

Before starting to construct the `let` statement, run the query to find out what this event actually is. This allows you to verify that your query is producing the expected results.

<a href="https://dataexplorer.azure.com/clusters/help/databases/Samples?query=H4sIAAAAAAAAAwsuyS/KdS1LzSsp5uWqUSguzc1NLMqsSlVIzi/NK9HQVEiqVABLh1QWpIJUlOQXKBiCRMEK4kFCBUX5WanJJQh1AGSi72VVAAAA" target="_blank">Run the query</a>

```Kusto
StormEvents
| summarize count() by EventType
| top 1 by count_
| project EventType
```

You should get results that look like the following image:

:::image type="content" source="../media/7-let-2-preview.png" alt-text="Screenshot of preview of let query using complicated scalar and results.":::

You'll notice that the query produced a tabular result with one column and one row. However, you'll want to convert this to a scalar value to use as a filter value in your main query. First, define the variable name we want to introduce as *MostFrequentEventType*. Next, you want to convert the tabular result to a scalar value by putting the whole query inside the `toscalar()` function.

The previous steps are summarized in the following `let` statement:

```kusto
let MostFrequentEventType = toscalar(
    StormEvents
    | summarize count() by EventType
    | top 1 by count_
    | project EventType);
```

Notice that this statement by itself isn't a valid query, because a valid query must contain at least one statement that's not a `let` statement. You can, however, use this stored scalar value in a query. Recall that you want to look at a count of the most frequent event time as a function of time. You'll filter on *MostFrequentEventType*, then summarize the count by a certain time bin.

In this case, let's look at the results per month. You'll use the `startofmonth()` function, which returns a datetime representing the start of the month for the given date value. In this query, you'll use the *StartTime* column as the input for the `startofmonth()` function.

Finally, render the results as a column chart to get a histogram of the count of the most frequent event type binned by month.

1. Run the following query:

    <a href="https://dataexplorer.azure.com/clusters/help/databases/Samples?query=H4sIAAAAAAAAA22OvQ7CMAyE90p9B4/tyIw6wsbU7igEoxYlcXAcUFEfnqSo/Ej1YMl3n3xnUOBAQfaMt4hOdve0utEjNCAUtDKKq7KANK0Q29kPb2GCEK1VPDwRNEUnVQ2nET4vFkrIwyY7M3RcZM90RS1fvt6WxV/IBI8eGeGnVLPeNrOrZYIoFrpYctJXbT66wWKdeUZ3Rk6widbpPlkvHT0NTA0BAAA=" target="_blank">Run the query</a>

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

The previous examples created a stored scalar value to be used as an input parameter in a query. However, it's also possible to use a `let` statement to create tabular data that's then used as the input to a query.

1. Filter the *StormEvents* table on events that indirectly or directly caused deaths. Then, return a subset of the columns using the `project` operator. This statement gives a tabular output called *KillerStorms*. Use this `let` statement as the beginning input for your query.

    ```kusto
    let KillerStorms =
        StormEvents
        | where DeathsDirect + DeathsIndirect > 0
        | project State, EventType, Deaths=DeathsDirect + DeathsIndirect;
    ```

1. Then, you can use some of the aggregation functions you've learned in previous units. Run the following query:

    <a href="https://dataexplorer.azure.com/clusters/help/databases/Samples?query=H4sIAAAAAAAAA32OsQ6DMAxEd77CI6gM3at0okPVEX4gBUukCgmyTSsqPr4hQYipnnyn8/NZFHgYa5Fq8TQwqAzCRHF7oxOOeoFPj4RQoZaeK0PYCpw2eXddMq5w3tIj+dfq1KIFS4ikZh7Dmk7UX9AlO1bKFuBpGDSZbyhgWIxrJQV2Lquu9ZOTfHeKEhov2m7/AiFPawHPOfVawZ5k1YfoD7eQKN4SAQAA" target="_blank">Run the query</a>

    ```kusto
    let KillerStorms =
        StormEvents
        | where DeathsDirect + DeathsIndirect > 0
        | project State, EventType, Deaths=DeathsDirect + DeathsIndirect;
    KillerStorms
    | summarize DistinctKillerEventTypes=dcount(EventType), TotalDeaths=sum(Deaths) by State
    | sort by TotalDeaths
    ```

    You should get results that look like the following image:

    :::image type="content" source="../media/7-let-3.png" alt-text="Screenshot of tabular let statement and results.":::

1. Look at the results. Are all events summarized in the *DistinctKillerEventTypes* column so-called "killer storms"?

## Create a user-defined function with the `let` statement

You can also use `let` statements to define user-defined functions, which are reusable subqueries. Suppose you want to figure out what percent of each event type caused damage. You'll create a user-defined function that will calculate percentages, and later call this function and specify which columns are to be used to calculate percentage.

Within a `let` statement, you'll declare function name, arguments, and body using the following general syntax:

```Kusto
let function=(argument1:datatype, argument2:datatype) {functionbody};
```

Specifically, you'll use a user-defined function to calculate percentages. First, define the data type and input arguments. For this example, you'll use the following arguments:

| Argument name | Data type | Description |
|--|--|--|
| *portion* | `real` | The portion of the total events that you want to calculate the percentage of. |
| *total* | `real` | The total number of events. |

You'll round the answer to two decimal places using the `round()` function.

Taken altogether, the user-defined function described by the `let` statement is:

```kusto
let Pcent = (portion:real, total:real){round(100 * portion / total, 2)};
```

1. Use this `let` statement in the following query:

    <a href="https://dataexplorer.azure.com/clusters/help/databases/Samples?query=H4sIAAAAAAAAA4VQy6rCMBDdC/7DWSbXgNWloht1X9AfiHWuVNqkTEexPv7dtCmocOHucmbOY3IKEqQZOcECqvIsuXczMNnCQLzYIgKNO9if3UFNkgQ/6JkYR5LBVOM5Hw624rncXIJfPRw8QFchd8DalvZIISE+VuyrGqMepQERS9Py63NZWs5vhF1rG42CLgvRorSJ406Xu+P3Ov9Vfc4Sica+QbffNRW11hX7E2XyHv5pZj6DDVLitpt4fFeT+k+ku3+Eer4ugK2zFx10e+xrAQAA" target="_blank">Run the query</a>

    ```kusto
    let Pcent = (portion: real, total: real) { round(100 * portion / total, 2) };
    StormEvents
    | extend Damage = DamageCrops + DamageProperty
    | summarize TotalEvents = count(), TotalDamagingEvents = countif(Damage > 0) by EventType
    | project EventType, TotalDamagingEvents, TotalEvents, Percentage = Pcent(TotalDamagingEvents, TotalEvents)
    | sort by EventType asc
    ```

    You should get results that look like the following image:

    :::image type="content" source="../media/7-let-percentage.png" alt-text="Screenshot of let statement with results.":::

1. Take a moment to understand the results. Try modifying the query to show a breakdown of the percentage by damage type and rerunning the query.

Take a look at the results. What does the percentage mean? Notice that the query calls the *Pcent* function, which we defined in the `let` statement. The inputs used in this function are *TotalDamagingEvents* and *TotalEvents*, meaning you're looking for the percent of events that caused damage.
