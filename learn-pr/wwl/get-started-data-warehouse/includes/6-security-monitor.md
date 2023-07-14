---
ms.custom:
  - build-2023
---
Security and monitoring are critical aspects of managing your data warehouse.

## Security

Data warehouse security is important to protect your data from unauthorized access. Fabric provides a number of security features to help you secure your data warehouse. These include:

- Role-based access control (RBAC) to control access to the warehouse and its data.
- SSL encryption to secure the communication between the warehouse and the client applications.
- Azure Storage Service Encryption to protect the data in transit and at rest.
- Azure Monitor and Azure Log Analytics to monitor the warehouse activity and audit the access to the data.
- Multi-Factor Authentication (MFA) to add an extra layer of security to user accounts.
- Azure Active Directory (Azure AD) integration to manage the user identities and access to the warehouse.

### Workspace permissions

Data in Fabric is organized into workspaces, which are used to control access and manage the lifecycle of data and services. Appropriate workspace roles are the first line of defense in securing your data warehouse.

In addition to workspace roles, you can grant *item permissions* and access through SQL.

> [!TIP]
> See [Workspaces in Power BI](https://learn.microsoft.com/power-bi/collaborate-share/service-new-workspaces#roles-and-licenses) for more information on workspace roles.

### Item permissions

In contrast to workspace roles, which apply to all items within a workspace, you can use *item permissions* to grant access to individual warehouses. This enables you to share a single data warehouse for downstream consumption.

You can grant permissions to users via T-SQL or in the Fabric portal. Grant the following permissions to users who need to access your data warehouse:

- Read: Allows the user to CONNECT using the SQL connection string. 
- ReadData: Allows the user to read data from any table/view within the warehouse.
- ReadAll: Allows user to read data the raw parquet files in OneLake that can be consumed by Spark.

A user connection to the SQL endpoint will fail without Read permission at a minimum.

## Monitoring

Monitoring activities in your data warehouse is crucial to ensure optimal performance, efficient resource utilization, and security. It helps you identify issues, detect anomalies, and take action to keep the data warehouse running smoothly and securely.

You can use *dynamic management views* (DMVs) to monitor connection, session, and request status to see live SQL query lifecycle insights. With DMVs, you can get details like the number of active queries and identify which queries are running for an extended period and require termination.

There are currently three DMVs available to use in Fabric:

- sys.dm_exec_connections: Returns information about each connection established between the warehouse and the engine.
- sys.dm_exec_sessions: Returns information about each session authenticated between the item and engine.
- sys.dm_exec_requests: Returns information about each active request in a session.

### Query monitoring

Use 'sys.dm_exec_requests' to identify long-running queries that may be impacting the overall performance of the database, and take appropriate action to optimize or terminate those queries.

Start by identifying the queries that have been running for a long time. Use the following query to identify which queries have been running the longest, in descending order:

```sql
    SELECT request_id, session_id, start_time, total_elapsed_time
    FROM sys.dm_exec_requests
    WHERE status = 'running'
    ORDER BY total_elapsed_time DESC;
```

You can continue investigating to understand which user ran the session with the long-running query, by running:

```sql
    SELECT login_name
    FROM sys.dm_exec_sessions
    WHERE 'session_id' = 'SESSION_ID WITH LONG-RUNNING QUERY';
```

Finally, you can use the `KILL` command to terminate the session with the long-running query:

```sql
    KILL 'SESSION_ID WITH LONG-RUNNING QUERY';
```

> [!IMPORTANT]
> You must be a workspace Admin to run the `KILL` command. Workspace Admins can execute all three DMVs. Member, Contributor, and Viewer roles can see their own results within the warehouse, but cannot see other users' results.
