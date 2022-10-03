The SQL Server Query Store is a per-database feature. It automatically captures a history of queries, plans, and runtime statistics to simplify performance troubleshooting and query tuning. It also provides insight into database usage patterns and resource usage.

Once Query Store is enabled on a database, the Query Store folder is visible for the database in Object Explorer. The Query Store views provide aggregated, quick insights into the performance aspects of a SQL Server database.

## Using the SQL Query Store to optimize performance

When the performance of a system begins to degrade, it makes sense to consult query wait statistics to potentially identify a cause. In addition to identifying queries that need tuning, it can also shed light on potential infrastructure upgrades that would be beneficial.

The SQL Query Store provides the Query Wait Statistics view to provide insight into the top wait categories for the database.

A bar chart displays the most impactful wait categories for the database when you open the Query Wait Statistics view. In addition, a filter located in the toolbar of the wait categories pane allows for the wait statistics to be calculated based on total wait time (default), average wait time, minimum wait time, maximum wait time, or standard deviation wait time.

By looking at this information, administrators can figure out how best to optimize the database to create the most efficient queries.

## Common optimization scenarios

The SQL Server Query Store provides valuable insight into the performance of the operations performed in a database. The most common scenarios include:

* Identifying and fixing performance regression due to inferior query execution plan selection
* Identifying and tuning the highest resource consumption queries
* A/B testing to evaluate the impacts of database and application changes
* Ensuring performance stability after SQL Server upgrades
* Determining the most frequently used queries
* Audit the history of query plans for a query
* Identifying and improving unplanned workloads
* Understand the prevalent wait categories of a database and the contributing queries and plans affecting wait times
* Analyze database usage patterns over time as it applies to resource consumption (CPU, I/O, Memory)

## Query plans and the query optimizer

Another way Azure SQL Server can help optimize cost and efficiency on complex queries is through a query optimizer. The optimizer analyzes multiple ways a query could be executed (called a *query plan*) and attempts to find the most cost-effective.

Query plans combine a series of relational operators to retrieve data and also capture information about the data such as estimated row counts. Another element of the execution plan is the memory required to perform operations such as joining or sorting data.

SQL Server uses what is known as cost-based query optimizer. The query optimizer calculates a cost for multiple possible plans based on the statistics it has on the columns being utilized, and the possible indexes that can be used for each operation in each query plan. Based on this information, it comes up with a total cost for each plan.

Some complex queries can have thousands of possible execution plans. The optimizer doesn't evaluate every possible plan, but uses heuristics to determine plans that are likely to have good performance. The optimizer will then choose the lowest cost plan of all the plans evaluated for a given query.
