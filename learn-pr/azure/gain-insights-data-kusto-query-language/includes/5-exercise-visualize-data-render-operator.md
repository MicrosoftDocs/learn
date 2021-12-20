A Kusto query can be used to explore datasets and gain insights. We have used a meteorological dataset to aggregate and compare the number of certain kinds of storm events in different US states for the year 2007. Here, you'll look at these results as a function of time with the aid of time-binned graphs. 

Recall that you have used the `summarize` operator to group events by a common field such as *State*.



When during the year were these storms? Group by week from start time represent visually.

Explain: bin
render
columnchart

[Click to run query](https://dataexplorer.azure.com/clusters/help/databases/Samples?query=H4sIAAAAAAAAAwsuyS/KdS1LzSsp5qpRKC7NzU0syqxKVUjOL80r0dBUSKpUSMrM0wguSSwqCcnMTdVRME/RBKosSs1LSS0CKsspzc1LzgDKAgAcJKS1SgAAAA==)

```kusto
StormEvents
| summarize count() by bin(StartTime, 7d)
| render columnchart
```

:::image type="content" source="../media/5-bin-1.png" alt-text="Screenshot of binned results graph.":::

That’s the number of storms per week, what about the damage they did?

[Click to run query](https://dataexplorer.azure.com/clusters/help/databases/Samples?query=H4sIAAAAAAAAAy2MwQ5EQBBE7/sVdSTcnZysu4QfGKZjJ9Ez0pog+/E72Fvl1atqNQjXG3ldXl/QruQtrGEzEkq879BImEn0QPYHVQSXvqzMRtxJV0qeVYr+QO980qoR7RxTjsKm0ZZ4TYIhTCv74RPbH8PaQ9t9AAAA)

```kusto
StormEvents
| extend damage = DamageProperty + DamageCrops
| summarize sum(damage) by bin(StartTime, 7d)
| render columnchart 
```

:::image type="content" source="../media/5-bin-2.png" alt-text="Screenshot of damage column chart binned by week.":::
