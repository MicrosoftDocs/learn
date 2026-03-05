When multiple tiles in a dashboard use related data, you can improve maintainability by defining *base queries* that retrieve a general set of records relevant for multiple tiles. Tile-specific queries then filter or group this data for particular visualizations.

Base queries help you avoid duplicating the same logic across multiple tiles. Instead of writing similar queries for each tile, you create one base query and reference it from multiple tiles.

For example, in a bike rental dashboard, you could create a base query through the dashboard's **Base queries** menu. When creating the base query, you would:

1. Assign it the variable name `_base_bike_data`
2. Define a query that returns all data fields in each neighborhood within the last 30 minutes:

```kql
bikes
| where ingestion_time() between (ago(30min) .. now())
| summarize latest_observation = arg_max(ingestion_time(), *) by Neighbourhood
```

:::image type="content" source="../media/base-query.png" alt-text="Screenshot showing a base query configuration." lightbox="../media/base-query.png":::

Then, you can create individual tile queries that reference this base query by using its variable name:

```kql
_base_bike_data
| project Neighbourhood, latest_observation, No_Bikes, No_Empty_Docks
| order by Neighbourhood asc
```