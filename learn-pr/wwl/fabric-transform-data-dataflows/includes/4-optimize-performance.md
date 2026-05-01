Your transformations work. Now it's time to make them efficient. A dataflow that takes minutes instead of hours to refresh saves compute resources and keeps downstream consumers working with current data. Dataflow Gen2 includes the Modern Query Evaluator for improved performance, and supports techniques like query folding and preview-only steps to optimize refresh execution.

## Modern Query Evaluator

The Modern Query Evaluator delivers improved performance and reliability for Power Query transformations in Dataflow Gen2. This update provides better optimization across common shaping patterns, helping data teams reduce end-to-end refresh times and scale transformation workloads more confidently as data volumes grow.

The Modern Query Evaluator is enabled by default for all Dataflow Gen2 instances and provides:

- **Faster refreshes** for multi-step shaping pipelines involving joins, group-bys, type conversions, and complex expressions
- **More predictable execution** when scaling a single dataflow to larger datasets or higher-frequency schedules
- **Better resource utilization** through improved query optimization

You don't need to configure anything to benefit from the Modern Query Evaluator—it automatically processes your dataflow transformations with these performance improvements.

## Understand query folding

Query folding is the process of pushing transformation logic from Power Query to the data source for execution. Instead of downloading all the raw data and processing it in the Power Query engine, query folding translates your M steps into a native query language (like SQL) that the data source executes. The source then returns only the transformed results.

This approach is faster because:

- The data source typically has more compute resources and is optimized for query execution.
- Less data transfers over the network since filtering and aggregation happen before the data leaves the source.
- The Power Query engine does less processing, which reduces refresh time and resource consumption.

There are three possible outcomes when query folding is evaluated:

| Outcome | Description |
|---|---|
| **Full folding** | All transformations are pushed to the data source. The Power Query engine receives the final result with minimal processing. |
| **Partial folding** | Some transformations are pushed to the source, and the remaining steps run in the Power Query engine. |
| **No folding** | No transformations are pushed to the source. Power Query downloads the raw data and processes everything locally. |

Full folding is the ideal outcome for performance. Partial folding is acceptable when only a few lightweight steps run locally. No folding should be avoided for large datasets because it forces all data through the Power Query engine.

## Check if a step folds

You can check whether a specific step folds by right-clicking the step in the Applied Steps pane and looking for the **View Native Query** option.

- If the **View Native Query** option is available, the step folds to the data source.
- If the option is grayed out, that step and all following steps run in the Power Query engine-meaning the query **does not** fold.

Check folding regularly as you build your transformations. Knowing where folding breaks helps you restructure your steps to maximize what the source handles.

> [!NOTE]
> Query folding is primarily available with structured data sources like SQL databases and OData feeds. File-based sources like CSV and Excel generally don't support query folding.

## Apply folding-friendly patterns

Certain transformations fold reliably to most structured data sources, while others break folding. Understanding this distinction helps you order your steps for better performance.

**Transformations that typically fold:**

- Filter rows (WHERE clauses)
- Select or remove columns (SELECT specific columns)
- Sort rows (ORDER BY)
- Group by and aggregate (GROUP BY with SUM, COUNT, and similar functions)
- Merge queries from the same source (JOIN)
- Change data types (CAST)
- Rename columns (AS aliases)

**Transformations that typically break folding:**

- Add custom columns with complex M expressions
- Pivot and unpivot operations
- Merge queries from different data sources
- Operations using `Table.Buffer` force evaluation
- Some text transformations with M-specific functions

When folding breaks at a step, all subsequent steps also run in the Power Query engine. The order of your transformations is important to support query folding.

## Use preview-only steps for efficient iteration

Preview-only steps let you add transformation steps that run during data preview and authoring validation but are excluded from final execution during refresh. Preview-only steps help you iterate faster while keeping production refresh logic clean and efficient.

To mark a step as preview-only, right-click the step in the Applied Steps pane and select **Enable only in previews**. Common uses for preview-only steps include:

- **Speed up authoring** by sampling, filtering, or limiting rows during design-time without changing the production output
- **Safer experimentation** when testing new steps—keep exploratory logic out of scheduled refresh
- **Debug specific scenarios** by adding temporary filters to focus on problem rows

Preview-only steps are useful when working with large datasets where you want to see a representative sample during development, but need the full dataset in production.

## Follow performance best practices

Beyond query folding and the Modern Query Evaluator, several other practices help your dataflows run efficiently:

**Filter early.** Apply row filters as the first steps in your query. Reducing the number of rows early means every subsequent transformation processes less data.

**Select columns early.** Remove columns you don't need as soon as possible. Fewer columns mean less data to process and transfer.

**Disable unnecessary loads.** If a query only serves as a staging or reference query (for example, a lookup table used in a merge), right-click the query in the Queries pane and deselect **Enable load**. This feature prevents the staging query from loading to the destination, reducing processing time.

**Use staging dataflows.** For complex scenarios, separate extraction from transformation. Create one dataflow that extracts and stages raw data in a lakehouse. Create a second dataflow that reads from the staging lakehouse and applies transformations. This pattern offers several benefits:

- The extraction logic is independent and can refresh on its own schedule.
- Multiple transformation dataflows can reuse the same staged data.
- If a transformation fails, the raw data is still available for reprocessing.

**Parameterize for reuse.** Dataflow Gen2 supports two approaches for environment parameterization. **Public parameters** are available in standard Dataflow Gen2 and let you define reusable inputs (such as filter values or destination names) that can be overridden at runtime through a pipeline. **Fabric Variable Libraries** provide centralized, workspace-level configuration values that are referenced directly in the dataflow script. Fabric Variable Libraries require **Dataflow Gen2 with CI/CD**, a variant you enable at creation by selecting the Git integration option. Both approaches reduce configuration drift when promoting solutions across CI/CD environments.

**Monitor refresh performance.** Use the Monitoring Hub in Fabric and the refresh history on the dataflow to track how long your dataflows take to refresh. Look for trends that indicate growing datasets or inefficient transformations. Email alerts notify you when scheduled refreshes fail, so you can respond quickly and fix issues before they impact downstream consumers.

Following these practices helps your dataflows scale as data volumes grow, and keeps your transformed data fresh and available for downstream analytics and AI workloads.
