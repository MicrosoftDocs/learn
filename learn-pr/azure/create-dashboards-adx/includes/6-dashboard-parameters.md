You've created a dashboard to view insights into your storm events dataset. In this unit, you'll see how parameters can be used as filters on the dashboard tiles. 

## What are parameters?

Parameters are used as building blocks for dashboard filters in Azure Data Explorer dashboards. They're managed in the dashboard scope, and can be added to queries to filter the data presented by the underlying visual. A query can use one or more parameters. This document describes the creation and use of parameters and linked filters in Azure Data Explorer dashboards. Parameters can be used to slice and dice dashboard visuals 

Parameters make your dashboard interactive. They act like a filter on any tile that uses the parameter, so that choosing a value from that parameter will show you a filtered view of the connected visual.

For example, each dashboard comes with a built-in time range parameter.

:::image type="content" source="../media/9-dashboard-time-range.png" alt-text="Screenshot showing time range parameter.":::

Recall that each visual is created from a query. If you've included this time range within the visual query, then changing its value will show only results for, for example, the past hour.
