You've been hired as a Senior Database Administrator to help with performance issues currently happening when users query the AdventureWorks2017 database. Your job is to identify issues in query performance and remedy them using techniques learned in this module.

You'll run queries with suboptimal performance, examine the query plans, and attempt to make improvements within the AdventureWorks2017 database.

In this exercise you will run query to generate actual execution plan and evaluate given execution plans (such as a key lookup).

## Run a query to generate actual execution plan

There are several ways to generate an execution plan in SQL Server Management Studio.

1. When the VM lab environment opens use the password on the **Resources** tab for the **Student** account to sign in to Windows.

1. From the lab virtual machine, start **SQL Server Management Studio (SSMS)**. Start a new query by selecting the **New Query** button in Management Studio.

    :::image type="content" source="../media/dp-3300-module-55-lab-01.png" alt-text="New Query":::

1. Copy and paste the code below into a new query window and execute it by selecting **Execute** or pressing the F5 key.

    Using the SHOWPLAN_ALL setting we can get the same information as we did in the last exercise but in the results pane instead of the graphical result.

    ```sql
    USE AdventureWorks2017;
    GO

    SET SHOWPLAN_ALL ON;
    GO

    SELECT BusinessEntityID
    FROM HumanResources.Employee
    WHERE NationalIDNumber = '14417807';
    GO

    SET SHOWPLAN_ALL OFF;
    GO
    ```

    This shows you a text version of the execution plan.

    :::image type="content" source="../media/dp-3300-module-55-lab-06.png" alt-text="Text version":::

## Resolve a Performance Problem from an Execution Plan

1. Copy and paste the code below into a new query window.

    Select the **Include Actual Execution Plan** icon as shown below before running the query, or type CTRL+M. Execute the query by selecting **Execute** or pressing the **F5** key. Make note of the execution plan and the logical reads in the messages tab.

    ```sql
    SET STATISTICS IO, TIME ON;

    SELECT [SalesOrderID] ,[CarrierTrackingNumber] ,[OrderQty] ,[ProductID], [UnitPrice] ,[ModifiedDate]
    FROM [AdventureWorks2017].[Sales].[SalesOrderDetail]
    WHERE [ModifiedDate] > '2012/01/01' AND [ProductID] = 772;
    ```

    When reviewing the execution plan you will note there is a key lookup. If you your mouse over the icon, you will see that the properties indicate it is performed for each row retrieved by the query. You can see the execution plan is performing a Key Lookup operation.
    
    To identify what index needs to be altered in order to remove the key lookup, you need to examine the index seek above it. Hover over the index seek operator with your mouse and the properties of the operator will appear. Make note of the output column as shown below.
    
    :::image type="content" source="../media/dp-3300-module-55-lab-07.png" alt-text="Clustered":::
    
    :::image type="content" source="../media/dp-3300-module-55-lab-08.png" alt-text="NonClustered":::

1. Fix the Key Lookup and rerun the query to see the new plan.

    Key Lookups are fixed by adding a COVERING index that INCLUDES all fields being returned or searched in the query. In this example the index only had ProductID. If we add the Output List fields to the index as Included Columns, then the Key Lookup will be removed. Since the index already exists you either have to DROP the index and recreate it or set the DROP_EXISTING=ON in order to add the columns. Note ProductID is already part of the index and does not need to be added as an included column.

    ```sql
    CREATE NONCLUSTERED INDEX [IX_SalesOrderDetail_ProductID]
    ON [Sales].[SalesOrderDetail] ([ProductID],[ModifiedDate])
    INCLUDE ([CarrierTrackingNumber],[OrderQty],[UnitPrice])
    WITH (DROP_EXISTING = on);
    GO
    ```

1. Rerun the query from Step 1. Make note of the changes to the logical reads and execution plan changes

## Use Query Store (QS) to detect and handle regression in AdventureWorks2017

Next you'll run a workload to generate query statistics for QS, examine Top Resource Consuming Queries to identify poor performance, and force a better execution plan.

## Run a workload to generate query stats for Query Store

1. Copy and paste the code below into a new query window and execute it by selecting **Execute** . Make note of the execution plan and the logical reads in the messages tab. This script will enable the Query Store for AdventureWorks2017 and sets the database to Compatibility Level 100

    ```sql
    USE master;
    GO

    ALTER DATABASE AdventureWorks2017 SET QUERY_STORE = ON;
    GO

    ALTER DATABASE AdventureWorks2017 SET QUERY_STORE (OPERATION_MODE = READ_WRITE);
    GO

    ALTER DATABASE AdventureWorks2017 SET COMPATIBILITY_LEVEL = 100;
    GO
    ```

1. Select the **File** > **Open** > **File** menu in SQL Server Management Studio.
1. Navigate to the **D:\Labfiles\Query Performance\CreateRandomWorkloadGenerator.sql** file.
1. Select the file to load it into Management Studio and then select **Execute** or press F5 to execute the query.

    :::image type="content" source="../media/dp-3300-module-55-lab-09.png" alt-text="Open File":::

1. Run a workload to generate statistics for Query Store.
1. Navigate back to the **D:\Labfiles\Query Performance\ExecuteRandomWorkload.sql** script to execute a workload.
1. Select **Execute** or press F5 to run the script.

    After execution completes, run the script a second time. Leave the query tab open for this query.

1. Copy and paste the code below into a new query window and execute it by selecting **Execute** or pressing the F5 key . This script changes the database compatibility mode using the below script to SQL Server 2019 (150)

    ```sql
    USE master;
    GO

    ALTER DATABASE AdventureWorks2017 SET COMPATIBILITY_LEVEL = 150;
    GO
    ```

1. Navigate back to the query tab from step 3, and re-execute.

## Examine Top Resource Consuming Queries to identify poor performance

1. In order to view the Query Store you will need to refresh the AdventureWorks2017 database in Management Studio. Right click on database name and choose select refresh. You will then see the Query Store option under the database.
    :::image type="content" source="../media/dp-3300-module-55-lab-10.png" alt-text="Expand Query Store":::

1. Expand Query Store node to view all available report. Select the plus sign to expand **Query Store** reports. Select **Top Resource Consuming Queries Report**.
    :::image type="content" source="../media/dp-3300-module-55-lab-11.png" alt-text="Top Resource Consuming Queries Report":::

1. The report will open as shown below. On the right, select the menu dropdown, then select **Configure**.
    :::image type="content" source="../media/dp-3300-module-55-lab-12.png" alt-text="Select Configure":::

1. In the configuration screen, change the filter for the minimum number of query plans to 2.

    :::image type="content" source="../media/dp-3300-module-55-lab-13.png" alt-text="Set Minimum number of query plans":::

1. Choose the query with the longest duration by selecting the left most bar in the bar chart in the top left portion of the report.

    :::image type="content" source="../media/dp-3300-module-55-lab-14.png" alt-text="Query with longest duration":::

‎This will show you the query and plan summary for your longest duration query in your query store.

## Force a better execution plan

1. Navigate to the plan summary portion of the report as shown below. You will note there are two execution plans with widely different durations.

    :::image type="content" source="../media/dp-3300-module-55-lab-15.png" alt-text="Plan summary":::

1. Select the Plan ID with the lowest duration (this is indicated by a lower position on the Y-axis of the chart) in the top right window of the report. In the graphic above, it’s PlanID 43. Select the plan ID next to the Plan Summary chart (it should be highlighted like in the above screenshot).

1. Select **Force Plan** under the summary chart. A confirmation window will popup, choose Yes to force the plan.

    :::image type="content" source="../media/dp-3300-module-55-lab-16.png" alt-text="Confirmation":::

    Once forced you will see that the Forced Plan is now greyed out and the plan in the plan summary window now has a check mark indicating is it forced.

    :::image type="content" source="../media/dp-3300-module-55-lab-17.png" alt-text="Forced check mark":::

## Use query hints to impact performance in AdventureWorks2017

Next you'll run a workload, change the query to use a parameter, and apply query hint to the query to optimize for a value and re-execute.

## Run a workload

Run the queries below, examine the Actual Execution Plan (Ctrl+M).

1. Select New Query and select on **Include Actual Execution Plan** icon before running the query or use CTRL+M.

    :::image type="content" source="../media/dp-3300-module-55-lab-18.png" alt-text="Include Actual Execution Plan":::

1. Execute the query below. Note that the execution plan shows an index seek operator.

    ```sql
    USE AdventureWorks2017
    GO

    SELECT SalesOrderId, OrderDate
    FROM Sales.SalesOrderHeader
    WHERE SalesPersonID=288;
    ```

    :::image type="content" source="../media/dp-3300-module-55-lab-19.png" alt-text="Execution Plan":::

1. Now run the next query.

    The only change this time is that the SalesPersonID value is set to 277. Note the Clustered Index Scan operation in the execution plan.

    ```sql
    USE [AdventureWorks2017]
    GO

    SELECT SalesOrderId, OrderDate
    FROM Sales.SalesOrderHeader
    WHERE SalesPersonID=277;
    ```

    :::image type="content" source="../media/dp-3300-module-55-lab-20.png" alt-text="SalesPersonID = 277":::

Based on the column statistics the database optimizer has chosen a different execution plan because of the different values of this WHERE clause. Because this query uses a constant in its WHERE clause, the optimizer sees each of these queries as unique and generates a different execution plan for each one.

## Change the query to use a parameter and use a Query Hint

1. Change the query to use a variable value for SalesPersonID.

1. Use the T-SQL DECLARE statement to declare @SalesPersonID so you can pass in a value instead of hard-code the value in the WHERE clause. You should ensure that the data type of your variable matches the data type of the column in the target table.

    ```sql
    USE AdventureWorks2017
    GO

    DECLARE @SalesPersonID INT;

    SELECT @SalesPersonID = 277;

    SELECT SalesOrderId, OrderDate
    FROM Sales.SalesOrderHeader
    WHERE SalesPersonID= @SalesPersonID;
    ```

1. Execute this query again changing the parameter value to 288.

    If you examine the execution plan, you will note is the same as it was for the value of 277. This is because SQL Server has cached the execution plan and is reusing for the second execution of the query. Note that although the same plan is used for both queries, it is not necessarily the best plan.

    ```sql
    USE AdventureWorks2017
    GO

    DECLARE @SalesPersonID INT;

    SELECT @SalesPersonID = 288;

    SELECT SalesOrderId, OrderDate
    FROM Sales.SalesOrderHeader
    WHERE SalesPersonID= @SalesPersonID;
    ```

1. Execute the following command to clear the plan cache for the AdventureWorks2017 database.

    ```sql
    USE AdventureWorks2017
    GO
    ALTER DATABASE SCOPED CONFIGURATION CLEAR PROCEDURE_CACHE;
    GO
    ```

1. Now Run the Query with the Query.

    Hint. Review the plan noting it now uses the plan with the index seek created for value 288 even though the @SalesPersonID = 277.

    ```sql
    USE AdventureWorks2017;
    GO

    DECLARE @SalesPersonID int

    SELECT @SalesPersonID = 277

    SELECT SalesOrderId, OrderDate
    FROM Sales.SalesOrderHeader
    WHERE SalesPersonID= @SalesPersonID
    OPTION (OPTIMIZE FOR (@SalesPersonID = 288));
    ```
