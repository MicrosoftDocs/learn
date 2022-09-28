You've already learned that the MySQL server maintains a cache of threads available to new connections, and that when a thread is no longer required it's destroyed.

Azure Database for MySQL Flexible Server allows you to configure a **thread pool**, a feature that provides a pool of worker threads that limit the number of active threads running on the server. For workloads with many short-lived connections and short transaction queries, this feature improves performance and the scalability of Azure Database for MySQL.

The Enterprise edition of MySQL offers a thread pool plugin.

> [!NOTE]
> Thread pool is a feature of Azure Database for MySQL Flexible Server and is only supported on version 8.0 or later.

Using Thread Pool is likely to be more efficient for the following scenarios:

- More than 500 simultaneous connections.
- High CPU utilization.
- High bursts of connections at the same time.

Using Thread Pool is likely to be less efficient for the following scenarios:

- Long periods of inactivity followed by high activity.
- Long running queries that never wait.
- Insufficient IOPS. Flexible server allows additional IOPS up to 20 K above the IOPS limit.

To enable thread pool in the Azure portal:

1. Navigate to your Azure Database for MySQL server, then select **Server parameters**.
1. In the search bar, enter **thread_handling** to display the **thread_handling** parameter.
1. Change the value to **pool-of-threads**. By default, this parameter is set to **one-thread-per-connection**, which creates a new thread for each new connection.

> [!NOTE]
> **thread_handling** is a static parameter and will only be applied when the server restarts. It can also be modified using Azure CLI.

There are two further settings that can improve performance by allowing threads to remain active and wait for the next query. This is known as *batch execution*, and the parameters are:

- **thread_pool_batch_wait_timeout** specifies the maximum time that a thread will wait for another query.
- **thread_pool_batch_max_time** specifies the number of times that a thread will repeat the cycle of query execution and waiting.

You can also define the number of threads in the pool by setting the following server parameters:

- **thread_pool_max_threads** This defines the maximum number of threads in the pool at any one time.
- **thread_pool_min_threads** This defines the minimum number of threads that will be reserved in the pool, even after connections are closed.

> [!NOTE]
> MySQL 5.6 doesn't support thread pools.
