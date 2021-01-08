As a data engineer, your job isn't finished once a database and its data have been migrated. You'll need to check that apps can access the new location, and that there hasn't been any performance degradation.

Having chosen how to move your on-premises databases into an Azure VM, and having migrated them, you'll now check your bike manufacturing company's applications can access the new database servers. For the databases that you chose to upgrade, or change compatibility level, you'll also want to validate that the databases are still performing well.

In this unit, you'll look at the final steps of migrating a SQL Server to a VM. You'll note that all the apps need to update their connection strings. Then you'll check how the databases are performing, and take action where things can be improved.

## Application connectivity to Azure Virtual Machines

One of the key benefits of doing a migration to SQL Server on an Azure Virtual Machine is that you can migrate the database and the applications with minimal changes to code. You might only need to change the connection string information within your applications. This statement assumes that the database is migrated to the same version of SQL Server, and the database stays at the same compatibility level that is on your on-premises server. If not, then there are a number of considerations that must be taken into account.

## Business intelligence considerations

Many on-premises business intelligence technologies have Platform as a Service (PaaS) equivalent technologies to take advantage of in Azure such as Azure Data Factory, Azure Analysis Services, Power BI, and more. There are scenarios where a business has invested heavy amounts of time and resources in building rich business intelligence estates. These business intelligence estates could consist of SQL Server Integration Services packages, complex SQL Server Reporting Services landscapes with scaled-out topologies using highly available reports. They often rely on scheduled reports that are sent to directly their consumers. There are also organizations who have heavily invested in MDX. They then use SQL Server Analysis Services where they haven't yet embraced an Analysis Services tabular model.

For these scenarios, it may seem their business intelligence investment is also a blocker for moving to PaaS options, but this isn't the case. It simply means there's a choice between using SQL Server on an Azure Virtual machine, or migrating to a Platform as a Service (PaaS). An organization could decide to remain on-premises too. The reality is you can use any of these approaches to accomplish your business goals. You can always change your business intelligence investment, on your own time, at a future date.

There's nothing stopping organizations from deploying a fully scaled-out Reporting Services solution in the same Microsoft Azure Virtual Network (VNet) that Managed Instance and Managed Instance databases are located in. You can also put your business intelligence solution in a separate VNet, and use VNet peering to ensure connectivity is secure. It's recommended you use Platform as a Service (PaaS) technologies to get the most up-to-date experience in Azure.

## Post migration considerations

There are a number of post migrations steps that you'll want to take to complete the migration if the database has been upgraded to a newer version of SQL Server, or a higher database compatibility level. The checks largely involve ensuring that the database performance hasn't been degraded. These checks are valid with migrations to SQL Database and SQL Database Managed Instance, as well as SQL Server on an Azure VM.

### Query performance

It's important when you're migrating from legacy technologies such as SQL server 2008, that you take advantage of the latest database compatibility. However, there are times that latest compatibility level produces non-optimal results that end up with query regressions. This is the perfect scenario to use Query Store, which is like a black box recorder at the database level. Query Store also captures execution plans where you can identify parameter sniffing issues and specifically see when queries have regressed. Use the Query Store to get a baseline of a healthy state, and then compare this healthy state when there are issues when you change the compatibility level.

A workload may be exposed to the risk of performance regression when you migrate from an older version of SQL Server to SQL Server 2014 (12.x) or newer, and change the database compatibility level. Starting with SQL Server 2014, all Query Optimizer changes are tied to the latest database compatibility level. However, plans aren't changed at point of upgrade, but when a user changes the COMPATIBILITY_LEVEL of the database. This capability, in combination with Query Store gives you a lot of control over the query performance during the upgrade process. Parameter sniffing performance can be addressed using these steps:

1. Use the RECOMPILE hint. A plan is calculated every time adapted to each parameter value.
1. Rewrite the stored procedure to use the option (`OPTIMIZE FOR`("input parameter" = "value")). Decide which value to use that suits most of the relevant workload, creating and maintaining one plan that becomes efficient for the parameterized value.
1. Rewrite the stored procedure using local variable inside the procedure. Now the optimizer uses the density vector for estimations, resulting in the same plan whatever the parameter value.
1. Rewrite the stored procedure to use the option (`OPTIMIZE FOR UNKNOWN`). Same effect as using the local variable technique.
1. Rewrite the query to use the hint `DISABLE_PARAMETER_SNIFFING`. Same effect as using the local variable technique by totally disabling parameter sniffing, unless `OPTION(RECOMPILE)`, `WITH RECOMPILE` or `OPTIMIZE FOR` "value" is used.

### Missing indexes

Incorrect or missing indexes cause extra I/O that leads to extra memory and CPU being used in a suboptimal way. This may be because the workload profile has changed such as using different predicates, which invalidate existing index design. Evidence of a poor indexing strategy or changes in workload profile include lookups for duplicate, redundant, rarely used, and unused indexes. Resolve index issues by:

1. Use the graphical execution plan for any Missing Index references
1. Indexing suggestions generated by Database Engine Tuning Advisor
1. Run the Missing Indexes DMV `sys.dm_db_missing_index_details`, or through the SQL Server Performance Dashboard
1. Use any pre-existing scripts that can use existing DMVs to provide insights into indexes
1. Check fo any index reference that is hinted/hard-coded into existing procedures and functions in your database

### Poorly written T-SQL statements

SQL Server Query Optimizer can only account for information that is known at compile time. If a workload relies on predicates that can only be known at execution time, then the potential for a poor plan choice increases. For a better-quality plan, predicates must be SARGable, or Search ARGument able. Some examples of non-sargable predicates:

- Implicit data conversions, like VARCHAR to NVARCHAR, or INT to VARCHAR. Look for runtime CONVERT_IMPLICIT warnings in the Actual Execution Plans. Converting from one type to another can also cause a loss of precision.
- Complex undetermined expressions such as WHERE UnitPrice + 1 < 3.975, but not WHERE UnitPrice < 320*200*32.
- Expressions using functions, such as WHERE ABS(ProductID) = 771 or WHERE UPPER(LastName) = 'Smith'
- Strings with a leading wildcard character, such as WHERE LastName LIKE '%Smith', but not WHERE LastName LIKE 'Smith%'.

You can use the following steps to resolve these types of issues:

1. Always declare variables/parameters as the intended target data type. Compare your user-defined code constructs stored in the database with system tables that hold information on the data types used in underlying tables.
1. If unable to traverse all code to the previous point, change the data type on the table to match any variable/parameter declaration.
1. Reason out the usefulness of functions being used as predicates.
1. Reason out the usefulness of wildcard searches.
1. Reason out the usefulness of complex expressions based on columnar data. Evaluate the need to instead create persisted computed columns, which can be indexed.

### Missed estimates

For SQL Server to SQL Server migrations, if this issue existed in the source SQL Server, migrating to a newer version of SQL Server as-is won't fix the issue. Table-Valued Functions return a table data type that can be an alternative to using views. While views are limited to a single SELECT statement, user-defined functions can contain additional statements that allow more logic.

> [!IMPORTANT] 
> Since the output table of a multi-statement Table-Valued Function (MSTVF) is not created at compile time, the SQL Server Query Optimizer relies on heuristics, and not actual statistics, to determine row estimations. Even if indexes are added to the base table(s), this is not going to help. For MSTVFs, SQL Server uses a fixed estimation of 1 for the number of rows expected to be returned by an MSTVF (starting with SQL Server 2014 (12.x) that fixed estimation is 100 rows).

The ways this can be resolved is as follows:

- If the Multi-Statement TVF is single statement only, convert to Inline TVF.
- Setting the database compatibility level 140 may provide the best approach ff you can't make changes to the code because the application is from a vendor or you've some other deployment challenge. At `db_compat` level 140, Adaptive Query Processing (AQP) might provide performance improvements to avoid rewriting the query.

### Other post migration steps

The other post migration steps that you should be aware of come down to taking advantage of Azure SQL Database, SQL Database Manage Instance, and SQL Server improvements that have been made to the product. There are a number of different improvements that have been made to:

- Security
- Performance
- Troubleshooting and management capabilities
- High availability and disaster recovery
- Business intelligence

For example, failover groups in SQL Database Managed Instance provides a good method to extend high availability to other regions. It's a simple configuration but it does require some intervention to implement.

Security technologies such as row level security, dynamic data masking, always encrypted, and transparent data encryption. All of these require you to opt in to take advantage of the enhanced security capabilities. Also, technologies such as Query Store, the newer dynamic management views and functions, extended events, diagnostic tracing, and auditing are all greatly improved compared to previous releases. It's important to be informed on the capabilities of these technologies to make the best use of them.

Finally, once the migration has completed. It's important to get all of your maintenance scripts in place to rebuild indexes and update statistics. Ensure that there are no orphaned users, that backups are executing correctly and successfully. You should then check the state of the error log and the general architecture of the environment.