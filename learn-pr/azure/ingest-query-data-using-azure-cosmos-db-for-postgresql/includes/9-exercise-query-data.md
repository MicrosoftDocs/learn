In the previous exercise, you loaded data into two distributed tables and one reference table in Azure Cosmos DB for PostgreSQL. In this exercise, you'll examine table colocation's effects and its impacts on data movement during query execution.

> [!IMPORTANT]
> This exercise relies on the Azure Cosmos DB for PostgreSQL database and distributed tables you created in Unit 3.

## Connect to the database using psql in the Azure Cloud Shell

1. In the Azure portal, navigate to the *learn-cosmosdb-postgresql* cluster you created in Unit 3.

1. From the left-hand navigation menu, select **Connection strings** under **Settings** and copy the connection string labeled **psql**.

    :::image type="content" source="../media/cosmos-db-postgresql-connection-strings-psql.png" alt-text="Screenshot of the Connection strings page of the Azure Cosmos DB Cluster resource; the copy to clipboard button to the right of the psql connection string is highlighted.":::

1. Paste the connection string into a text editor, such as Notepad, and replace the `{your_password}` token with the password you assigned to the `citus` user when creating your cluster. Copy the updated connection string for use below.

1. From the **Connection strings** page in the Azure portal, open an Azure Cloud Shell dialog by selecting the Cloud Shell icon on the toolbar in the Azure portal.

    :::image type="content" source="../media/azure-cloud-shell.png" alt-text="Screenshot of the Cloud Shell icon on the Azure portal toolbar. A Cloud Shell dialog is open at the bottom of the browser window.":::

    The Cloud Shell will open as an embedded panel at the bottom of your browser window.

1. If necessary, select **Bash** as the environment in the Cloud Shell window.

    :::image type="content" source="../media/azure-cloud-shell-welcome.png" alt-text="Screenshot of the welcome page of Azure Cloud Shell with a prompt to choose an environment between Bash or PowerShell. Bash is highlighted.":::

1. Now, use the `psql` command-line utility to connect to your database. Paste your updated connection string (the one containing your correct password) at the prompt in the Cloud Shell, and then run the command, which should look similar to the following sample command:

    ```bash
    psql "host=c.learn-cosmosdb-postgresql.postgres.database.azure.com port=5432 dbname=citus user=citus password=P@ssword.123! sslmode=require"
    ```

## Identify the distribution column for each table

1. In the Cloud Shell, run the following query to determine the distribution column defined for each of your distributed tables:

    ```sql
    SELECT table_name, distribution_column FROM citus_tables;
    ```

1. Note the distribution column for each table in the query output:

    ```output
        table_name     | distribution_column 
    -------------------+---------------------
     payment_events    | user_id
     payment_merchants | <none>
     payment_users     | user_id
    ```

## Join colocated distributed tables

In the previous exercise, you used the same column as the shard key for both the `payment_events` and `payment_users` tables.

1. Attempt to do a complex join between the `payment_events` and `payment_users` table using the `user_id` field:

    ```sql
    SELECT login, event_id
    FROM payment_events AS e
    LEFT JOIN payment_users u ON e.user_id = u.user_id;
    ```

1. Run the same query with `EXPLAIN` and review the output:

    ```sql
    EXPLAIN VERBOSE
        SELECT login, event_id
        FROM payment_events AS e
        LEFT JOIN payment_users u ON e.user_id = u.user_id;
    ```

1. The output of that query shows it was fragmented and executed across each of the 32 shards in the cluster:

    ```output
    Custom Scan (Citus Adaptive)  (cost=0.00..0.00 rows=100000 width=40)
        Output: remote_scan.login, remote_scan.event_id
        Task Count: 32
        Tasks Shown: One of 32
    ```

## Repartition joins across non-distribution columns

1. Next, you'll look at a complex join between tables whose data isn't colocated. You'll temporarily revert the `payment_merchants` table to a distributed table. Run the following statements to change the `payment_merchants` table from a reference table to a distributed one:

    ```sql
    SELECT undistribute_table('payment_merchants');
    SELECT create_distributed_table('payment_merchants', 'merchant_id');
    ```

1. Now that you have a table to work with that has a different distribution column, run the following query and observe the results:

    ```sql
    SELECT name, event_id
    FROM payment_events AS e
    LEFT JOIN payment_merchants m ON e.merchant_id = m.merchant_id
    LIMIT 5;
    ```

1. You'll receive the following error, because complex joins (any joins other than an inner join) between non-colocated tables aren't supported:

    ```output
    ERROR: complex joins are only supported when all distributed tables are co-located and joined on their distribution columns
    ```

1. Now, attempt the same query using an `INNER JOIN`:

    ```sql
    SELECT name, event_id
    FROM payment_events AS e
    INNER JOIN payment_merchants m ON e.merchant_id = m.merchant_id
    LIMIT 5;
    ```

    ```output
    ERROR: the query contains a join that requires repartitioning
    HINT: Set citus.enable_repartition_joins to on to enable repartitioning
    ```

1. Based on the error and hint, you now know that this join requires dynamically repartitioning the tables so that the coordinator can execute the query. Run the following command to enable repartitioning joins:

    ```sql
    SET citus.enable_repartition_joins to on;
    ```

1. Execute the `INNER JOIN` query again and observe the results:

    ```sql
    SELECT name, event_id
    FROM payment_events AS e
    INNER JOIN payment_merchants m ON e.merchant_id = m.merchant_id
    LIMIT 5;
    ```

    Notice that, while the query executes successfully, it takes a few seconds for the results to be returned.

1. Run `EXPLAIN` on the `INNER JOIN` query to view the execution plan and try to identify why it took so long to execute:

    ```sql
    EXPLAIN
        SELECT name, event_id
        FROM payment_events AS e
        INNER JOIN payment_merchants m ON e.merchant_id = m.merchant_id
        LIMIT 5;
    ```

1. In the `EXPLAIN` output, notice that tasks aren't supported for repartition queries. You can see the `MapMergeJob` tasks the coordinator used to dynamically repartition the tables to perform the join operation. This data shuffle between nodes helps to explain the slowness of the query.

    ```output
     Custom Scan (Citus Adaptive)  (cost=0.00..0.00 rows=100000 width=40)
        Task Count: 12
        Tasks Shown: None, not supported for re-partition queries
        ->  MapMergeJob
                Map Task Count: 32
                Merge Task Count: 12
        ->  MapMergeJob
                Map Task Count: 32
                Merge Task Count: 12
    ```

## Join distributed tables on a non-distribution column

You discovered in the previous task that you couldn't perform complex joins when data is dispersed across different workers. When a SQL query is unsupported, one way to work around it is by using common table expressions (CTEs), which use what is referred to as pull-push execution.

> [!IMPORTANT]
> The use of CTEs to perform push-pull query execution is considered an anti-pattern and is being used here only to demonstrate the performance impact of running such a query.

1. Recall the complex join query you attempted to execute above and the error you received when trying to run it.

    ```sql
    SELECT name, event_id
    FROM payment_events AS e
    LEFT JOIN payment_merchants m ON e.merchant_id = m.merchant_id
    LIMIT 5;
    ```

    ```output
    ERROR: complex joins are only supported when all distributed tables are co-located and joined on their distribution columns
    ```

1. The workaround is to include a CTE to bypass the limitation. Run the following query:

    ```sql
    WITH merchants AS (SELECT * FROM payment_merchants)
    SELECT name, event_id
    FROM payment_events
    LEFT JOIN merchants USING (merchant_id)
    LIMIT 5;
    ```

    This approach allows you to successfully execute the join between your non-colocated tables. However, it's an expensive query to run, and you should avoid this approach.

1. Run an `EXPLAIN` on the query to view the execution plan:

    ```sql
    EXPLAIN
        WITH merchants AS (SELECT * FROM payment_merchants)
        SELECT name, event_id
        FROM payment_events
        LEFT JOIN merchants USING (merchant_id)
        LIMIT 5;
    ```

    The output shows that it was necessary to create a distributed subplan. Queries were sent to each of the worker nodes to retrieve data and then returned to the coordinator to do the work of joining the results. It's considered a distributed query anti-pattern due to the data movement required to complete the query and its effect on performance.

    ```output
    Limit  (cost=0.00..0.00 rows=5 width=40)
        ->  Custom Scan (Citus Adaptive)  (cost=0.00..0.00 rows=100000 width=40)
            ->  Distributed Subplan 15_1
               ->  Custom Scan (Citus Adaptive)  (cost=0.00..0.00 rows=100000 width=72)
                     Task Count: 32
                     Tasks Shown: One of 32
                     ->  Task
                           Node: host=private-w0.learn-cosmosdb-postgresql.postgres.database.azure.com port=5432 dbname=citus
                           ->  Seq Scan on payment_merchants_102524 payment_merchants  (cost=0.00..33.68 rows=1468 width=69)
            Task Count: 32
            Tasks Shown: One of 32
            ->  Task
               Node: host=private-w0.learn-cosmosdb-postgresql.postgres.database.azure.com port=5432 dbname=citus
               ->  Limit  (cost=22.50..23.32 rows=5 width=40)
                     ->  Hash Left Join  (cost=22.50..757.72 rows=4482 width=40)
                           Hash Cond: (payment_events.merchant_id = intermediate_result.merchant_id)
                           ->  Seq Scan on payment_events_102232 payment_events  (cost=0.00..138.82 rows=4482 width=16)
                           ->  Hash  (cost=10.00..10.00 rows=1000 width=40)
                                 ->  Function Scan on read_intermediate_result intermediate_result  (cost=0.00..10.00 rows=1000 width=40)
    ```

1. In the Cloud Shell, run the following command to disconnect from your database instance.

    ```sql
    \q
    ```

    **Congratulations**! You've executed multiple queries against your Azure Cosmos DB for PostgreSQL distributed tables and explored the details of how the coordinator optimizes query execution.

## Clean up

It's crucial that you clean up any unused resources. You're charged for the configured capacity, not how much the database is used.

1. Open a web browser and navigate to the [Azure portal](https://portal.azure.com/).

1. In the left-hand navigation menu, select **Resource Groups**, and then select the resource group you created as part of the exercise in Unit 3.

1. In the **Overview** pane, select **Delete resource group**.

1. Enter the name of the resource group you created to confirm, then select **Delete**.

1. Select **Delete** again to confirm the deletion.
