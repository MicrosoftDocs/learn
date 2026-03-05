Security and monitoring are critical aspects of managing your data warehouse. Fabric provides multiple layers of protection and visibility tools to help you control access and understand query performance.

## Security

Fabric data warehouse security operates at multiple levels, from workspace access down to individual rows and columns. This design allows you to support the distinct needs of your organization by still allowing the democratization of data, but with governance.

### Workspace roles

Data in Fabric is organized into *workspaces*, and workspace roles are the first layer of access control. Assign users to appropriate roles based on the level of access they need. For example, Admins have full control, while Viewers can view items but can't make changes.

> [!TIP]
> For more information, see [Workspaces in Power BI](/power-bi/collaborate-share/service-new-workspaces#roles-and-licenses).
### Item permissions

In addition to workspace roles, you can grant **item permissions** to share individual warehouses without granting access to the entire workspace. This granularity is useful when you need to share a warehouse for downstream consumption with specific users.

Grant the following permissions as needed:

- **Read** - Allows the user to connect using the SQL analytics endpoint.
- **ReadData** - Allows the user to read data from any table or view in the warehouse.
- **ReadAll** - Allows the user to read raw parquet files in OneLake.

> [!NOTE]
> A user connection to the SQL analytics endpoint fails without Read permission at a minimum.

### Granular SQL security

For more precise access control, Fabric data warehouse supports granular security using T-SQL. These features let you restrict data visibility without changing the underlying tables:

- **Object-level security** - Control access to specific tables, views, or procedures.
- **Row-level security (RLS)** - Restrict which rows a user can see using WHERE clause predicates.
- **Column-level security (CLS)** - Restrict which columns are visible to specific users.
- **Dynamic data masking** - Mask sensitive data (such as email addresses or account numbers) from non-privileged users.

Securing your warehouse data is important for both regulatory compliance and for ensuring that AI-powered tools like Copilot and data agents operate within governed boundaries. Security policies you define in T-SQL are enforced regardless of how the data is accessed.

> [!TIP]
> Row-level security, column-level security, and dynamic data masking are covered in depth in [Secure a Microsoft Fabric data warehouse](/training/modules/secure-data-warehouse-in-microsoft-fabric/).

## Monitoring

Monitoring warehouse activity helps you identify performance issues, optimize queries, and understand usage patterns.

### Query insights

*Query insights* provides a central location for historical query data and actionable performance information. It retains data for 30 days and helps you identify long-running queries, track performance changes over time, and understand which queries consume the most resources.

Query insights uses system views that you can query directly:

- `queryinsights.exec_requests_history` - Returns information about each completed SQL request.
- `queryinsights.long_running_queries` - Returns queries ranked by execution time.
- `queryinsights.exec_sessions_history` - Returns information about completed sessions.

### Dynamic management views

You can also use *dynamic management views* (DMVs) to monitor active connections, sessions, and requests in real time. For example, use `sys.dm_exec_requests` to identify currently running queries:

```sql
SELECT request_id, session_id, start_time, total_elapsed_time
FROM sys.dm_exec_requests
WHERE status = 'running'
ORDER BY total_elapsed_time DESC;
```

> [!IMPORTANT]
> You must be a workspace Admin to run the `KILL` command to terminate long-running sessions. Members, Contributors, and Viewers can see their own results but can't see other users' queries.
