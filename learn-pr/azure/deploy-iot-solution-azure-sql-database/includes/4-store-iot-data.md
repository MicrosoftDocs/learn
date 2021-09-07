IoT workloads can be characterized by high rates of input data, on both steady and burst streams, to be ingested from devices. 

Recall in the distributor scenario, your IoT solution will be taking in real-time telemetry data from thousands of trucks every second. Here, you'll learn how to implement a design pattern to ingest data and optimize storage of that data.

## Ingest millions of events per second with the shock absorber pattern

A common design pattern for systems, like the truck fleet example, involves a **landing zone** (or staging area) that is optimized for absorbing the shock of the high and spiky input rate. After, the data flows into its final destination (usually one or more tables) that instead is optimized for persistence and analysis. There are few knobs we can use to optimize our data models for these purposes. Different indexing approaches can be taken for different pieces of a database. For example, a light indexing approach better suits a higher ingestion rate, while a more comprehensive to approach favors query and retrieval. Azure SQL Database also provides specialized capabilities like in-memory OLTP tables and columnstore indexes that can be used together to implement what is often referred to as a **shock absorber** pattern for IoT solutions. Let's dive into the pattern you see below.

:::image type="content" source="../media/4-shock-absorber.svg" alt-text="Diagram of the shock absorber pattern for Azure SQL." border="false":::

### In-memory OLTP

By using in-memory OLTP tables (only available on Premium/Business Critical service tiers) as a landing zone for incoming streams of events and messages from IoT devices, you can largely eliminate latching and locking contention that can affect regular tables (subject to things like last page insert scenarios). In-memory OLTP tables avoid latch and lock contention, because they are optimized around the data being in-memory. Another benefit of this approach is the ability to reduce the overhead of transaction log operations by minimizing IOs for `SCHEMA_ONLY` tables (where the risk of losing some events in a failure is acceptable) or to reduce the impact of log updates for tables with schema and data persistence. By combining in-memory OLTP tables with natively compiled stored procedures, you can also improve the execution performance for all critical data management operations on ingested data.

A common solution architecture would likely include an event store, like Azure IoT Hub. In this case, events flow from devices, and an event processor pulls events from the store, using a memory-optimized table-valued parameter that batches hundreds or thousands of incoming events into a single data structure. This process would greatly reduce the number of database round trips. It could also improve throughput to up to millions of events per second.

### Columnstore indexes

With billions of events potentially ingested per day, the maximum in-memory OLTP table size (that is proportional to Azure SQL compute size utilized) could be reached. A common approach is to use those tables for the “hot” portion of the dataset (newly ingested data). Events can then be offloaded to disk-based tables, which are optimized for persistence and analytics. Using a time or data volume trigger, you can use a bulk loading process to store the data in a columnstore-based table.

A columnstore-based table contains data that's logically organized as a table with rows and columns, and physically stored in a column-wise data format. Bulk loading is the most performant way to move data into a columnstore index because it operates on batches of rows. Bulk loading fills rowgroups to maximum capacity and compresses them directly into the columnstore. Only rows that don't meet the minimum of 102,400 rows per rowgroup go to the deltastore. To perform a bulk load, often the [bcp Utility](/sql/tools/bcp-utility) is used.

:::image type="content" source="../media/4-columnstore.svg" alt-text="Diagram illustrating how columnstore works in Azure SQL." border="false":::

By selecting the right batch size (for example, between 102,400 and 1,048,576, depending on your events generation rate and logic) you can maximize efficiency. Appropriate batching eliminates the need to move new data rows into columnstore's delta rowgroup and wait for the Tuple Mover to compress them. Instead, batching allows you to go straight to a compressed rowgroup, which reduces logging and increases overall throughput by at least 10 times. Plus, you still achieve a similar level of data compression, which is important when you're dealing with hundreds of billions of events.

Once the  data is offloaded to a columnstore-based table, events can be efficiently analyzed with aggregations and time-series analytical workloads, without impacting the ingestion process. By adopting this design pattern for your IoT solutions, you can use a familiar relational engine environment while scaling to billions of events ingested per day and terabytes of compressed historical data stored.

## Optimize storage and retrieval for large volumes of IoT data

IoT solutions generally produce large data volumes. Whether you need to store data in raw formats, like JSON, to preserve and process the original information, or you can shred messages into more schematized/relational table structures, it is not uncommon that these solutions will have to deal with billions of events/messages and terabytes of data to manage. You will likely need to optimize your storage tier for costs, data volume, and performance.

Depending on your requirements, you can certainly think about persisting less-frequently accessed, raw data fragments in a less expensive storage layer like Azure Blob Storage. Then, you can process them with an analytical engine like Spark in Azure Synapse Analytics (in a canonical modern data warehouse or lambda architecture scenario). That solution works well for data transformations or non-interactive, batch analytics scenarios. However, if you need to frequently access and query both raw and structured data, you can use Azure SQL Database as a serving layer. This decision would simplify your solution architecture since both warm and cold data are persisted in the same store.

### Store raw data in the database

Azure SQL Database supports storing raw JSON messages as NVARCHAR(MAX) data types. These messages can be inserted into tables or provided as an argument in stored procedures using standard Transact-SQL (T-SQL). Any client-side language or library that works with string data in Azure SQL Database will also work with JSON data. Additionally, JSON can be stored in any table that supports the NVARCHAR type, which includes  memory-optimized or columnstore-based tables and does not introduce any constraints in the client-side code or in the database layer.

To optimize storage for large volumes of IoT data, you can use clustered columnstore indexes and their intrinsic data compression benefits to dramatically reduce storage needs. On text-based data, it’s not uncommon to get more than 20x compression ratio, depending on your data shape and form.

### Optimize JSON data retrieval from the database

Storing large amounts of data efficiently may not be enough, as you may struggle to extract great insights and analysis from that store. Azure SQL Database's battled-tested query processor and storage engine provides extra options to optimize the data access path.

Azure SQL Database provides full functionality and support for JSON data. With JSON functions in T-SQL, like `ISJSON`, `JSON_VALUE`, and `JSON_QUERY`, you can treat JSON data like any other SQL data type. You can extract values from the JSON test to use JSON data in the `SELECT` statement or in a search predicate. If your JSON structure happens to be stable and known upfront, the best option is to design your relational schema to accommodate the most relevant attributes from JSON data. You can then use `OPENJSON` to transform these attributes to row fields when inserting new data.

:::image type="content" source="../media/4-json-data-support.svg" alt-text="Diagram illustrating how JSON is supported with T-SQL." border="false":::

The result is fully relational columns (with optimized SQL data types) that can be used for retrieval and analytical purposes, including complex filtering and aggregations. This data will be properly indexed to support various access paths. You can additionally decide to keep the entire JSON fragment and store it in a NVARCHAR(MAX) field in the same table if further processing may be needed.

Since columnstore-based tables are optimized for scans and aggregations rather than key lookup queries, you can also create computed columns based on JSON functions that are exposed as regular relational columns within the original JSON column, simplifying query design and development. You can further optimize data retrieval of critical queries and access paths by creating regular (row-based) nonclustered indexes on computed columns. While these indexes will slightly increase your overall storage needs, they will help the query processor filter rows on key lookups and range scans. These indexes will also help with other operations like aggregations.

You can add computed columns and related indexes at any time, so in the distributor scenario, or any other scenario, you should test to find the right balance for your solution.

### Optimize data retrieval and analytics with replicas in Azure SQL Database

Depending on your workload requirements, it may be beneficial to separate your read and write workloads with secondary replicas in Azure SQL Database. There are several different options:

- **Geo-replication** allows you to create readable secondary databases in the same or different region.
- **Auto-failover group** allows you to manage the replication and failover of a group of databases on a server to another region. The secondary group of databases in the failover group can be used for read-only purposes.
- **Business critical** is a service tier in Azure SQL Database that includes one free, readable replica
- **Hyperscale** is a service tier in Azure SQL Database that supports geo-replication (currently in preview and limited to a single geo-replicated database), 0-4 High Availability (HA) replicas that can be used for read-only workloads, and 0-30 Named replicas (read-only) (currently in preview) that can have different names, authentication, authorization, and compute sizes than the primary. For the most up-to-date status on the preview and details, refer to the [documentation](/azure/azure-sql/database/service-tier-hyperscale-replicas).

Regardless of the option you select, you can use replicas to scale out IoT data consumers without impacting the ingestion process. These replicas can support read workloads like alerting, dashboards, analytics, and machine learning.

:::image type="content" source="../media/4-read-scale.svg" alt-text="Diagram illustrating how replicas can support read workloads." border="false":::

## Manage large IoT data stores with Azure SQL Database

There are a few other things you should keep in mind when it comes to managing such large IoT stores with Azure SQL Database: partitioning, data compression, and index maintenance. Let's start with some tips for table partitioning:

- Partition (aligned!) event tables and indexes based on the desired time granularity. Depending on your retention policies, this granularity could be daily, weekly, monthly, etc.
- Avoid thousands of partitions as they can be ineffective on both management and operations.
- Automate the implementation of sliding window strategies by dropping older time periods and creating new tables. As an alternative, you can create multiple tables that represent time periods (for example, Q1-Q2). You can reduce concurrency issues by creating aggregated views for consumers.

As for data compression, columnstore native compression can easily provide 25x reduction for IoT events. Additionally, for scenarios where columnstore is not a great solution (for example, tables with many `UPSERT` operations), use page compression on row store tables.

Finally, avoid rebuilding and reorganizing indexes for scenarios where the event data is mostly static.
