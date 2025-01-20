In addition to adding data sources and tiles, you can use some advanced features of real-time dashboards to provide a richer, more flexible real-time data visualization experience. 

## Base queries

While each tile has its own query, a common pattern in dashboard design is for multiple tiles to be based on a related set of data. You can make your dashboard more maintainable by defining *base queries* that retrieve a general set of records that are relevant for multiple tiles, and then using tile-specific queries to further filter or group the data for a particular data visualization.

For example, in the bike rental dashboard example discussed previously, you could define a base query that returns all of the data fields for the latest observation in each neighborhood within the last 30 minutes:

```kql
bikes
| where ingestion_time() between (ago(30min) .. now())
| summarize latest_observation = arg_max(ingestion_time(), *) by Neighbourhood
```

When you create a base query, you assign it a *variable name* that you can reference in tile-specific queries. In the bike rental example above, you could assign the variable name `base_bike_data` and modify the query for the bar chart tile to use the base query like this:

```kql
base_bike_data
| project Neighbourhood, latest_observation, No_Bikes, No_Empty_Docks
| order by Neighbourhood asc
```

## Pages

By default, a real-time dashboard has one page. However, you can add more pages as containers for more tiles. It's a great way to create logical groups of organization by items, such as data source, subject area, or even aggregation or detail level.

![Screenshot of a dashboard with multiple pages.](../media/dashboard-pages.png)

## Parameters

You can add flexibility to a real-time dashboard by providing *parameters* that users can use to filter the data displayed in the tiles. Parameters are useful when you want to enable users to view data only for a specific time period or to focus on some other subset of the data.

You can define multiple parameters for a dashboard, and base the filter values on specific text or on the results of a query. For example, in the bike rental dashboard we've been discussing in this module, you could create a filter for the **Neighborhood** field based on the following query:

```kql
bikes
| distinct Neighbourhood
| order by Neighbourhood asc
```

The filter uses the query to return a list of discrete neighborhood names from which the user can select one or more neighborhoods to include in the dashboard visualizations.

Each parameter is assigned a variable name, which you can reference in tile or base queries. For example, by creating a parameter named `selected_neighbourhoods` you can modify the base query for the bike rental dashboard like this:

```kql
bikes
| where ingestion_time() between (ago(30min) .. now())
    and (isempty(['selected_neighbourhoods']) or Neighbourhood in (['selected_neighbourhoods']))
| summarize latest_observation = arg_max(ingestion_time(), *) by Neighbourhood
```

The modified query includes an `and` clause that filters the data based on whether the `selected_neighbourhoods` variable is empty (in which case all neighborhoods are included in the results) or if it contains one or more specific neighborhood names (in which case only observations for those neighborhoods are included).

## Auto refresh

Auto refresh automatically updates dashboard data, eliminating the need for manual page reloads or refresh actions. Editors can set a default refresh rate, which both editors and viewers can adjust during dashboard viewing. However, editors have the authority to establish a minimum refresh rate to manage cluster workload, preventing users from setting a rate below this threshold.

