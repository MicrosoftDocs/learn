You've been asked to write a query that answers the following question:

> What was the total week-by-week damage caused by all flood events? Show damage in the unit of Euros. In this case, damage refers to both property and crop damage. At present, the Euro is worth 1.14 USD.

This solution provides one possible way to construct a query that answers the previous question.

## Solution process

1. Set the conversion rate using the `let` operator.
1. Filter out as much information as possible.
    - The *EventType* should have the term "flood"
1. Create a column that sums damage from *DamageProperty* and *DamageCrops* to give a value of damage in USD. Multiply this value column by the conversion rate set in Step 1 to obtain damage in Euros.
1. Summarize the sum of the new damage column by a seven day bin.
1. Render the results as a column chart.

## Solution query

The previous steps are all included in the following query:

<a href="https://dataexplorer.azure.com/clusters/help/databases/Samples?query=H4sIAAAAAAAAAy2NwQ6CMBBE73zFhBOokZCYeDCclLsJ/ECBVZrQlmwXFOPHW8XTzsvM7AwkKCdGgXyfH07IstbZmdhrZ8FKKKrEsSlnsuKjNx49MeGH9TISeuUR3wbnuji49BSyHS7KqDsVyXqv7EZiWbYrngP6dBNGQ8FPxijWL/qqfz5Fs6DRFkkliqXWhnY4dmmIc/hOjNYNk7FtH9wP3MER/cAAAAA=" target="_blank"> Click to run query</a>

```kusto
let Eur = 1.14; //conversion rate
StormEvents
| where EventType has "flood"
| extend Damage=(DamageProperty+DamageCrops)*Eur
| summarize sum(Damage) by bin (StartTime, 7d)
| render columnchart
```

Your results should look something like the following image:

:::image type="content" source="../media/9-solution.png" alt-text="Screenshot of solution query and results.":::

## Insights

From the results, we can see that floods caused financial damage mainly during the spring and summer months. There were several spikes of damage, reaching at most around 1,000 million Euro of damage.
