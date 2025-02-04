Trial restores are a key component of any disaster recovery strategy.

You want to familiarize yourself with the steps to restore a backed-up database to a specific point in time, in case it becomes necessary. You also want to investigate how long a restore operation takes, a key part of the calculation of Recovery Time Objection (RTO). You can plan for this time in your guidance for your organization.

You can treat the restored database as a replacement for the original database or use it as a data source to update the original database. Though you can overwrite and replace a database in a SQL Server instance or Azure SQL Managed Instance, you cannot overwrite an Azure SQL Database with a restore.

Let's perform a restore from automated Azure SQL Database backups.

## Confirm that backups are active

> [!TIP]
> It can take up to 15 minutes after database creation for the first successful backup to finish. 

Let's look at the backups Azure SQL takes for us, automatically.

1. In Azure Cloud Shell, run the following PowerShell command to set a variable to the value of your SQL Server instance:

    ```powershell
    $sqlserver=Get-AzSqlServer
    ```

1. View the available restore points, based on backups, with the `Get-AzSqlDatabaseRestorePoint` PowerShell cmdlet:

    ```powershell
    Get-AzSqlDatabaseRestorePoint `
        -ResourceGroupName <rgn>[sandbox resource group name]</rgn> `
        -DatabaseName sql-erp-db `
        -ServerName $sqlserver.ServerName
    ```

    You should get an output similar to the following code. If the command returns no value, a backup hasn't started yet. Rerun this command in a couple of minutes.

    ```output
    ResourceGroupName        : <rgn>[sandbox resource group name]</rgn>
    ServerName               : erpserver-53903
    DatabaseName             : sql-erp-db
    Location                 : East US
    RestorePointType         : CONTINUOUS
    RestorePointCreationDate :
    EarliestRestoreDate      : 9/24/19 4:21:21 PM
    RestorePointLabel        :
    ```

    `RestorePointType` is `CONTINUOUS`, indicating that backups are automatically happening. `EarliestRestoreDate` indicates the timestamp of the first backup. With backups in place, let's continue the exercise.

## Drop a table from the database

Let's start by simulating a mistaken database modification.

1. On the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) menu or from the **Home** page, select **All resources**, select **erpserver-NNNN**, select **SQL databases**, and then select the **sql-erp-db** database. 

1. We'll use the T-SQL query editor built into the Azure portal. Select **Query editor (preview)**, then sign in with the **dbadmin** user and the password that you specified for this account. The following T-SQL commands would also work in SQL Server Management Studio, or the mssql extension for Visual Studio Code, or other T-SQL query tools.

1. Let's drop the `Person` table that we created earlier. In a new query window, run this command. Note the time on your clock.

    ```sql
    DROP TABLE Person
    ```

1. To check the tables in the database, select **New Query**. Then, in the **Query 2** window, run this command to list all tables in the database:

    ```sql
    SELECT schema_name(t.schema_id) as schema_name,
        t.name as table_name
    FROM sys.tables AS t
    ORDER BY schema_name, table_name;
    ```

    You should see **No results** returned, because we deleted the `Person` table.

    :::image type="content" source="../media/7-no-results.png" alt-text="Screenshot that shows no results returned after querying for the tables in the database.":::

## Create a point-in-time restore

The `Person` table was mistakenly deleted. Now, let's restore the database to its previous state.

1. On the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) menu or from the **Home** page, select **All resources**, and then select the **sql-erp-db** database.

1. At the top of the **Overview** page, select **Restore**.

1. Complete the **Basics** tab on the **Restore database** page with these values, and then select **Review + create**. Here, you provide a new database name for the restored version of the database. 

    | Setting | Value |
    | --- | --- |
    | Select source | **Point-in-time** |
    | Database name | `sql-erp-db-restored` |
    | Restore point | Select a time before you dropped the `Person` table, perhaps 10 minutes ago. |
    | Server | erpserver-xxxxx |
    | Want to use SQL elastic pool? | No |
    | Compute + storage | Default value |
    | Backup storage redundancy | **Locally-redundant backup storage** |

    :::image type="content" source="../media/7-restore-sql-database-point-in-time-recovery.png" alt-text="Screenshot that shows the restore database page with the Review + create button selected." lightbox="../media/7-restore-sql-database-point-in-time-recovery.png":::

1. Select **Create**. The database restore takes several minutes to complete.

## View the restored database

The restored database contains the `Person` table.

1. In the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) menu or from the **Home** page, select **All resources**, and then select the `sql-erp-db-restored` database.

1. Select **Query editor (preview)**, and then sign in with the **dbadmin** user and the password that you specified for this account.

1. To check the tables in the database, in the **Query 1** window, run this command:

    ```sql
    SELECT schema_name(t.schema_id) as schema_name,
        t.name as table_name
    FROM sys.tables AS t
    ORDER BY schema_name, table_name;
    ```

    The database has been restore to the state it was, including the `Person` table.

    :::image type="content" source="../media/7-query-after-restore-person-table.png" alt-text="Screenshot showing results after querying for the tables in the database.":::

1. Confirm that the data is in the table by running this command:

    ```sql
    SELECT * FROM Person;
    ```

    You should see the data that you entered previously.

    :::image type="content" source="../media/7-query-after-restore-select.png" alt-text="Screenshot showing confirmed results after querying for the tables in the database.":::

You've now learned how you can restore a database if something unintended happens to the data. You've familiarized yourself with the restore process. You can now assure your organization that you've properly defined the backup and restore procedures.
