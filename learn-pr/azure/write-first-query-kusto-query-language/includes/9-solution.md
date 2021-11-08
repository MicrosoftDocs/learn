You've been asked to write a query that answers the following question: 

> In the month of April 2007, what were the top five damage-causing storms in the state of Virginia?

This solution provides one possible way to construct a query that answers the above question.

## Solution process

1. The first thing we want to do is filter out as much information as possible. 
    * The time window should be between April 1 and April 30, 2007. We'll use `where` operator to create this filter.
    * We only want to return results from the state of Virginia. We'll use `where` operator to create this filter.
1. Now, we need to create a column that sums damage from *DamageProperty* and *DamageCrops*. We can use either the `extend` or `project` operators. To figure out which kind of storm caused this damage, we need to make sure to see the *EventType* column. We'll use the `project` operator.
1. Lastly, we want to see the top five most damaging events. We can use the `sort` operator, with the default mode being descending. Alternatively, and more efficiently, we can use the `top` operator.

## Solution query

The above steps are all included in the following query:

```kusto
StormEvents
| where StartTime between (datetime(4-1-2007)..datetime(4-30-2007))
| where State == "VIRGINIA"
| project damage=DamageProperty+DamageCrops, EventType
| top 5 by damage
```

:::image type="content" source="../media/9-solution.png" alt-text="Screenshot of solution.":::

## Insights

From the above results, we can see that all top five damage-causing events in the month of April and in the state of Virginia were Frost/Freeze events.