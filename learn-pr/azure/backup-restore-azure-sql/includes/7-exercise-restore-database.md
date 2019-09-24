Trial restores are a key component of any disaster recovery strategy.

You want to familiarize yourself with the steps to restore a backed-up database to a specific point-in-time should it become necessary. You also want to investigate how long a restore operation will take so you can plan for this in your guidance for your organization.

Here, you will perform trial restores from automated Azure SQL Database backups.

> [!IMPORTANT]
> The first automatic backup operation must be complete before your can restore a database. Don't start this exercise until 15 minutes or so after you completed the exercise in unit 3.

## Confirm existence of backup

It can take up to 15 minutes for the first successful backup to complete. We need to make sure that we have a backup before we continue with the exercise.

1. Run the following PowerShell command in the Cloud Shell to validate that continuous backups are running. Update `ERPServer-NNNN` with the name of your database server.

    ```powershell
    Get-AzSqlDatabaseRestorePoint `
        -ResourceGroupName <rgn>[sandbox resource group name]</rgn> `
        -DatabaseName sql-erp-db `
        -ServerName ERPServer-NNNN
    ```

    You should see output similar to below if your backups are running. If the command returns no value, a backup hasn't kicked off quite yet. Rerun 

    ```output
    ResourceGroupName        : Learn-ad055e8f-5334-4d86-8f85-68fc996d19d9
    ServerName               : ERPServer-53903
    DatabaseName             : sql-erp-db
    Location                 : East US
    RestorePointType         : CONTINUOUS
    RestorePointCreationDate :
    EarliestRestoreDate      : 9/24/19 4:21:21 PM
    RestorePointLabel        :
    ```

    Note that the `RestorePointType` is `CONTINUOUS`, indicating that backups are automatically happening. The `EarliestRestoreDate` indicates the timestamp of the first backup. With backups in place, let's continue with the exercise.

## Drop a table from the database

Let's start by simulating a mistaken database modification.

1. In the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true), select **All resources** and then select the **sql-erp-db** database.

1. Select **Query editor**, and then sign in with the **dbadmin** user and the password you specified.

1. Let's drop the **Person** table that we created earlier. In the **Query 1** window, run this command.

    ```sql
    DROP TABLE Person
    ```

1. To check the tables in the database, select **New Query**, and then in the **Query 2** window, run this command.

    ```sql
    SELECT schema_name(t.schema_id) as schema_name,
        t.name as table_name
    FROM sys.tables t
    ORDER BY schema_name, table_name;
    ```

## Run a point-in-time restore

The **Person** table has been mistakenly deleted. Now, let's restore the database to its previous state.

1. In the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true), select **All resources** and then select the **sql-erp-db** database.

1. At the top of the **Overview** page, select **Restore**.

1. Complete the **Restore** page with these values, and then select **OK**.

    | Setting | Value |
    | --- | --- |
    | Select source | Point-in-time |
    | Database name | sql-erp-db-restored |
    | Restore point | Select a time 10 minutes ago, before you dropped the **Person** table |
    | Target server | ERPServer |
    | Elastic pool | None |
    | Pricing tier | Default value |
    | | |

    ![Screenshot of restoring a database in the portal](../media/7-restoring-a-database-pitr.png)

## View the restored database

The restored database should contain the **Person** table. You can check that in the portal.

1. In the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true), select **All resources** and then select the **sql-erp-db-restored** database.

1. Select **Query editor**, and then sign in with the **dbadmin** user and the password you specified.

1. To check the tables in the database, in the **Query 1** window, run this command.

    ```sql
    SELECT schema_name(t.schema_id) as schema_name,
        t.name as table_name
    FROM sys.tables t
    ORDER BY schema_name, table_name;
    ```

1. Examine the results. The **Person** table should now be present.

1. Confirm that the data is in the table by running this command.

    ```sql
    SELECT * FROM Person
    ```

You've now seen how you can restore a database in the event that something unintended happens to the data. You've familiarized yourself with the restore process, and can now assure your organization that your backup and restore procedures are properly defined.