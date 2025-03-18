MySQL supports two broad categories of connections:

- **Short-lived** - a connection that is open for a short period of time to execute a simple query. MySQL's architecture is designed for this type of workload, handling up to 80 thousand connect and disconnects per second.
- **Long-lived** - a connection that is open "indefinitely" such as a web server or application server. In this scenario, the client makes a connection to a MySQL server and then does not disconnect until the client server is stopped, keeping the connection for weeks or months.

The server parameter **max_connections** defines the maximum number of client connections permitted. Once this maximum is reached, MySQL will not allow any new connections until an active connection is disconnected.

## Connection pooling and persistent connections

The way that an application manages database connections can have a significant impact on the overall performance of a database. You should aim to reduce:

- The number of times connections are established.
- The time for establishing connections in key code paths.

For best results, consider using either connection pooling or persistent connections to connect to Azure Database for MySQL servers.

**Connection pooling** is used to handle the creation, management, and allocation of database connections. When a database connection is requested, it prioritizes the allocation of existing idle database connections, rather creating a new connection. After the connection has finished, it is recovered so that it can be used again instead of being closed. See [Java samples to illustrate connection pooling | Microsoft Learn](/azure/mysql/sample-scripts-java-connection-pooling).

**Persistent connections** is a similar idea to that of connection pooling. Persistent connections replace short-lived connections that typically execute within < 5-10 millisecond with long-lived connections. This change often requires only minor changes to your code but can make major performance improvements for typical application scenarios. This approach avoids a new connection thread being created for each new query, thereby improving performance.

## Connection stored procedures

Azure Database for MySQL allows many parameters to be viewed and modified in the Azure portal by navigating to the server and the **Server Parameters** blade (or using Azure CLI). There are, however, two administrative tasks that require additional privileges must be carried out using stored procedures. These are:

- mysql.az_kill - equivalent to the KILL CONNECTION statement. Takes the processlist_id as input parameter. Terminates the connection after terminating a statement being executed by the connection.
- mysql.az_kill_query - equivalent to the KILL QUERY statement. Takes the processlist_id as input parameter. Terminates only the statement being executed by the connection and does not terminate the connection.

These stored procedures require SUPER USER privileges.

## Connection efficiency

For best performance, you should typically use **ProxySQL**, or **Heimdall Data Proxy** proxy solutions for MySQL. For more information on connection efficiency, see [Connection Efficiency](/azure/mysql/concept-performance-best-practices).
