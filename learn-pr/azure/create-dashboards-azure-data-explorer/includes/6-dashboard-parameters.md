Interacting with dashboards can allow you to easily view different insights within the same context.

You created a dashboard to view insights into your storm events dataset. Next, you use parameters to filter dashboard tiles.

## What are parameters?

Parameters are used as building blocks for dashboard filters in Azure Data Explorer dashboards. They're managed in the dashboard scope, and can be added to queries to filter the data presented by the underlying visual. A query can use one or more parameters.

Parameters make your dashboard interactive. They act like a filter on any tile that uses the parameter, so that choosing a value from that parameter shows you a filtered view of the connected visual. Recall that each visual is created from a query. If the parameter isn't used in the query, the filter remains disabled. Once the parameter is added to the query to filter the data, the parameter becomes active.

For example:

Say you define a parameter called `state`, and then add the parameter to the query for a dashboard visual. Then, in the parameter dropdown, you choose a particular state, like Missouri. Your dashboard visual only displays results associated with the state of Missouri. Using a parameter is similar to injecting the condition as a filter in a query. But the filter is dynamic and lets you change many queries at once or quickly change between filter values.

Each dashboard comes with a built-in time range parameter. You can use this time range to only see data from a chosen time window.

:::image type="content" source="../media/9-dashboard-time-range.png" alt-text="Screenshot showing time range parameter.":::

## What are cross-filters?

Cross-filters allow you to select a value within a tile, and this value is used to filter other dashboard visuals. Instead of selecting a parameter value from the drop-down list, you select the parameter value by selecting a field on a tile.

You only need to add a cross-filter on the tile you're selecting. All other tiles that use this parameter in their query are then filtered accordingly. You can create more than one cross-filter on the same tile, or different cross-filters on different tiles.