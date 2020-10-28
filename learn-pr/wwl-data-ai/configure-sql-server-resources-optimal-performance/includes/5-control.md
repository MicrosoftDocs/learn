While some SQL Servers or Azure SQL managed instances only support one application’s databases (this configuration is commonly seen in mission critical applications), many servers support databases for multiple applications with differing performance requirements and different peak workload cycles. Balancing these differing requirements can be challenging to the administrator. One of the ways to balance server resources is to use Resource Governor, which was introduced to SQL Server 2008.

Resource Governor is a feature in SQL Server and Azure SQL managed instance that allows you to granularly control how much CPU, physical IO, and memory resources can be used by an incoming request from an application. Resource Governor is enabled at the instance level and allows you to define how connections are treated by using a classifier function, which subdivides sessions into workload group. Each workload group is configured to use a specific pool of system resources.

## Resource pools

A resource pool represents physical resources available on the server. SQL Server always has two pools, default and internal, even when Resource Governor is not enabled. The internal pool is used by critical SQL Server functions and cannot be restricted. The default pool, and any resource pools you explicitly define, can be configured with limits on the resources it can use. You can specify the following limits for each non-internal pool:

- Min/Max CPU percent

- Cap of CPU percent

- Min/Max memory percent

- NUMA node affinity

- Min/Max IOPs per volume

>[!NOTE]
>Changes to a pool only affect new sessions, not existing ones. A change to a pool will not help you restrict the resources of a long-running process. The exception is external pools used in conjunction with SQL Server Machine Learning Services, which are external to SQL Server and can be limited by a pool change.

With the exception of min/max CPU percent, all of the other resource pool settings represent hard limits and cannot be exceeded. Min/Max CPU percentage will only apply when there is CPU contention. For example, if you have a maximum of 70%, if there is available CPU cycles the workload may use up to 100%. If there are other workloads running, the workload will be restricted to 70%.

## Workload group

A workload group is a container for session requests based on their classification by the classifier function. Like resource pools there are two built-in groups, default and internal, and each workload group can only belong to one resource pool. However, a resource pool can host multiple workload groups. All connections go into the default workload group, unless they passed into another user-defined group by the classifier function. And by default, the default workload group uses the resources assigned to the default resource pool.

## Classifier function

The classifier function is run at the time a connection is established to the SQL Server instance and classifies each connection into a given workload group. If the function returns a NULL, default, or the name of the non-existent workload group the session is transferred into the default workload group. Since the classifier is run at every connection, it should be tested for efficiency. The following image shows a sample classifier function that classifies users based on their user name.

```SQL
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

You can increase the complexity of the function definition shown in the example, but you should verify that the more complex function doesn't impact the user login performance.

## Resource Governor use cases

Resource Governor is used primarily in multi-tenant scenarios where a group of databases share a single SQL Server instance, and performance needs to be kept consistent for all users of the server. You can also use Resource Governor to limit the resources used by maintenance operations like consistency checks and index rebuilds, to try to guarantee sufficient resources for user queries during your maintenance windows.
