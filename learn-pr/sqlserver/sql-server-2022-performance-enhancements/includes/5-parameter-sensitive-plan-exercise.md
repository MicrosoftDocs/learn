---
ms.custom:
  - build-2023
---
> [!NOTE]
> This exercise will be leveraging the following githib repository:
>
> https://github.com/microsoft/sqlworkshops-sql2022workshop/tree/main/sql2022workshop/03_BuiltinQueryIntelligence/pspopt
>
> Before continuing with the exercise, make sure that the prerequisites and setup has been completed.

Imagine you're the SQL Server database administrator (DBA) for Wide World Importers and part of your role is to keep up to date with new features in the product. You have learned that SQL Server 2022 is generally available and you need to evaluate the product. The Wide World Importers business unit has made note of inconsistent runtimes, which has direct effect on the customer experience. You have noted that the issue is with how SQL Server parameterizes the queries. Looking through the notes you find that SQL Server 2022 has made optimizations when it comes to how the engine parameterizes the queries with Parameter Sensitive Plan optimization.

In this exercise, we'll be evaluating the Parameter Sensitive Plan
optimization and putting together a demo for our business unit to build
a use case on why we should upgrade to SQL Server 2022 and Compatibility
Mode 160.

## Prerequisites

- SQL Server 2022 Evaluation or Developer Edition
- A virtual machine (VM) or computer with at minimum 2 CPUs and 8 GB of memory. For some of the exercises, it's best to have a machine with 8 CPUs or more.
- Install the latest version of [SQL Server Management Studio (SSMS)](/sql/ssms/download-sql-server-management-studio-ssms).
- Download [ostress.exe](/troubleshoot/sql/tools/replay-markup-language-utility#tools-in-rml-utilities-for-sql-server) from https://aka.ms/ostress. Install using the RMLSetup.msi file that is downloaded. Use all defaults for the installation.

## Set up the exercise

1. Create a directory called `c:\sql_sample_databases` to store backups and files.

1. Download a backup of a customized version of the `WideWorldImporters` sample database for the PSP exercise from https://aka.ms/wwi_pspopt, and copy it into `c:\sql_sample_databases` directory.

   > [!NOTE]
   > If you try to restore the default sample `WideWorldImporters` database, you can use the [restorewwi.sql](https://github.com/microsoft/sqlworkshops-sql2022workshop/blob/main/sql2022workshop/03_BuiltinQueryIntelligence/pspopt/restorewwi.sql), [populatedata.sql](https://github.com/microsoft/sqlworkshops-sql2022workshop/blob/main/sql2022workshop/03_BuiltinQueryIntelligence/pspopt/populatedata.sql) and [rebuild_index.sql](https://github.com/microsoft/sqlworkshops-sql2022workshop/blob/main/sql2022workshop/03_BuiltinQueryIntelligence/pspopt/rebuild_index.sql) scripts to customize the database for the exercise.

1. [Restore](/sql/t-sql/statements/restore-statements-transact-sql) the customized version of the `WideWorldImporters` sample database to your SQL Server 2022 instance using SSMS. You may need to change the directory paths for the location of your backup and where you'll restore the database files.

   ```sql
   USE master;
   GO
   DROP DATABASE IF EXISTS WideWorldImporters;
   GO
   -- Edit the locations for files to match your storage
   RESTORE DATABASE WideWorldImporters FROM DISK = 'c:\sql_sample_databases\wwi_pspopt.bak' with
   MOVE 'WWI_Primary' TO 'c:\sql_sample_databases\WideWorldImporters.mdf',
   MOVE 'WWI_UserData' TO 'c:\sql_sample_databases\WideWorldImporters_UserData.ndf',
   MOVE 'WWI_Log' TO 'c:\sql_sample_databases\WideWorldImporters.ldf',
   MOVE 'WWI_InMemory_Data_1' TO 'c:\sql_sample_databases\WideWorldImporters_InMemory_Data_1',
   stats=5;
   GO
   ```

   > [!IMPORTANT]
   > If you have permission issues to restore the backup, you can try to copy the backup into the default `data` folder for your SQL Server installation and try the restore again. You will need to edit the restore script accordingly. The default for most instances is `C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA.`

1. Create a new procedure to be used for the workload test using the following script.

   ```sql
   USE WideWorldImporters;
   GO
   CREATE OR ALTER PROCEDURE [Warehouse].[GetStockItemsbySupplier]  @SupplierID int
   AS
   BEGIN
   SELECT StockItemID, SupplierID, StockItemName, TaxRate, LeadTimeDays
   FROM Warehouse.StockItems s
   WHERE SupplierID = @SupplierID
   ORDER BY StockItemName;
   END;
   GO
   ```

1. Execute the following script from SSMS to ensure the `WideWorldImporters` database is at dbcompat 150 and clear the query store.

    ```sql
    USE WideWorldImporters;
    GO
    ALTER DATABASE current SET COMPATIBILITY_LEVEL = 150;
    GO
    ALTER DATABASE SCOPED CONFIGURATION CLEAR PROCEDURE_CACHE;
    GO
    ALTER DATABASE current SET QUERY_STORE CLEAR;
    GO
    ```

## Exercise - Viewing PSP optimization for a single query execution

To help us understand what is happening within the Wide World Importers
database, lets look at the PSP optimization for a single query execution executing under the older database compatibility mode of 150.

1. Run the following script to execute the stored procedure created earlier, and make sure that the **Actual Execution Plan** option is enabled. Run the script **twice**.

    ```sql
    USE WideWorldImporters;
    GO
    SET STATISTICS TIME ON;
    GO
    -- The best plan for this parameter is an index seek
    EXEC Warehouse.GetStockItemsbySupplier 2;
    GO
    ```

    :::image type="content" source="../media/parameter-senstive-plan-exercise-execute-stored-proc.png" alt-text="Screenshot of SSMS with the script to execute the GetStockItemsbySupplier stored procedure.":::

1. Select the **Messages** tab in the output pane of the query. Notice that the query runs under 1 second.

   :::image type="content" source="../media/parameter-senstive-plan-exercise-execute-stored-proc-message.png" alt-text="Screenshot of SSMS with the output message of the GetStockItemsbySupplier stored procedure.":::

1. Check the timings for `SET STATISTICS TIME ON` from the second query
execution. The query is run twice so the second execution won't require
a compile, which is reflected in **Execution 2** in the above screenshot. This is the time we want to compare.

   :::image type="content" source="../media/parameter-senstive-plan-exercise-execute-stored-proc-execution-plan-seek.png" alt-text="Screenshot of SSMS with the execution plan of the GetStockItemsbySupplier stored procedure showing Index Seek.":::

   The query plan uses an **Index Seek** reflected in the above screenshot. When this plan is within the procedure cache, the business unit reports that performance exceeds the service level agreement (SLA).

1. In a different query window, run the following script to execute the stored procedure again, but this time clearing the procedure cache and a different supplier value.

    ```sql
    USE WideWorldImporters;
    GO
    SET STATISTICS TIME ON;
    GO
    ALTER DATABASE SCOPED CONFIGURATION CLEAR PROCEDURE_CACHE;
    GO
    -- The best plan for this parameter is an index scan
    EXEC Warehouse.GetStockItemsbySupplier 4;
    GO
    ```

   :::image type="content" source="../media/parameter-senstive-plan-exercise-execute-stored-proc-2.png" alt-text="Screenshot of SSMS with the script to execute the GetStockItemsbySupplier stored procedure with a supplier value of 4.":::

   This may take a few minutes to run. If you look at the **Execution plan**, the query is using a **Clustered Index Scan** and **Parallelism**.

   :::image type="content" source="../media/parameter-senstive-plan-exercise-execute-stored-proc-execution-plan-index-scan.png" alt-text="Screenshot of SSMS with the execution plan of the GetStockItemsbySupplier stored procedure showing Clustered Index Scan.":::

   When this query runs, the business unit reports that the query runs long but is acceptable for the information being requested and meets the SLA. However, after the `EXEC Warehouse.GetStockItemsbySupplier 4` query runs, the business unit notices the query, `EXEC Warehouse.GetStockItemsbySupplier 2` executes slower than before and no longer meets the SLA agreement.

1. To see what's going on and work on identifying the issue, go back and
run the first query in this exercise again.

    ```sql
    USE WideWorldImporters;
    GO
    SET STATISTICS TIME ON;
    GO
    -- The best plan for this parameter is an index seek
    EXEC Warehouse.GetStockItemsbySupplier 2;
    GO
    ```

   You see that the query executes quickly (less than one second). However, the timing from `SET STATISTICS TIME ON` is longer than the previous execution. Examine the messages recorded from setting statistics time to on. We can see a significant increase in **SQL Server Execution Times**.

   :::image type="content" source="../media/parameter-senstive-plan-exercise-execute-stored-proc-message-2.png" alt-text="Screenshot of SSMS with the output message of the GetStockItemsbySupplier stored procedure showing an increase in SQL Server Execution Times.":::

   If you look at the **Execution plan**, it now shows the query is using a clustered index scan and parallelism. The query plan that was compiled when running `EXEC Warehouse.GetStockItemsbySupplier 4`.

   :::image type="content" source="../media/parameter-senstive-plan-exercise-execute-stored-proc-execution-plan-index-scan-2.png" alt-text="Screenshot of SSMS with the execution plan of the GetStockItemsbySupplier stored procedure showing a switch of the query plan from Index Seek to Clustered Index Scan.":::

## Exercise - Workload problem for PSP

1. Execute the following script to clear plan cache and query store. Remember that dbcompat is still set to 150.

    ```sql
    USE WideWorldImporters;
    GO
    ALTER DATABASE SCOPED CONFIGURATION CLEAR PROCEDURE_CACHE;
    GO
    ALTER DATABASE CURRENT SET QUERY_STORE CLEAR;
    GO
    ```

1. Set up Performance Monitor ([perfmon](https://techcommunity.microsoft.com/t5/ask-the-performance-team/windows-performance-monitor-overview/ba-p/375481)) to capture **Processor\\% Processor Time** (not Processor Information) and **SQL Server:SQL Statistics\\Batch Requests/sec** counters.

   :::image type="content" source="../media/parameter-senstive-plan-exercise-2-select-performance-monitor.png" alt-text="Screenshot of Performance Monitor.":::

1. Select **Performance Monitor** by opening **Performance** > **Monitoring Tools**. Select the plus icon to add the counters **Processor\\% Processor Time** and **SQL Server:SQL Statistics\\Batch
Requests/sec** counters.

   :::image type="content" source="../media/parameter-senstive-plan-exercise-2-select-plus-sign.png" alt-text="Screenshot of Performance Monitor and selecting the plus sign.":::

1. After you have selected the plus icon, an **Add Counters** menu is displayed.
Add the **Processor\\% Processor Time** and **SQL Server:SQL Statistics\\Batch Requests/sec** counters, and then select **OK**. The counters are in alphabetical order.

   :::image type="content" source="../media/parameter-senstive-plan-exercise-2-add-counters.png" alt-text="Screenshot of Performance Monitor and adding counters.":::

1. Use the **X** icon to remove **% Processor Time (Processor Information)** from the counters.

   :::image type="content" source="../media/parameter-senstive-plan-exercise-2-remove-counter.png" alt-text="Screenshot of Performance Monitor and removing counters.":::

1. With the performance counters ready, let's simulate a workload against
our Wide World Importers database. Run **[workload_index_seek.cmd 10](https://github.com/microsoft/sqlworkshops-sql2022workshop/blob/main/sql2022workshop/03_BuiltinQueryIntelligence/pspopt/workload_index_seek.cmd)** from the Command Prompt or within a PowerShell terminal. This should finish quickly. The parameter used is the number of users. In this case, we're using `10`. You may want to increase this for machines with 8 CPUs or more. Make sure that you are in the directory you downloaded as part of the prerequisites.

   > [!NOTE]
   > If you are using a named instance, edit **workload_index_seek.cmd** and **workload_index_scan.cmd** to use `-S.\<instance name>`

   :::image type="content" source="../media/parameter-senstive-plan-exercise-2-index-seek-command.png" alt-text="Screenshot of Command Prompt for executing workload_index_seek.cmd.":::

   Observe the performance monitor counters we set up previously.

   :::image type="content" source="../media/parameter-senstive-plan-exercise-2-index-seek-performance.png" alt-text="Screenshot of Performance Monitor after running an index seek query.":::

1. Now run **[workload_index_scan.cmd](https://github.com/microsoft/sqlworkshops-sql2022workshop/blob/main/sql2022workshop/03_BuiltinQueryIntelligence/pspopt/workload_index_scan.cmd)** from the command prompt or within a PowerShell terminal. This should take longer, but now locks into cache a plan for a scan.

   :::image type="content" source="../media/parameter-senstive-plan-exercise-2-index-scan-command.png" alt-text="Screenshot of Command Prompt for executing workload_index_scan.cmd.":::

1. Run **[workload_index_seek.cmd 10](https://github.com/microsoft/sqlworkshops-sql2022workshop/blob/main/sql2022workshop/03_BuiltinQueryIntelligence/pspopt/workload_index_seek.cmd)** again from the command prompt or within a PowerShell terminal.

   Observe the performance monitor counters we set up previously. You'll notice a higher **% Processor Time** (CPU), and lower **Batch Requests/sec**. You'll also observe that the workload doesn't finish in a few seconds as before.

   :::image type="content" source="../media/parameter-senstive-plan-exercise-2-index-seek-performance-2.png" alt-text="Screenshot of Performance Monitor after running an index scan and index seek query.":::

1. Press \<Ctrl\>+\<C\> in the command window or PowerShell terminal to
cancel the workload for **workload_index_seek.cmd**, as it can take
minutes to complete.

1. Pause Performance Monitor by selecting the pause button.

1. Run the following script in SSMS to see the skew in `supplierID`
values in the table.

    ```sql
    USE WideWorldImporters;
    GO
    SELECT SupplierID, count(*) as supplier_count
    FROM Warehouse.StockItems
    GROUP BY SupplierID;
    GO
    ```

   The differences in `supplier_count` explain why "one size does not fit all" for the stored procedure based on parameter values. The seek business process returns data for `SupplierID` 2, which when initially executed, the optimizer compiles a query plan that uses a clustered index seek. However, when we execute the scan business process, the optimizer compiles a query plan that uses a clustered index scan. This new plan is stored within the procedure cache and is the one used for future queries. When this happens, we can see by the above performance metrics the query doesn't scale for those `SupplierID`s with a lower supplier count due to the skew in the data. This parameter sensitivity also known as *parameter sniffing* would require attention of the DBA and could require coding changes to ensure that the query scales when using parameters for `SupplierID`.

   :::image type="content" source="../media/parameter-senstive-plan-exercise-2-supplier-count.png" alt-text="Screenshot of SSMS after running the stored procedures in the exercise showing the differences in supplier_count.":::

For more information on parameter sensitivity, see [Query processing architecture guide](/sql/relational-databases/query-processing-architecture-guide#parameter-sensitivity).

## Exercise - Solve the parameter sniffing problem with no code changes

SQL Server 2022 enhancements to PSP can solve the parameter sniffing problem observed in the last exercise with no code changes. SQL Server 2022 with compatibility mode 160 will improve performance and scalability of your queries.

1. Let's get this workload to run faster and consistently using PSP
optimization. Run the following in SSMS to set your compatibility mode to 160 and clear your cache.

    ```sql
    USE WideWorldImporters;
    GO
    ALTER DATABASE CURRENT SET COMPATIBILITY_LEVEL = 160;
    GO
    ALTER DATABASE SCOPED CONFIGURATION CLEAR PROCEDURE_CACHE;
    GO
    ALTER DATABASE CURRENT SET QUERY_STORE CLEAR;
    GO
    ```

1. Validate that the `WideWorldImporters` database is set to compatibility
level 160 by executing the following T-SQL.

    ```sql
    SELECT name, compatibility_level 
    FROM sys.databases
    WHERE name = 'WideWorldImporters'
    ```

   :::image type="content" source="../media/parameter-senstive-plan-exercise-3-check-compatibility-mode.png" alt-text="Screenshot of SSMS checking compatibility mode.":::

1. Resume capturing Performance Monitor by selecting the play button.

1. Run **[workload_index_seek.cmd 10](https://github.com/microsoft/sqlworkshops-sql2022workshop/blob/main/sql2022workshop/03_BuiltinQueryIntelligence/pspopt/workload_index_seek.cmd)** from the Command Prompt or within a PowerShell terminal. The command should finish quickly as in the second exercise.

1. Now run **[workload_index_scan.cmd](https://github.com/microsoft/sqlworkshops-sql2022workshop/blob/main/sql2022workshop/03_BuiltinQueryIntelligence/pspopt/workload_index_scan.cmd)** from the Command Prompt or within a PowerShell terminal. This should take longer again, and locks into cache a plan for a scan.

1. Run **[workload_index_seek.cmd 10](https://github.com/microsoft/sqlworkshops-sql2022workshop/blob/main/sql2022workshop/03_BuiltinQueryIntelligence/pspopt/workload_index_seek.cmd)** again from the Command Prompt or within PowerShell terminal. The command now finishes again in a few seconds. Unlike in the previous exercise where the command took a longer time to run and we needed to terminate the workload.

   Observe the Performance Monitor counters and you'll see consistent performance.

   :::image type="content" source="../media/parameter-senstive-plan-exercise-3-performance-monitor-consistent.png" alt-text="Screenshot of Performance Monitor showing consistent performance from running the index scan and index seek queries.":::

1. To observe why there's a performance difference, look in the Query Store. Open the **WideWorldImporters** > **Query Store** > **Top Resource Consuming Queries** in SSMS **Object Explorer** to open the report. There will be two plans for the same stored procedure. The one difference is that there's a new option applied to the query for each procedure, which is why there are two different *queries* in the Query Store.

   :::image type="content" source="../media/parameter-senstive-plan-exercise-3-query-store-top-resources-report.png" alt-text="Screenshot of SSMS Query Store Top Resource Consuming Queries report.":::

   :::image type="content" source="../media/parameter-senstive-plan-exercise-3-query-store-top-resources-variant-1.png" alt-text="Screenshot of SSMS Query Store Top Resource Consuming Queries report showing the first variant of the query that we ran.":::

   :::image type="content" source="../media/parameter-senstive-plan-exercise-3-query-store-top-resources-variant-2.png" alt-text="Screenshot of SSMS Query Store Top Resource Consuming Queries report showing the second variant of the query that we ran.":::

1. Execute the following script to look at the Query Store plan. Look into the details of the results to see the query text is the same but slightly different
with the option to use variants. You'll see that the `query_hash` is the same value.

    ```sql
    USE WideWorldImporters;
    GO
    -- Look at the queries and plans for variants
    -- Notice each query is from the same parent_query_id and the query_hash is the same
    SELECT qt.query_sql_text, qq.query_id, qv.query_variant_query_id, qv.parent_query_id, 
    qq.query_hash,qr.count_executions, qp.plan_id, qv.dispatcher_plan_id, qp.query_plan_hash,
    cast(qp.query_plan as XML) as xml_plan
    FROM sys.query_store_query_text qt
    JOIN sys.query_store_query qq
    ON qt.query_text_id = qq.query_text_id
    JOIN sys.query_store_plan qp
    ON qq.query_id = qp.query_id
    JOIN sys.query_store_query_variant qv
    ON qq.query_id = qv.query_variant_query_id
    JOIN sys.query_store_runtime_stats qr
    ON qp.plan_id = qr.plan_id
    ORDER BY qv.parent_query_id;
    GO
    ```

   :::image type="content" source="../media/parameter-senstive-plan-exercise-3-same-query-hash.png" alt-text="Screenshot of SSMS showing the same query_hash for the query store plan.":::

1. Execute the following script and observe the text of the query is from the stored procedure without variant options. This is the text from the *parent plan*.

    ```sql
    USE WideWorldImporters;
    GO
    -- Look at the "parent" query
    -- Notice this is the SELECT statement from the procedure with no OPTION for variants.
    SELECT qt.query_sql_text
    FROM sys.query_store_query_text qt
    JOIN sys.query_store_query qq
    ON qt.query_text_id = qq.query_text_id
    JOIN sys.query_store_query_variant qv
    ON qq.query_id = qv.parent_query_id;
    GO
    ```

   :::image type="content" source="../media/parameter-senstive-plan-exercise-3-query-store-parent-plan.png" alt-text="Screenshot of SSMS showing the parent plan for the query store plan.":::

1. Execute the following script. If you select the `dispatcher_plan` value, you'll see a graphical plan operator called **MULTIPLE PLAN**.

    ```sql
    USE WideWorldImporters;
    GO
    -- Look at the dispatcher plan
    -- If you "click" on the SHOWPLAN XML output you will see a "multiple plans" operator
    SELECT qp.plan_id, qp.query_plan_hash, qv.query_variant_query_id, cast (qp.query_plan as XML) as dispatcher_plan
    FROM sys.query_store_plan qp
    JOIN sys.query_store_query_variant qv
    ON qp.plan_id = qv.dispatcher_plan_id;
    GO
    ```

   :::image type="content" source="../media/parameter-senstive-plan-exercise-3-query-store-dispatcher-plan.png" alt-text="Screenshot of SSMS showing the dispatcher plan for the query store plan.":::

   :::image type="content" source="../media/parameter-senstive-plan-exercise-3-query-store-multiple-plan.png" alt-text="Screenshot of SSMS showing the multiple plan for the query store plan.":::

1. To find the parent stored procedure of the statements from variants,
execute the following script. Scroll left and right on the results and you'll see the `parent_query_id`, `query_variant_query_id`,
`query_hash`, and other columns of interest.

    ```sql
    USE [WideWorldImporters];
    GO
    SELECT  Pl.plan_id as QueryStorePlanId, Pl.query_id as QueryStoreQueryId, qvr.query_variant_query_id, qvr.parent_query_id,
    qvr.dispatcher_plan_id,OBJECT_NAME(Qry.object_id) as ObjectName, Txt.query_sql_text,
    convert(xml,Pl.query_plan)as ShowPlanXML, Qry.query_hash,Rs.first_execution_time, Rs.last_execution_time,
    Rs.count_executions AS NumberOfExecutions, Qry.count_compiles AS NumberOfCompiles, RS.avg_rowcount, Rs.max_rowcount,
    Qry.initial_compile_start_time, Qry.last_compile_start_time, Pl.plan_type_desc
    FROM sys.query_store_runtime_stats AS Rs
    JOIN sys.query_store_plan AS Pl
    ON Rs.plan_id = Pl.plan_id
    JOIN sys.query_store_query_variant qvr
    ON Pl.query_id = qvr.query_variant_query_id
    JOIN sys.query_store_query as Qry
    ON qvr.parent_query_id = Qry.query_id
    JOIN sys.query_store_query_text AS Txt  
    ON Qry.query_text_id = Txt.query_text_id  
    ORDER BY Pl.query_id, Rs.last_execution_time;
    GO
    ```
