Now you're connected to the data source that's preloaded into Azure Data Explorer. Before you start creating new dashboards, let's learn a bit about how dashboards in Azure Data Explorer work.

## What are Azure Data Explorer Dashboards?

Dashboards tell a story through visualizations, and are an excellent way to monitor your data and see all of your most important insights at a glance. Dashboards aren't static pictures. They're interactive, and the dashboard tiles update as the underlying data changes.

The visualizations you see on the dashboard are called tiles. Tiles can display a single number, a graph, a data table, or another visualization. Tiles are dynamically linked to the source data, so they change whenever your underlying data changes. You can pin (create) tiles to a dashboard from a query, or create new tiles within a new or existing dashboard page.

## What are the advantages of using the native dashboard experience?

Azure Data Explorer dashboards provide three main advantages:

* You can explore the data in the Azure Data Explorer web UI. Your data is hosted in the Azure Data Explorer product, and can be queried in the same environment you use to create dashboards.
* Natively pinned queries from the Azure Data Explorer web UI to Azure Data Explorer dashboards. There's no need to export data to another service.
* Optimized dashboard rendering performance. Your data is dynamically linked to the source, for quick rendering and data updates.