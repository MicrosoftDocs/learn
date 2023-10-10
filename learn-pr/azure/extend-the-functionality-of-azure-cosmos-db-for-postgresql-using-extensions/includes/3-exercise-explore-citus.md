In this exercise, you create a multi-node Azure Cosmos DB for PostgreSQL database. You'll then create a few tables before running a few queries against your database to learn more about the distributed architecture provided by the Citus extension for PostgreSQL.

## Create an Azure Cosmos DB for PostgreSQL database

To complete this exercise, you must create an Azure Cosmos DB for the PostgreSQL cluster. Your cluster will have:

- One coordinator node, with 4 vCores, 16-GiB RAM, and 512 GiBM of storage
- Two worker nodes, each with 4 vCores, 32-GiB RAM, and 512 GiBM of storage

1. Navigate to the [Azure portal](https://portal.azure.com/) in a web browser.

2. In the Azure portal, select **Create a resource**, **Databases**, and **Azure Cosmos DB**. You can also use the **Search** functionality to find the resource.

    :::image type="content" source="../media/cosmos-db-postgresql-create.png" alt-text="Screenshot of the Azure portal's create a resource screen where Databases and Azure Cosmos DB are highlighted.":::

3. On the **Select API option** screen, select **Create** within the **Azure Cosmos DB for PostgreSQL** tile.

    :::image type="content" source="../media/cosmos-db-select-api-option.png" alt-text="Screenshot of the Azure Cosmos DB for PostgreSQL tile that is highlighted on the Azure Cosmos DB Select API option dialog.":::

    > [!NOTE]
    > After selecting **Create**, the portal will display a database configuration screen.

4. On the **Basics** tab, enter the following information:

    | Parameter       | Value |
    | --------------- | ----- |
    | **Project details** |       |
    | Subscription    | Choose your Azure subscription.  |
    | Resource group  | Select **Create new** and name your resource group `learn-cosmosdb-postgresql`. |
    | **Cluster details** |       |
    | Cluster name    | _Enter a globally unique name_, such as `learn-cosmosdb-postgresql`. |
    | Location        | Leave the default, or use a region close to you. |
    | Scale           | See configuration settings in the next step. |
    | PostgreSQL version | Leave the default version (15) selected. |
    | **Administrator account** | |
    | Admin username  | This username is set to `citus` and can't be edited. |
    | Password        | Enter and confirm a strong password. |

    :::image type="content" source="../media/cosmos-db-postgresql-basics-tab.png" alt-text="Screenshot of the Basics tab of the Create an Azure Cosmos DB - PostgreSQL cluster dialog. The fields are populated with the values specified in the exercise.":::

    Note the password for later use.

5. For the **Scale** setting, select **Configure**, and on the node configuration page, set the following:

    | Parameter        | Value |
    | ---------------- | ----- |
    | **Nodes**            |       |
    | Node count       |  Choose **2 nodes**. |
    | Compute per node | Select **4 vCores, 32 GiB RAM**. |
    | Storage per node | Select **512 GiBM**. |
    | **Coordinator**      | (You might need to expand this section)      |
    | Coordinator compute | Select **4 vCores, 16 GiB RAM**. |
    | Coordinator storage | Select **512 GiBM**. |

    The [high availability and automatic failover capabilities](/azure/postgresql/hyperscale/concepts-high-availability) are out of scope for this exercise, so leave the **High availability** checkbox unchecked.

    :::image type="content" source="../media/cosmos-db-postgresql-cluster-config.png" alt-text="Screenshot of the Create an Azure Cosmos DB - PostgreSQL cluster configuration dialog.":::

6. Select **Save** on the scale page to return to the cluster configuration.

7. Select the **Next : Networking >** button to move on to the **Networking** tab of the configuration dialog.

8. On the **Networking** tab, set the **Connectivity method** to **Public access (allowed IP addresses)**, and check the **Allow public access from Azure services and resources within Azure to this cluster** box.

    :::image type="content" source="../media/cosmos-db-postgresql-networking-tab.png" alt-text="Screenshot of the Create an Azure Cosmos DB - PostgreSQL cluster Networking tab. The settings specified in the exercise are highlighted.":::

9. Select the **Review + create** button, then select **Create** on the review screen to create your cluster.

## Connect to the database using psql in the Azure Cloud Shell

1. Once your Azure Cosmos DB for PostgreSQL cluster has finished provisioning, navigate to the resource in the Azure portal.

2. From the left-hand navigation menu, select **Connection strings** under **Settings** and copy the connection string labeled **psql**.

    :::image type="complex" source="../media/cosmos-db-postgresql-connection-strings-psql.png" alt-text="Screenshot of the Connection strings page of the Azure Cosmos DB Cluster resource.":::
       On the Connection strings page, the copy to clipboard button to the right of the psql connection string is highlighted.
    :::image-end:::

3. Paste the connection string into a text editor such as Notepad and replace the `{your_password}` token with the password you assigned to the `citus` user when creating your cluster. Copy the updated connection string for use below.

4. Open the [Azure Cloud Shell](https://shell.azure.com/) in a web browser.

5. Select **Bash** as the environment.

    :::image type="content" source="../media/azure-cloud-shell-welcome.png" alt-text="Screenshot of the welcome page of Azure Cloud Shell with a prompt to choose an environment between Bash or PowerShell. Bash is highlighted.":::

6. If prompted, select the subscription you used for your Azure Cosmos DB for PostgreSQL account. Then select **Create storage**.

    :::image type="content" source="../media/azure-cloud-shell-mount-storage.png" alt-text="Screenshot of the Azure Cloud Shell wizard showing no storage mounted is displayed. Azure Subscription is showing in the Subscription dropdown.":::

7. Now, use the psql command-line utility to connect to your database. Paste your updated connection string (the one containing your correct password) at the prompt in the Cloud Shell, and then run the command, which should look similar to the following command:

    ```bash
    psql "host=c.learn-cosmosdb-postgresql.postgres.database.azure.com port=5432 dbname=citus user=citus password=P@ssword.123! sslmode=require"
    ```

### Discover information about the nodes in your cluster

The [coordinator metadata tables](/azure/postgresql/hyperscale/reference-metadata#coordinator-metadata) contain information about worker nodes in your cluster.

1. Execute the following query against the worker node table, [`pg_dist_node`](/azure/postgresql/hyperscale/reference-metadata#worker-node-table) to view information about the nodes in your cluster:

    ```sql
    -- Turn on expanded display to pivot the results 
    \x
    ```

    ```sql
    -- Retrieve node details
    SELECT * FROM pg_dist_node;
    ```

2. Review the query output for details, including the ID, name, and port associated with each node. In addition, you can see if the node is active and should contain shards, among other bits of information.

    ```sql
    -[ RECORD 1 ]----+-----------------------------------------------------------------
    nodeid           | 2
    groupid          | 2
    nodename         | private-w1.learn-cosmosdb-postgresql.postgres.database.azure.com
    nodeport         | 5432
    noderack         | default
    hasmetadata      | t
    isactive         | t
    noderole         | primary
    nodecluster      | default
    metadatasynced   | t
    shouldhaveshards | t
    -[ RECORD 2 ]----+-----------------------------------------------------------------
    nodeid           | 3
    groupid          | 3
    nodename         | private-w0.learn-cosmosdb-postgresql.postgres.database.azure.com
    nodeport         | 5432
    noderack         | default
    hasmetadata      | t
    isactive         | t
    noderole         | primary
    nodecluster      | default
    metadatasynced   | t
    shouldhaveshards | t
    -[ RECORD 3 ]----+-----------------------------------------------------------------
    nodeid           | 4
    groupid          | 0
    nodename         | private-c.learn-cosmosdb-postgresql.postgres.database.azure.com
    nodeport         | 5432
    noderack         | default
    hasmetadata      | t
    isactive         | t
    noderole         | primary
    nodecluster      | default
    metadatasynced   | t
    shouldhaveshards | f
    ```

    You can use the node names and port numbers provided in the output to connect directly to workers, which is a common practice when [tuning query performance](/azure/postgresql/hyperscale/concepts-performance-tuning). Connecting directly to worker nodes requires the **Enable access to the worker nodes** checkbox to be selected on the **Networking** page of your Azure Cosmos DB for PostgreSQL resource in the Azure portal.

    :::image type="content" source="../media/enable-access-to-worker-nodes.png" alt-text="Screenshot of the enable access to the worker nodes option in the Networking section. Networking is highlighted and selected in the left-hand navigation menu.":::

## Create distributed tables

Now that you're connected to your database, you can start to populate the database. You'll use `psql` to:

- Create users and payment tables.
- Instruct Citus to distribute both tables, sharding them across the worker nodes.

Distributed tables are horizontally partitioned across available worker nodes. This distribution means the table's rows are stored on different nodes in fragment tables called shards.

1. In the Cloud Shell, run the following query to create the `payment_users` and `payment_events` tables:

    ```sql
    CREATE TABLE payment_users
    (
        user_id bigint PRIMARY KEY,
        url text,
        login text,
        avatar_url text
    );

    CREATE TABLE payment_events
    (
        event_id bigint,
        event_type text,
        user_id bigint,
        merchant_id bigint,
        event_details jsonb,
        created_at timestamp,
        -- Create a compound primary key so that user_id can be set as the distribution column
        PRIMARY KEY (event_id, user_id)
    );
    ```

    The `PRIMARY KEY` assignment for the `payment_events` table is a compound key, allowing the `user_id` field to be assigned as the distribution column.

2. When the `CREATE TABLE` commands are executed, local tables are created on the coordinator node. To distribute the tables to the worker nodes, you must run the [`create_distributed_table`](/azure/postgresql/hyperscale/reference-functions#create_distributed_table) function for each table, specifying what distribution column to use when sharding them. In the Cloud Shell, run the following query to distribute your `payment_events` and `payment_users` tables across the worker nodes:

    ```sql
    SELECT create_distributed_table('payment_users', 'user_id');
    SELECT create_distributed_table('payment_events', 'user_id');
    ```

    Both the `payment_events` and `payment_users` tables were assigned the same distribution column, resulting in related data for both tables being colocated on the same node. Details on selecting the correct distribution column are outside the scope of this learning module. Still, you can learn more about it by reading the [Choose distribution columns in Azure Cosmos DB for PostgreSQL](/azure/postgresql/hyperscale/howto-choose-distribution-column) article in the Microsoft docs.

## Create a reference table

Next, you'll use `psql` to:

- Create the merchants table.
- Instruct Citus to distribute the entire table as a reference table on every worker node.

A reference table is a distributed table whose entire contents are concentrated into a single shard replicated on every worker. Queries on any worker can access the reference information locally without the network overhead of requesting rows from another node. Reference tables don't require the specification of a distribution column, because there's no need to distinguish different shards per row. Reference tables are typically small and used to store data relevant to queries running on any worker node.

1. In the Cloud Shell, run the following query to create the `payment_merchants` table:

    ```sql
    CREATE TABLE payment_merchants
    (
        merchant_id bigint PRIMARY KEY,
        name text,
        url text
    );
    ```

2. Next, use the [`create_reference_table()`](/azure/postgresql/hyperscale/reference-functions#create_reference_table) function to distribute the table to every worker node.

    ```sql
    SELECT create_reference_table('payment_merchants');
    ```

## Load data into the events table

Woodgrove Bank has provided you with their historical event data in a CSV file, so you have some data to work with while installing and testing the requested extensions. They'll provide user data via a secure Azure blob storage account for you to populate the `payment_users` table in the next exercise. The `events.csv` file is available via a publicly accessible URL.

You can use the `COPY` command to perform a one-time bulk load of this data into the `payment_events` table.

1. Run the following command to download CSV files containing user and payment information and then use the `COPY` command to load data from the downloaded CSV files into the distributed tables, `payment_users` and `payment_events`:

    ```sql
    SET CLIENT_ENCODING TO 'utf8';

    \COPY payment_events FROM PROGRAM 'curl https://raw.githubusercontent.com/MicrosoftDocs/mslearn-create-connect-postgresHyperscale/main/events.csv' WITH CSV
    ```

    In the `COPY` command issued, the `FROM PROGRAM` clause informs the coordinator to retrieve the data files from an application running on the coordinator, in this case, `curl`. The `WITH CSV` option provides information about the format of the file being ingested.

2. Execute the following commands to verify data was loaded into the `payment_events` table using the `COPY` command.

    ```sql
    SELECT COUNT(*) FROM payment_events;
    ```

## View details about your distributed tables

Now that you've created a few distributed tables let's use the `citus_tables` view to inspect those tables.

1. Execute the following query to view the details of your distributed tables:

    ```sql
    SELECT table_name, citus_table_type, distribution_column, table_size, shard_count FROM citus_tables;
    ```

2. Observe the output from the query and the details it provides.

    ```output
    table_name        | citus_table_type | distribution_column | table_size | shard_count 
    ------------------+------------------+---------------------+------------+-------------
    payment_events    | distributed      | user_id             | 26 MB      |          32
    payment_merchants | reference        | <none>              | 48 kB      |           1
    payment_users     | distributed      | user_id             | 512 kB     |          32
    ```

    > [!NOTE]
    > Note the `shard_count` and the difference between how many shards are used for distributed versus reference tables. This distinction provides some insight into how Citus handles the distribution of data internally. The `citus_table` view also includes information about the size of your tables.

## Examine table sharding

Next, look at the shards Citus created to distribute each table's data:

1. The `pg_dist_shard` metadata table contains the details of shards in your cluster. Execute the following query to view the shards created for each of your tables:

    ```sql
    SELECT * from pg_dist_shard;
    ```

2. Review the output of the above query. Recall that the `payment_merchants` table exists in a single shard. Compare that to the `payment_events` and `payment_users` tables, each containing 32 shards.

3. To see how Citus handles sharding reference tables, you can use the `citus_shards` view to view the location of shards on worker nodes. Execute the following query:

    ```sql
    SELECT table_name, shardid, citus_table_type, nodename FROM citus_shards WHERE table_name = 'payment_merchants'::regclass;
    ```

    In the output, the `payment_merchants` table's single shard is distributed across every node in the cluster.

    ```output
    table_name        | shardid | citus_table_type |                             nodename                             
    ------------------+---------+------------------+-----------------------------------------------------------------
    payment_merchants |  102072 | reference        | private-w0.learn-cosmosdb-postgresql.postgres.database.azure.com
    payment_merchants |  102072 | reference        | private-w1.learn-cosmosdb-postgresql.postgres.database.azure.com
    payment_merchants |  102072 | reference        | private-c.learn-cosmosdb-postgresql.postgres.database.azure.com
    ```

4. To compare, execute the following query to view the distribution of shards for the `payment_events` table:

    ```sql
    SELECT table_name, shardid, citus_table_type, nodename FROM citus_shards WHERE table_name = 'payment_events'::regclass;
    ```

    For `distributed` tables, each `shardid` appears only once in the results, and each shard only exists on a single node.

    ```output
    table_name     | shardid | citus_table_type |                             nodename                             
    ---------------+---------+------------------+-----------------------------------------------------------------
    payment_events |  102040 | distributed      | private-w0.learn-cosmosdb-postgresql.postgres.database.azure.com
    payment_events |  102041 | distributed      | private-w1.learn-cosmosdb-postgresql.postgres.database.azure.com
    payment_events |  102042 | distributed      | private-w0.learn-cosmosdb-postgresql.postgres.database.azure.com
    payment_events |  102043 | distributed      | private-w1.learn-cosmosdb-postgresql.postgres.database.azure.com
    payment_events |  102044 | distributed      | private-w0.learn-cosmosdb-postgresql.postgres.database.azure.com
    payment_events |  102045 | distributed      | private-w1.learn-cosmosdb-postgresql.postgres.database.azure.com
    payment_events |  102046 | distributed      | private-w0.learn-cosmosdb-postgresql.postgres.database.azure.com
    payment_events |  102047 | distributed      | private-w1.learn-cosmosdb-postgresql.postgres.database.azure.com
    payment_events |  102048 | distributed      | private-w0.learn-cosmosdb-postgresql.postgres.database.azure.com
    payment_events |  102049 | distributed      | private-w1.learn-cosmosdb-postgresql.postgres.database.azure.com
    payment_events |  102050 | distributed      | private-w0.learn-cosmosdb-postgresql.postgres.database.azure.com
    payment_events |  102051 | distributed      | private-w1.learn-cosmosdb-postgresql.postgres.database.azure.com
    payment_events |  102052 | distributed      | private-w0.learn-cosmosdb-postgresql.postgres.database.azure.com
    payment_events |  102053 | distributed      | private-w1.learn-cosmosdb-postgresql.postgres.database.azure.com
    payment_events |  102054 | distributed      | private-w0.learn-cosmosdb-postgresql.postgres.database.azure.com
    payment_events |  102055 | distributed      | private-w1.learn-cosmosdb-postgresql.postgres.database.azure.com
    payment_events |  102056 | distributed      | private-w0.learn-cosmosdb-postgresql.postgres.database.azure.com
    payment_events |  102057 | distributed      | private-w1.learn-cosmosdb-postgresql.postgres.database.azure.com
    payment_events |  102058 | distributed      | private-w0.learn-cosmosdb-postgresql.postgres.database.azure.com
    payment_events |  102059 | distributed      | private-w1.learn-cosmosdb-postgresql.postgres.database.azure.com
    payment_events |  102060 | distributed      | private-w0.learn-cosmosdb-postgresql.postgres.database.azure.com
    payment_events |  102061 | distributed      | private-w1.learn-cosmosdb-postgresql.postgres.database.azure.com
    payment_events |  102062 | distributed      | private-w0.learn-cosmosdb-postgresql.postgres.database.azure.com
    payment_events |  102063 | distributed      | private-w1.learn-cosmosdb-postgresql.postgres.database.azure.com
    payment_events |  102064 | distributed      | private-w0.learn-cosmosdb-postgresql.postgres.database.azure.com
    payment_events |  102065 | distributed      | private-w1.learn-cosmosdb-postgresql.postgres.database.azure.com
    payment_events |  102066 | distributed      | private-w0.learn-cosmosdb-postgresql.postgres.database.azure.com
    payment_events |  102067 | distributed      | private-w1.learn-cosmosdb-postgresql.postgres.database.azure.com
    payment_events |  102068 | distributed      | private-w0.learn-cosmosdb-postgresql.postgres.database.azure.com
    payment_events |  102069 | distributed      | private-w1.learn-cosmosdb-postgresql.postgres.database.azure.com
    payment_events |  102070 | distributed      | private-w0.learn-cosmosdb-postgresql.postgres.database.azure.com
    payment_events |  102071 | distributed      | private-w1.learn-cosmosdb-postgresql.postgres.database.azure.com
    ```

    Congratulations! You've successfully created a multi-node, distributed database using Azure Cosmos DB for PostgreSQL. Using metadata tables and views, you explored how the Citus extension distributes data and provides added capabilities to PostgreSQL.

5. In the Cloud Shell, run the following command to disconnect from your database:

    ```sql
    \q
    ```

    You can keep the Cloud Shell open and move on to the next unit.
