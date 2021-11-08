Kusto queries can be used to filter data and return specific information.
Recall that in the storm events example, we've narrowed down events by time range, keywords, and values in a particular column. Now you want to organize these results to see the highest damaging storm events first.

## Use the `sort` operator

It's difficult to make sense of randomly ordered data. Let's make it a bit easier to understand by sorting the order in which the results are presented. We'd like to know what were the events with the highest damage to property, so we'll order the results by the field `DamageProperty`.

1. Run the following query:

    ```kusto
    StormEvents
    | where DamageProperty > 0
    | project State, EventType, DamageProperty
    | sort by DamageProperty desc
    ```
    
1. You should get results that look like the following image: 

    :::image type="content" source="../media/6-sort-1.png" alt-text="Screenshot of sort operator.":::

1. Notice that the results start from the highest property damage value, and decrease. In fact, the query sorts in descending order by default, so you can leave out the `desc` and obtain the same results. The state and event types aren't ordered in any way. We can actually sort based on more than one expression as shown in the next example.

> [!TIP]
> To take the top number of results for any field, you can use the `top` operator. For example, instead of sorting in descending order and looking at the top ten events, you can use `top 10 by DamageProperty`.

## Sort on more than one expression

Each region has unique weather patterns, so we'd actually like to know which events in each state made the most damage. To answer this question, we'll sort first on the state name, and then the damage within each state. The `sort` operator sorts in descending order by default, so we'll use `asc` to indicate that we want to sort the state names in ascending order.

1. Run the following query:

    ```kusto
    StormEvents
    | where DamageProperty > 0
    | project State, EventType, DamageProperty
    | sort by State asc, DamageProperty
    ```

1. You should get results that look like the following image:

    :::image type="content" source="../media/6-sort-2.png" alt-text="Screenshot of sort operator example 2.":::

1. Notice that now we've gotten a table with the same rows as the previous query, but sorted in a different order. Here, we first sort by the state name, starting with Alabama. Within results from the state of Alabama, the damage property values are sorted in descending order.
