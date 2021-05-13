You have been hired as a database administrator to identify performance related issues and provide viable solutions to resolve any issues found. You need to use on-premises tools to identify the performance issues and suggest methods to resolve them.

## Identify fragmentation

1. When the VM lab environment opens, use the password on the **Resources** tab above for the Student account to sign in to Windows.
1. Start **SQL Server Management Studio**.
1. You will be prompted to connect to your SQL Server. Enter **LON-SQL1** for the local server name, ensure that **Windows Authentication** is selected, and select **Connect**.

    > [!NOTE]
    > If you'd like to copy and paste the code you can find the code in the **D:\LabFiles\Monitor Resources\exercise_steps.sql** file.


1. Select **New Query**. Copy and paste the following T-SQL code into the query window. Select **Execute** to execute this query. 

    ```sql
    USE AdventureWorks2017

    
    GO
    
    SELECT i.name Index_Name
    
     , avg_fragmentation_in_percent
    
     , db_name(database_id)
    
     , i.object_id
    
     , i.index_id
    
     , index_type_desc
    
    FROM sys.dm_db_index_physical_stats(db_id('AdventureWorks2017'),object_id('person.address'),NULL,NULL,'DETAILED') ps
    
     INNER JOIN sys.indexes i ON ps.object_id = i.object_id 
    
     AND ps.index_id = i.index_id
    
    WHERE avg_fragmentation_in_percent > 50 -- find indexes where fragmentation is greater than 50%
    ```
     
    This query will report any indexes that have a fragmentation over 50%. You should not see any indexes with fragmentation.

    > [!NOTE]
    > If you'd like to copy and paste the code you can find the code in the **D:\LabFiles\Monitor Resources\Monitor Resources scripts.sql** file.

1. Select **New Query**. Copy and paste the following T-SQL code into the query window. Select **Execute** to execute this query. 

    ```sql
    USE AdventureWorks2017


    GO
    
    INSERT INTO [Person].[Address]
    
     ([AddressLine1]
    
     ,[AddressLine2]
    
     ,[City]
    
     ,[StateProvinceID]
    
     ,[PostalCode]
    
     ,[SpatialLocation]
    
     ,[rowguid]
    
     ,[ModifiedDate])
    
    SELECT AddressLine1,
    
     AddressLine2, 
    
     'Amsterdam',
    
     StateProvinceID, 
    
     PostalCode, 
    
     SpatialLocation, 
    
     newid(), 
    
     getdate()
    
    from Person.Address;
    
    
    GO
    ```

    This query will increase the fragmentation level of the Person.Address table and its indexes by adding a large number of new records.


1. Execute the first query again. This query will report any indexes that have a fragmentation over 50%. You should see four indexes with fragmentation.


1. Copy and paste the following T-SQL code into the query window. Select Execute to execute this query. 

    ```sql
    SET STATISTICS IO,TIME ON
    
    GO
    
    USE AdventureWorks2017

    
    GO
    
    SELECT DISTINCT (StateProvinceID)
    
     ,count(StateProvinceID) AS CustomerCount
    
    FROM person.Address
    
    GROUP BY StateProvinceID
    
    ORDER BY count(StateProvinceID) DESC;
    
    GO
    ```
     
    
    Click on the **Messages** tab in the result pane of SQL Server Management Studio. Make note of the count of logical reads performed by the query.

    :::image type="content" source="../media/results.png" alt-text="Screenshot showing the results of the query.":::

## Rebuild indexes

1. Select **New query**. Copy and paste the following T-SQL code into the query window. Click the execute button to execute this query. 


1. Copy and paste the following T-SQL code into the query window. Click the execute button to execute this query. 

    ```sql
    USE AdventureWorks2017
    
    
    GO
    
    ALTER INDEX [IX_Address_StateProvinceID] ON [Person].[Address] REBUILD PARTITION = ALL WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
    ```

1. Re-execute the query from step 4 in the first task. Confirm that the **AK_Address_StateProvinceID** index no longer has fragmentation greater than 50%.

    ```sql
    USE AdventureWorks2017

    
    GO
    
    SELECT i.name Index_Name
    
     , avg_fragmentation_in_percent
    
     , db_name(database_id)
    
     , i.object_id
    
     , i.index_id
    
     , index_type_desc
    
    FROM sys.dm_db_index_physical_stats(db_id('AdventureWorks2017'),object_id('person.address'),NULL,NULL,'DETAILED') ps
    
     INNER JOIN sys.indexes i ON ps.object_id = i.object_id 
    
     AND ps.index_id = i.index_id
    
    WHERE avg_fragmentation_in_percent > 50 -- find indexes where fragmentation is greater than 50%
    ```

1. Re-execute the query from step 6 in the first task. Make note of the logical reads in the **Messages** tab of the **Results** pane in Management Studio. Was there a change from the number of logical reads encountered before you rebuilt the index?

    ```sql
    SET STATISTICS IO,TIME ON
    
    GO
    
    USE AdventureWorks2017

    
    GO
    
    SELECT DISTINCT (StateProvinceID)
    
     ,count(StateProvinceID) AS CustomerCount
    
    FROM person.Address
    
    GROUP BY StateProvinceID
    
    ORDER BY count(StateProvinceID) DESC;
    
    GO
    ```

Because the index has been rebuilt, it will now be as efficient as possible and the logical reads should reduce. You have now seen that index maintenance can have an effect on query performance.

To finish this exercise select **Done** below.
