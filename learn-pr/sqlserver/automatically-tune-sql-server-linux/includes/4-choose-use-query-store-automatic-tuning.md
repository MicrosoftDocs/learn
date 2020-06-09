SQL Server 2019 performance depends on many factors, including query execution plans. If the server chooses a suboptimal query plan, performance might drop and you should return to using the previous plan.

Suppose your wine import company has chosen to run SQL Server 2019 on Red Hat Enterprise Linux (RHEL) servers. These servers host your sales management database. Your team is using Azure Data Studio to investigate and display performance changes over time. You make configuration changes manually when you suspect that a bottleneck has developed.

You've a large database deployment project starting soon and want to reduce the administrative load imposed by the sales database on your team. You can then free personnel to work on the deployment.

Here, you'll learn about the Query Store feature and automatic tuning, which you use to optimize performance with less administrative involvement.

## Query plans and the query optimizer

Users and client software send queries, in the form of Transact-SQL code, to the database server and await results. Queries define what data the user is interested in but don't define the steps the query engine must take to obtain that data from the database. Those steps are defined in a query plan.

A query plan consists of one or more operations that must be executed in a linear flow or in several different branches. The operations might include, for example:

- Scanning an index to return rows
- Computing values
- Merging results from multiple tables or views

The query plan is created by SQL Server's query optimizer. This component runs on every SQL Server as part of the database engine.

When a query arrives from a client, the query optimizer might create multiple query plans, each of which will generate the same results. However, each query plan is likely to return results more quickly or more slowly, depending on factors like table sizes and defined indexes. The query optimizer assesses each plan by assigning a cost to each step. It totals the cost for each plan and then chooses the one with the lowest cost. The lowest cost plan is compiled and cached in memory for use later.

For simple queries, such as a selection of rows from a single table, based on the values of a column in the same table, the cheapest plan is obvious and always the same. For a query that joins multiple tables, involves multiple indexes, or includes parameters, the choice is more complex and might vary over time.

For example, suppose you create a stored procedure that returns the top selling products in the database for your wine import company. The stored procedure includes a parameter named **@numberofresults** that defines how many products you want to return. To find out the best selling wine, you call this procedure with **@numberofresults = 1**.

The best query plan to return the top seller might be different to the best query plan to return the top 50 best selling wines.

## Query plan choice regressions

The query optimizer creates and compiles a query plan for each new query it receives. The data is returned to the user and the compiled query plan is saved to a cache. This process usually maximizes performance because SQL Server doesn't recompile the plan when the same query is requested.

However, in some circumstances, the query optimizer doesn't choose the best query plan because it has incorrect data, or because the user has supplied a different value for a parameter. When the query optimizer starts using a suboptimal query plan, it's known as a query plan regression. That suboptimal performance will continue as long as the bad query plan remains in the cache.

One issue that often causes plan regression is skewed data. This kind of data doesn't conform to common statistical patterns, such as the bell curve. Because the query optimizer assumes that data is typical when it creates a query plan, it might cause a regression if the data isn't typical.

Whatever the cause, a query plan regression results in suboptimal performance. As an administrator, you should try to detect regressions and quickly remove them.

## Query Store and automatic tuning

Query Store is a feature of SQL Server 2016 and later that records rich telemetry about queries, query plans, and performance. Use Query Store to determine when query plans change and whether the change resulted in an increase or a decrease in performance.

If a query plan regression occurs, the Query Store shows it clearly and provides a Transact-SQL command you can use to return to the old query plan.

In SQL Server 2019, you can also use the new automatic tuning feature. If you enable automatic tuning, SQL Server will detect plan regressions by using Query Store and automatically fix them by returning to the previous query plan, which is referred to as the "last known good plan". When configured, this change happens with no involvement from database administrators.

## How to enable Query Store

You choose to enable or disable the Query Store for each database in SQL Server. Use it whenever you want to obtain full information about the performance of your queries. If you're using SQL Server Management Studio (SSMS) to administer your servers, you can use it to enable the Query Store:

1. In SSMS, in the **Object Explorer**, right-click the database you wish to administer, and then click **Properties**.
1. In the **Database Properties** dialog, click the **Query Store** page.
1. In the **Operation Mode (Requested)** box, select **On**.

Instead, you can use Azure Data Studio or the SQLCMD tool to execute the following code, replacing the name of the database you wish to administer:

```sql
ALTER DATABASE <DatabaseName> SET QUERY_STORE = ON;
```

You can only enable automatic tuning when the Query Store is enabled for the same database. Use the following code to enable automatic tuning:

```sql
ALTER DATABASE <DatabaseName> 
SET AUTOMATIC_TUNING ( FORCE_LAST_GOOD_PLAN = ON );
```