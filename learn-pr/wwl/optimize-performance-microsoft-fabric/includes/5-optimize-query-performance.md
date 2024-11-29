Although Microsoft Fabric is a Software as a Service (SaaS) solution, it does require more than simply worrying about authentication and authorization. Microsoft provides several tools to assist you with both securing your information at the workspace and the item level. It also provides you with the ability to monitor and optimize how your data is being used by the system users.


## Item permissions

In contrast to workspace roles, which apply to all items within a workspace, you can use *item permissions* to grant access to individual warehouses. This enables you to share a single data warehouse for downstream consumption.

You can grant permissions to users via T-SQL or in the Fabric portal. Grant the following permissions to users who need to access your data warehouse:

- Read: Allows the user to CONNECT using the SQL connection string. 
- ReadData: Allows the user to read data from any table/view within the warehouse.
- ReadAll: Allows user to read data the raw parquet files in OneLake that can be consumed by Spark.

A user connection to the SQL analytics endpoint fails without Read permission at a minimum.

## Monitoring

Monitoring activities in your data warehouse is crucial to ensure optimal performance, efficient resource utilization, and security. It helps you identify issues, detect anomalies, and take action to keep the data warehouse running smoothly and securely.

You can use *dynamic management views* (DMVs) to monitor connection, session, and request status to see live SQL query lifecycle insights. With DMVs, you can get details like the number of active queries and identify which queries are running for an extended period and require termination.

There are currently three DMVs available to use in Fabric:

- sys.dm_exec_connections: Returns information about each connection established between the warehouse and the engine.
- sys.dm_exec_sessions: Returns information about each session authenticated between the item and engine.
- sys.dm_exec_requests: Returns information about each active request in a session.

### Query monitoring

Use 'sys.dm_exec_requests' to identify long-running queries that may be impacting the overall performance of the database. You can then take appropriate action to optimize or terminate those queries.

Start by identifying the queries that have been running for a long time. Use the following query to identify which queries have been running the longest, in descending order:

```sql
    SELECT request_id, session_id, start_time, total_elapsed_time
    FROM sys.dm_exec_requests
    WHERE status = 'running'
    ORDER BY total_elapsed_time DESC;
```

You can continue investigating to understand which user ran the session with the long-running query, by running:

```sql
    SELECT login_name
    FROM sys.dm_exec_sessions
    WHERE 'session_id' = 'SESSION_ID WITH LONG-RUNNING QUERY';
```

Finally, you can use the `KILL` command to terminate the session with the long-running query:

```sql
    KILL 'SESSION_ID WITH LONG-RUNNING QUERY';
```

> [!IMPORTANT]
> You must be a workspace Admin to run the `KILL` command. Workspace Admins can execute all three DMVs. Member, Contributor, and Viewer roles can see their own results within the warehouse, but cannot see other users' results.

## Understand Fabric's data warehouse experience

Fabric's *data warehouse* is a relational data warehouse that supports the full transactional T-SQL capabilities you'd expect from an enterprise data warehouse. It's a fully managed, scalable, and highly available data warehouse that can be used to store and query data in the Lakehouse. Using the data warehouse, you're fully in control of creating tables, loading, transforming, and querying data using either the Fabric portal or T-SQL commands. You can use SQL to query and analyze the data, or use Spark to process the data and create machine learning models.

Data warehouses in Fabric facilitate collaboration between data engineers and data analysts, working together in the same experience. Data engineers build a relational layer on top of data in the Lakehouse, where analysts can use T-SQL and Power BI to explore the data.

## Design a data warehouse

Like all relational databases, Fabric's data warehouse contains tables to store your data for analytics later. Most commonly, these tables are organized in a schema that is optimized for multidimensional modeling. In this approach, numerical data related to events (for example, sales orders) are grouped by different attributes (for example, date, customer, store). For instance, you can analyze the total amount paid for sales orders that occurred on a specific date or at a particular store.

### Tables in a data warehouse

Tables in a data warehouse are typically organized in a way that supports efficient and effective analysis of large amounts of data. This organization is often referred to as dimensional modeling, which involves structuring tables into fact tables and dimension tables.

**Fact tables** contain the numerical data that you want to analyze. Fact tables typically have a large number of rows and are the primary source of data for analysis. For example, a fact table might contain the total amount paid for sales orders that occurred on a specific date or at a particular store. This table is easily identified as it's relatively ***tall*** with many records or rows. It's also an optimal storage mechanism if it's a ***clean fact*** as it will only contain numeric values allowing for high compression rates.

**Dimension tables** contain descriptive information about the data in the fact tables. Dimension tables typically have a few rows and are used to provide context for the data in the fact tables. For example, a dimension table might contain information about the customers who placed sales orders. This type of table, when viewed in a model may appear wider and short, when compared to a fact table as it is only descriptive information. A date dimension table is a common example. Even with 10 years worth of data, we have roughly 3,652 rows, but we have every descriptive element of the individual day. If we need to get to a lower level of granularity, we can create an outrigger table, for instance, hours and minutes, to track events at an even more granular level.

In addition to attribute columns, a dimension table contains a unique key column that uniquely identifies each row in the table. In fact, it's common for a dimension table to include two key columns:

- A *surrogate key* is a unique identifier for each row in the dimension table. It's often an integer value that generated by the database management system when a new row is inserted into the table.
- An *alternate key* is often a natural or business key that identifies a specific instance of an entity in the transactional source system - such as a product code or a customer ID.

You need both surrogate and alternate keys in a data warehouse, because they serve different purposes. Surrogate keys are specific to the data warehouse and help to maintain consistency and accuracy in the data. Alternate keys on the other hand are specific to the source system and help to maintain traceability between the data warehouse and the source system.

#### Special types of dimension tables

Special types of dimensions provide more context and enable more comprehensive data analysis.

*Time dimensions* provide information about the time period in which an event occurred. This table enables data analysts to aggregate data over temporal intervals. For example, a time dimension might include columns for the year, quarter, month, and day in which a sales order was placed.

*Slowly changing dimensions* are dimension tables that track changes to dimension attributes over time, like changes to a customer's address or a product's price. They're significant in a data warehouse because they enable users to analyze and understand changes to data over time. Slowly changing dimensions ensure that data stays up-to-date and accurate, which is imperative to making good business decisions.

### Data warehouse schema designs

In most transactional databases that are used in business applications, the data is *normalized* to reduce duplication. In a data warehouse however, the dimension data is **denormalized** to reduce the number of joins required to query the data. It's also an optimal approach to data storage and removes the dependency upon the source system. For instance, if you're integrating multiple source systems, we assign **surrogate** keys which prevent collisions and potential corruption of data.

Often, a data warehouse is organized as a *star schema*, in which a fact table is directly related to the dimension tables, as shown in this example:

[ ![Image of a traditional star schema.](../media/star-schema.png)](../media/star-schema.png#lightbox)

You can use the attributes of something to group together numbers in the fact table at different levels. For example, you could find the total sales revenue for a whole region or just for one customer. The information for each level can be stored in the same dimension table.

> [!TIP]
> See [What is a star schema?](/power-bi/guidance/star-schema) for more information on designing star schemas for Fabric.

If there are lots of levels or some information shared by different things, it might make sense to use a *snowflake schema* instead. Here's an example:

[ ![Diagram of a snowflake schema design displaying multiple dimensions.](../media/snowflake-schema.png)](../media/snowflake-schema.png#lightbox)

In this case, the **DimProduct** table has been split up (normalized) to create separate dimension tables for product categories and suppliers.

- Each row in the **DimProduct** table contains key values for the corresponding rows in the **DimCategory** and **DimSupplier tables**.

A **DimGeography** table contains information on where customers and stores are located.

- Each row in the **DimCustomer** and **DimStore** tables contains a key value for the corresponding row in the **DimGeography** table.
