# data modeling best practices

Now that your data is connected in the semantic model, you need to transform and shape the data. For our scenario, we need to perform minimal transformations since we are connected to a curated lakehouse, which is ideal.

## Transform data

When designing your semantic models, there are several best practices when transforming the data to ensure your model is efficient, scalable, and easy to manage. The following guidance isn't meant to be exhaustive or applied without exception, but you should consider how and when you can use these techniques when designing scalable semantic models.

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

## Create a star schema

In our scenario, we imported a dimension table from .csv that needs to connect to the lakehouse. After the imported table has been transformed for the business need, you can create relationships to shape a *star schema*. Power BI works best with a star schema.

In a star schema, *fact* tables and *dimension* tables work together to organize and analyze data. The fact table stores the main data about business activities, like sales or events, while the dimension tables provide context and descriptive information about those activities.

For example, if you have a sales fact table, it might store data like the amount sold and the date of each sale. The dimension tables would then provide additional details, such as customer information, product details, and time periods. By linking the fact table to the dimension tables, you can easily filter, group, and analyze the data.

/choose-power-bi-model-framework/media/model-frameworks-star-schema-design.png

### Create relationships

It's easy to create relationships to connect fact and dimension tables. Identify which columns are related in each table and create the relationship. If you're working with data from relational sources, such as a database or data warehouse, you might know these columns as *keys*.

When you don't have key columns to connect your data, you need to examine the tables to determine which columns to create the relationships on.





> [!TIP]
> Review the [Optimization guide for Power BI](/power-bi/guidance/power-bi-optimization) for more ways to increase report performance.