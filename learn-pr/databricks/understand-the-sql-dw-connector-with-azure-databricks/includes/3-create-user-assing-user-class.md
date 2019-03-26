To add a SQL Server authenticated user to SQL Data Warehouse, you need to complete these steps:

1. Create a server login.
1. Add a user to the master database by using the new server login.
1. Add a user to SQL Data Warehouse by using the new server login.

Let's start by creating the server login that we'll use for the exercises in this module.

## Add a user to the master database

1. By using Azure Data Studio, connect to the master database located under the SQL Server instance you created in the previous unit (in the section "Create new connections in Azure Data Studio").

    Use these values to create a connection to the master database:
    - _SQL Server_: The SQL Server instance that you created for this module.
    - _Authentication_: **SQL Login**
    - _User name_: **Server Admin**
    - _Database_: **master**

1. Go to the **Servers** list in the menu on the left side of Azure Data Studio. Under the SQL Data Warehouse connection you made to the master database, expand **Databases** and **System Databases**. Right-click **master** and select **New Query**.

    ![Right-click master and select New Query](../media/azure-data-studio-new-query-master.png)

1. Check whether the **master** database is selected for the query window.

1. Create a new server login by running this statement in the window:

    ```sql
    CREATE LOGIN LabUserLogin WITH PASSWORD = 'Str0ng_password';
    ```

1. Select the **Run** button to execute the query. You should see a message telling you that the commands completed successfully.

    ![Execute the query](../media/azure-data-studio-new-query.png)

1. Create a user in the master database by using login you created in step 4:

    ```sql
    CREATE USER LabUser FOR LOGIN LabUserLogin;
    ```

## Add a user to SQL Data Warehouse

1. By using Azure Data Studio, connect to the SQL Data Warehouse database located under the SQL Server instance you created earlier in this module. Follow the steps listed in step 2 of the section "Create connections in Azure Data Studio."

    Use these values to make the connection to the SQL Data Warehouse database:

    - *SQL Server:* The SQL Server instance that you created for this module.
    - *Authentication:* **SQL Login**
    - *User name:* **Server Admin**
    - *Database:* The SQL Data Warehouse database that you created for this module.

1. Navigate to the Servers list on the left-hand menu in Azure Data Studio. Right-click on the SQL Data Warehouse connection you made to the SQL Data Warehouse database, then select **New Query** from the context menu.

    ![Right-click on the SQL Data Warehouse connection then click New Query.](../media/azure-data-studio-new-query-dw.png)

1. Check if **SQL data Warehouse** (`sql-dw-exercise`) is selected for the query window.

1. To create user in **SQL Data Warehouse** using login created in earlier steps, execute the below statement:

    ```sql
    CREATE USER LabUser FOR LOGIN LabUserLogin;
    ```

1. Execute the following statement to allow LabUser to read data from SQL Data Warehouse:

    ```sql
    EXEC sp_addrolemember 'db_datareader', 'LabUser';
    ```

## Assign Resource Class

Resource Classes manage resource allocation for query execution in SQL Data Warehouse. Resource Classes help to control memory allocation, CPU cycles, and Concurrency Slots given to each query.

Click [here](https://docs.microsoft.com/azure/sql-data-warehouse/sql-data-warehouse-develop-concurrency#resource-classes)
to learn more about resource classes.

To assign resource class to user added in SQL Data Warehouse, execute the below statement in same query window used for the previous step:

```sql
EXEC sp_addrolemember 'largerc', 'LabUser';
```

The above statement assigns the '**largerc'** resource class to the newly added user.