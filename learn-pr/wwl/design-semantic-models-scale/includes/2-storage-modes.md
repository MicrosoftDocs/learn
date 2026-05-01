The first design decision for any semantic model in Microsoft Fabric is how data flows into the model. The storage mode you choose affects query performance, data freshness, and which Fabric features are available. In Fabric, Direct Lake is the default, and for most workloads it's the right choice.

## Direct Lake mode

Direct Lake is the default storage mode for semantic models created in Microsoft Fabric. Unlike Import mode, Direct Lake doesn't copy data into the model. Unlike DirectQuery, it doesn't translate queries into source SQL. Instead, Direct Lake reads Delta tables directly from OneLake into memory, which combines the speed of Import with the freshness of DirectQuery.

When a user opens a report backed by a Direct Lake semantic model, the engine loads column data from Delta Parquet files on demand. You don't need to schedule a refresh, like you do with Import mode. When the underlying Delta tables update, the model reflects those changes.

Direct Lake models automatically enable the large semantic model storage format. This setting removes the 10-GB model size limit and is a prerequisite for both query scaleout and XMLA endpoint read/write access. You don't need to enable it manually for Direct Lake models.

### Direct Lake connection options

Direct Lake models can connect to data through two paths:

- **OneLake tables**: The model connects directly to Delta tables in a lakehouse or warehouse. This is the simplest path and works well when your data is in a single Fabric data store.
- **SQL analytics endpoint**: The model connects through the SQL endpoint of a lakehouse or warehouse. This path enables access to views, cross-database queries, and security features defined at the SQL layer.

Choose OneLake tables when your data is straightforward and lives in one place. Choose the SQL analytics endpoint when you need views, cross-source joins, or row-level security defined in SQL.

### Fallback behavior

Some operations can cause a Direct Lake model to fall back to DirectQuery mode. Complex DAX calculations, queries that exceed available memory, or certain unsupported operations trigger this fallback. When fallback occurs, the query runs against the SQL analytics endpoint rather than reading Delta files directly.

You can configure fallback behavior in the semantic model settings:

- **Allow fallback**: Queries that can't run in Direct Lake mode fall back to DirectQuery automatically. The user gets results, but performance might decrease.
- **Disallow fallback**: Queries that can't run in Direct Lake mode return an error. This option enforces consistent performance but requires that all queries stay within Direct Lake capabilities.

For most production workloads, start with fallback allowed and monitor which queries trigger it. Then optimize those queries or data structures to reduce fallback frequency over time.

## Import mode

Import mode copies data into the semantic model and stores it in a compressed, in-memory format. Queries run against the local copy, which makes Import the fastest storage mode for query performance. However, the data is only as current as the last refresh.

Import mode is the right choice when:

- Your data source is outside Fabric (on-premises databases, third-party APIs, flat files).
- Query performance is the top priority and near-real-time freshness isn't required.
- You need features that aren't yet supported in Direct Lake.

> [!TIP]
> When using Import mode, connect to views instead of raw tables, include only necessary columns, and use appropriate data types to reduce model size. Learn more about [techniques to reduce data loaded into Import models](/power-bi/guidance/import-modeling-data-reduction).

## DirectQuery mode

DirectQuery sends queries directly to the data source at query time. No data is stored in the model, which makes DirectQuery suitable for real-time data scenarios and very large datasets that can't be imported.

The tradeoff is performance. Every report interaction generates a query against the source system. DirectQuery works best when:

- Real-time data is required and even short refresh delays aren't acceptable.
- Source data volumes are too large to import, and the data source is outside Fabric.
- Governance requirements mandate that data stays at the source.

> [!TIP]
> For more information, see [DirectQuery model guidance](/power-bi/guidance/directquery-model-guidance).

## Composite mode

Composite mode combines storage modes within a single model. Some tables use Import, while others use DirectQuery or Direct Lake. This provides flexibility for scenarios where different tables have different performance and freshness needs.

For example, a large fact table might stay in Direct Lake while a small reference table from an external source uses Import. Composite mode also enables many-to-many relationships between tables from different data sources.

Use composite mode when:

- You need data from both Fabric and non-Fabric sources in the same model.
- Some tables require real-time data while others benefit from cached performance.
- You need to combine Direct Lake tables with Import tables for cross-source analysis.

## Choose the right storage mode

The following table summarizes when to choose each mode:

| Mode | Data location | Query speed | Data freshness | Best for |
|------|--------------|-------------|----------------|----------|
| **Direct Lake** | OneLake (Delta tables) | Fast | Near real-time | Fabric-native workloads (default) |
| **Import** | In-model cache | Fastest | Refresh-dependent | Non-Fabric sources, max performance |
| **DirectQuery** | Source system | Depends on source system | Near real-time | Real-time requirements, very large external data |
| **Composite** | Mixed | Varies | Mixed | Cross-source scenarios, hybrid requirements |

Storage mode also affects AI consumption. When Copilot or data agents query a semantic model, they return answers based on whatever data the model currently reflects. Direct Lake's near-real-time freshness means AI queries return current results without waiting for a scheduled refresh. For models that serve both human users and AI, storage mode choice directly affects the quality of both experiences.

In Fabric, start with Direct Lake. Move to another mode only when your specific scenario requires it.
