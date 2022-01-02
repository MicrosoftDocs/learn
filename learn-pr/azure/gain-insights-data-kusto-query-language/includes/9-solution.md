You've been asked to write a query that answers the following question: 

> What was the total week-by-week damage caused by all wind events? Show damage in the unit of Euros. In this case, damage refers to both property and crop damage. At present, the Euro is worth 1.14 USD.

This solution provides one possible way to construct a query that answers the above question.

## Solution process

1. Set the conversion rate using the `let` operator.
1. Filter out as much information as possible.
    1. The *EventType* should have the term "wind"
1. Create a column that sums damage from *DamageProperty* and *DamageCrops* to give a value of damage in USD. Multiply this value column by the conversion rate set in Step 1 to obtain damage in Euros.
1. Summarize the sum of the new damage column by a 7 day bin.
1. Render the results as a column chart.

## Solution query

The above steps are all included in the following query:

<a href="https://dataexplorer.azure.com/clusters/help/databases/Samples?query=H4sIAAAAAAAAAy2NwQ6CMBBE73zFhBOokZCYeDCclLsJ/ECBjTShLdkuIMaPt4qnnZeZ2RlIUE6MAvkxP12QZa2zM7HXzoKVUFSJY1POZMVHbyw9MeGH9ToSeuURL9p2cTDpKWQ73JRRDyqS7d7ZjcSy7je8BvTpLmyGgp+MUaxf9FX/fIpmRaMtkkoUS60NHXDu0hDn8J0YrRsmY9s+uB/5LLK4vwAAAA==" target="_blank"> Click to run query</a>

```Kusto
let Eur = 1.14; //conversion rate
StormEvents
| where EventType has "wind"
| extend Damage=(DamageProperty+DamageCrops)*Eur
| summarize sum(Damage) by bin (StartTime, 7d)
| render columnchart 
```

Your results should look something like the following image:

:::image type="content" source="../media/9-solution.png" alt-text="Screenshot of solution query and results.":::

## Insights

From the above results, we can see that winds caused financial damage all throughout the year. There were several spikes of damage, reaching over 200 million Euro damage.