You've been asked to write a query that answers the following question: 

> In the month of April 2007, what were the top five damage-causing storm events in the state of Virginia?

This solution provides one possible way to construct a query that answers the question.

## Solution process

1. Filter out as much information as possible:
    * The time window should be between April 1 and April 30, 2007. Use the `where` operator to create this filter.
    * You want to return results from only the state of Virginia. Use the `where` operator to create this filter.
1. Create a column that sums damage from **DamageProperty** and **DamageCrops** by using the `project` operator.
1. To figure out which kind of storm caused this damage, you need to return the **EventType** column. Use the `project` operator.
1. You want to see the top five most damaging events. You can use the `sort` operator, whose default mode is descending. Alternatively, and more efficiently, you can use the `top` operator.

## Solution query

The following query includes all the preceding steps:

<a href="https://dataexplorer.azure.com/clusters/help/databases/Samples?query=H4sIAAAAAAAAAwsuyS/KdS1LzSsp5qpRKM9ILUpVCC5JLCoJycxNVUhKLSlPTc1T0EhJLEktAYpomOga6hoZGJhr6ukhiRkbQAQ1kc0oSVWwtVVQCvMMcvf083RUAsoVFOVnpSaXKLgk5iamp9pCqICi/ILUopJKbQjXGcgt1lEAuymksiAVqK0kv0DBVCGpEqoPALF1AUy0AAAA" target="_blank">Run the query</a>

```kusto
StormEvents
| where StartTime between (datetime(4-1-2007)..datetime(4-30-2007))
| where State == "VIRGINIA"
| project Damage=DamageProperty+DamageCrops, EventType
| top 5 by Damage
```

Your results should look something like the following image:

:::image type="content" source="../media/9-solution.png" alt-text="Screenshot of a table with five damage-causing storms in Virginia.":::

## Insights

From the results of this solution, you can see that all the top five damage-causing events in the month of April and in the state of Virginia were all frost or freeze events.
