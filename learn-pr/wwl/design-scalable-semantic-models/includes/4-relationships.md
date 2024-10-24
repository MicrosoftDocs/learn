After choosing the model framework and transforming data, you need to create relationships to allow data to be filtered and aggregated based on data from another table. It’s common to create a star schema and enforce rules that filter dimension tables, allowing model relationships to efficiently apply those filters to fact tables.

## Create a star schema

In our scenario, we imported a dimension table from .csv that needs to connect to the lakehouse. You can create relationships to shape a *star schema* after the imported table is transformed.

In a star schema, *fact* tables and *dimension* tables work together to organize and analyze data. The fact table stores the main data about business activities, like sales or events, while the dimension tables provide context and descriptive information about those activities.

For example, if you have a sales fact table, it might store data like the amount sold and the date of each sale. The dimension tables would then provide additional details, such as customer information, product details, and time periods. By linking the fact table to the dimension tables, you can easily filter, group, and analyze the data.

:::image type="content" source="../media/model-frameworks-star-schema-design.png" alt-text="Graphic showing a fact table in the center and multiple dimension tables connected by relationships organized in a star-like shape with a star background to explain the reason behind the star schema name.":::

## Create Relationships

Creating relationships between fact and dimension tables is straightforward by identifying the related columns in each table and creating the relationship. In relational sources like databases or data warehouses, these columns are often known as *keys*. If key columns are absent, examine the tables to determine which columns to use for relationships.

Relationships come in different types:

- **One-to-Many** is the most common type, where one record in a table relates to multiple records in another.
- **One-to-Many** is the same as many-to-one, depending on which way the filter is configured between tables.
- **Many-to-Many** is less common but necessary for complex data. It allows multiple records in one table to relate to multiple records in another.

For many-to-many relationships, you might need to use a **bridge table**. A bridge table helps manage these relationships by linking the tables through intermediary keys. Composite models also assist with many-to-many relationships by allowing you to combine data from different sources.

### Filter direction

When you create a relationship, you configure which direction the data is filtered from one table to another. In a star schema, the direction typically goes from the dimension table to the fact table, allowing the dimension table to filter the fact table's results.

Bi-directional filters are also possible and sometimes used in one-to-one or many-to-many relationships. Before using a bi-directional filter, ensure your data and relationships are correctly configured. Be cautious, as bi-directional filters can negatively affect model query performance and potentially confuse report users.

**Referential integrity** ensures that relationships between tables remain consistent. It means that every value in a foreign key column must have a corresponding value in the primary key column of the related table.

Understanding filter direction and referential integrity is crucial for accurate data modeling. Filters only propagate if the relationship path is intact and follows the defined direction. These configurations ensure data consistency and integrity across your model.

### Inactive relationships

Relationships can be disabled and have their filter context modified by DAX functions. Sometimes, you need more than one relationship between tables, but only one can be active at a time between two tables. In such cases, use the `USERELATIONSHIP` function in DAX to reference inactive relationships to get the same filtering behavior. Here’s an example:

```DAX
CALCULATE(
    SUM(Sales[Amount]),
    USERELATIONSHIP(Sales[Date], Calendar[Date])
)
```

Using DAX functions for relationships is valuable because they allow you to create dynamic and flexible calculations that can adapt to different data scenarios. This flexibility enables you to handle complex data models and perform advanced analytics that would be difficult to achieve with static relationships alone.

## Use disconnected tables

It's unusual that a model table isn't related to another model table. Such a table in a valid model design is described as a disconnected table. A disconnected table isn't intended to propagate filters to other model tables. Instead, it accepts "user input" (perhaps with a slicer visual), allowing model calculations to use the input value in a meaningful way. For example, consider a disconnected table with a range of currency exchange rate values. When filtering by a single rate value, a measure expression can use that value to convert sales values.

The Power BI Desktop what-if parameter is a feature that creates a disconnected table. For more information, see [Create and use a What if parameter to visualize variables in Power BI Desktop](/power-bi/transform-model/desktop-what-if).
