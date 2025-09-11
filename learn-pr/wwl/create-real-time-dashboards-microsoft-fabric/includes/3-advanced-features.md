Real-Time Dashboards include several features that help you organize and interact with your data more effectively. You can organize your dashboard using multiple pages, add interactive parameters to filter data, and set up automatic data refresh.

## Pages

By default, a Real-Time Dashboard has one page. However, you can add more pages as containers for more tiles. This helps you organize related content into logical groups. For example, you might create separate pages for different data sources, or subject areas.

## Parameters

Parameters add flexibility to your dashboard by allowing users to filter the data displayed in tiles. For example, users might want to view data for only a specific time period or focus on a particular subset of the data.

You can create multiple parameters for a dashboard. Parameter values can be based on specific text or on the results of a query. Each parameter has a variable name that you can reference in your tile queries using an underscore prefix.

For example, in a bike rental dashboard, if you created a parameter that lets users filter by neighborhood and named it `_selected_neighbourhoods`, you would reference it in your tile queries like this:

```kql
bikes
| where ingestion_time() between (ago(30min) .. now())
    and (isempty(_selected_neighbourhoods) or Neighbourhood in (_selected_neighbourhoods))
| summarize latest_observation = arg_max(ingestion_time(), *) by Neighbourhood
```

This query includes a filter that checks whether the `_selected_neighbourhoods` parameter is empty (which happens when no neighborhoods are selected, showing all neighborhoods) or contains specific values (showing only those neighborhoods).

## Auto refresh

Auto refresh automatically updates your dashboard data without needing to manually reload the page. Dashboard editors can set a default refresh rate and viewers can adjust this rate during their session. However, editors can also set a minimum refresh rate to manage system performance and prevent users from refreshing too frequently.

