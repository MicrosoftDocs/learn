---
ms.custom:
  - build-2023
---
> [!NOTE]
> This exercise uses the following githib repository:
>
> https://github.com/microsoft/sqlworkshops-sql2022workshop/tree/main/sql2022workshop/03_BuiltinQueryIntelligence/persistedmgf
>
> Before you continue, make sure that you complete the prerequisites and setup.

Imagine that you're a database administrator for the World Wide Importers Corporation. You need to understand how memory grant feedback is different in SQL Server 2022 than in previous versions. To understand this difference, this module simulates an out of date statistics exercise. Review the persistence of the memory grant feedback that is new to SQL Server 2022 and requires the Query Store.

In this exercise, you learn how memory grant feedback can improve query performance automatically, including persisting feedback to the Query Store.

## Prerequisites

- SQL Server 2022 Evaluation or Developer Edition
- A virtual machine (VM) or computer with at minimum 2 CPUs and 8 GB of memory
- The latest version of [SQL Server Management Studio (SSMS)](/sql/ssms/download-sql-server-management-studio-ssms)

## Set up the exercise

1. Create a directory called *c:\sql_sample_databases* to store backups and files.

1. Download a backup of a customized version of the `WideWorldImportersDW` sample database backup for the memory grant feedback exercise from https://aka.ms/wwidw_mgf. Save it to the *c:\sql_sample_databases* directory.

   > [!NOTE]
   > If you try to restore the default sample `WideWorldImportersDW` database, you can use the [extendwwidw.sql](https://github.com/microsoft/sqlworkshops-sql2022workshop/blob/main/sql2022workshop/03_BuiltinQueryIntelligence/persistedmgf/extendwwidw.sql) script to customize the database for the exercise.

1. [Restore](/sql/t-sql/statements/restore-statements-transact-sql) the `WideWorldImportersDW` database to your SQL Server 2022 instance using SSMS. You might need to change the directory paths for the location of your backup and where you restore the database files.

   ```sql
   USE master;
   GO
   DROP DATABASE IF EXISTS WideWorldImportersDW;
   GO
   RESTORE DATABASE WideWorldImportersDW FROM DISK = 'c:\sql_sample_databases\wwidw_mgf.bak'
   WITH MOVE 'wwi_primary' TO 'c:\sql_sample_databases\wideworldimportersdw.mdf',
   MOVE 'wwi_userdata' TO 'c:\sql_sample_databases\wideworldimportersdw_userdata.ndf',
   MOVE 'wwi_log' TO 'c:\sql_sample_databases\wideworldimportersdw.ldf',
   MOVE 'wwidw_inmemory_data_1' TO 'c:\sql_sample_databases\wideworldimportersdw_inmemory_data'
   GO
   ```

   > [!IMPORTANT]
   > If you have permission issues to restore the backup, you can try to copy the backup into the default *data* folder for your SQL Server installation and try the restore again. You need to edit the restore script accordingly. The default for most instances is *C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA*.

1. Run the following script from SSMS. This script ensures the `WideWorldImporters` database is at `dbcompat 150` and clears the query store.

   ```sql
   USE [WideWorldImportersDW];
   GO
   ALTER DATABASE [WideWorldImportersDW] SET COMPATIBILITY_LEVEL = 150;
   GO
   ALTER DATABASE SCOPED CONFIGURATION CLEAR PROCEDURE_CACHE;
   GO
   ALTER DATABASE WideWorldImportersDW SET QUERY_STORE CLEAR ALL;
   GO
   ```

## Exercise - Memory grant feedback

1. To evaluate persisted memory grant feedback, simulate creating an out of date statistics on a table. Run the following script in SSMS.

    ```sql
    USE WideWorldImportersDW;
    GO
    UPDATE STATISTICS Fact.OrderHistory 
    WITH ROWCOUNT = 1000;
    GO
    ```

1. Now that the statistics are out of date, you can run a query to determine the effect on performance. Execute the following script in SSMS. Before you run the script, make sure to include the actual execution plan. This script takes around 30 to 45 seconds to run.

    ```sql
    USE WideWorldImportersDW;
    GO
    SELECT fo.[Order Key], fo.Description, si.[Lead Time Days]
    FROM  Fact.OrderHistory AS fo
    INNER HASH JOIN Dimension.[Stock Item] AS si 
    ON fo.[Stock Item Key] = si.[Stock Item Key]
    WHERE fo.[Lineage Key] = 9
    AND si.[Lead Time Days] > 19;
    GO
    ```

   :::image type="content" source="../media/memory-grant-execute-select-query.png" alt-text="Screenshot of SSMS query executing select query for memory grant exercise.":::

1. When the query returns select the **Execution plan** tab, look at the yellow warning on the hash join operator. Hover over the **Hash Match** operator on the query plan.  

   :::image type="content" source="../media/memory-grant-query-execution-plan.png" alt-text="Screenshot of the execution plan in SSMS.":::

   The script, which didn't do a full scan of statistics, leads to an inaccurate estimate of the number of rows the query returns. The query estimated 52.8634 rows and actually returned 66,416 rows. The query also caused 52,008 pages, each 8 KB in size totaling up to over 400 MB, to spill and be read from the `tempdb`.

1. Now, hover over the **SELECT** operator in the query plan.

   :::image type="content" source="../media/memory-grant-query-plan-select-operator.png" alt-text="Screenshot of the execution plan in SSMS and hovering over the select operator.":::

1. The Memory Grant for this query is around 1.4 MB. That value is far short of the more than 400 MB that spilled to `tempdb`. Right-click on the **SELECT** operator and select **Properties**.

   :::image type="content" source="../media/memory-grant-query-plan-properties.png" alt-text="Screenshot of the execution plan in SSMS selecting properties for the select operator.":::

   :::image type="content" source="../media/memory-grant-query-plan-select-properties.png" alt-text="Screenshot of the execution plan select operator properties in SSMS.":::

1. **IsMemoryGrantFeedbackAdjusted** has a value of `NoFirstExecution`. This means no adjustment has been made since there's no feedback and the query was compiled. The *used* memory is only the memory used as part of the grant and doesn't account for the spill.

1. You can query the Query Store in order to find information. Run the following script in SSMS.

    ```sql
    USE WideWorldImportersDW;
    GO
    SELECT qpf.feature_desc, qpf.feedback_data, qpf.state_desc, qt.query_sql_text, (qrs.last_query_max_used_memory * 8192)/1024 as last_query_memory_kb 
    FROM sys.query_store_plan_feedback qpf
    JOIN sys.query_store_plan qp
    ON qpf.plan_id = qp.plan_id
    JOIN sys.query_store_query qq
    ON qp.query_id = qq.query_id
    JOIN sys.query_store_query_text qt
    ON qq.query_text_id = qt.query_text_id
    JOIN sys.query_store_runtime_stats qrs
    ON qp.plan_id = qrs.plan_id;
    GO
    ```

   Looking at the output, you see that feedback has been stored to allocate a larger memory grant on the next execution than was used on the previous execution.

   :::image type="content" source="../media/memory-grant-query-store-output.png" alt-text="Screenshot of the query store output in SSMS.":::

1. Now that the Query Store has this feedback, run the following script in SSMS.  

    ```sql
    USE WideWorldImportersDW;
    GO
    SELECT fo.[Order Key], fo.Description, si.[Lead Time Days]
    FROM  Fact.OrderHistory AS fo
    INNER HASH JOIN Dimension.[Stock Item] AS si 
    ON fo.[Stock Item Key] = si.[Stock Item Key]
    WHERE fo.[Lineage Key] = 9
    AND si.[Lead Time Days] > 19;
    GO
    ```

   The query should run quicker than last time.

1. After you run the query, see if you have any further feedback updates. Run the following script in SSMS.

    ```sql
    USE WideWorldImportersDW;
    GO
    SELECT qpf.feature_desc, qpf.feedback_data, qpf.state_desc, qt.query_sql_text, (qrs.last_query_max_used_memory * 8192)/1024 as last_query_memory_kb 
    FROM sys.query_store_plan_feedback qpf
    JOIN sys.query_store_plan qp
    ON qpf.plan_id = qp.plan_id
    JOIN sys.query_store_query qq
    ON qp.query_id = qq.query_id
    JOIN sys.query_store_query_text qt
    ON qq.query_text_id = qt.query_text_id
    JOIN sys.query_store_runtime_stats qrs
    ON qp.plan_id = qrs.plan_id;
    GO
    ```

   :::image type="content" source="../media/memory-grant-query-store-output-2.png" alt-text="Screenshot of the query store output in SSMS again.":::

   Notice that the memory grant used is now more than the previous run.

## Exercise - Memory grant feedback persistence

The SQL Server 2022 feature that you're reviewing is memory grant feedback persistence. After you test the memory grant, test the persistence.

1. To test the persistence, clear the plan cache. In previous versions, clearing the plan cache lost the memory grant feedback. Run the following script in SSMS.

    ```sql
    USE [WideWorldImportersDW];
    GO
    ALTER DATABASE SCOPED CONFIGURATION CLEAR PROCEDURE_CACHE;
    GO
    ```

1. Run the following script in SSMS.  

    ```sql
    USE WideWorldImportersDW;
    GO
    SELECT fo.[Order Key], fo.Description, si.[Lead Time Days]
    FROM  Fact.OrderHistory AS fo
    INNER HASH JOIN Dimension.[Stock Item] AS si 
    ON fo.[Stock Item Key] = si.[Stock Item Key]
    WHERE fo.[Lineage Key] = 9
    AND si.[Lead Time Days] > 19;
    GO
    ```

   The query run time should still be as quick as it was in your second execution.

   :::image type="content" source="../media/memory-grant-feedback-query-execution-plan-2.png" alt-text="Screenshot of the execution plan in SSMS after clearing the plan cache to observe memory grant feedback persistence.":::

Even though you still have an underestimation of the rows in the query, you have the memory grant despite having cleared the procedure cache on the SQL Server 2022 instance. This behavior demonstrates the capability of memory grant feedback persistence in SQL Server 2022.

## Explore the exercise

What did you notice about the memory grant feedback persistence? Here are a few takeaways:

- When a query first executes with insufficient memory grant, it's recorded and viewable in the Query Store
- The second time the query runs, the memory grant is adjusted based on the feedback from the first run
- Even after you clear the procedure cache or restarting the SQL Server 2022 service, the memory grant feedback persists
