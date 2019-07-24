It's easy to configure long-term retention.

Your retail organization must comply with data protection regulations in your jurisdiction. You need to keep all data for two years and you want to keep one backup each month for six months. You have been asked to configure a long-term retention policy in Azure SQL Database to implement these requirements.

Here, you will use the Azure portal to set up a policy and then check it in PowerShell.

## Use the Azure portal to configure long-term retention

Let's start by configuring the two-year retention by using the portal:

1. In the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true), click **All resources** and then click **ERPServer**
1. Under **Settings**, click **Manage Backups**
1. In the list of databases, click **sql-erp-db**, and then click **Configure retention**.
1. Select the **Yearly LTR Backups** checkbox.
1. In the **How long would you like this annual backup to be kept?** controls, select **2 Year(s)**.

    ![Configure a yearly retention policy](../media/5-configure-ltr-policy.png)

1. Click **Apply**, and then click **Yes**.

## Use PowerShell to configure long-term retention

You can also create long-term retention policies by using PowerShell. Follow these steps:

1. In the Cloud Shell, to determine the name of your database server, run this command, and then make a note of the server name:

    ```bash
    Get-AzSqlServer
    ```

1. To view long-term retention policies for the database server, run this command, and substitute the server name:

    ``` Powershell
    Get-AzSqlDatabase -ResourceGroupName <rgn>[sandbox resource group name]</rgn> -ServerName <ServerName> | Get-AzSqlDatabaseLongTermRetentionPolicy
    ```

1. To view the long-term retention policies for the **sql-erp-db** database, run this command, and substitute the server name::

    ``` Powershell
    Get-AzSqlDatabaseBackupLongTermRetentionPolicy -ServerName <ServerName> -DatabaseName sql-erp-db  -ResourceGroupName <rgn>[sandbox resource group name]</rgn>
    ```

1. To create a long-term retention policy via Powershell, run this command, and substitute the server name:

    ``` Powershell
    Set-AzSqlDatabaseBackupLongTermRetentionPolicy -ServerName <ServerName> -DatabaseName sql-erp-db -ResourceGroupName <rgn>[sandbox resource group name]</rgn> -MonthlyRetention P6M -YearlyRetention P2Y -WeekOfYear 1
    ```

1. To check that the new policy has been applied, run this command again:

    ```PowerShell
    Get-AzSqlDatabaseBackupLongTermRetentionPolicy -ServerName <ServerName> -DatabaseName sql-erp-db  -ResourceGroupName <rgn>[sandbox resource group name]</rgn>
    ```

1. In the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true), click **All resources** and then click **ERPServer**
1. Under **Settings**, click **Manage Backups**, and then the list of databases, check the **sql-erp-db** long-term retention properties.

    ![Completed long-term retention settings](../media/5-completed-ltr-settings.png)