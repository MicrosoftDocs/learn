A Kusto query can be used to explore datasets and gain insights. We have used a meteorological dataset to aggregate and visualize data. Here, you'll learn how to use `let` statements to introduce variables and organize complex queries.

The let statement can be used to set a variable name equal to an expression or a function, or to create views. You can use multiple let statments; each statement must be followed by a semicolon (`;`). 

Let statements can be used in a variety of situations. On the simplest level, you can define scalar values at the beginning of a query to later be referenced in a query. For more complicated uses, you can convert a tabular result to a scalar value to be used as input, or create a tabular output to be used as the tabular input for the query.

## Construct a scalar `let` statement

Recall that previous queries filtered on locations or minimum damage. If you want to change these values frequently, it can be useful to define them using a `let` statement at the beginning of the query.

The following query uses two `let` statements to define scalar values. They are separated by semicolons, and later used in the query.

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

## Convert a tabular answer to scalar

and then input

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

– filter already for a certain subset What is the advantage?

<a href="https://dataexplorer.azure.com/clusters/help/databases/Samples?query=H4sIAAAAAAAAA8tJLVHwzszJSS0KLskvyi22BVOuZal5JcVcCkBQo1CekVqUquCSmliSUeySWZSaXKIN4XjmpYC5CnYKBlC1BUX5WSCR4JLEklQdBbA5IZUFQCZEiy0eY6y5kB3CVaNQXJqbm1iUWZWqkJKcX5pXogE3TlMhqRJmB8QQACPjzrjIAAAA" target="_blank"> Click to run query</a>

```kusto
let KillerStorms=StormEvents
    | where DeathsDirect+DeathsIndirect > 0
    | project State, EventType, Deaths=DeathsDirect+DeathsIndirect;
KillerStorms
| summarize dcount(EventType) by State, Deaths
```

You should get results that look like the following image:

:::image type="content" source="../media/7-let-3.png" alt-text="Screenshot of tabular let statement and results.":::