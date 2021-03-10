Companies need to keep backups for months or years for regular administrative protection, such as to restore accidentally deleted data.

For example, data protection laws in at least one country where your retail organization operates require you to keep records of all customer transactions for 5 years. You need to ensure that data in Azure SQL Database, which underpins your enterprise resource planning (ERP) system, is kept for at least that long.

Here, you'll learn about long-term retention policies in Azure SQL Database and how to use them when you need backups to be kept for more than 35 days.

## Long-term backup retention policies

Azure SQL Database automatic backups remain available to restore for up to 35 days. This period is enough for the purposes of day-to-day administration. But sometimes you might need to retain data for longer periods. For example, data protection regulations in your local jurisdiction might require you to keep backups for several years.

For these requirements, use the long-term retention (LTR) feature. This way, you can store Azure SQL Database backups in read-access geo-redundant storage (RA-GRS) blobs for up to 10 years. If you need access to any backup in LTR, you can restore it as a new database by using either the Azure portal or PowerShell.

## How SQL Database long-term retention works

LTR takes the backups that are automatically made for point-in-time recovery and copies them to different blobs. This copy operation runs in the background at low priority to ensure that there's no impact on performance. 

These backups don't happen by default. You must configure a policy to start and manage them. 

## How to write a long-term retention policy

The long-term retention policy sets how frequently an automatic backup will be copied for long-term retention. You specify this frequency with letters:

- `W`: Specifies that one full backup each week will be coped to long-term retention.
- `M`: Specifies that one full backup from the first week of each month will be copied to long-term retention.
- `Y`: Specifies that one full backup each year will be coped to long-term retention.

If you use `Y` for yearly backups, you can specify the week of the year when that backup is copied by using the `WeekOfYear` parameter.

For each policy letter, you use numbers to indicate how long the backup should be retained. For example, to keep the weekly backup for 10 weeks, use `W=10`. To keep the annual backup for 3 years, use `Y=3`.

## Example long-term retention policies

You can combine weekly, monthly, and yearly retention values to create a flexible policy. For example:

- `W=0, M=0, Y=5, WeekOfYear=3`

    This policy retains the full backup taken in the 3rd week of the year for 5 years.

- `W=0, M=10, Y=0`

    This policy retains the first full backup of each month for 10 months.

- `W=12, M=0, Y=0`

    This policy retains each weekly full backup for 12 weeks.

- `W=4, M=12, Y=10, WeekOfYear=1`

    This policy retains each weekly backup for 4 weeks. It also retains the first full backup of each month for 12 months. The first full backup taken in the first week of each year is retained for 10 years.

## Setting retention policies in PowerShell

In PowerShell, you can examine a long-term retention policy by using this command:

``` powershell
Get-AzSqlDatabase `
    -ResourceGroupName <ResourceGroupName> `
    -ServerName <ServerName> `
    | Get-AzSqlDatabaseLongTermRetentionPolicy
```

To configure the policy, use the `Set-AzSqlDatabaseBackupLongTermRetentionPolicy` cmdlet. When you specify these policies in PowerShell, you must use ISO 8601 duration values. For example, to specify the `W=10` policy, pass the string `P10W` to the `-WeeklyRetention` parameter. To specify the `Y=3` policy, pass the string `P3Y` to the `-YearlyRetention` parameter.

``` powershell
Set-AzSqlDatabaseBackupLongTermRetentionPolicy `
    -ServerName <ServerName> `
    -DatabaseName <DatabaseName> `
    -ResourceGroupName <ResourceGroupName> `
    -WeeklyRetention P10W `
    -YearlyRetention P3Y `
    -WeekOfYear 1
```
