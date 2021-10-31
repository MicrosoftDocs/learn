Kusto queries can be used to filter data and return specific information.
Recall that in the storm events example, we've been able to narrow down events by time range, keywords, and values in a particular column. Here, you'll learn how to count the sort the results of a query.

## Use the `sort` operator

It's difficult to make sense of randomly ordered data. Let's make it a bit easier to understand by sorting the order in which the results are presented. In this example, we're going to order the results of a previous query by the field `DamageProperty`. 

Run the following query:

```kusto
StormEvents
| where DamageProperty > 0
| project State, EventType, DamageProperty
| sort by DamageProperty
```

:::image type="content" source="../media/6-sort-1.png" alt-text="Screenshot of sort operator.":::

Notice that the results start from the highest property damage value, and decrease. The state and event types are not ordered in any way. We can actually sort based on more than one expression.

## Sort on more than one expression

In this example, we'll sort first on the state name, and then the damage within each state. The `sort` operator sorts in descending order by default, so we'll use `asc` to indicate that we want to sort the state names in ascending order.

Run the following query

```kusto
StormEvents
| where DamageProperty > 0
| project State, EventType, DamageProperty
| sort by State asc, DamageProperty
```

:::image type="content" source="../media/6-sort-2.png" alt-text="Screenshot of sort operator example 2.":::

Now we've gotten a table with the same rows as the previous query, but just sorted in a different order. Here, we first sort by the state name, starting with Alabama. Within results from the state of Alabama, the damage property values are sorted in descending order.

## Check your work

Scroll down to the next state name. Is it in ascending alphabetical order from the previous state? What do you notice about the `DamageProperty` values?