As Wide World Importers expands the number of sensors it uses to store its products in optimal conditions, the database needs to scale to handle the growth in the amount of data. In this exercise, you scale the Azure Cosmos DB for PostgreSQL instance that you created in the previous exercise.

The new configuration has these components:

- One coordinator node that has four vCores and 0.5 TiB of storage
- Two worker nodes, each with four vCores and 0.5 TiB of storage

To show that the system isn't down while you take steps to scale the database, you can start benchmarking a query and let it run while you scale.

## Start benchmarking

[pgbench](https://www.postgresql.org/docs/current/pgbench.html) is a tool you can use to benchmark query and server performance. For this example, you use the outliers query that you used in the preceding exercise as a base. You alter the outliers query to bring back all outliers.

Here are the updated SQL statements for the outliers query:

```sql
SELECT device_id, COUNT((CASE WHEN (payload ->> 'humidity')::decimal < 60 THEN 1 ELSE NULL END)) AS LowHumidity,  
COUNT((CASE WHEN (payload ->> 'humidity')::decimal > 70 THEN 1 ELSE NULL END)) AS HighHumidity,
COUNT((CASE WHEN (payload ->> 'temperature')::decimal < 55 THEN 1 ELSE NULL END)) AS LowTemperature,
COUNT((CASE WHEN (payload ->> 'temperature')::decimal > 60 THEN 1 ELSE NULL END)) AS HighTemperature,
COUNT((CASE WHEN (payload ->> 'humidity')::decimal BETWEEN 60 AND 70 THEN 1 ELSE NULL END)) AS RegularHumidity,  
COUNT((CASE WHEN (payload ->> 'temperature')::decimal BETWEEN 55 AND 60 THEN 1 ELSE NULL END)) AS RegularTemperature
FROM events
GROUP BY device_id;
```

You store this SQL in a file and have pgbench run the benchmark for some time. pgbench reports its findings periodically so that you can be sure the benchmark is still running. Because pgbench is accessing the data that you created in the preceding exercise, this exercise simulates scaling the Azure Cosmos DB for PostgreSQL cluster while the data is in use.

For this exercise, pgbench is set to run for 20 minutes. The scale process takes about 20 minutes to finish.

To start benchmarking:

1. Open [Azure Cloud Shell](https://shell.azure.com) by using the icon at the top of the Azure portal. In the Bash shell environment, run the following command to store the outlier query in a SQL file:

    ```bash
    echo "SELECT device_id, COUNT((CASE WHEN (payload ->> 'humidity')::decimal < 60 THEN 1 ELSE NULL END)) AS LowHumidity,  
    COUNT((CASE WHEN (payload ->> 'humidity')::decimal > 70 THEN 1 ELSE NULL END)) AS HighHumidity,
    COUNT((CASE WHEN (payload ->> 'temperature')::decimal < 55 THEN 1 ELSE NULL END)) AS LowTemperature,
    COUNT((CASE WHEN (payload ->> 'temperature')::decimal > 60 THEN 1 ELSE NULL END)) AS HighTemperature,
    COUNT((CASE WHEN (payload ->> 'humidity')::decimal BETWEEN 60 AND 70 THEN 1 ELSE NULL END)) AS RegularHumidity,  
    COUNT((CASE WHEN (payload ->> 'temperature')::decimal BETWEEN 55 AND 60 THEN 1 ELSE NULL END)) AS RegularTemperature
    FROM events
    GROUP BY device_id;" > outliers.sql
    ```

1. In the split portal window above Cloud Shell, go to your Azure Cosmos DB for PostgreSQL cluster.
1. On the left menu under **Settings**, select **Connection String**.
1. Copy the value for **PostgreSQL connection URL**.
1. In the Cloud Shell command line, store the connection URL in a variable named `PGURL`. Use your PostgreSQL connection URL, and be sure to update the password placeholder to use your password.

    ```bash
    export PGURL='postgres://citus:YOUR_PASSWORD@YOUR_COORDINATOR_NODE_NAME.postgres.database.azure.com:5432/citus?sslmode=require'
    ```

1. Start benchmarking the query. For this command, you need to know about a few parameters:

    - `-c` is the number of clients that are simulated.
    - `-j` is the number of worker threads in pgbench.
    - `-T` is the time to run (in seconds).
    - `-n` is short for "no-vacuum." Because you're benchmarking a custom query and not a stock test scenario, you need to use this option.
    - `-P` is the time to report progress (in seconds). This value shows the time since you started the query, the transactions per second since the last report, the average transaction latency, the standard deviation, and the number of failed transactions since the last report.
    - `-f` reads from a file.

    Start the following command, and then continue to the next section:

    ```bash
    pgbench $PGURL -c 64 -j 64 -T 1200 -n -P 5 -f outliers.sql
    ```

## Add a worker node

Because Wide World Importers is experiencing a substantial growth in data, you need to add worker nodes to assist with storing data and processing queries. Keep in mind that this step only adds the worker nodes. It doesn't distribute data to the new worker nodes. Also note that after you go from single-node to multi-node, you can't go back to a single-node configuration for the same cluster.

1. In the Azure portal, go to the Azure Cosmos DB for PostgreSQL cluster that you created in the preceding exercise.
1. In the left menu under **Settings**, select **Scale**.
1. In the **Nodes** section, select the following values:
    - **Node count**: **2 nodes**
    - **Compute per node**: **4 vCores, 32 GiB RAM**
    - **Storage per node**: **512 GiB**

    The worker node dropdowns apply to **each** worker node. The values you select aren't split among the worker nodes.

1. Confirm that the **Coordinator** section is already populated with the following values:
    - **Coordinator compute**: **4 vCores, 16 GiB RAM**
    - **Coordinator storage**: **512 GiB**
1. Confirm that your configuration looks like the following screenshot. Then select **Save**.

    :::image type="content" source="../media/scale-to-2-worker-nodes.png" alt-text="Screenshot that shows the options to select on the Scale pane for your cluster.":::

As the nodes are scaling, make note of the benchmark progress reports. Does the number of transactions per second (tps) vary significantly? Did the latency change?

Here's a sample of what you might see when you run your benchmark while scaling is in progress:

```text
progress: 200.0 s, 16.6 tps, lat 3777.639 ms stddev 412.349
progress: 205.0 s, 16.0 tps, lat 3883.296 ms stddev 293.945
progress: 210.0 s, 17.8 tps, lat 3740.630 ms stddev 369.093
progress: 215.0 s, 16.4 tps, lat 3757.807 ms stddev 391.108
progress: 220.0 s, 16.4 tps, lat 3766.657 ms stddev 307.420
progress: 225.0 s, 17.8 tps, lat 3843.797 ms stddev 353.991
progress: 230.0 s, 16.0 tps, lat 3774.659 ms stddev 587.353
progress: 235.0 s, 17.2 tps, lat 3767.750 ms stddev 481.232
progress: 240.0 s, 18.2 tps, lat 3762.134 ms stddev 547.005
progress: 245.0 s, 16.2 tps, lat 3862.109 ms stddev 425.600
progress: 250.0 s, 15.6 tps, lat 3737.595 ms stddev 462.585
progress: 255.0 s, 19.0 tps, lat 3789.396 ms stddev 397.788
progress: 260.0 s, 15.4 tps, lat 3810.983 ms stddev 512.523
progress: 265.0 s, 17.8 tps, lat 3752.572 ms stddev 349.812
progress: 270.0 s, 16.4 tps, lat 3761.078 ms stddev 283.022
progress: 275.0 s, 16.8 tps, lat 3772.768 ms stddev 226.155
progress: 280.0 s, 16.6 tps, lat 3818.130 ms stddev 438.356
progress: 285.0 s, 16.6 tps, lat 3934.123 ms stddev 468.004
progress: 290.0 s, 17.0 tps, lat 3785.802 ms stddev 312.983
progress: 295.0 s, 17.8 tps, lat 3752.572 ms stddev 390.830
```

The number of transactions per second and the latency should be fairly consistent and not vary wildly throughout the process. Because pgbench runs the query on the data that was loaded in the preceding exercise, this result is similar to your customers accessing the database while you're scaling your single-node database to a multi-node cluster.

If the scale finishes before the 20-minute mark, select **Ctrl+C** to stop the benchmark. You use pgbench for benchmarking in an upcoming exercise. Don't close Cloud Shell yet because next you need it to run a check by using psql.

## What if Wide World Importers started with minimal resources?

At the beginning of this training module, when you provisioned your Azure Cosmos DB for PostgreSQL cluster, you configured the resources to be more than the default values. You took this step to ensure minimal downtime in this process. However, if Wide World Importers started with the default resources that are used for a single node, it would have to increase the compute cores and storage on the coordinator as part of the requirements to switch to a multi-node cluster. When you switch from minimal resources to the minimum requirements for the multi-node cluster, you see the following notice. The message indicates that the node will be restarted because you changed the coordinator compute cores and coordinator storage. Because the node needs to restart, there will be downtime. Select **Continue** to continue switching from a single node to a multi-node environment.

:::image type="content" source="../media/restart-single-to-multi-node.png" alt-text="Screenshot that shows a dialog that's shown when you change from a single-node configuration to multi-node, with Continue selected.":::

If you provisioned your demo environment by using the minimal resources, the pgbench process sees errors like this example:

```text
pgbench: error: client 20 script 0 aborted in command 0 query 0: FATAL:  terminating connection due to administrator command
SSL connection has been closed unexpectedly
```

In that scenario, the pgbench process would end with output that looks like this example:

```text
pgbench: fatal: Run was aborted; the preceding results are incomplete.
```

If you want to prepare for growing from a single-node configuration to a multi-node configuration with minimal disruption, it's a good idea to start (as we did earlier) with the following resource allocation:

- One node
- Compute: Four vCores with 16 GiB of RAM
- Storage: 512 GiB

## Confirm that data isn't distributed or scaled

After the nodes are provisioned and pgbench has stopped, you can use the Cloud Shell session for this step. Because the tables haven't been converted to distributed types, they're all located on the coordinator node. The `citus_tables` view shows tables that are distributed. You shouldn't see any tables in this view.

1. Reconnect to the Azure Cosmos DB for PostgreSQL cluster by using psql in Cloud Shell.
1. In psql, run the following query:

    ```sql
    SELECT * FROM citus_tables;
    ```

No tables are returned because no tables have been configured for distribution yet. Next, you need to determine how the tables should be distributed. Because data already exists, you need to distribute the data with minimal impact to the system.
