Woodgrove Bank has provided you with data loading requirements that dictate using several different ingestion methods. Individual transaction events arrive from the contactless-payments application rapidly throughout the day and must be inserted as quickly as possible. The bank also provided CSV files containing historical transaction events and user data that must be bulk loaded into the database as efficiently as possible. In addition, they asked for a couple of new tables to be populated from their historical data once loaded.

In Azure Cosmos DB for PostgreSQL, there are multiple approaches you can use to ingest data efficiently into a distributed database. Loading data into distributed tables is accomplished in the same manner as when loading data into non-distributed tables. The primary difference is that you must provide a value for the table's assigned [_distribution column_](/azure/postgresql/hyperscale/howto-choose-distribution-column) for every row being inserted.

Each row in a distributed table is written to a [shard](/azure/postgresql/hyperscale/concepts-nodes#shards) based on the value of its distribution column. To correctly identify the shard into which data should be inserted, the coordinator hashes the row's distribution column. The coordinator then compares the hashed value to the assigned hash range for each shard. Once the correct shard is identified, the coordinator routes the query to it, where the remote insert command is executed on all replicas of that shard.

## Load individual rows using the INSERT command

Woodgrove Bank requires the ability to insert individual transaction records into the database when they're received from the contactless payments app. To insert individual rows into distributed tables, you can use the standard PostgreSQL [INSERT](http://www.postgresql.org/docs/current/static/sql-insert.html) command. Distributed tables appear as standard tables to SQL, but how the queries are executed differs because the underlying tables are horizontally partitioned across worker nodes.

To ensure the coordinator can accurately relay queries to the correct shards, you must specify a value for the _distribution column_ when loading data into distributed tables. In other words, each INSERT statement needs to include a non-null value for the row's distribution column.

You can find a table's assigned distribution column using the [distributed tables view](/azure/postgresql/hyperscale/reference-metadata#distributed-tables-view) on the coordinator node. For example, running the query `SELECT distribution_column FROM citus_tables WHERE table_name = 'payment_events'::regclass;` reveals the distribution column for the `payment_events` table is the `user_id` field.

In the below example, two transactions are being added to the `payment_events` table in Woodgrove Bank's database using individual INSERT commands.

```sql
/*
-- Table schema, for reference
CREATE TABLE payment_events
(
  event_id bigint,
  event_type text,
  user_id bigint,
  merchant_id bigint,
  event_details jsonb,
  created_at timestamp
);
*/

INSERT INTO payment_events VALUES (4951447424,'SendFunds',1159138,4951447330,'{"code": 4951447330, "particulars": "twofactorauth", "reference": "2factorauth"}','1/12/16 5:22');

INSERT INTO payment_events VALUES (4951447488,'RequestFunds',1171503,4951447340,'{"code": 4951447340, "particulars": "vue", "reference": "vuejs"}','1/12/16 5:22');
```

Because each row contains a valid value for the `user_id` column, the two rows are successfully inserted into the `payment_events` table. Now, look at what happens if you attempt to insert a row where the value of the distribution column is `null`:

```sql
INSERT INTO payment_events VALUES (4951447499,'GiftFunds',null,4951447350,'{"code": 4951447350, "particulars": "twofactorauth", "reference": "2factorauth"}','1/12/16 5:22');
```

This `INSERT` statement results in an error:

```output
ERROR: cannot perform an INSERT with NULL in the partition column
```

When executing the `INSERT` command to add data to a distributed table, it's essential to remember that the _distribution column_ must be specified. Doing so enables the coordinator to determine which shard it should add the row to in the cluster.

### Combine INSERT statements to improve efficiency

Through your experience with Woodgrove Bank's contactless payment app, you know that they receive a high number of transactions, many of which arrive concurrently throughout the day. A technique you can use to improve the efficiency of inserting individual rows is to process transactions in batches, combining multiple insert statements into a single statement containing numerous rows. This approach eliminates the need to make repeated database queries. For example, you can insert multiple transaction rows all at once like this:

```sql
INSERT INTO payment_events VALUES 
  (4951447425,'GiftFunds',1159138,4951447350,'{"code": 4951447350, "particulars": "twofactorauth", "reference": "2factorauth"}','1/12/16 5:22'),
  (4951447489,'SendFunds',1171503,4951447360,'{"code": 4951447360, "particulars": "vue", "reference": "vuejs"}','1/12/16 5:22'),
  (4961447699,'RequestFunds',1171503,4951447370,'{"code": 4951447370, "reference": "Lombiq", "particulars": "Orchard-User-Notifications"}','1/12/16 5:22');
```

## Bulk load data with the COPY command

When you need higher ingestion rates, the [`COPY` command](https://www.postgresql.org/docs/current/app-psql.html#APP-PSQL-META-COMMANDS-COPY) allows you to bulk load data. You can use the `COPY` command to load data directly into distributed tables from an application using the `FROM STDIN` option, files, and other sources. When you use the `COPY` command to write data into distributed tables, it asynchronously copies data to worker nodes using a parallel connection for each shard placement. The coordinator routes data to the appropriate worker nodes, allowing data to be ingested using multiple workers and cores in parallel.

Woodgrove Bank requested you provide a mechanism for bulk loading their historical data. The data they provided is stored in comma-separated value (CSV) files. The following commands show how you can download the `events.csv` file onto the coordinator node, and then bulk load the file data into the `payment_events` table:

```sql
-- Download the events.csv file
\! curl -O https://raw.githubusercontent.com/MicrosoftDocs/mslearn-create-connect-postgresHyperscale/main/events.csv

-- Bulk load the data from the file into the payment_events table
\COPY payment_events FROM 'events.csv' WITH (format CSV)
```

You can also combine the above statements into a single command using the `FROM PROGRAM` clause to inform the coordinator to retrieve the data files from an application running on the coordinator. In this case, you instruct the coordinator to use the `curl` application to download a file from the specified URL. The `WITH CSV` option provides information about the format of the file being ingested.

```sql
\COPY payment_events FROM PROGRAM 'curl https://raw.githubusercontent.com/MicrosoftDocs/mslearn-create-connect-postgresHyperscale/main/events.csv' WITH CSV
```

The `COPY` command provides a practical and fast way of loading data directly from files. Note, however, that when targeting a distributed table, each row in the source file must contain a value for the distribution column.

### Load data from files in blob storage using the pg_azure_storage extension

An alternative method for bulk loading file data is to use the `pg_azure_storage` extension. `pg_azure_storage` is a new PostgreSQL extension developed by Microsoft that allows you to work with and bulk load data stored in files hosted in [Azure Blob Storage](https://azure.microsoft.com/services/storage/blobs/#overview).

Files need to be added or [migrated to an Azure Storage account](/azure/storage/common/storage-use-azcopy-migrate-on-premises-data) before you can take advantage of this extension's features. Moving files into Azure Blob Storage allows you to use a cloud-native, secure storage service.

To get started, you need to load the extension:

```sql
-- Install the extension in the database
SELECT create_extension('azure_storage');
```

The `pg_azure_storage` extension includes the `account_add()` method. This method connects a storage account to your database and enables access to the files within the account. To connect, you must provide the storage account name and access key by using the following syntax:

```sql
-- Provide the storage account credentials
SELECT azure_storage.account_add('{STORAGE_ACCOUNT_NAME}', '{STORAGE_ACCOUNT_ACCESS_KEY}');
```

Providing an access key is only required when working with data in containers with a "Private (no anonymous access)" access level. Suppose you wish to pull data from a container whose access level is set to "Container (anonymous read access for containers and blobs)." In that case, you can ingest files from Azure Blob Storage using their public URLs and enumerate container contents without configuring the account key in the `pg_azure_storage` extension.

For example, you created a storage account named `stlearnpostgresql` for Woodgrove Bank and added a couple of files into a private container named `historical-data`. To provide access to that account from your database, you need to run the following query, providing the storage account access key you retrieved from the Storage Account's **Access keys** page in the Azure portal:

```sql
SELECT azure_storage.account_add('stlearnpostgresql', '4zzZGx4sUk8TBVnHnoPYt0G7A3w9/DJJBCfdxeeb+VDrR8P3bSwWA3lYsTvO1HwYzrt4XQ37iIEL+AStWuQ/uA==');
```

Now that you're connected to the storage account, you can list the blobs within a named container. To view the files in the `historical-data` container, run the following query:

```sql
SELECT path, content_type, pg_size_pretty(bytes)
FROM azure_storage.blob_list('stlearnpostgresql', 'historical-data');
```

The `blob_list()` function outputs all of the blobs within the container you specified:

```output
    path    | content_type | pg_size_pretty 
------------+--------------+----------------
 events.csv | text/csv     | 17 MB
 users.csv  | text/csv     | 29 MB
```

Woodgrove Bank provided you with the column list for data in the `users.csv` file, based on the following table schema:

```sql
/*
-- Table structure and distribution details provided for reference
CREATE TABLE payment_users
(
    user_id bigint PRIMARY KEY,
    url text,
    login text,
    avatar_url text
);

SELECT created_distributed_table('payment_users', 'user_id');
*/
```

They also informed you that the CSV file doesn't contain a header row.

Suppose you hadn't been provided with details about the data within the file. In that case, you can use the Azure portal to preview files smaller than 2.1 MB, or you can download a copy of the file and quickly open it to explore the structure of the file.

Now that you understand the data contained in the file, you can fulfill Woodgrove Bank's request to bulk load historical data from files. To bulk load data from files in blob storage, `pg_azure_storage` extends the native PostgreSQL `COPY` command to make it capable of handling Azure Blob Storage resource URLs. This feature is enabled by default, and you can manage it by using the `azure_storage.enable_copy_command` setting. Using the extended `COPY` command, run the following command to ingest user data into the `payment_users` table:

```sql
-- Bulk load data from the user.csv file in Blob Storage into the payment_users table
COPY payment_users FROM 'https://stlearnpostgresql.blob.core.windows.net/historical-data/users.csv';
```

The output from the `COPY` command will specify the number of rows copied into the table, such as `COPY 264197`.

To learn more about the `pg_azure_storage` extension, read the documentation and complete the [Extend the functionality of Azure Cosmos DB for PostgreSQL using extensions](/training/modules/extend-the-functionality-of-azure-cosmos-db-for-postgresql-using-extensions/) module.

## Populate tables using the FROM SELECT Clause

As part of bulk loading Woodgrove Bank's historical data, they requested that you create a couple of new tables from their existing data. First, they want an aggregate table containing the count of events by type per user, which they'll use to populate a dashboard. Second, they would like you to extract unique merchant records from the `payment_events` table into a new merchants table for future analysis of merchant activity.

They provided you with the following schemas for the new tables but have asked you to handle setting up table distribution and writing the queries required to load data into the tables.

```sql
CREATE TABLE user_events
(
  user_id bigint,
  user_login text,
  event_type text,
  event_count bigint
);

CREATE TABLE payment_merchants
(
  merchant_id bigint PRIMARY KEY,
  name text,
  url text
);
```

Loading data into distributed tables from other tables can be accomplished using the results of a `SELECT` query using `INSERT … SELECT` statements. As with executing standard `INSERT` statements, the results of the `SELECT` query must include values for the distribution column for each row.

This method also allows you to use the [`ON CONFLICT DO UPDATE` clause](https://www.postgresql.org/docs/current/sql-insert.html#SQL-ON-CONFLICT) to direct the `INSERT` statement to perform an "UPSERT," updating an existing row that conflicts with the row proposed for insertion. UPSERTs provide the easiest way to calculate and save aggregates ahead of time, known as [distributed rollups](https://docs.citusdata.com/en/stable/develop/reference_dml.html#rollups).

### Using colocated source and destination tables

The data required for populating the `user_events` table is contained in the `payment_events` and `payment_users` tables. The most efficient distribution column based on the proposed table schema will be the same field used by the `payment_events` and `payment_users` tables, `user_id`, because that column best meets the [four criteria for choosing an ideal distribution column](/azure/postgresql/hyperscale/howto-choose-distribution-column#general-tips).

```sql
SELECT create_distributed_table('user_events', 'user_id');
```

With the `user_events` table now distributed, the two source tables and the destination table are implicitly colocated because they share the same distribution column. You came up with the following query for loading the table, but you want to verify that query will route the `INSERT ... SELECT` statement down to worker nodes to be executed in parallel.

```sql
INSERT INTO user_events
SELECT e.user_id, login, event_type, COUNT(event_id)
FROM payment_events AS e
INNER JOIN payment_users AS u on e.user_id = u.user_id
GROUP BY e.user_id, login, event_type;
```

Before executing the query, you can use the [`EXPLAIN`](https://www.postgresql.org/docs/current/sql-explain.html) statement to view the execution plan.

```output
Custom Scan (Citus Adaptive)  (cost=0.00..0.00 rows=0 width=0)
  Task Count: 32
  Tasks Shown: One of 32
  ->  Task
        Node: host=private-w0.learn-cosmosdb-postgresql.postgres.database.azure.com port=5432 dbname=citus
        ->  Insert on user_events_102394 citus_table_alias  (cost=530.35..619.99 rows=0 width=0)
              ->  HashAggregate  (cost=530.35..575.17 rows=4482 width=37)
                    Group Key: e.user_id, u.login, e.event_type
                    ->  Hash Join  (cost=334.93..485.53 rows=4482 width=37)
                          Hash Cond: (e.user_id = u.user_id)
                          ->  Seq Scan on payment_events_102232 e  (cost=0.00..138.82 rows=4482 width=27)
                                Filter: (user_id IS NOT NULL)
                          ->  Hash  (cost=231.08..231.08 rows=8308 width=18)
                                ->  Seq Scan on payment_users_102264 u  (cost=0.00..231.08 rows=8308 width=18)
```

The `Custom Scan (Citus Adaptive)  (cost=0.00..0.00 rows=0 width=0)` and `Task Count: 32` lines show that the query will be executed in parallel on each of the 32 shards. Running the query populates the new table, and you can run the following to view the results:

```sql
SELECT * FROM user_events ORDER BY user_id LIMIT 5;
```

```output
 user_id | user_login |  event_type   | event_count 
---------+------------+---------------+-------------
      45 | mojodna    | RequestFunds  |           2
      45 | mojodna    | RequestFunds  |           2
      87 | tmornini   | IssuesEvent   |           1
      87 | tmornini   | DisputeCharge |           1
      87 | tmornini   | DisputeCharge |           1
```

When the `SELECT` and `INSERT` statements include tables with the same distribution column, and the distribution column appears in both the `INSERT` and `SELECT` statements, the coordinator will route the `INSERT ... SELECT` statement down to the worker nodes for parallel execution. This technique is the most performant and recommended approach when possible.

### Pulling data to the coordinator

Extracting the distinct merchant IDs in the `payment_events` table into the proposed merchant table won't allow the same distribution column to be shared between the two tables. The schema provided for the `payment_merchants` table doesn't contain the `user_id` column, so you must choose the best column available, `merchant_id`.

You write the following query to handle the population of the `payment_merchants` table:

```sql
INSERT INTO payment_merchants SELECT DISTINCT merchant_id, CONCAT('merchant', '_', merchant_id), CONCAT('https://api.woodgrove.com/merchants/', merchant_id) FROM payment_events;
```

Knowing the tables don't share the same distribution column and aren't colocated, you want to understand better how the query will be executed before running it, so you again use the [`EXPLAIN`](https://www.postgresql.org/docs/current/sql-explain.html) statement to view the query-execution plan.

```output
Custom Scan (Citus INSERT ... SELECT)  (cost=0.00..0.00 rows=0 width=0)
  INSERT/SELECT method: pull to coordinator
  ->  HashAggregate  (cost=750.00..752.00 rows=200 width=72)
        Output: remote_scan.merchant_id, remote_scan.name, remote_scan.url
        Group Key: remote_scan.merchant_id, remote_scan.name, remote_scan.url
        ->  Custom Scan (Citus Adaptive)  (cost=0.00..0.00 rows=100000 width=72)
              Output: remote_scan.merchant_id, remote_scan.name, remote_scan.url
              Task Count: 32
              Tasks Shown: One of 32
              ->  Task
                    Query: SELECT DISTINCT merchant_id, concat('merchant', '_', merchant_id) AS name, concat('https://api.woodgrove.com/merchants/', merchant_id) AS url FROM public.payment_events_102040 payment_events WHERE true
                    Node: host=private-w0.learn-cosmosdb-postgresql.postgres.database.azure.com port=5432 dbname=citus
                    ->  HashAggregate  (cost=194.84..221.80 rows=1797 width=72)
                          Output: merchant_id, (concat('merchant', '_', merchant_id)), (concat('https://api.woodgrove.com/merchants/', merchant_id))
                          Group Key: payment_events.merchant_id, concat('merchant', '_', payment_events.merchant_id), concat('https://api.woodgrove.com/merchants/', payment_events.merchant_id)
                          ->  Seq Scan on public.payment_events_102040 payment_events  (cost=0.00..161.23 rows=4482 width=72)
                                Output: merchant_id, concat('merchant', '_', merchant_id), concat('https://api.woodgrove.com/merchants/', merchant_id)
```

The `INSERT/SELECT method` line reveals the `pull to coordinator` method will be used to execute this query. When the source and destination tables aren't colocated, and [repartition optimization](https://docs.citusdata.com/en/stable/develop/reference_sql.html#repartition-joins) isn't possible, the coordinator will retrieve results from `SELECT` queries executed on each worker node and pull the data up to run the query locally. The coordinator then uses the distribution column to route rows back down to the worker nodes for insertion into the appropriate shard. This method is the least efficient of the three techniques, because all the data is forced to pass through a single node, and processing can't be parallelized across workers.

Given the data ingestion method required to load this table is the least efficient technique, and knowing that the table will be frequently joined with the `payment_events` table for analytical queries, it's a good idea to reevaluate how the table is distributed.

After considering the options and Woodgrove Bank's common query patterns, you decide the `payment_merchants` table would be better defined as a [reference table](/azure/postgresql/hyperscale/concepts-nodes#type-2-reference-tables). Change a distributed table to a reference table involves running the `undistribution_table()` function against the table and then redefining it as a reference table, as follows:

```sql
SELECT create_reference_table('payment_merchants');
```

As a reference table, the entire contents of the `payment_merchants` table are concentrated in a single shard, which is then replicated on every worker.

Running `EXPLAIN` on the `INSERT ... SELECT` statement after converting the table to a reference table shows that loading the data will still be accomplished using the `pull to coordinator` method. As such, this change won't provide performance benefits during data ingestion. However, it will affect future queries, such as joins between the `payment_merchants` and `payment_events` tables.

## Ingest data using Azure services

In addition to ingesting data using SQL commands and PostgreSQL extensions, you can also apply other Azure services to load data into your database.

### Azure Data Factory

[Azure Data Factory](/azure/data-factory/introduction) (ADF) is a cloud-based data integration service that offers a code-free visual environment for orchestrating and automating data movement. You can use ADF to [copy data from more than 85 possible sources into Azure Cosmos DB for PostgreSQL](/azure/postgresql/hyperscale/howto-ingest-azure-data-factory).

Woodgrove Bank's requirements asked for a mechanism for performing a one-time bulk load of their historical data. ADF is another alternative solution that could be considered, but this solution is more appropriate if there's a requirement for recurring, repeatable data movement and orchestration pipelines.

### Azure Stream Analytics

Azure Cosmos DB for PostgreSQL shines at handling high throughput, real-time workloads, such as hosting [IoT](/azure/postgresql/hyperscale/quickstart-build-scalable-apps-model-high-throughput) device input. [Azure Stream Analytics](https://azure.microsoft.com/services/stream-analytics/#features) (ASA) can act as a no-code, performant and scalable mechanism for [inserting data into Azure Cosmos DB for PostgreSQL](/azure/postgresql/hyperscale/howto-ingest-azure-stream-analytics).

This ingestion method isn't necessary given Woodgrove Bank's current requirements, but it would be helpful if they decided to start ingesting data from devices such as ATMs.
