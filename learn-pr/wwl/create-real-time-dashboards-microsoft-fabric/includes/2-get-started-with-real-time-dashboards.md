Real-Time Dashboards in Microsoft Fabric are built on real-time streaming data sources. Each dashboard consists of one or more *tiles*, each displaying a real-time data visualization.

:::image type="content" source="../media/dashboard.png" alt-text="Screenshot of a Real-Time Dashboard." lightbox="../media/dashboard.png":::

## Create a Real-Time Dashboard

To create a Real-Time Dashboard, you'll need a source of real-time data; such as a KQL database in an eventhouse. You can then create a Real-Time Dashboard with a *data source* that references the KQL database.

### Configure authorization for data sources

When connecting the dashboard to the data source, you can specify who has permission to access the data:

- **Pass-through identity** - Each person viewing the dashboard accesses data using their own permissions.
- **Dashboard editor's identity** - Everyone viewing the dashboard accesses data using the dashboard creator's permissions.

### Create tiles

A dashboard contains at least one tile, in which the results of a KQL query are displayed.

### Specify a query

When you first add a tile, you can enter and test the query you want to use to query the underlying data source. For example, you might use a KQL query similar to the following example to query a table named **bikes** and retrieve details of available bikes and empty bike parking docks for a bike rental system in a city:

```kql
bikes
| where ingestion_time() between (ago(30min) .. now())
| summarize latest_observation = arg_max(ingestion_time(), *) by Neighbourhood
| project Neighbourhood, latest_observation, No_Bikes, No_Empty_Docks
| order by Neighbourhood asc
```

The query in the example retrieves the most recent observation (the latest record ingested into the source table) within the last 30 minutes for each neighborhood.

Initially, the tile displays the results of the query as a table as shown in the following image.

:::image type="content" source="../media/tile-table.png" alt-text="Screenshot of a dashboard with a tile containing a table." lightbox="../media/tile-table.png":::

### Visualize the data

After creating a tile, you can edit it to define a visual in which the data is represented as a chart, map, or other data visualization. For example, it might make more sense to display the rental bike data as a bar chart that shows the number of bikes and empty parking docks in each neighborhood.

:::image type="content" source="../media/tile-bar-chart.png" alt-text="Screenshot of a tile being edited to include a bar chart." lightbox="../media/tile-bar-chart.png":::

You can add multiple tiles to a dashboard and arrange them to organize the way the data is visualized. You can also add *text tiles* to provide additional information.

