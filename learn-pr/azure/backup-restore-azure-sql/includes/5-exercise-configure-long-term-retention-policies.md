In this module you use the Azure portal to configure the long-term retention policies

   1. In the Azure portal, select the newly created SQL server database and under settings click **Manage Backups**
   1. Under the **Configure policies** click the **Configure retention**
   1. Select the checkbox for the database on which you want to set or modify long-term backup retention policies. If the checkbox next to the database is not selected, the changes for the policy will not apply to that database.
   1. Set a new retention policy by selecting weekly for this example, and specify 3 as the number of weeks
   1. Click **Apply**

![Screenshot of the Azure portal showing retention policy options](../media/5-ltr-configure-policies.PNG)

## View and create Long-term Retention policies using PowerShell

   1. View Long-term Retention policies for the whole server with Powershell

   ``` Powershell
       Get-AzSqlDatabase -ResourceGroupName rg-sql-erp -ServerName sql-erp | Get-AzSqlDatabaseLongTermRetentionPolicy -Current
   ```

   1. View Long-term Retention policies for a specific database

   ``` Powershell
       Get-AzSqlDatabaseBackupLongTermRetentionPolicy -ServerName sql-erp -DatabaseName sql-erp-db  -ResourceGroupName rg-sql-erp -Current
   ```

   1. Create a Long-term Retention policy via Powershell

   ``` Powershell
       Set-AzSqlDatabaseBackupLongTermRetentionPolicy -ServerName sql-erp -DatabaseName sql-erp-db -ResourceGroupName rg-sql-erp -WeeklyRetention P12W
   ```