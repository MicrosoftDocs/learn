You have been hired as a database administrator to identify performance related issues and provide viable solutions to resolve any issues found. You need to use on-premises tools to identify the performance issues and suggest methods to resolve them.

## Task 1: Run blocked queries report

1. When the VM lab environment opens start SQL Server Management Studio.
1. You will be prompted to connect to your SQL Server. Enter **LON-SQL1** for the local server name, ensure that **Windows Authentication** is selected, and select **Connect**.
1. Start a new query by selecting the **New Query** button in Management Studio.

    :::image type="content" source="../media/new-query-button.png" alt-text="New Query button"::: 

1. Copy and paste the code below into your query window. 

 
    ```tsql
    USE MASTER

    GO

    CREATE EVENT SESSION [Blocking] ON SERVER 

    ADD EVENT sqlserver.blocked_process_report(

    ACTION(sqlserver.client_app_name,sqlserver.client_hostname,sqlserver.database_id,sqlserver.database_name,sqlserver.nt_username,sqlserver.session_id,sqlserver.sql_text,sqlserver.username))

    ADD TARGET package0.ring_buffer

    WITH (MAX_MEMORY=4096 KB, EVENT_RETENTION_MODE=ALLOW_SINGLE_EVENT_LOSS, MAX_DISPATCH_LATENCY=30 SECONDS, MAX_EVENT_SIZE=0 KB,MEMORY_PARTITION_MODE=NONE, TRACK_CAUSALITY=OFF,STARTUP_STATE=ON)

    GO

    -- Start the event session 

    ALTER EVENT SESSION [Blocking] ON SERVER 

    STATE = start; 

    GO
    ```

1. Select **Execute** to execute this query.

    The above T-SQL code will create an Extended Event session that will capture blocking events. The data will contain the following elements:

    - Client application name

    - Client host name

    - Database ID

    - Database name

    - NT Username

    - Session ID

    - T-SQL Text

    - Username


1. Select **New Query** from SQL Server Management Studio. Copy and paste the following T-SQL code into the query window. Select the **Execute** button to execute this query.

    ```sql
    USE AdventureWorks2017

    GO

    BEGIN TRANSACTION

    UPDATE Person.Person SET LastName = LastName;

    GO
    ```
 

5. Open another query window by selecting the **New Query** button. Copy and paste the following T-SQL code into the query window. Click the execute button to execute this query.

    ```sql
    USE AdventureWorks2017


    GO

    SELECT TOP (1000) [LastName]

    ,[FirstName]

    ,[Title]

    FROM Person.Person

    where FirstName = 'David'
    ```
    

    You should notice that this query does not return results immediately and appears to be still running.


1. In Object Explorer, navigate to Management, and expand the hive by clicking the plus sign. Expand the Extended Events hive and then expand the Sessions Hive. Expand  Blocking. Right click on package0.ring_buffer and select View Target Data. 

    :::image type="content" source="../media/view-target-data.png" alt-text="View target data":::

1. Select the hyperlink.

    :::image type="content" source="../media/hyperlink.png" alt-text="Hyperlink":::

1. The XML will show you which processes are being blocked and which process is causing the blocking. 

    :::image type="content" source="../media/xml.png" alt-text="XML":::

1. Right click **Blocking** and select **Stop Session**.

    :::image type="content" source="../media/stop-session.png" alt-text="Stop Session":::

1. Navigate back to the query tab you opened in step 6, and type **ROLLBACK TRANSACTION** on the line below the query. Highlight **ROLLBACK TRANSACTION** and execute the command by selecting **Execute**.

    :::image type="content" source="../media/rollback-transaction.png" alt-text="ROLLBACK TRANSACTION":::

11. Navigate back to the query tab you opened in Step 7. You will notice that the query has now completed.

## Enable Read Commit Snapshot Isolation

1. Copy and paste the following T-SQL code into the query window. Select **Execute** to execute this query. 

    ```sql
    USE master
    
    GO
    
    ALTER DATABASE AdventureWorks2017 SET READ_COMMITTED_SNAPSHOT ON WITH ROLLBACK IMMEDIATE;
    
    GO
    ```
1.  Begin a new query against the AdventureWorks2017 database. Copy and paste the following T-SQL code into the query window. Click the execute button or press t to execute this query.

    ```sql
    USE AdventureWorks2017
    
    
    GO
    
    BEGIN TRANSACTION
    
    UPDATE Person.Person SET LastName = LastName;
    
    GO
    ```
 
1. Start another new query against the AdventureWorks2017 database. Copy and paste the following T-SQL code into the query window. Click the execute button to execute this query. 

    ```sql
    USE AdventureWorks2017
    
    
    GO
    
    SELECT TOP (1000) [LastName]
    
     ,[FirstName]
    
     ,[Title]
    
     FROM Person.Person
    
     where firstname = 'David'
    ```

1. Consider why the query in step 3 now completes whereas in the previous task it was blocked by the UPDATE.
