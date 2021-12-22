
<a href="https://dataexplorer.azure.com/clusters/help/databases/Samples?query=H4sIAAAAAAAAAwsuyS/KdS1LzSsp5qpRSK0oSc1LUUhJzE1MT1WwVXABMwKK8gtSi0oqFbShAs5AAZDy8ozUolSYajsFA6BQcWlubmJRZlWqQmJZugZESlMhqVIBbEdIZUEqSFF+UQlIDKgkHqIEALtwQu2HAAAA" target="_blank"> Click to run query</a>

```kusto
StormEvents
| extend damage = DamageProperty + DamageCrops
| where damage > 0
| summarize avg(damage) by EventType
| sort by avg_damage
```

:::image type="content" source="../media/6-avg.png" alt-text="Screenshot of avg aggregate function results.":::


<a href="https://dataexplorer.azure.com/clusters/help/databases/Samples?query=H4sIAAAAAAAAAwsuyS/KdS1LzSsp5qpRSK0oSc1LUUhJzE1MT1WwVXABMwKK8gtSi0oqFbShAs5AAZDy4tLc3MSizKpUhdzECg2ILk2FpEoFsIEhlQWpIEX5RSUgMaCSeIgSANaUj+R0AAAA" target="_blank"> Click to run query</a>

```kusto
StormEvents
| extend damage = DamageProperty + DamageCrops
| summarize max(damage) by EventType
| sort by max_damage
```

:::image type="content" source="../media/6-max.png" alt-text="Screenshot of max aggregate function results.":::

<a href="https://dataexplorer.azure.com/clusters/help/databases/Samples?query=H4sIAAAAAAAAAwsuyS/KdS1LzSsp5qpRSK0oSc1LUUhJzE1MT1WwVXABMwKK8gtSi0oqFbShAs5AAZDy8ozUolSYajsFA6BQcWlubmJRZlWqAlBLMtDYzJzUYg2IEh0FUx0FIwMgBcQWQGxpqqmQVKkAtj6ksiAVpD+/qARFTCGxOBkAk1m5yaUAAAA=" target="_blank"> Click to run query</a>

```kusto
StormEvents
| extend damage = DamageProperty + DamageCrops
| where damage > 0
| summarize percentiles(damage, 5, 20, 50, 80, 95) by EventType
| sort by EventType asc
```

:::image type="content" source="../media/6-percentiles.png" alt-text="Screenshot of percentiles aggregate function results.":::