In this exercise, you restore and query AdventureWorks2019 sample database to familiarize yourself with your newly deployed Azure Arc-enabled SQL Managed Instance.

## Exercise 1: Restore AdventureWorks2019

1. Download AdventureWorks2019 sample database backup [AdventureWorks2019](/sql/samples/adventureworks-install-configure#download-backup-files).

1. Use the `kubectl cp` command to [copy](/azure/azure-arc/data/migrate-to-managed-instance#step-2-copy-the-backup-file-into-the-pods-file-system) the downloaded backup file to your backup drive, which is attached to your Arc-enabled SQL Managed Instance.
1. Open Azure Data Studio.
1. Expand **Connections**.
1. Expand **Azure Arc Controllers**.
1. Expand your Arc data controller.
1. Right-click on your Arc-enabled SQL Managed Instance and select **Manage**.
1. The external endpoint is what you connect to your Arc-enabled SQL Managed Instance. Copy it and open either SQL Server Manage Studio or Azure Data Studio. The primary external endpoint is available from Azure Data Studio as shown, or by using the [`az sql mi-arc list`](/azure/azure-arc/data/connect-managed-instance#view-azure-arc-enabled-sql-managed-instances) command.
1. Connect to your external endpoint and name accordingly.
1. Open a new query window to perform your database restore.
1. Run the [Restore Filelistonly](/sql/t-sql/statements/restore-statements-filelistonly-transact-sql) command to confirm you have access to the AdventureWorks2019 backup file. In this example, we restore from locally attached storage.
1. Run the [Restore Database](/sql/t-sql/statements/restore-statements-transact-sql) command to restore to your Arc-enabled SQL Managed Instance.

    ![Screenshot of Azure Arc-enabled SQL Managed Instance - DB Restore.](../media/database-restore-3.png)

1. Refresh your database list in the Connections tab for your Arc-enabled SQL Managed Instance connection.

## Explore AdventureWorks2019  

Whether you deploy your Arc-enabled SQL Managed Instance to Azure, on-premises, or any public cloud, you can access it in the same way as any other instance of SQL Server. Using your preferred tools like SQL Server Management Studio or Azure Data Studio, you explore the AdventureWorks2019 database we restored in the previous exercise.

1. Right-click on AdventureWorks2019 in your database listing and select **New Query**.
1. Run the following statement to list all schemas and tables in the AdventureWorks2019 database:

    ```sql
    Select S.Name as 'SchemaName',
            T.Name as 'TableName'
    From sys.schemas as S
        Inner Join sys.tables as T on T.schema_id = S.schema_id
    Order By S.Name, T.Name;
    ```

    ![Screenshot of Azure Arc-enabled SQL Managed Instance - schema-table query and results.](../media/database-Table-listing-5.png)

1. Run the following statement to retrieve all order details in the AdventureWorks2019 database:

    ```sql
    Select SUM(OrderQty) SumOfOrderQty, P.Name, SOH.OrderDate
    From Sales.SalesOrderHeader as SOH
        Inner Join Sales.SalesOrderDetail As SOD ON SOH.SalesOrderID = SOD.SalesOrderID
        Inner Join Production.Product as P on SOD.ProductID = P.ProductID
    Group By P.Name, SOH.OrderDate
    Order By SOH.OrderDate Desc;
    ```

    ![Screenshot of Azure Arc-enabled SQL Managed Instance - sales query results.](../media/database-Order-details-6.png)
