Your retail organization must comply with data protection regulations in your jurisdiction. You need to keep all data for two years and you want to keep one backup each month for six months. You have been asked to configure a long-term retention policy in Azure SQL Database to meet these requirements.

Here, you will use the Azure portal to set up a policy and then check it in PowerShell.

## Use the Azure portal to configure long-term retention

Let's start by configuring the two year retention by using the portal.

1. In the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true), select **All resources** and then select **ERPServer-NNNN**.

1. Under **Settings**, select **Manage Backups**.

1. In the list of databases, select **sql-erp-db**, and then select **Configure retention**.

1. Select **Yearly LTR Backups**.

1. In the **How long would you like this annual backup to be kept?** controls, select **2 Year(s)**.

    ![Configure a yearly retention policy](../media/5-configure-ltr-policy.png)

1. Select **Apply**, and then select **Yes**.

## Use PowerShell to configure long-term retention

You can also create long-term retention policies by using PowerShell.

1. Run this command to start PowerShell in the Cloud Shell.

    ```bash
    pwsh
    ```

1. In the Cloud Shell, to determine the name of your database server, run this command, and then make a note of the server name.

    ```powershell
    $sqlserver=Get-AzSqlServer
    ```

1. To view long-term retention policies for the database server, run this command.

    ``` powershell
    Get-AzSqlDatabase `
        -ResourceGroupName <rgn>[sandbox resource group name]</rgn> `
        -ServerName $sqlserver `
        | Get-AzSqlDatabaseLongTermRetentionPolicy
    ```

1. Run this command to view the long-term retention policies for the **sql-erp-db** database.

    ``` powershell
    Get-AzSqlDatabaseBackupLongTermRetentionPolicy `
        -ServerName $sqlserver `
        -DatabaseName sql-erp-db `
        -ResourceGroupName <rgn>[sandbox resource group name]</rgn>
    ```

1. To create a long-term retention policy via PowerShell, run this command.

    ``` powershell
    Set-AzSqlDatabaseBackupLongTermRetentionPolicy `
        -ServerName $sqlserver `
        -DatabaseName sql-erp-db `
        -ResourceGroupName <rgn>[sandbox resource group name]</rgn> `
        -MonthlyRetention P6M `
        -YearlyRetention P2Y `
        -WeekOfYear 1
    ```

1. To check that the new policy has been applied, run this command again.

    ```powerShell
    Get-AzSqlDatabaseBackupLongTermRetentionPolicy `
        -ServerName $sqlserver `
        -DatabaseName sql-erp-db `
        -ResourceGroupName <rgn>[sandbox resource group name]</rgn>
    ```

1. In the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true), select **All resources** and then select **ERPServer**

1. Under **Settings**, select **Manage Backups**, and then the list of databases, check the **sql-erp-db** long-term retention properties.

    ![Completed long-term retention settings](../media/5-completed-ltr-settings.png)