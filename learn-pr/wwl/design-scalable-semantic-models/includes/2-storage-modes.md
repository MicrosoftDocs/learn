Your first step is to connect to the necessary data sources when designing a semantic model. Ideally, the data should already be prepared **before integrating it into the semantic model**. Transforming data in the lakehouse or data warehouse ensures consistency and reduces extra processing in the model. 

## Choose a storage mode

Choosing the appropriate storage mode for your needs is crucial when designing a scalable semantic model. Depending on your data source, you can choose between *Import*, *DirectQuery*, *Direct Lake*, and *Composite model*.

- **Import mode** offers you the most options, design flexibility, and delivers fast performance.When possible, you should always choose Import mode. When you aren't able to use Import mode, there are other considerations to keep in mind for DirectQuery or Direct Lake modes.

- **DirectQuery** is best when your data source stores large volumes of data and/or your report needs to deliver near real-time data.

- **Direct Lake** is optimized for large volumes of data that can be quickly loaded into memory from Delta tables in a Microsoft Fabric lakehouse.

- **Composite models** can boost the query performance for DirectQuery and still deliver near real-time query results from an import model. Composite models combine data from more than one DirectQuery source or combine DirectQuery with import data.

:::image type="content" source="link" alt-text="storage mode options or maybe graphic":::
<!--- insert image with storage mode options and maybe graphic about what they are... --->

For our scenario, you have a lakehouse as your primary data source and also need to import .csv files to supplement the data. This means you need to understand best practices when connecting to imported data and how to configure Direct Lake features. We explore this guidance in the following sections.

> [!TIP]
>Learn more about [techniques to help reduce the data loaded into import models](/power-bi/guidance/import-modeling-data-reduction).

### DirectQuery mode

DirectQuery mode allows you to work with large data without importing it into the model. However, it requires careful management to ensure performance:

- **Set relationships to enforce integrity**: Use the Assume Referential Integrity property on relationships to enable INNER JOIN statements rather than OUTER JOIN.
- **Limit DAX calculation complexity**: Keep DAX measures simple to avoid added complexity at the source, which can lead to slow queries. Apply transformations as far upstream as possible.
- **Avoid relationships on calculated columns**: Don't create relationships on calculated columns.
- **Avoid relationships on Unique Identifier columns**: Don't create relationships on Unique Identifier columns.
- **Use dual storage mode**: Apply dual storage mode for dimensions related to fact tables that are in DirectQuery.

Refer to the [DirectQuery model guidance](/power-bi/guidance/directquery-model-guidance) for a complete list of considerations in developing DirectQuery models.

> [!NOTE]
> You can configure DirectQuery connections as *dual* storage mode, which allows tables with this setting can act as either cached or not cached, depending on the context of the query that's submitted to the semantic model. In some cases, you fulfill queries from cached data. In other cases, you fulfill queries by executing an on-demand query to the data source.

### Direct Lake mode

Direct Lake provides near real-time data directly from Fabric lakehouses, but you must first:

- **Ensure data access**: Configure Direct Lake to directly access ADLS storage through shortcuts, ensuring data is available without added latency.
- **Configure fallback behavior**: Set up Direct Lake to fallback to DirectQuery when a DAX query exceeds limits or uses unsupported features. Choose to allow, ensure no fallback, or always fallback to DirectQuery based on your needs.
- **Integrate with Fabric lakehouse/warehouse**: Ensure every table in the semantic model points to a table in a Fabric lakehouse or warehouse. Avoid blank tables with no columns.

For more information, review the [Direct Lake overview](/fabric/get-started/direct-lake-overview) documentation.

### Composite models

Composite models allow you to specify which visuals query back-end data sources or use the imported storage. Many-to-many relationships are also easier without the need for bridge tables. When using a composite model, consider the following best practices:

- **Resource allocation**: Ensure the back-end source has sufficient resources to handle queries efficiently.
- **Query optimization**: Minimize the number of literal values in source queries and aggregate data locally when possible.
- **Reduce cardinality**: Keep the cardinality of columns used in relationships low to avoid performance degradation.

For more information, review the [Composite model](/power-bi/transform-model/desktop-composite-models) documentation.
