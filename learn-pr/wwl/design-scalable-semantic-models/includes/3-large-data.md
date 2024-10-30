When working with very large data sources, you need a different data loading strategy. In this unit, we explain how to enable large semantic model storage formatting and how to configure incremental refresh. These features allow large semantic models to refresh at a more manageable rate and size.

## Large semantic model storage formats

The *large semantic model storage format* in Microsoft Fabric allows you to handle bigger data sources efficiently. This format is ideal for complex analytical models that require more memory and processing power. This feature allows your semantic model to grow beyond the 10-GB limit. Your limit might vary because the capacity or Fabric admin determines the large semantic model limit. To enable this feature, it's as easy as selecting a box in the workspace settings.

If your semantic model continues growing larger and progressively consumes more memory, be sure to configure Incremental refresh.

> [!TIP]
> See the documentation to learn more about [Large semantic models](/power-bi/enterprise/service-premium-large-models).

## Incremental refresh

Incremental refresh allows you to refresh only the data that has changed or been added since the last refresh. This feature reduces the time and resources required for data refreshes, making it ideal for frequently updated large data sources.

Suppose your sales table is incredibly large and takes a long time to refresh the semantic model. If you need to keep the data up-to-date, then you can configure Incremental refresh to only refreshing the new and updated transactions.

To enable incremental refresh, you first need to define parameters and filter the row using the parameters in Power Query. Once applied, you configure the Incremental refresh policy on the table in Power BI Desktop. You can optionally configure the table to get the latest data with DirectQuery. To take advantage of this feature, your semantic model must be published to a supported Fabric workspace.

> [!TIP]
> See the documentation to learn more about [Incremental refresh for semantic models](/power-bi/connect-data/incremental-refresh-overview).

## Partitioning

Incremental refresh focuses on refreshing only the changed or new data, whereas partitioning involves dividing the entire table into smaller segments. Partitioning involves dividing a large table into smaller, more manageable pieces called partitions. Each partition can be processed independently, which can improve query performance and manageability.

For example, you could create partitions for each month or quarter on your sales table, allowing queries to target specific partitions rather than the entire dataset.

To enable partitioning, you can use tools like SQL Server Management Studio (SSMS) or Tabular Editor.

> [!TIP]
> See the documentation to learn more about partitioning for [Advanced incremental refresh with the XMLA endpoint](/power-bi/connect-data/incremental-refresh-xmla).
