# Connect to data

Scalability in this context refers to building semantic models that can handle growth in the volume of data. A model that ingests thousands of rows of data might grow to millions of rows over time, and the model must be designed to accommodate such growth. It's important to consider that your data will grow and/or change, which increases complexity.

Designing your semantic models with scalability in mind should include:

- **Flexibility**: Accommodating changes and increases in data volume with acceptable report performance.
- **Reduced complexity**: Ensuring models are less complex and easier to manage.

Another key element is to do as much data preparation work as possible **before bringing it into the semantic model**. For example, if you have the opportunity to transform data in the lakehouse or data warehouse, that's where it should be done. Transformation at the source produces consistency for any other solutions built on that data and ensures that your model doesn't need to do any extra processing.

## Standard best practices

When designing your semantic models, there are several best practices that apply regardless of the storage mode. These practices help ensure that your models are efficient, scalable, and easy to manage:

- **Only bring in necessary data**: Remove unnecessary rows and columns, and only process what is needed for the business requirements.
- **Avoid wide tables**: Design a star schema with fact and dimension tables for better performance.
- **Pre-aggregate data**: Aggregate data before loading it into the model whenever possible.
- **Reduce calculated columns**: Perform data transformations requiring additional columns as close to the source as possible.
- **Avoid high cardinality columns**: Break datetime columns into separate date and time columns if needed.
- **Use appropriate data types**: Use integers instead of strings for ID columns and consider surrogate keys if necessary.
- **Limit bi-directional filters**: Minimize the use of bi-directional filters on relationships.
- **Disable auto date/time**: Connect to a date table at the source or create your own date table.
- **Disable attribute hierarchies**: Turn off attribute hierarchies for non-attribute columns.
- **Query database views**: Use views rather than tables when querying a relational database to manage columns and push transformations closer to the source.
- **Ensure query folding**: Check that query folding is achieved, and if not, work with the data engineer to move transformations upstream.
- **Consider partitioning and incremental refresh**: Avoid loading unnecessary data by using partitioning and incremental refresh.

> [!TIP]
>Learn more about [techniques to help reduce the data loaded into import models](/power-bi/guidance/import-modeling-data-reduction).

## Choose a storage mode

Choosing the correct semantic model framework is at the heart of building any scalable solution. Depending on the storage mode, there may be additional guidance. When possible, you should always choose Import mode. When you aren't able to use Import mode, there are other considerations to keep in mind for DirectQuery or Direct Lake modes.

### DirectQuery mode

DirectQuery mode allows you to work with large datasets without importing them into the model. However, it requires careful management to ensure performance:

- **Set relationships to enforce integrity**: Use the Assume Referential Integrity property on relationships to enable INNER JOIN statements rather than OUTER JOIN.
- **Limit DAX calculation complexity**: Keep DAX measures simple to avoid added complexity at the source, which can lead to slow queries. Apply transformations as far upstream as possible.
- **Avoid relationships on calculated columns**: Don't create relationships on calculated columns.
- **Avoid relationships on Unique Identifier columns**: Don't create relationships on Unique Identifier columns.
- **Use dual storage mode**: Apply dual storage mode for dimensions related to fact tables that are in DirectQuery.

> [!NOTE]
> Refer to the [DirectQuery model guidance](/power-bi/guidance/directquery-model-guidance) for a complete list of considerations in developing DirectQuery models.

### Direct Lake mode

Direct Lake mode is optimized for large volumes of data that can be quickly loaded into memory from Delta tables. When using Direct Lake mode, keep the following in mind:

- **Ensure data access**: Configure Direct Lake to directly access ADLS storage through shortcuts, ensuring data is available without added latency.
- **Configure fallback behavior**: Set up Direct Lake to fallback to DirectQuery when a DAX query exceeds limits or uses unsupported features. Choose to allow, ensure no fallback, or always fallback to DirectQuery based on your needs.
- **Integrate with Fabric lakehouse/warehouse**: Ensure every table in the semantic model points to a table in a Fabric lakehouse or warehouse. Avoid blank tables with no columns.

For more information, review the [Direct Lake overview](/fabric/get-started/direct-lake-overview) documentation.
