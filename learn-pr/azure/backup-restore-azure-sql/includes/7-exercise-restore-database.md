As part of this exercise we will drop the table created earlier and aim to restore the database from the available backups and determine if the table gets restored. We'll do this in both the Portal and then use Poershell to perform the same operation.

   1. So lets drop the table you created in the earlier exercise.
   1. Verify that this table is no longer available.

    > [!NOTE]
    > You will have to use either the Query editor or SQL Management Studio to drop the table

## View backups and restore from a backup using Azure portal

View the backups that are retained for a specific database with a LTR policy, and restore from those backups

   1. In the Azure portal, select your SQL server and then click **Manage Backups**. On the **Available backups** tab, select the database for which you want to see available backups.

![Screenshot of the available backups](../media/7-view-available-backups.PNG)

   1. In the **Available backups** pane, review the available backups.

![Screenshot of the available backups](../media/7-ltr-available-backups.PNG)

Lets restore the database to to the most recent backup containing the table you just dropped, in the portal.

   1. Select the backup from which you want to restore, and then specify the new database name.

![Screenshot of restoring from a selected backup](../media/7-ltr-restore.PNG)

   1. Click **Apply** to restore your database from the backup in Azure SQL storage to the new database.
   1. When the restore job is completed, open the SQL databases page to view the newly restored database
   1. Verify that the table has been restored.

   1. Drop the table again

## View available backups using Powershell

   1. Use the Azure Cloud Shell terminal on the right to run the following PowerShell commands to view the backups available:

    > [!NOTE]
    > Switch your Cloud Shell session to **PowerShell** before trying these commands, if it isn't already.

   1. View the backups available for this database via Azure Powershell.

        ``` Powershell
        $database = Get-AzSqlDatabase -ResourceGroupName "rg-sql-erp" -ServerName "sql-erp" -DatabaseName "sql-erp-db"
        ```

   1. Restore the database to to the most recent backup containing the table you just dropped, using Azure PowerShell.

        ``` Powershell
        Restore-AzSqlDatabase -FromPointInTimeBackup -PointInTime UTCDateTime -ResourceGroupName $Database.ResourceGroupName -ServerName $Database.ServerName -TargetDatabaseName "RestoredDatabase" -ResourceId $Database.ResourceID -Edition "Standard" -ServiceObjectiveName S2
        ```

   1. Verify that the table has been restored again.

   1. View the Long-term Retention backups available on the server

       (note to author, this may not display results due to the time needed for it to take effect)

        ``` Powershell
        Get-AzSqlDatabaseLongTermRetentionBackup -Location "westeurope" -ServerName "sql-erp"
        ```

   1. Restore from Long-term Retention backup

        (note to author, the database cannot be restored on top of the existing database, so you'll need to account for this in your steps)

        ``` Powershell
        Restore-AzSqlDatabase -FromLongTermRetentionBackup -ResourceId <Resource ID> -ServerName "sql-erp" -ResourceGroupName "rg-sql-erp" -TargetDatabaseName "RestoredDatabaseLTR" -ServiceObjectiveName S2
        ```