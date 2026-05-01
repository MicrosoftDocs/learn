When multiple people create reports independently, the results are predictable: inconsistent connection settings, duplicated metric definitions, and no standard patterns. Reusable Power BI assets solve this problem by establishing shared foundations that enforce consistency across teams.

## Shared semantic models

A shared semantic model provides a single, centralized definition of business metrics, relationships, and calculations that multiple reports can consume. Instead of each report embedding its own model, reports connect to a shared semantic model through DirectQuery to a semantic model.

This core-plus-specialized pattern works well for organizations that need consistency without limiting flexibility. The core semantic model defines measures like revenue, cost, and margin. Specialized reports add their own visuals, filters, and other calculations without duplicating the underlying logic. With this pattern, you update it in one place and every connected report reflects the change immediately when the definition of "revenue" changes.

When you connect a report to an existing semantic model, select **Power BI semantic models** from the data source list in Power BI Desktop, then choose the published model. The report sends queries to the shared model at run time, so metric definitions stay consistent across every report that uses it.

> [!IMPORTANT]
> Shared semantic models create single sources of truth for business metrics. When AI agents query your data through Fabric IQ, endorsed shared models are the preferred data source because they provide consistent, validated definitions. Unmanaged, duplicated models create ambiguity for both human consumers and AI features.

## Power BI templates

A Power BI template (`.pbit`) captures the complete structure of an existing report without including data. The template preserves report pages, visuals, data model definitions, queries, and parameters. When someone opens a template, Power BI Desktop prompts for parameter values and data source credentials, then builds a fresh report from the saved structure.

Templates are useful when you have a standard report layout that applies to multiple scenarios. For example, a monthly sales report template lets each regional team generate their own report with the same visuals and measures, connected to their specific data source. A financial reporting template can include standardized KPI cards, trend charts, and table layouts that every department reuses.

To create a template, select **File** > **Export** > **Power BI template** in Power BI Desktop. Provide a description that explains the template's purpose, then save the `.pbit` file. Because templates exclude data, the file size is small and easy to distribute through a shared folder, a Teams channel, or a central repository.

Templates also support multiple parameter types. Text parameters handle server and database names. Boolean parameters control conditional logic in queries. Date parameters set default date ranges for the report. Well-designed parameters make a template flexible enough for different teams without requiring Power Query expertise.

> [!TIP]
> You can also create Power BI data source (`.pbids`) files that preserve only the connection information for a data source. When someone opens a `.pbids` file, Power BI Desktop launches with the connection preconfigured — they only need to authenticate. For more information, see [Create a Power BI data source file](/power-bi/connect-data/desktop-data-sources#using-pbids-files-to-get-data).

## Choose the right asset type

Each reusable asset type fits a different scenario. The following table summarizes when to use each approach:

| Asset type | Use when | Key benefit |
|---|---|---|
| Shared semantic model | Multiple reports need centralized metric definitions and relationships | Single source of truth for business logic |
| Report template (`.pbit`) | You need consistent report structure and layout across teams or regions | Standardizes visual design and query patterns |

Templates establish consistency at the development stage. Shared semantic models establish consistency at the consumption stage. In practice, you might use both together: a template that connects to a shared semantic model, giving teams standardized report structure backed by centralized business logic.

These reusable assets form the foundation of the **Develop** stage. Next, you add version control to track and manage changes as your team collaborates.
