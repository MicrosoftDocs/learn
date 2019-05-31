# Title

Backup and restore a single Azure SQL Database

## Role(s)

- Solution Architect

## Level

- Beginner

## Product(s)

- Azure SQL Database

## Prerequisites

- Basic knowledge of Azure SQL Database
- Basic knowledge of Azure PowerShell

## Summary

Protect the data in a single Azure SQL database and recover from data loss or corruption with backup and restore.

## Learning objectives

1. Configure backup and retention of a single Azure SQL database
2. Restore a single Azure SQL database

## Chunk your content into subtasks

Identify the subtasks of *Backup and restore your Azure SQL Database*

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- | ---- | ---- | ---- | ---- |
| Explain the benefits of Azure SQL backup | Set up backup and retention policies | Knowledge check & exercise | 1 | Yes |
| Configure backup for Azure SQL | Set up backup and retention policies | Exercise | 1 | Yes |
| Explain the benefits of Long-term retention policies | Set up backup and retention policies | Exercise | 1 | Yes |
| Restore backup to Azure SQL | ability to recover | Exercise | 2 | Yes |

## Outline the units

*Add more units as needed for your content*

1. **Introduction**

    A retail organization has recently moved their ERP database to Azure SQL Database. This database holds critical operational data, and needs to be protected from data loss or corruption. They need to set up backup and retention policies to ensure they have the ability to recover, and need to be familiar with the steps and options to recover, should the need arise.

1. **Azure SQL Database Backup**

    List the content that will enable the learner to *Explain the benefits of Azure SQL backup*:

    - Define Azure SQL Backups
        - Default backups are set depending on each service tier
        - All instances have backups enabled by default
        - Where Backups are stored
        - Storage costs for Backups

    *Knowledge check*

    What types of questions will test *learning objective*?

    - When are backups taken?
    - Where are Azure SQL backups stored?

1. **Exercise - Configure backup for Azure SQL Database**

    List the steps which apply the learning content from previous unit:

    1. Create a resource group for the new Azure SQL instance

        ``` CLI
        az group create --location westeurope --name rg-sql-erp
        ```

    1. Create an Azure SQL server

        ``` CLI
        az sql server create --resource-group rg-sql-erp --name sql-erp --location westeurope --admin-user dbadmin123 --admin-password StrongPassword123
        ```

    1. Create an Azure SQL server and database instance using the CLI

        ``` CLI
        az sql db create --resource-group rg-sql-erp --name sql-erp-db --server sql-erp --edition Standard
        ```

    1. Use the portal to view the newly create Azure SQL server and database. View the default policy for PITR (Point In Time Restore) configuration that was setup automatically for this database.

    1. Change the PITR configuration to 28 days. Apply changes, policy is updated within seconds.

    1. Add a table and a few sample records to the database. Make sure that the database (with the new table and data) is backed up.

1. **Long-term Retention policies**

    List the content that will enable the learner to *Explain the benefits of Long-term retention policies*:

    - Define Long-term retention policies
        - Able to setup additional to normal backup
        - Can choose a combination of weekly/monthly/yearly retention policies
        - Can choose how many days/week/months/years you would like these backups to be kept

1. **Exercise - Long-term Retention policies**

    1. View the Long-term Retention policies configuration in the portal
    1. Set new policy in the portal
    1. Apply changes
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

1. **Restore backup to Azure SQL Database**

    What types of questions will test *learning objective*?

    - Explain when you can restore from backups
        - Within the portal
        - Via Azure Powershell
    - How the restore operation works

1. **Exercise - Restore backup to Azure SQL Database**

    List the steps which apply the learning content from previous unit:

    1. Drop the table you created in the earlier exercise. Verify that this table is no longer available.
    1. View the backups available for this database in the portal.
    1. Restore the database to to the most recent backup containing the table you just dropped, in the portal.
    1. Verify that the table has been restored.

    1. Drop the table again
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

1. **Summary**

    How did you solve the problem in the initial scenario with the knowledge learned in the module?

    - Explained Azure SQL backup
    - Explained Long-term retention policies
    - Viewed the backups in the portal
    - Restored the backups with the portal and with Powershell

## Notes

Supporting documentation:

https://docs.microsoft.com/azure/sql-database/sql-database-recovery-using-backups

https://docs.microsoft.com/azure/sql-database/sql-database-long-term-backup-retention-configure
