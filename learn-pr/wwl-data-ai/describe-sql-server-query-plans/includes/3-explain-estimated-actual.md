The topic of actual versus estimated execution plans can be confusing. The difference is that the actual plan includes runtime statistics that are not captured in the estimated plan. The operators used, and order of execution will be the same as the estimated plan in nearly all cases. The other consideration is that in order to capture an actual execution plan the query has to be executed, which can be extremely time consuming, or not be possible. For example, the query may be an UPDATE statement that can only be run once. However, if you need to see query results as well as the plan, you’ll need to use one of the actual plan options.

:::image type="content" source="../media/module-55-optimize-queries-final-01.png" alt-text="An estimated execution plan generated in SQL Server Management Studio":::

As shown above, you can generate an estimated plan in SSMS by clicking the button pointed to by the estimated query plan box (or using the keyboard command Control+L). You can generate the actual plan by either clicking the icon shown or using the keyboard command Control+M, and executing the query This is different than an estimated query plan, which does not require the query to be executed. The two option buttons work a bit differently. The Estimated Query Plan button responds immediately to whatever query in highlighted (or the entire workspace, if nothing is highlighted). The Actual Execution plan button is a toggle. Once you click it, it says on and displays the Actual plan for all queries. To stop displaying plans, you can click the button again, which will turn it off.

There is overhead to both executing a query and generating an estimated execution plan, so viewing execution plans should be done carefully in a production environment.

For the most part you can use the estimated execution plan while writing your query, to understand its performance characteristics, identify missing indexes, or detect query anomalies. The actual execution plan is best used to understand the runtime performance of the query, and most importantly gaps in statistical data that cause the query optimizer to make suboptimal choices based on the data it has available.

## Read a query plan

Execution plans show you what tasks the database engine is performing while retrieving the data needed to satisfy a query. Let’s dive into the plan.

First, the query itself is shown below:

```tsql
SELECT [stockItemName]

 ,[UnitPrice] * [QuantityPerOuter] AS CostPerOuterBox

 ,[QuantityonHand]

FROM [Warehouse].[StockItems] s

 JOIN [Warehouse].[StockItemHoldings] sh ON s.StockItemID = sh.StockItemID

ORDER BY CostPerOuterBox;
```

This query is joining the StockItems table to the StockItemHoldings table where the values in the column StockItemID are equal. So the database engine has to first identity those rows before it can process the rest of the query.

:::image type="content" source="../media/module-55-optimize-queries-final-02.png" alt-text="[Query Execution Plan":::

Each icon in the plan shows a specific operation, which represents the various actions and decisions that make up an execution plan. The SQL Server database engine has over 100 query operators that can make up on an execution plan. You will notice that under each operator icon, there is a cost percentage relative to the total cost of the query. Even an operation that shows a cost of 0% still represents some cost. In fact, 0% is usually due to rounding, because the graphical plan costs are always shown as whole numbers, and the real percentage is something less than 0.5%.

The flow of execution in an execution plan is from right to left, and top to bottom, so in the plan above, the Clustered Index Scan operation on the StockItemHoldings.PK_Warehouse_StockItemHoldings clustered index is the first operation in the query. The widths of the lines that connect the operators are based on the estimated number of rows of data that flow onward to the next operator. A thick arrow is an indicator of large operator to operator transfer and may be indicative of an opportunity to tune a query. You can also hold your mouse over an operator and see additional information in a ToolTip as shown below.

:::image type="content" source="../media/module-55-optimize-queries-final-03.png" alt-text="ToolTip for the Clustered Index Scan Operation on the StockItems table":::

The tooltip highlights the cost and estimates for the estimated plan, and for an actual plan will include the comparisons to the actual rows and costs. Each operator also has properties that will show you more than the tooltip does. If you right-click on a specific operator, you can select the Properties option from the context menu to see the full property list. This option will open up a separate Properties pane in SQL Server Management Studio, which by default is on the right side. Once the Properties pane is open, clicking on any operator will populate the Properties list with properties for that operator. Alternatively, you can open the Properties pane by clicking on View in the main SQL Server Management Studio menu and choosing Properties.

:::image type="content" source="../media/module-55-optimize-queries-final-04.png" alt-text="Properties for Operator":::

The Properties pane includes some additional information and shows the output list which provides details of the columns being passed to the next operator. Examining these columns, in conjunction with a clustered index scan operator can indicate that an additional nonclustered index might be needed to improve the performance of the query. Since a clustered index scan operation is reading the entire table, in this scenario a non-clustered index on the StockItemID column in each table could be more efficient.

## Lightweight query profiling

As mentioned above, capturing actual execution plans, whether using SSMS or the Extended Events monitoring infrastructure can have a large amount of overhead, and is typically only done in live site troubleshooting efforts. Observer overhead, as it is known, is the cost of monitoring a running application. In some scenarios this cost can be just a few percentage points of CPU utilization, but in other cases like capturing actual execution plans, it can slow down individual query performance significantly. The legacy profiling infrastructure in SQL Server’s engine could produce up to 75% overhead for capturing query information, whereas the lightweight profiling infrastructure has a maximum overhead of around 2%.

Starting with SQL Server 2014 SP2 and SQL Server 2016, Microsoft introduced lightweight profiling and enhanced it with SQL Server 2016 SP1 and all later versions. In the first version of this feature, lightweight profiling collected row count and I/O utilization information (the number of logical and physical reads and writes performed by the database engine to satisfy a given query). In addition, a new extended event called query_thread_profile was introduced to allow data from each operator in a query plan to be inspected. In the initial version of lightweight profiling, using the feature requires trace flag 7412 to be enabled globally.

In newer releases (SQL Server 2016 SP2 CU3, SQL Server 2017 CU11, and SQL Server 2019), if lightweight profiling is not enabled globally, you can use the USE HINT query hint with QUERY_PLAN_PROFILE to enable lightweight profiling at the query level. When a query that has this hint completes execution, a query_plan_profile extended event is generated, which provides an actual execution plan. You can see an example of a query with this hint:

```tsql
SELECT [stockItemName]

 ,[UnitPrice] * [QuantityPerOuter] AS CostPerOuterBox

 ,[ QuantityonHand]

FROM [Warehouse].[StockItems] s

JOIN [Warehouse].[StockItems] sh ON s.StockItemID = sh.StockItemID

ORDER BY CostPerOuterBox 

OPTION(USE HINT ('QUERY_PLAN_PROFILE');
```

## Last query plans stats

SQL Server 2019 and Azure SQL Database support two further enhancements to the query profiling infrastructure. First, lightweight profiling is enabled by default in both SQL Server 2019 and Azure SQL Database and managed instance. Lightweight profiling is also available as a database scoped configuration option, called LIGHTWEIGHT_QUERY_PROFILING. With the database scoped option, you can disable the feature for any of your user databases independent of each other.

Second, there is a new dynamic management function called sys.dm_exec_query_plan_stats, which can show you the last known actual query execution plan for a given plan handle. In order to see the last known actual query plan through the function, you can enable trace flag 2451 server-wide.  Alternatively, you can enable this functionality using a database scoped configuration option called LAST_QUERY_PLAN_STATS. 

You can combine this function with other objects to get the last execution plan for all cached queries as shown below:

```tsql
SELECT *

FROM sys.dm_exec_cached_plans AS cp

CROSS APPLY sys.dm_exec_sql_text(plan_handle) AS st

CROSS APPLY sys.dm_exec_query_plan_stats(plan_handle) AS qps; 

GO
```

This functionality lets you quickly identify the runtime stats for the last execution of any query in your system, with minimal overhead. The image below shows how to retrieve the plan. If you click on the execution plan XML, which will be the first column of results, will display the execution plan shown in the second image below.

:::image type="content" source="../media/module-55-optimize-queries-final-05.png" alt-text="Retrieving the Actual Execution Plan for a Query":::

[![Execution Plan retrieved from SQL Server 2019](../media/module-55-optimize-queries-final-06.png)](../media/module-55-optimize-queries-final-06.png#lightbox)

As you can see from the properties of the Columnstore Index Scan, the plan retrieved from the cache has actual number of rows retrieved in the query.
