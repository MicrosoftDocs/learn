As Woodgrove Bank expands its customer base, the database needs to scale. For this exercise, we create an Azure Cosmos DB for PostgreSQL instance with the following setup:

* One coordinator node, with 4 vCores and 0.5 TiB of storage
* Two worker nodes, each with 4 vCores and 0.5 TiB of storage

We create a `payment_users` table and load the data. Once we have the data loaded, we add another worker node. Then, we use the Shard rebalancer. Finally, we'll rebalance the data to take advantage of the new worker node.

## Create an Azure Cosmos DB for PostgreSQL database

Create an Azure Cosmos DB for PostgreSQL database with the following specifications:

* One coordinator node, with 4 vCores and 0.5 TiB of storage
* Two worker nodes, each with 4 vCores and 0.5 TiB of storage

1. Open a web browser and navigate to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com).

1. Next, select **Create a resource**, **Databases**, and **Create** within the **Azure Cosmos DB** tile. You can also use the **Search** functionality to find the resource.

    :::image type="complex" source="../media/cosmos-db-postgresql-create.png" alt-text="Screenshot of Create an Azure Cosmos DB for PostgreSQL resource.":::
        Screenshot of Create a resource. Databases in the Categories navigation and Create within the Azure Cosmos DB tile in the Azure services section are highlighted.
    :::image-end:::

1. On the **Create an Azure Cosmos DB account** screen, select **Create** within the **Azure Cosmos DB for PostgreSQL** tile.

    :::image type="content" source="../media/cosmos-db-select-api-option.png" alt-text="Screenshot of the Create an Azure Cosmos DB account screen. The Azure Cosmos DB for PostgreSQL option is highlighted.":::

    > [!NOTE]
    > When you select **Create**, the portal will display a **Create an Azure Cosmos DB for PostgreSQL cluster** configuration screen.

1. On the **Basics** tab, enter the following information:

    | Parameter | Value |
    | --------------- | ----- |
    | **Project details** | |
    | Subscription | Leave as the default subscription for the sandbox environment. |
    | Resource group | Select **Create new** and name your resource group `learn-cosmosdb-postgresql`. |
    | **Cluster details** | |
    | Cluster name | _Enter a globally unique name_, such as `learn-cosmosdb-postgresql`. |
    | Location | Leave the default, or use a region that is close to you. |
    | Scale | See configuration settings in the next step. |
    | PostgreSQL version | Leave the default version selected. |
    | Database name | Leave the default name (`citus`). |
    | **Administrator account** | |
    | Admin username | This username is set to `citus` and can't be edited. |
    | Password | Enter and confirm a strong password. |

    :::image type="content" source="../media/cosmos-db-postgresql-basics-tab.png" alt-text="Screenshot of creating an Azure Cosmos DB for PostgreSQL in the Azure portal. The settings for the Basics tab are shown in the screenshot.":::

    > [!NOTE]
    > Note the server name and password for later use.

1. For the **Scale** setting, select **Configure** and on the node configuration page, set the following:

    | Parameter | Value |
    | ---------------- | ----- |
    | **Nodes** | |
    | Node count | Select **2 nodes**. |
    | Compute per node | Select **4 vCores, 32 GiB RAM**. |
    | Storage per node | Select **512 GiBM**. |
    | **Coordinator** | |
    | Coordinator compute | Select **4 vCores, 16 GiB RAM**. |
    | Coordinator storage | Select **512 GiBM**. |
    | High availability | Leave unchecked. |

    :::image type="content" source="../media/cosmos-db-postgresql-cluster-config.png" alt-text="Screenshot of the Azure Cosmos DB for PostgreSQL cluster scale configuration dialog. The settings for Nodes and Coordinator appear in the screenshot.":::

1. Select **Save** on the scale page to return to the cluster configuration.

1. Select the **Next : Networking >** button to move on to the **Networking** tab of the configuration dialog.

1. On the **Networking** tab, set the **Connectivity method** to **Public access (allowed IP addresses)**, and check the **Allow public access from Azure services and resources within Azure to this cluster** box.

    :::image type="complex" source="../media/cosmos-db-postgresql-networking-tab.png" alt-text="Screenshot of Azure Cosmos DB for PostgreSQL networking configuration.":::
        Screenshot of Azure Cosmos DB for PostgreSQL cluster networking configuration. Public access (allowed IP addresses) is highlighted for the Connectivity method. Allow public access from Azure services is checked and highlighted.
    :::image-end:::

1. Select the **Review + create** button and on the review screen, select **Create** to create your Azure Cosmos DB for PostgreSQL cluster.

## Connect to the database using psql in the Azure Cloud Shell

1. Once the Azure Cosmos DB for PostgreSQL cluster is created, navigate to the resource in the Azure portal.

1. On the navigation, under **Settings**, select **Connection strings**. Copy the connection string labeled **psql**.

    :::image type="complex" source="../media/psql-connection-string.png" alt-text="Screenshot of the Connection strings page of the Azure Cosmos DB Cluster resource.":::
        Screenshot of the Connection strings page of the Azure Cosmos DB Cluster resource. The 'Connection strings' navigation is highlighted. The psql connection string is also highlighted.
    :::image-end:::

1. Open [Azure Cloud Shell](https://shell.azure.com/) in a web browser.

1. Select **Bash**.

    :::image type="content" source="../media/azure-cloud-shell-welcome.png" alt-text="Screenshot of Azure Cloud Shell welcome message with a prompt to choose an environment between Bash or PowerShell. Bash is selected.":::

1. If prompted, select the subscription you used for your Azure Cosmos DB for PostgreSQL account. Then select **Create storage**.

    :::image type="content" source="../media/azure-cloud-shell-mount-storage.png" alt-text="Screenshot of Azure Cloud Shell welcome wizard showing no storage mounted. Azure Subscription (the current subscription) is showing in the Subscription dropdown.":::

1. Now, use the psql command-line utility to connect to Azure Cosmos DB for PostgreSQL. Copy the connection string from Step 2, and paste it into the Cloud Shell. Update the `password` part of the connection string to use the password set-up when creating the Azure Cosmos DB for PostgreSQL cluster. Then, run the command.

## Create and distribute the table

1. Run the following query to create the exercise table:

    ```sql
    CREATE TABLE payment_users
    (
        user_id bigint PRIMARY KEY,
        url text,
        login text,
        avatar_url text
    );
    ```

1. Once the table is created, then distribute the table. Run the following command:

    ```sql
    SELECT create_distributed_table('payment_users','user_id');
    ```

## Load the data

Now load the data from CSV files and ensure the data is loaded. Keep in mind that this data is spread across two worker nodes.

The `COPY` command allows you to bulk load data from files located on the coordinator node.

1. Run the following command at the Citus prompt to download CSV files containing user and payment information and then use the `COPY` command to load data from the downloaded CSV files into the distributed tables, `payment_users` and `payment_events`.

    ```sql
    SET CLIENT_ENCODING TO 'utf8';

    \COPY payment_users FROM PROGRAM 'curl https://raw.githubusercontent.com/MicrosoftDocs/mslearn-create-connect-postgresHyperscale/main/users.csv' WITH CSV
    ```

    In the `COPY` command issued, the `FROM PROGRAM` informs the coordinator to retrieve the data files from an application running on the coordinator, in this case `curl`. The `WITH CSV` option provides information about the format of the file being ingested.

1. Execute the following commands to verify data was loaded into the `payment_users` table using the `COPY` command.

    ```sql
    SELECT COUNT(*) FROM payment_users;
    ```

## Show the shard rebalancer

As data is loaded to empty distributed tables, the data is distributed to the worker nodes. Shard rebalancing shouldn't be needed.

1. Navigate to the Azure Cosmos DB for PostgreSQL resource in the Azure portal.
1. From the navigation menu, select **Shard rebalancer**.

    :::image type="complex" source="../media/shard-rebalancer-rebalancing-not-recommended.png" alt-text="Screenshot of the shard rebalancer in the Azure portal with two worker nodes.":::
        Screenshot of the Shard rebalancer in the Azure portal with a message showing that rebalancing isn't recommended at this time. The Shard rebalancer option in the Cluster management section of the navigation menu is highlighted. There's one coordinator node and two worker nodes.
    :::image-end:::

## Add a worker node

Since Woodgrove Bank is experiencing a growth in usage, we need to add a worker node to assist with the storage of data and processing of the queries. Keep in mind that this step only adds the worker node. It doesn't distribute data to the new worker node.

1. Navigate to the Azure Cosmos DB for PostgreSQL Cluster resource in the Azure portal.
1. From the navigation menu, select **Scale**.
1. Increase the **Node count** from 2 to 3.

    :::image type="complex" source="../media/scale-three-worker-nodes.png" alt-text="Screenshot of the Scale screen for the Azure Cosmos DB for PostgreSQL Cluster resource.":::
        Screenshot of the Scale screen for the Azure Cosmos DB for PostgreSQL Cluster resource. The 'Scale' navigation is highlighted. The Node count selector is highlighted.
    :::image-end:::

1. Select **Save**.

## Recheck the shard rebalance

Once a node is added, then the data needs to be distributed. Confirm shard rebalancing is needed.

1. Navigate to the Azure Cosmos DB for PostgreSQL cluster in the Azure portal.
1. From the navigation menu, select **Shard rebalancer**. Shard rebalancing is recommended.

    :::image type="complex" source="../media/shard-rebalancer-recommending-rebalancing.png" alt-text="Screenshot of the Shard rebalancer in the Azure portal with a message showing that rebalancing is recommended.":::
        Screenshot of the Shard rebalancer in the Azure portal with a message showing that rebalancing is recommended. The Shard rebalancer shows one coordinator node and three worker nodes.
    :::image-end:::

## Check the current rebalance strategy

In order to know the current rebalance strategy for the users table, run the following query in Cloud Shell while connected to the cluster:

```sql
SELECT name, default_strategy FROM pg_dist_rebalance_strategy;
```

The `default_strategy` column indicates `t` for `true` or `f` for `false`. `by_shard_count` should have the `t` value for its `default_strategy`.

```output
      name      | default_strategy 
----------------+------------------
 by_shard_count | t
 by_disk_size   | f
 ```

## Run the rebalance query

The rebalancer query is run from the Citus prompt.

In Azure Cloud Shell, logged into the Azure Cosmos DB for PostgreSQL resource, run the following command:

```sql
SELECT rebalance_table_shards(rebalance_strategy:='by_shard_count');
```

As the query executes, it outputs how the shards are moving from one worker node to another. Here's a sample of the output:

```output
citus=> SELECT rebalance_table_shards(rebalance_strategy:='by_shard_count');
NOTICE:  Moving shard 102008 from private-w0.learn-cosmosdb-postgresql.postgres.database.azure.com:5432 to private-w2.learn-cosmosdb-postgresql.postgres.database.azure.com:5432 ...
NOTICE:  Moving shard 102009 from private-w1.learn-cosmosdb-postgresql.postgres.database.azure.com:5432 to private-w2.learn-cosmosdb-postgresql.postgres.database.azure.com:5432 ...
NOTICE:  Moving shard 102010 from private-w0.learn-cosmosdb-postgresql.postgres.database.azure.com:5432 to private-w2.learn-cosmosdb-postgresql.postgres.database.azure.com:5432 ...
NOTICE:  Moving shard 102011 from private-w1.learn-cosmosdb-postgresql.postgres.database.azure.com:5432 to private-w2.learn-cosmosdb-postgresql.postgres.database.azure.com:5432 ...
```

## Show the balanced distribution

Refresh the Shard rebalancer in the portal. Notice that rebalancing is no longer recommended.

:::image type="complex" source="../media/shard-rebalancer-rebalancing-not-recommended-3-nodes.png" alt-text="Screenshot of the shard rebalancer in the Azure portal with three worker nodes.":::
    Screenshot of the Shard rebalancer in the Azure portal with a message showing that rebalancing isn't recommended at this time. The Shard rebalancer shows one coordinator node and three worker nodes.
:::image-end:::

While this exercise shows how scaling and rebalancing works with one table, this pattern applies to each distributed and reference table. Rebalancing balances data across all of the nodes in a cluster.
