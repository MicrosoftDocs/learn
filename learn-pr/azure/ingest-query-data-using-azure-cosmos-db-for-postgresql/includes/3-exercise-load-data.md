In this exercise, you create a multi-node Azure Cosmos DB for PostgreSQL database. You then put into practice several of the data ingestion methods discussed in Unit 3 to ingest Woodgrove Bank's historical and transactional data.

## Create an Azure Cosmos DB for PostgreSQL database

To complete this exercise, you must create an Azure Cosmos DB for PostgreSQL cluster. Your cluster will have:

- One coordinator node, with 4 vCores, 16-GiB RAM, and 512 GiBM of storage
- Two worker nodes, each with 4 vCores, 32-GiB RAM, and 512 GiBM of storage

1. Navigate to the [Azure portal](https://portal.azure.com/) in a web browser.

1. In the Azure portal, select **Create a resource**, **Databases**, and **Azure Cosmos DB**. You can also use the **Search** functionality to find the resource.

    :::image type="content" source="../media/cosmos-db-postgresql-create.png" alt-text="Screenshot of the Azure portal's Create a resource screen, Databases and Azure Cosmos DB are highlighted.":::

1. On the **Select API option** screen, select **Create** within the **Azure Cosmos DB for PostgreSQL** tile.

    :::image type="content" source="../media/cosmos-db-select-api-option.png" alt-text="Screenshot of the PostgreSQL tile on the Azure Cosmos DB Select API option dialog.":::

    After selecting **Create**, the portal will display a resource configuration screen.

1. On the **Basics** tab, enter the following information:

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

    :::image type="content" source="../media/cosmos-db-postgresql-basics-tab.png" alt-text="Screenshot of the Basics tab of the Create an Azure Cosmos DB - PostgreSQL cluster dialog, and the fields are populated with the values specified in the exercise.":::

    Note the password for later use.

1. For the **Scale** setting, select **Configure**, and on the node configuration page, set the following:

    | Parameter        | Value |
    | ---------------- | ----- |
    | **Nodes**            |       |
    | Node count       |  Choose **2 nodes**. |
    | Compute per node | Select **4 vCores, 32 GiB RAM**. |
    | Storage per node | Select **512 GiBM**. |
    | **Coordinator**      |  (you might need to expand this section)     |
    | Coordinator compute | Select **4 vCores, 16 GiB RAM**. |
    | Coordinator storage | Select **512 GiBM**. |

    The [high availability and automatic failover capabilities](/azure/postgresql/hyperscale/concepts-high-availability) are out of scope for this exercise, so leave the **High availability** checkbox unchecked.

    :::image type="content" source="../media/cosmos-db-postgresql-cluster-config.png" alt-text="Screenshot of the node configuration specified in the exercise on the Create an Azure Cosmos DB - PostgreSQL cluster configuration dialog.":::

1. Select **Save** on the scale page to return to the cluster configuration.

1. Select the **Next : Networking >** button to move on to the **Networking** tab of the configuration dialog.

1. On the **Networking** tab, set the **Connectivity method** to **Public access (allowed IP addresses)**, and check the **Allow public access from Azure services and resources within Azure to this cluster** box.

    :::image type="content" source="../media/cosmos-db-postgresql-networking-tab.png" alt-text="Screenshot of the Create an Azure Cosmos DB - PostgreSQL cluster Networking tab. The Public access and Allow public access from Azure services and resources within Azure to these cluster settings are highlighted.":::

1. Select the **Review + create** button, and on the review screen, select **Create** to create your cluster.

## Connect to the database using psql in the Azure Cloud Shell

1. Once your cluster has finished provisioning, navigate to the resource in the Azure portal.

1. From the left-hand navigation menu, select **Connection strings** under **Settings** and copy the connection string labeled **psql**.

    :::image type="content" source="../media/cosmos-db-postgresql-connection-strings-psql.png" alt-text="Screenshot of the Connection strings page of the Azure Cosmos DB Cluster resource. On the Connection strings page, the copy to clipboard button to the right of the psql connection string is highlighted.":::

1. Paste the connection string into a text editor, such as Notepad.exe, and replace the `{your_password}` token with the password you assigned to the `citus` user when creating your cluster. Copy the updated connection string for use below.

1. From the **Connection strings** page in the Azure portal, open an Azure Cloud Shell dialog by selecting the Cloud Shell icon on the toolbar in the Azure portal.

    :::image type="content" source="../media/azure-cloud-shell.png" alt-text="Screenshot of the Cloud Shell icon on the Azure portal toolbar and a Cloud Shell dialog is open at the bottom of the browser window.":::

    The Cloud Shell will open as an embedded panel at the bottom of your browser window.

1. If necessary, select **Bash** as the environment in the Cloud Shell window.

    :::image type="content" source="../media/azure-cloud-shell-welcome.png" alt-text="Screenshot of the welcome page of Azure Cloud Shell with a prompt to choose an environment between Bash or PowerShell. Bash is highlighted.":::

1. If you've never used Cloud Shell before, you might be prompted to mount a storage account. Select the subscription you used for your database account, then select **Create storage**.

    :::image type="content" source="../media/azure-cloud-shell-mount-storage.png" alt-text="Screenshot of the Azure Cloud Shell wizard showing no storage mounted. Azure Subscription (the current subscription) is showing in the Subscription dropdown.":::

1. Now, use the `psql` command-line utility to connect to your database. Paste your updated connection string (the one containing your correct password) at the prompt in the Cloud Shell, and then run the command, which should look similar to the following command:

    ```bash
    psql "host=c.learn-cosmosdb-postgresql.postgres.database.azure.com port=5432 dbname=citus user=citus password=P@ssword.123! sslmode=require"
    ```

## Create tables in the database

Now that you're connected to your database, you can begin populating the database. You'll use `psql` to:

- Create users and events tables.
- Distribute the two tables, sharding them across the worker nodes.

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

    Based on your recommendation to choose the `user_id` field as the distribution column for both tables, the `PRIMARY KEY` assignment for the `payment_events` table was changed to a compound key. This compound key will allow the `user_id` field to be assigned as the distribution column.

1. Next, create the merchants table:

    ```sql
    CREATE TABLE payment_merchants
    (
        merchant_id bigint PRIMARY KEY,
        name text,
        url text
    );
    ```

## Distribute the tables

Executing the `CREATE TABLE` commands results in local tables being created on the coordinator node. To distribute the tables to the worker nodes, you must run the `create_distributed_table` function for each table, specifying what distribution column to use when sharding them.

1. In the Cloud Shell, run the following query to distribute your `payment_events` and `payment_users` tables across the worker nodes:

    ```sql
    SELECT create_distributed_table('payment_users', 'user_id');
    SELECT create_distributed_table('payment_events', 'user_id');
    ```

    The `payment_events` and `payment_users` tables were assigned the same distribution column, resulting in related data for both tables being colocated on the same node. You don't need to use the `colocate with` parameter of the `create_distributed_table` function, as tables with the same shard key will be implicitly colocated.

1. Now, define the `payment_merchant` table as a reference table:

    ```sql
    SELECT create_reference_table('payment_merchants');
    ```

## Insert payment data

Woodgrove Bank's payment transactions come as individual requests through the contactless payment app and should be added to the database as quickly as possible. Many transactions often arrive around the same time. To accomplish this transaction most efficiently, you can add individual rows to the `payment_events` table by batching multiple `INSERT` statements together.

1. In the Cloud Shell, run the following `INSERT` statement to load multiple transaction rows into the `payment_events` table at once:

    ```sql
    INSERT INTO payment_events VALUES
        (5050825575,'SendFunds',1159138,17724730,'{"code": 17724730, "particulars": "twofactorauth", "reference": "2factorauth"}','1/12/16 5:22'),
        (5050825788,'RequestFunds',1171503,11730342,'{"code": 11730342, "particulars": "vue", "reference": "vuejs"}','1/12/16 5:22');
    ```

1. Execute the following command to view the two records inserted into the table:

    ```sql
    SELECT * FROM payment_events;
    ```

## Bulk load data using the COPY command

Woodgrove Bank has provided links to their historical event and user data, which are stored in CSV files. They have made these files available via publicly accessible URLs and have requested that you perform a one-time bulk load of these data into the new database.

You can use the `COPY` command to fulfill this request. It allows you to bulk load data from files.

1. Run the following command to download CSV files containing user and payment information and then use the `COPY` command to load data from the downloaded CSV files into the distributed tables, `payment_users` and `payment_events`:

    ```sql
    SET CLIENT_ENCODING TO 'utf8';

    \COPY payment_users FROM PROGRAM 'curl https://raw.githubusercontent.com/microsoftdocs/mslearn-create-connect-postgresHyperscale/main/users.csv' WITH CSV

    \COPY payment_events FROM PROGRAM 'curl https://raw.githubusercontent.com/microsoftdocs/mslearn-create-connect-postgresHyperscale/main/events.csv' WITH CSV
    ```

    In the `COPY` command issued, the `FROM PROGRAM` clause informs the coordinator to retrieve the data files from an application running on the coordinator, in this case, `curl`. The `WITH CSV` option provides information about the format of the file being ingested.

1. Execute the following commands to verify data was loaded into the `payment_users` and `payment_events` tables using the `COPY` command:

    ```sql
    SELECT COUNT(*) FROM payment_users;
    SELECT COUNT(*) FROM payment_events;
    ```

## Extract merchant data from the Events table

Woodgrove Bank has requested that you extract unique merchant data into a new table as part of bulk loading their historical data. You can use a `SELECT FROM` statement to pull the list of distinct merchants from the `payment_events` table.

1. Before inserting the data, run the following `EXPLAIN` statement to review the query execution plan:

    ```sql
    EXPLAIN
        INSERT INTO payment_merchants SELECT DISTINCT merchant_id, CONCAT('merchant', '_', merchant_id), CONCAT('https://api.woodgrove.com/merchants/', merchant_id) FROM payment_events;
    ```

    The `EXPLAIN` output reveals that the inefficient `pull to coordinator` method will be used for the `INSERT ... SELECT` query execution. This inefficiency occurs because the coordinator is unable to determine the distribution column involved in the query and must pull the data from each worker node to execute the query locally.

1. Now, load the distinct merchants into the `payment_merchants` table and use the `merchant_id` to assign a unique name and set the API URL:

    ```sql
    INSERT INTO payment_merchants SELECT DISTINCT merchant_id, CONCAT('merchant', '_', merchant_id), CONCAT('https://api.woodgrove.com/merchants/', merchant_id) FROM payment_events;
    ```

1. Verify the data loaded correctly by executing the following `SELECT` statement to view the top five records in the table:

    ```sql
    SELECT * FROM payment_merchants LIMIT 5;
    ```

    **Congratulations**! You've successfully created a multi-node, distributed database using Azure Cosmos DB for PostgreSQL and used multiple data ingestion methods to populate your distributed tables.

1. In the Cloud Shell, run the following command to disconnect from your database:

    ```sql
    \q
    ```

    You can keep the Cloud Shell open and move on to Unit 4: Use coordinator metadata tables and views to understand data distribution.
