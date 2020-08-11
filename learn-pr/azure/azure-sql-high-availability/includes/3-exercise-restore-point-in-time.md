In this exercise, you'll see how you can recover from a common error by using point in time restore (PITR). This process is easy to do in the portal or programmatically, but in this exercise you'll learn how to do it by using the Azure CLI.

## Setup: Use scripts to deploy Azure SQL Database

In the terminal on the right side, you'll see Azure Cloud Shell, which is a way to interact with Azure by using a browser. Before you start the exercises, you need to run a script there to create your environment: an Azure SQL Database that contains the AdventureWorks database. There will be some prompts in the script for a password and your local IP address.  

These scripts should take 3-5 minutes to complete. Make sure to note your password, unique ID, and region because they won't be shown again.

1. To get the IP address that's required, you need to disconnect from any VPN service and run `(Invoke-WebRequest -Uri "https://ipinfo.io/ip").Content` in a local PowerShell window (not in this browser). Note the resulting IP address.

1. Run the following script in Azure Cloud Shell on the right side of this page. Enter a complex password and public IP address when prompted.

    ```powershell
    $adminSqlLogin = "cloudadmin"
    $password = Read-Host "Your username is 'cloudadmin'. Please enter a password for your Azure SQL Database server that meets the password requirements"
    # Prompt for local ip address
    $ipAddress = Read-Host "Disconnect your VPN, open PowerShell on your machine and run '(Invoke-WebRequest -Uri "https://ipinfo.io/ip").Content'. Please enter the value (include periods) next to 'Address': "
    # Get resource group and location and random string
    $resourceGroup = Get-AzResourceGroup | Where ResourceGroupName -like "<rgn>Sandbox resource group name</rgn>"
    $resourceGroupName = "<rgn>Sandbox resource group name</rgn>"
    $uniqueID = Get-Random -Minimum 100000 -Maximum 1000000
    $storageAccountName = "mslearnsa"+$uniqueID
    $location = $resourceGroup.Location
    # The logical server name has to be unique in the system
    $serverName = "aw-server$($uniqueID)"
    ```

1. Output and store (in a text file or similar location) the information you'll need throughout this module by running the following script in Azure Cloud Shell. You'll probably need to select **Enter** after you paste in the code because the last line won't run by default.

    ```powershell
    Write-Host "Please note your unique ID for future exercises in this module:"  
    Write-Host $uniqueID
    Write-Host "Your resource group name is:"
    Write-Host $resourceGroupName
    Write-Host "Your resources were deployed in the following region:"
    Write-Host $location
    Write-Host "Your server name is:"
    Write-Host $serverName
    ```
   > [!IMPORTANT]
   > Don't forget to note your password, unique ID, and region. You'll need this information throughout the module.

1. Run the following script to deploy an Azure SQL database and logical server with the AdventureWorks sample. This script will also add your IP address as a firewall rule, enable Advanced Data Security, and create a storage account for use in upcoming units.

    ```powershell
    # The logical server name has to be unique in the system
    $serverName = "aw-server$($uniqueID)"
    # The sample database name
    $databaseName = "AdventureWorks"
    # The storage account name has to be unique in the system
    $storageAccountName = $("sql$($uniqueID)")
    # Create a new server with a system-wide unique server name
    $server = New-AzSqlServer -ResourceGroupName $resourceGroupName `
        -ServerName $serverName `
        -Location $location `
        -SqlAdministratorCredentials $(New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $adminSqlLogin, $(ConvertTo-SecureString -String $password -AsPlainText -Force))
    # Create a server firewall rule that allows access from the specified IP range and all Azure services
    $serverFirewallRule = New-AzSqlServerFirewallRule `
        -ResourceGroupName $resourceGroupName `
        -ServerName $serverName `
        -FirewallRuleName "AllowedIPs" `
        -StartIpAddress $ipAddress -EndIpAddress $ipAddress
    $allowAzureIpsRule = New-AzSqlServerFirewallRule `
        -ResourceGroupName $resourceGroupName `
        -ServerName $serverName `
        -AllowAllAzureIPs
    # Create a database
    $database = New-AzSqlDatabase  -ResourceGroupName $resourceGroupName `
        -ServerName $serverName `
        -DatabaseName $databaseName `
        -SampleName "AdventureWorksLT" `
        -Edition "GeneralPurpose" -Vcore 2 -ComputeGeneration "Gen5"
    # Enable Advanced Data Security
    $advancedDataSecurity = Enable-AzSqlServerAdvancedDataSecurity `
        -ResourceGroupName $resourceGroupName `
        -ServerName $serverName
    # Create a storage account
    $storageAccount = New-AzStorageAccount -ResourceGroupName $resourceGroupName `
        -AccountName $storageAccountName `
        -Location $location `
        -Type "Standard_LRS"
    ```

1. On your local computer, open SSMS and create a new connection to your logical server. For the server name, enter the name of your Azure SQL Database logical server. If you didn't save the name earlier, you might need to refer to the Azure portal to get it. For example, **aw-server\<unique ID>.database.windows.net**.  

    > [!div class="nextstepaction"]
    > [Azure portal](https://portal.azure.com/learn.docs.microsoft.com/?azure-portal=true)

    1. When you're in the Azure portal, you can enter **AdventureWorks** in the search box to find your database and its associated logical server.

    1. In the **Authentication** box, enter **SQL Server Authentication**. Enter the corresponding Server Admin **Login** and **Password** (the one you provided during deployment in the previous exercise).  

    1. Select **Remember password**, and then select **Connect**.  

    :::image type="content" source="../media/3-connect-azure-sql.png" alt-text="Screenshot that shows how to connect to SQL Database in SSMS.":::  

    > [!NOTE]
    > Depending on your local configuration (for example, VPN), your client IP address might differ from the IP address the Azure portal used during deployment. If it does, you'll see a message that says "Your client IP address does not have access to the server. Sign in to an Azure account and create a new firewall rule to enable access." If you get this message, sign in with the account you're using for the sandbox and add a firewall rule for your client IP address. You can complete these steps by using the pop-up wizard in SSMS.  

## Setup: Configure auditing by using Log Analytics

In this exercise, you'll learn how to use auditing through Log Analytics to determine when DROP statements have occurred. To do this, you must first configure auditing.

1. Go to the Azure portal, and then go to your Azure SQL database.

    > [!div class="nextstepaction"]
    > [Azure portal](https://portal.azure.com/learn.docs.microsoft.com/?azure-portal=true)

1. In the left pane, under **Security**, select **Auditing**. Select **View server settings**. You can apply auditing at the server level. It then applies to all databases in the Azure SQL Database logical server.  

1. Set **Auditing** to **ON**.  

1. Select **Log Analytics (Preview)**, and then select **Configure**.  

1. Select **Create New Workspace**.  

1. Enter the information for the subscription, resource group, and location that you're using to complete this module. We recommend that you name your Log Analytics workspace **azuresql\<unique ID>-la**, filling in the unique ID for your resources. Select **OK**.  

    It might take some time to validate and create your Log Analytics account. You should see it soon. 

1. Select **Save**.  

   > [!IMPORTANT]
   > Be sure to select **Save**. If you don't, Log Analytics won't collect logs.

## Complete PITR

Before you go any further, it's important to understand the recommended process for doing PITR:  

1. A table or database is deleted by accident.
1. Determine the time that you need to go back to. It should be before the error happened.  
1. Complete PITR via PowerShell or the Azure portal to go back to this time. This process deploys a new database and restores a copy of your database. For example, AdventureWorks-copy.  
1. Confirm the new database (for example, AdventureWorks-copy) is in the correct state (as it was before the accident occurred).  
1. Rename the original database. For example, rename AdventureWorks to AdventureWorks-old.
1. Rename the new database with the original database name. For example, rename AdventureWorks-copy to AdventureWorks.  
1. Delete the original database. For example, AdventureWorks-old.  

In this exercise, you'll complete these steps.  

### Simulate deletion of data

1. First, let's confirm that the table we'll *accidentally* delete exists and has data in it. Let's look at some of the values in SalesLT.OrderDetail.  

    Go to SSMS and check/update your connection. Make sure the connection you use is connecting to the logical server but not to a specific database (for example, set to **\<default>** in the following screenshot). You should also confirm that **Additional Connection Parameters** is contains no text.  

    :::image type="content" source="../media/3-default.png" alt-text="Screenshot of the default connection.":::

1. Right-click on your AdventureWorks database and create a new query. Run the following query and review the results.  

    ```sql
    SELECT TOP 10 * from SalesLT.SalesOrderDetail
    ```

    :::image type="content" source="../media/3-sales-detail-ssms.png" alt-text="Screenshot of the sales order detail table.":::  

1. Now, let's simulate the loss of data by dropping a table in the database.  

    **Using the same query window**, run the following query and note the completion time.

    ```sql
    DROP TABLE SalesLT.SalesOrderDetail
    ```

    > [!IMPORTANT]
    > Save the completion time, you may need it later, for example `Completion time: 2020-06-22T09:20:27.1859237-07:00`.

1. Finally, before you get into the steps to restore, run the follow code in Azure Cloud Shell on the right to configure your environment in the Azure Cloud Shell.  

    ```powershell
    $resourceGroup = Get-AzResourceGroup | Where ResourceGroupName -like <rgn>Sandbox resource group name</rgn>
    $server = Get-AzureRmSqlServer -ResourceGroupName $resourceGroup.ResourceGroupName
    $logical_server = $server.ServerName
    $resource_group = $resourceGroup.ResourceGroupName

    # Specify your default resource group and Azure SQL Database logical server
    az configure --defaults group=$resource_group sql-server=$logical_server

    # Confirm the defaults have been set
    az configure --list-defaults
    ```

    The `group` and `sql-server` parameters returned should match the name of your Microsoft Learn resource group and your Azure SQL Database logical server.

### Identify the time to restore the database to

1. The first step is to figure out when you should restore the database. In order to complete step 1, you need to know when the last "good" transaction occurred, before the "bad" one, so you can restore to before the "bad" transaction but after the last "good" one.  

    One way to determine the drop time, is if you have access to the `Completion time` of the `DROP` statement, which you noted in the previous step.  

    A new way may be to use the Audit logs in the Azure portal. Navigate to your Azure SQL Database in the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true), e.g. **AdventureWorks**. In the left-hand menu, under Security, select **Auditing** and then select **View audit logs**.  

1. Select **Log Analytics**. If you see a **Get Started** screen, select **OK**. This then takes you to a query editor that allows you to query logs using Kusto query language (KQL), which is meant to be easy to use for querying logs for SQL professionals.  

    :::image type="content" source="../media/3-log-analytics.png" alt-text="Screenshot of how to select log analytics.":::  

1. Copy the below KQL query and paste it into the query editor in the Log Analytics view in the Azure portal (replace the existing query).

    ```kql
    search database_name_s == "AdventureWorks"
    | where Category == 'SQLSecurityAuditEvents' and statement_s like 'DROP'
    | project format_datetime(event_time_t, 'yyyy-MM-dd hh:mm:ss.fff'), ResourceGroup, server_instance_name_s, database_name_s,  statement_s, succeeded_s,client_ip_s, server_principal_name_s, application_name_s
    | sort by event_time_t desc
    ```

1. Select **Run** and review the results. It should be similar to below, but with a different date/time.

    If you see other `DROP`s, you should select the one related to the table you just dropped.  

    :::image type="content" source="../media/3-log-analytics-results.png" alt-text="Screenshot of the Log analytics results.":::

    > [!NOTE]
    > The logs can take a 5-10 minutes to show up here. If you are waiting for longer than 3-5 minutes, you can leverage the `Completion time` you noted in the previous step (but you need to convert to GMT). But know, that in a real world situation, it is highly unlikely you will be able to get to that window with the completion time, so using auditing can help greatly.  

1. In this example, the date/time is `2020-07-24 08:06:24.386`. The required format is slightly different. Update it using this example as a reference and to the definition of `$before_error_time`. You also may want to subtract `.001` seconds, to ensure you restore to *before* the error occurred.  

    * Log Analytics format: `2020-07-24 08:06:24.386`
    * Required format: `2020-07-24T20:06:24.385`  

    ```powershell
    $before_error_time ="2020-07-24T20:06:24.385"
    ```

### Restore the database and confirm missing data

1. In this step you'll use `az cli db restore` to restore to before the table was deleted. Run the following in the terminal to your right in this window.

    ```powershell
    # Restore the database to the time before the database was deleted
    az sql db restore --dest-name "AdventureWorks-copy" --name "AdventureWorks" --time $before_error_time --verbose
    ```

    The restore will take about 5-10 minutes. When you run a restore, Azure deploys a new Azure SQL Database in your Azure SQL Database logical server that has all the same configuration options as the original. After it's deployed, it will then restore the database into that new Azure SQL Database.  

    You can check the status by refreshing your view of databases in **SSMS** by right-clicking on **Databases** and selecting **Refresh**. Once the database has been deployed, you will see the restore is now in progress.  

    :::image type="content" source="../media/3-db-restore.png" alt-text="Screenshot of a database restoring in SSMS.":::  

    Once you see this, it should only be 2-3 minutes more. You will know it is done, because the command will complete. Also, you will no longer see "(Restoring...)" next to the copy database when you initiate a refresh.  

    If you notice it is taking longer than above stated times, it could be due to your Microsoft Learn environment. There are a limited number of restore requests that can be processed/submitted at once for a single subscription. If you want to learn more about the limits and related details for PITR while you wait, you can [read more to learn the details related to recovering an Azure SQL database by using automated database backups](https://docs.microsoft.com/azure/sql-database/sql-database-recovery-using-backups?azure-portal=true).  

1. In order to confirm the new database is in the correct state (before the accident occurred), right-click on the logical server in SSMS and select **Refresh** to refresh your connection to the Azure SQL Database logical server.  

1. Then, right-click on your new database, e.g. **AdventureWorks-copy** and select **New Query**.  

    :::image type="content" source="../media/3-new-query.png" alt-text="Screenshot of creating a new query.":::  

1. Use the following query to confirm the table exists.  

    ```sql
    SELECT TOP 10 * from SalesLT.SalesOrderDetail
    ```

    You should get something similar to the following screenshot, which confirms your database has been restored to where you want it to be.

    :::image type="content" source="../media/3-sales-detail-ssms.png" alt-text="Screenshot of the sales order detail table.":::  

### Swap the databases and clean up

1. Next, you'll rename the original database to **AdventureWorks-old** so you can later rename the new database to the original database name. As long as your applications use retry logic, this will make it so no connection strings need to be changed.

    If at any point your database appears unavailable (e.g. you can't connect to the databases in SSMS if you refresh the connection), it could be due to updates happening to the DNS table. So while the database isn't physically unavailable, it is unresolvable. If you wait a minute or so, you should be able to resume normal activities.  

    ```powershell
    az sql db rename --name "AdventureWorks" --new-name "AdventureWorks-old"
    ```

1. Now that the original database name is no longer taken, you can rename the copy database to that of the original, again using the Azure Cloud Shell.  

    ```powershell
    az sql db rename --name "AdventureWorks-copy" --new-name "AdventureWorks"
    ```

1. Finally, you have no need for the old database, so you can delete it with `az sql db delete`.

    ```powershell
    az sql db delete --name "AdventureWorks-old" --yes
    Write-Host "Database deleted"
    ```

1. You can confirm it no longer exists with the following command.

    ```powershell
    az sql db list -o table
    ```

You've now seen how you can leverage PITR in Azure SQL Database. PITR is also available in Azure SQL Managed Instance, **for databases not the whole instance**. You can use almost the same commands except with `az sql midb` as opposed to `az sql db`.
