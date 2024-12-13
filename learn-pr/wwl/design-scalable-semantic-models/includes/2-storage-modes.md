When you design a scalable semantic model, selecting the appropriate storage mode is crucial. Depending on your data source, you have four options: *Import*, *DirectQuery*, *Direct Lake*, and *Composite model*. Each mode has its own advantages and considerations to ensure optimal performance and scalability.

### Import Mode

**Import** involves importing and storing data within Power BI, offering the most flexibility and fastest performance. However, it requires periodic refreshes to keep the data current, meaning the data is only as up-to-date as the last refresh.

Guidance for Import models also applies to the other storage modes. You should always choose Import, if your model allows. The primary goal is to reduce how much data you bring into the semantic model and how many transformations are performed within Power BI. Optimization tips include:

- Connect to views instead of tables when working with relational databases.
- Only include necessary tables, rows, and columns.
- Consider partitioning and incremental refresh to avoid loading unnecessary data.
- Use appropriate data types, such as integer for ID columns instead of string.
- Ensure query folding, which reduces the work done within the Power BI engine.

> [!TIP]
>Learn more about [techniques to help reduce the data loaded into import models](/power-bi/guidance/import-modeling-data-reduction).

### DirectQuery mode

**DirectQuery** allows you to query data directly from the source without storing it in Power BI, making it ideal for handling large volumes of data and near real-time data delivery. However, it has slower performance compared to Import Mode and offers limited modeling capabilities.

**Optimization Tips**:

- Avoid complex calculations at the source by simplifying Data Analysis Expressions (DAX).
- Apply dual storage mode for dimensions related to fact tables.
- Use the *Assume Referential Integrity* property on relationships.
- Avoid relationships on calculated and Unique Identifier columns.

> [!TIP]
> See the documentation for more [DirectQuery model guidance](/power-bi/guidance/directquery-model-guidance).

### Direct Lake mode

**Direct Lake** allows querying data directly from a Microsoft Fabric lakehouse or warehouse without storing it in a semantic model, making it ideal for handling large volumes of data. This mode is optimized for quickly loading data into memory from Delta tables in Microsoft Fabric. While it offers the advantage of quick access to large data volumes, it requires the setup of a lakehouse or warehouse, and Delta tables might need to be tuned for optimal performance.

**Optimization Tips**:

- Configure Direct Lake to access ADLS (Azure Data Lake Storage) storage through shortcuts.
- Set up fallback behavior to DirectQuery for complex DAX queries.

### Composite mode

**Composite Mode** mode can mix Import and DirectQuery modes, or integrate multiple DirectQuery data sources. This mode supports many-to-many relationships without the need for bridge tables. It offers the flexibility of querying and reporting capabilities by combining the benefits of both Import and DirectQuery modes. However, it requires periodic refreshes for Import mode tables and might have potential performance impacts when combining data from different sources.

**Optimization Tips**:

- Ensure the back-end source has sufficient resources.
- Minimize the number of literal values in source queries.
- Keep the cardinality of columns used in relationships low.

> [!TIP]
> See the documentation for more [Composite model guidance](/power-bi/guidance/composite-model-guidance).
