A Kusto query can be used to explore datasets and gain insights. We have used a meteorological dataset to aggregate and visualize data. Here, you'll learn how to use `let` statements to introduce variables and organize complex queries.

`let` statements are useful for breaking up a complex expression into multiple parts, defining constants outside of the query body for readability, or defining a variable once and using it multiple times within a query. `let` statements can be used to create well-organized complex queries. You can use multiple let statements; each statement must be followed by a semicolon (`;`).

`let` statements can be used in a variety of situations. On the simplest level, you can define scalar values that will later be referenced in a query. You can create a tabular filtered view of a table that will used as the tabular input for the query. You can also create a function using a `let` statement.

## Define a scalar with a `let` statement

Recall that previous queries filtered on locations or minimum damage. Let's define these boundary values using a `let` statement at the beginning of the query.

The following query uses two `let` statements to define scalar values that will later be used as input parameters in the query. The first value is a number, and the second is a string. The two `let` statements and the following tabular query statement are each separated by a semicolon.

Notice the commented-out portions of the query that begin with double forward slashes (`//`). Add double forward slashes to each commented-out line.

1. Run the following query:
    
    <a href="https://dataexplorer.azure.com/clusters/help/databases/Samples?query=H4sIAAAAAAAAA8tJLVHwzcxzScxNTE9VsFUwtFbQ11fIK81NSi3iygFKFuQkJoMklByDPKP8/RyVrBVAKopLijLz0rmCS/KLcl3LUvNKihW4ahTKM1KLUhWCSxJLgFpsoXrh4hBLnIvyC4q1IewAIDu1qKRSwQ7hCKDy4tLc3MSizCqYFtvEsnQNVB3aSIZpKiRVKoAdEVJZkAoAoyeg39IAAAA=" target="_blank"> Click to run query</a>
    
    ```kusto
    let MinDamage = 1; // number
    let place = "ARIZONA";  // string
    StormEvents 
    | where State == place 
    | where DamageCrops+DamageProperty > MinDamage
    | summarize Damage=avg(DamageProperty+DamageCrops) by EventType
    ```

    You should get results that look like the following image:

    :::image type="content" source="../media/7-let-1.png" alt-text="Screenshot of query using the let operator and its results.":::

1. Try changing the state name or the minimum damage numbers and rerunning the query. How do the results change?

## Convert a tabular answer to scalar input using a `let` statement

Next, let's look at a count of the most frequent event time as a function of time. First, you need to figure out which is the most frequent event type. Then, you'll use this value in a query.

To do this, you'll use a `let` statement. First, define the variable name we want to introduce as *MostFrequentEventType*. We'll use the *StormEvents* table to find the top 1 *EventType* by count. Use the `project`operator to return only the *EventType* column. Finally, you want to convert this tabular result with one column and one row to a scalar value that can be used later for input into the query. Do this by putting the whole query inside the `toscalar()` operator.

These steps are summarized in the following let statement:

```kusto
let MostFrequentEventType = toscalar(
    StormEvents
    |summarize count() by EventType
    | top 1 by count_
    | project EventType);
```

Notice that this statement by itself does not print an answer. You can, however, use this stored scalar value in a query. Recall that you want to look at a count of the most frequent event time as a function of time. You'll filter on the *MostFrequentEventType* defined above, and then summarize the count by a certain time bin.

In this case, let's look at the results per month. You'll use the `startofmonth()` operator, which returns a datetime representing the start of the month for the given date value. Use the *StartTime* to determine the start of month.

Finally, render the results as a column chart to get a histogram of the count of the most frequent events binned by month.  

1. Run the following query:

    <a href="https://dataexplorer.azure.com/clusters/help/databases/Samples?query=H4sIAAAAAAAAA22OsQ6DMAxEd77CYyJ1Ya4Y260T7FUIrqAiCXUcKio+voZWLQMeLNn37nQ9MlxC5DPhI6Hn0yirmgaEAjhEa3pDKgOZkgO5VY7rPcfknKHuhWBD8qw01BP8/B9GMgbIF2Flrt/vQOGOlv+0Pmbb/BmeLRLCpk2xX1PQ3R5151VkQxxuLnhuVbkcVedQHyBvtPgIfYMkpj45b1uR38P9xEwNAQAA" target="_blank"> Click to run query</a>

    ```kusto
    let MostFrequentEventType = toscalar(
        StormEvents
        |summarize count() by EventType
        | top 1 by count_
        | project EventType);
    StormEvents
    | where EventType == MostFrequentEventType
    | summarize count() by bin(startofmonth(StartTime), 1d)
    | render columnchart 
    ```

    You should get results that look like the following image:

    :::image type="content" source="../media/7-let-2.png" alt-text="Screenshot of let query using complicated scalar and results." lightbox="../media/7-let-2.png":::

## Construct a `let` statement with tabular output

The above examples created a stored scalar value to be used as an input parameter in a query. However, it's also possible to use a `let` statement to create a tabular output that's then used as the input to a query.

1. Filter the *StormEvents* table on events that caused deaths (indirectly or directly). Then, project a subset of the columns using the `project` operator. This gives a tabular output called *KillerStorms*. Use this as the beginning input for your query.

    ```kusto
        let KillerStorms=StormEvents
        | where DeathsDirect+DeathsIndirect > 0
        | project State, EventType, Deaths=DeathsDirect+DeathsIndirect;
    ```

1. Then, you can use some of the aggregate functions you've learned in previous units. Run the following query:

    <a href="https://dataexplorer.azure.com/clusters/help/databases/Samples?query=H4sIAAAAAAAAA31OOw6DMAzdcwqPoDJ0r9KJDlVHuEAKlkiVD3IMFRWHb0hQxVQv9rPezyDDQxuD1LAnG2RatxkdBwFxVngPSAg1Kh5CrQk7PmVwd32CcIXzzh3Jv7ZPw4qxguTTLmM8s0T+sbmIYxGxQpisVaQ/MVwH1q7jTMjtZN/5yXHxyygraD0rsydFdZHPEp5LbrSZeuINH6hfkphbegQBAAA=" target="_blank"> Click to run query</a>
    
    ```kusto
    let KillerStorms=StormEvents
        | where DeathsDirect+DeathsIndirect > 0
        | project State, EventType, Deaths=DeathsDirect+DeathsIndirect;
    KillerStorms
    | summarize DistinctKillerEvents=dcount(EventType), TotalDeaths=sum(Deaths) by State
    | sort by TotalDeaths
    ```
    
    You should get results that look like the following image:
    
    :::image type="content" source="../media/7-let-3.png" alt-text="Screenshot of tabular let statement and results.":::

## Create a user-defined function with the `let` statement

You can also use `let` statements to define user-defined functions, which are reusable subqueries. Suppose you want to figure out what percent of each event type caused damage. You'll create a user-defined function that will calculate percentages, and later call this function and specify which columns to be used to calculate percentage.

Within a `let` statement, you'll declare function name, schema, and body using the following general syntax:

```Kusto
let function=(variable1:datatype, variable2:datatype) {functionbody};
```

You'll use the following user-defined function to calculate percentages:

```kusto
let pcent=(val:decimal, val2:decimal){round(100 * val / val2, 2)};
```

You use two input values that are decimals. The first

<a href="https://dataexplorer.azure.com/clusters/help/databases/Samples?query=H4sIAAAAAAAAA4WQyw6CMBBF93zFLFttIrLU4Ebdk8gP1DIaDG1JGYj4+HcLjRETE1fzuDPnTqZCglqhoZR1sloVqEotKwG+SN4VvzvbmoIt4xhmgwKLUReQ8Oc6OpB1et95RhM9AK+EpoCd1PKMaQhbZ+tmHvLM5+io96NNq7V05Q0htySrgEiV9yLGRWiOS6U5T8XyxAJrE3M49jBqeV+jZ9bOXlDRp/eTI6aOAjJ0wwuGg8dfsH8rfLjeOvpyB9moF+R08iBPAQAA" target="_blank"> Click to run query</a>

```kusto
let pcent=(val:decimal, val2:decimal){round(100 * val / val2, 2)};
StormEvents
| extend Damage=DamageCrops+DamageProperty
| summarize TotalEvents=count(), TotalDamagingEvents=countif(Damage>0) by EventType
| project EventType, TotalDamagingEvents, TotalEvents, Percentage=pcent(TotalDamagingEvents, TotalEvents)
| sort by EventType asc
```

You should get results that look like the following image:

:::image type="content" source="../media/7-let-percentage.png" alt-text="Screenshot of let statement with results.":::