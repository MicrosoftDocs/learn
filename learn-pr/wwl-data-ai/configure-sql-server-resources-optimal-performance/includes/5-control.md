While some SQL Servers or Azure SQL managed instances are dedicated to a single application's databases, a configuration often seen in mission-critical applications, many servers support databases for multiple applications with varying performance requirements and peak workload cycles. Balancing these differing requirements can be challenging for administrators. One effective way to manage server resources is by using Resource Governor, introduced in SQL Server 2008.

[Resource Governor](/sql/relational-databases/resource-governor/resource-governor) is a feature in SQL Server and Azure SQL managed instances that allow granular control over CPU, physical I/O, and memory resources for incoming application requests. When enabled at the instance level, Resource Governor uses a classifier function to define how connections are treated, subdividing sessions into workload groups. Each workload group is configured to use a specific pool of system resources.

## Resource pools

A resource pool represents the physical resources available on the server. SQL Server always has two pools: default and internal, even when Resource Governor isn't enabled. The internal pool is reserved for critical SQL Server functions and can't be restricted. The default pool, along with any resource pools you explicitly define, can be configured with limits on the resources they can use. For each noninternal pool, you can specify the following limits:

- Min/Max CPU percent
- Cap of CPU percent
- Min/Max memory percent
- NUMA node affinity
- Min/Max IOPs per volume

>[!NOTE]
>Changes to a resource pool only impact new sessions, not those already in progress. Therefore, modifying a pool won't restrict the resources of a long-running process. The exception to this rule is external pools used with SQL Server Machine Learning Services, which can be limited by a pool change even for ongoing sessions.

All resource pool settings, except for the minimum and maximum CPU percentage, represent hard limits that can't be exceeded. The min/max CPU percentage only applies when there's CPU contention. For instance, if you set a maximum of 70%, the workload may use up to 100% of available CPU cycles when there's no contention. However, if other workloads are running, the workload will be restricted to 70%.

## Workload group

A workload group serves as a container for session requests, classified by the classifier function. Similar to resource pools, there are two built-in groups: default and internal. Each workload group is associated with a single resource pool, but a resource pool can host multiple workload groups. By default, all connections are directed to the default workload group unless the classifier function assigns them to a user-defined group. The default workload group utilizes the resources allocated to the default resource pool.

## Classifier function

The classifier function is run at the time a connection is established to the SQL Server instance and classifies each connection into a given workload group. If the function returns a NULL, default, or the name of the nonexistent workload group the session is transferred into the default workload group. Since the classifier is run at every connection, it should be tested for efficiency. The following image shows a sample classifier function that classifies users based on their user name.

```sql
CREATE FUNCTION dbo.RGClassifier()
RETURNS SYSNAME
WITH SCHEMABINDING
AS
BEGIN
DECLARE @WorkloadGroup AS SYSNAME
IF(SUSER_NAME() = 'ReportUser')
    SET @WorkloadGroup = 'ReportServerGroup'

ELSE IF (SUSER_NAME() = 'PrimaryUser')
    SET @WorkloadGroup = 'PrimaryServerGroup'
ELSE
    SET @WorkloadGroup = 'default'

RETURN @WorkloadGroup
END
```

You can increase the complexity of the function definition shown in the example, but you should verify that the more complex function doesn't impact the user performance.

## Resource Governor use cases

Resource Governor is used primarily in multitenant scenarios where a group of databases share a single SQL Server instance, and performance needs to be kept consistent for all users of the server. You can also use Resource Governor to limit the resources used by maintenance operations like consistency checks and index rebuilds, to try to guarantee sufficient resources for user queries during your maintenance windows.
