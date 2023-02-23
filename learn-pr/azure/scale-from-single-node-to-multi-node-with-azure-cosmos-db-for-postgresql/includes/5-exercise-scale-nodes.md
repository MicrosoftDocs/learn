As Wide World Importers expands the number of sensors, the database needs to scale to handle the growth in the amount of data. For this exercise, you'll scale the Azure Cosmos DB for PostgreSQL instance created in the previous exercise to:

- One coordinator node, with 4 vCores and 0.5 TiB of storage
- Two worker nodes, each with 4 vCores and 0.5 TiB of storage

To show that the system isn't down while scaling, you can start benchmarking a query and let it run while scaling.

## Start benchmarking

[pgbench](https://www.postgresql.org/docs/current/pgbench.html) is used for benchmarking query and server performance. For this example, you'll use the outliers query used in the last exercise as a base. You'll alter the outliers query to bring back all outliers. The updated SQL for the outliers query is this:

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

You'll store this SQL in a file and have `pgbench` run the benchmark for some time. It reports its findings periodically so that you can be sure the benchmark is still running. Since `pgbench` is accessing the data created in the previous exercise, this exercise is simulating scaling the Azure Cosmos DB for PostgreSQL cluster while the data is in use.

For this exercise, `pgbench` will be set to run for 20 minutes. The scale process may take about 20 minutes.

1. Open [Azure Cloud Shell](https://shell.azure.com) from the icon at the top of the Azure portal. From the `bash` prompt, run the following command to store the outlier query in a SQL file.

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

2. In the portal above Azure Cloud Shell, navigate to your Azure Cosmos DB for PostgreSQL cluster.
3. Under **Settings** in the navigation, select **Connection String**.
4. Copy the value for **PostgreSQL connection URL**.
5. In the command line, store the connection URL in a variable named `PGURL`. Use your PostgreSQL connection URL, and be sure to update the password to your password.

    ```bash
    export PGURL='postgres://citus:YOUR_PASSWORD@YOUR_COORDINATOR_NODE_NAME.postgres.database.azure.com:5432/citus?sslmode=require'
    ```

6. Start benchmarking the query. For this command, there are a few parameters to know:

    - `-c` is the number of clients that are simulated.
    - `-j` is the number of worker threads in `pgbench`.
    - `-T` is the time to run (in seconds).
    - `-n` is short for "no-vacuum". Since you're benchmarking a custom query and not a stock test scenario, you need to use this option.
    - `-P` is the time to report progress (in seconds). This shows the time since starting the query, the transactions per second since the last report, average transaction latency, standard deviation, and number of failed transactions since the last report.
    - `-f` reads from a file.

    Start the following command and then continue to the next section:

    ```bash
    pgbench $PGURL -c 64 -j 64 -T 1200 -n -P 5 -f outliers.sql
    ```

## Add a worker node

Since Wide World Importers is experiencing a growth in data, you need to add worker nodes to assist with the storage of data and processing of the queries. Keep in mind that this step only adds the worker nodes. It doesn't distribute data to the new worker nodes. Also note that once you go from single node to multi-node, you can't go back from multi-node to single node.

1. In the Azure portal, navigate to the Azure Cosmos DB for PostgreSQL cluster created in the previous exercise.
2. From the navigation menu, select **Scale**.
3. Set the **Nodes** section with the following values:
    - **Node count**: **2 nodes**
    - **Compute per node**: **4 vCores, 32 GiB RAM**
    - **Storage per node**: **512 GiB**

    > **Note**: The worker node dropdowns apply to **each** worker node, not split among the worker nodes.

4. Confirm the **Coordinator** section is already populated with the following values:
    - **Coordinator compute**: **4 vCores, 16 GiB RAM**
    - **Coordinator storage**: **512 GiB**
5. Confirm your configuration looks like the screenshot below. Select **Save**.

    ![Screenshot of the Scale screen for the Azure Cosmos DB for PostgreSQL resource. The 'Scale' option in the resource navigation is highlighted. The 'Node count' dropdown shows '2 nodes'. The 'Compute per node' dropdown shows '4 vCores, 32 GiB RAM'. The 'Storage per node' shows '512 GiB '. The 'Coordinator compute' dropdown shows '4 vCores, 16 GiB RAM'. The 'Coordinator storage' dropdown shows '512 GiB'.](../media/scale-to-2-worker-nodes.png)

As the nodes are scaling, make note of the benchmark progress reports. Does the number of transactions per second (tps) vary significantly? Did the latency change?

This is a sample of what you may see when running your benchmark while scaling:

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

The number of transactions per second and the latency should be fairly consistent and not vary wildly throughout the process. As `pgbench` is running the query on the data loaded in the previous exercise, this is similar to your customers accessing the database while you're scaling your single-node cluster to a multi-node cluster.

If the scale finishes before the 20-minute mark, use `Ctrl+C` to stop the benchmark. You'll use `pgbench` for benchmarking in an upcoming exercise. Don't close Azure Cloud Shell yet, as you need it to run a check with `psql`.

## What if Wide World Importers started with minimal resources?

At the beginning of this module, when you provisioned your Azure Cosmos DB for PostgreSQL cluster, you configured the resources to be more than the default values. This was done to ensure minimal downtime in this process. However, if Wide World Importers started with the default resources used for a single node, they would have to increase the compute cores and storage on the coordinator as part of the requirements for a multi-node cluster. When going from minimal resources to the minimum requirements for the multi-node cluster, you'll see the following notice that indicates that the node will be restarted due to changing the coordinator compute cores and coordinator storage. Since the node needs to restart, there will be downtime. Select **Continue** to continue switching from a single node to a multi-node environment.

![Screenshot of the messaging when saving changes from a single node to multi-node. The messaging states 'You selected to change configuration for this cluster from single node to multi-node. The following configuration items are going to change: 1. Worker node count 2. Coordinator compute cores (requires restart) 3. Coordinator storage (requires restart). Some of these changes require node restart. Changing the configuration back from multi-node to single node isn't supported.'](../media/restart-single-to-multi-node.png)

If you provisioned your demo environment with the minimal resources, the `pgbench` process would see errors like this:

```text
pgbench: error: client 20 script 0 aborted in command 0 query 0: FATAL:  terminating connection due to administrator command
SSL connection has been closed unexpectedly
```

The `pgbench` process would end with:

```text
pgbench: fatal: Run was aborted; the above results are incomplete.
```

If you want to prepare for growing from a single-node configuration to a multi-node configuration with minimal disruption, it's advised to start--as we did earlier--with the following resource allocation:

- One node
- Compute: 4 vCores with 16-GiB RAM
- Storage: 512 GiB

## Confirm data isn't distributed or scaled

Once the nodes are finished provisioning and `pgbench` has stopped, you can reuse the Azure Cloud Shell session for this step. As the tables haven't been converted to distributed types, they all live on the coordinator node. The `citus_tables` view shows tables that are distributed. You shouldn't see any tables on it.

1. Reconnect to the Azure Cosmos DB for PostgreSQL cluster using `psql` in Azure Cloud Shell.
2. In `psql`, run the following query:

    ```sql
    SELECT * FROM citus_tables;
    ```

Notice that there are no tables returned. No tables have been configured for distribution yet. You need to identify how the tables should be distributed. As there's data already existing, you need to distribute the data with minimal impact to the system.
