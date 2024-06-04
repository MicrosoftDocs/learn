Dataflows can solve problems, but they can also create problems when implemented suboptimally.

## Best practices

Keep the following best practices in mind when planning your dataflow implementation:
- Bring in only data you need.
- Leverage [query folding](https://powerquery.microsoft.com/blog/introduction-to-practical-query-folding/). 
- [Endorse your dataflows](/power-bi/collaborate-share/service-endorsement-overview) as either promoted or certified to encourage use.
- Use [incremental refresh](/power-bi/connect-data/incremental-refresh-overview) to control partition processing.
- Use Power Automate for [trigger-based dataflow and dataset refresh](/power-query/dataflows/trigger-dataflows-and-power-bi-dataset-sequentially).
- [Review and optimize dataflow refresh](/power-bi/transform-model/dataflows/dataflows-understand-optimize-refresh) using refresh history and the CSV log.
- Use [dataflows in Power BI Premium](/power-bi/transform-model/dataflows/dataflows-premium-features?tabs=gen2) to take advantage of:
  - Enhanced compute engine.
  - DirectQuery.
  - Computed entities.
  - Linked entities.
  - Incremental refresh.
- Split things into multiple dataflows and [reuse dataflows cross multiple workspaces](/power-query/dataflows/best-practices-reusing-dataflows).


> [!TIP]
> For more detailed information, see [Dataflow best practices](/power-bi/transform-model/dataflows/dataflows-best-practices).

