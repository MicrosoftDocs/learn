Every client connection has its own thread, and queries are executed within that thread. Each thread executes on a single core. Concurrency is the number of threads that can execute at the same time. By default, the Innodb storage engine will execute as many threads concurrently as needed.

Innodb manages thread concurrency using several server parameters. Two parameters regulate the number of concurrent threads:

- Innodb_thread_concurrency
- Innodb_thread_sleep_delay

The default value of **Innodb_thread_concurrency** is zero, which means that Innodb does not place a limit the number of concurrently executing threads. Generally, the advice is not to change this parameter unless you need to place a limit on the number of concurrent threads that can execute at any one time.

For databases with a particularly high workload, or when you suspect that concurrency is the cause of poor performance, you can place a limit on the number of concurrently running threads. A starting point is to set **innodb_thread_concurrency** to either the same number, or twice the number of available cores. Each query can only execute on one core, but execution time will be extremely fast.

If a thread cannot execute because **innodb_thread_concurrency** has reached its limit, the **Innodb_thread_sleep_delay** defines the number of microseconds the thread waits before trying to execute again. The default value is 10,000 microseconds. If the thread cannot execute the second time it tries, it gets placed in a thread queue. The **Innodb_thread_sleep_delay** value will be correct for most workloads, only if you execute an extremely large number of very small queries could this value be too large and cause latency. However, before changing the value consider setting **Innodb_adaptive_max_sleep_delay**.

**Innodb_adaptive_max_sleep_delay** allows Innodb to adjust the **Innodb_thread_sleep_delay** value depending on the current workload. The default value for **Innodb_adaptive_max_sleep_delay** is 15,000 microseconds. The sleep delay will be adjusted up or down, up to this maximum.

> [!TIP]
> If you are running on adequate hardware and MySQL version 8.0 or later, you probably won't need to change the concurrency parameters. If you are not running on the latest version of MySQL, upgrade to the latest version **before** tuning the concurrency parameters.

> [!NOTE]
> When running on-premises hardware it is difficult to buy new hardware to solve concurrency bottlenecks. For these scenarios, the best solution might be to shard your data.

With Azure Database for MySQL you can upgrade the compute tier easily and cost effectively.

For long running queries, the **innodb_concurrency_tickets** parameter defines the number of "tickets" or the amount of work can be done without any further concurrency checks being done. If you have a lot of very long running queries, you may want to tune this value. For most workloads, however, this value does not need to be changed.

Finally, the **innodb_commit_concurrency** parameter defines how many threads can be committed at the same time. If you've set the **innodb_thread_concurrency** value to limit the number of threads that can run concurrently, tuning **innodb_commit_concurrency** to a low value may help further. The default is 0, which allows any number of threads to commit concurrently.

All these parameters can be displayed and modified in the Azure portal, in **Server parameters, o**r using Azure CLI.

From MySQL Workbench you can see the number of threads that have been created, the number of threads connected, and the number of threads that are running.

:::image type="content" source="../media/workbench-connections.png" alt-text="Screenshot showing the workbench connections." lightbox="../media/workbench-connections.png":::

To view the client connections in MySQL Workbench:

1. Connect to your MySQL server using an existing named connection or by creating a new connection.
1. MySQL Workbench connects to the server and opens a **Query tab**.
1. Select the **Administration** tab.
1. Under **Management**, select **Client Connections**. The following metrics are provided:
    1. Threads connected
    1. Threads running
    1. Threads created
    1. Threads cached
    1. Total connections
    1. Connection limit
    1. Aborted clients
    1. Aborted connections

## Limiting client connections

MySQL normally copes with as many client connections as required. However, if too many connections are made, each running queries, the execution time can slow down until *all* the queries are taking an extended time to finish. This is the *thundering herd* problem - new connections are being added while existing connections cannot execute within a reasonable time.

Azure Database for MySQL allows you to limit the number of connections to the server. This number is displayed in MySQL Workbench **as Connection Limit,** and is also a parameter in Azure Database for MySQL under Server Parameters called **max_connections**. When the number of connections reaches this limit, the server will not connect any more users until the number of connections drops. This is a safeguard against overloading the server and causing queries to take an unacceptable time to run.

To change the **max_connections** value, go to the Azure portal, navigate to your Azure Database for MySQL server, and select **Server Parameters**. In the search bar enter **max_connections** to display or edit the **max_connections** value.

Set **max_connections** to 1x, 2x, or 4x the available CPU cores. Double the number of **max_connections** until the number of transactions per second no longer increases. Once latency starts to increase you know that the number of connections is not limiting performance.
