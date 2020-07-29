In the module, you learned about geo-replication and auto-failover groups. In this exercise, you'll configure auto-failover groups for your Azure SQL Database. You'll then initiate a failover and observe the results, leveraging an application.

## Auto-failover groups in Azure SQL  

To configure auto-failover groups for a database(s) and observe the results in an application, you must complete the following steps:  

1. Configure environment
1. Create an empty Azure SQL Database server in the failover region
1. Create a failover group between the servers
1. Configure the network
1. Add database(s) to the failover group  
1. Configure your command prompt applications
1. Understand the running applications
1. Initiate a failover
1. Fail back

This exercise will guide you through configuring auto-failover groups for your AdventureWorks database. You'll then use a simple command-line application to understand where reads and writes occur, and the importance of retry logic in your applications. Finally, you'll do a fun exercise to determine how many read-replicas are associated with a Business critical database that also has an auto-failover group.  

### Configure environment

1. In the below cell, copy it to Notepad or similar and fill in your information. Add your SQL authentication password. For `$drLocation`, you'll need to supply the region where you want your failover group to be. Ideally, you would select a paired region to the region of your current server, which you can determine from the list [here](https://docs.microsoft.com/azure/best-practices-availability-paired-regions?azure-portal=true). At a minimum, it cannot be the same region where your original database is. Finally, add the IP address of your local machine. You should already have found this at the beginning of the exercise, but if you need to locate it again, open PowerShell on your local machine and run `(Invoke-WebRequest -Uri "https://ipinfo.io/ip").Content`.

    ```powershell
    # Add your info
    $password = "password"
    $drLocation = "eastus2"
    $ipAddress = "xx.xx.xx.xx"
    ```

1. Once your command is updated, run it in the Azure Cloud Shell (on the right side of this page).

1. Next, run the following in the Azure Cloud Shell to configure your variables for the steps that follow.

    ```powershell
    $admin = "cloudadmin"
    $resourceGroup = Get-AzResourceGroup | Where ResourceGroupName -like <rgn>Sandbox resource group name</rgn>
    $location = $resourceGroup.Location
    $resourceGroup = $resourceGroup.ResourceGroupName
    $database = "AdventureWorks"
    $server = Get-AzureRmSqlServer -ResourceGroupName $resourceGroup
    $server = $server.ServerName
    $drServer = "$($server)-dr"
    $failoverGroup = "$($server)-fg"
    $firewallRule = "AllowMyIp"
    Write-Host "Variables Received"
    ```

1. Create an empty Azure SQL Database server in the failover region by running the following in the Azure Cloud Shell.

    ```powershell
    # create a backup server in the failover region
    New-AzSqlServer -ResourceGroupName $resourceGroup `
        -ServerName $drServer `
        -Location $drLocation `
        -SqlAdministratorCredentials $(New-Object -TypeName System.Management.Automation.PSCredential `
        -ArgumentList $admin, $(ConvertTo-SecureString -String $password -AsPlainText -Force))
    Write-Host "New Azure SQL Database logical server Created in different region"
    ```

1. Create a failover group between the servers by running the following in the Azure Cloud Shell.

    ```powershell
    # create a failover group between the servers
    New-AzSqlDatabaseFailoverGroup -ResourceGroupName $resourceGroup `
        -ServerName $server `
        -PartnerServerName $drServer `
        -FailoverGroupName $failoverGroup 
    Write-Host "New auto-failover group created between the two Azure SQL Database logical servers"
    ```

1. Configure the network by running the following in the Azure Cloud Shell.

    ```powershell
    # Add a firewall rules that gives your VM access to the new server
    New-AzSqlServerFirewallRule -ResourceGroupName $resourceGroup `
        -ServerName $drServer `
        -FirewallRuleName $firewallRule `
        -StartIpAddress $ipAddress `
        -EndIpAddress $ipAddress;
    ```

    For the purposes of this exercise (illustrating auto-failover groups) this is sufficient from a networking perspective. However, this is slightly different from what you would do in an enterprise environment. In an enterprise environment, your machine that needs access will likely be a set of resources that make up some type of application. In the event of a failover of your database, you may want to failover your application/VMs/other resources to that new region as well. Both sets of resources will need access to the resources/servers/databases in the other region. In order to do this, you can use virtual network peering, virtual network to virtual network connections, or potentially something else (like ExpressRoute). It will depend on your scenario.

1. Add database(s) to the failover group by running the following in the Azure Cloud Shell.

    ```powershell
    # add the database to the failover group
    Get-AzSqlDatabase -ResourceGroupName $resourceGroup `
        -ServerName $server -DatabaseName $database | `
        Add-AzSqlDatabaseToFailoverGroup -ResourceGroupName $resourceGroup `
        -ServerName $server `
        -FailoverGroupName $failoverGroup
    Write-Host "AdventureWorks database added to the auto-failover group"
    ```

    The above step takes some time, because what you're doing is restoring the database in the other region, which involves copying the data from the original region to the DR region. You can work on **Configure your Command Prompt applications** and then come back here to check if it has completed.  

What you've just done is deploy and configure and auto-failover group for your AdventureWorks database.

### Configure your command prompt applications

For this exercise, you'll leverage two ostress workloads to check the *Updateability* (whether a database is in a `ReadWrite` or `ReadOnly` state) of your primary and secondary servers in your failover group. This is intended to simulate an application where you have read and write workloads.  

1. Open two separate command prompt windows, and format the windows on your screen so you can see this window (the browser) as well as both command prompts.  

1. In both command prompts, you need to navigate to the Availability folder as you did in the previous exercises. For example, you might use

    ```cmd
    cd C:\Users\username\mslearn-azure-sql-fundamentals\05-Availability
    ```

    If `C:\Users\username\mslearn-azure-sql-fundamentals\05-Availability` was the filepath to the folder.

1. The first command prompt window will be used to check the status of your primary server in the failover group you created. Format and then run the following command with your server name and password:

    ```cmd
    .\ostress.exe -S"<server-name>-fg.database.windows.net" -Q"SELECT DATABASEPROPERTYEX(DB_NAME(),'Updateability')" -U"cloudadmin" -d"AdventureWorks" -P"password" -n1 -r50000 -oprimary
    ```

    > [!NOTE]
    > With auto-failover groups, you connect to the failover group name, which is the abstraction for the database.

1. The second command prompt window will be used to check the status of your secondary server in the failover group you created. Format and then run the following command with your server name and password:  

    ```cmd
    ostress.exe -S"<server-name>-fg.secondary.database.windows.net" -Q"SELECT DATABASEPROPERTYEX(DB_NAME(),'Updateability')" -U"cloudadmin" -d"AdventureWorks" -P"password" -n1 -r50000 -osecondary
    ```

The result from the first command prompt you configured should be `READ_WRITE` because it is the primary failover group server and you have not initiated any failovers.  

The result from the second command prompt you configured should be `READ_ONLY` because it is the disaster recovery or secondary server that you configured. You should only be able to write from one of the servers at any given time.  

In the next steps, you'll examine what happens to both servers when a failover occurs.  

### Initiate a failover and observe the results

1. Using the Azure Cloud Shell terminal (to your right), check the status of the secondary server.

    ```powershell
    (Get-AzSqlDatabaseFailoverGroup -FailoverGroupName $failoverGroup `
        -ResourceGroupName $resourceGroup -ServerName $drServer).ReplicationRole
    ```

    The result tells you if the secondary server in the auto-failover group is being used as the primary or secondary database.  

1. You can now see what happens when a failover occurs by starting a manual failover with the Azure PowerShell commands below in the Azure Cloud Shell terminal.  

    ```powershell
    Switch-AzSqlDatabaseFailoverGroup -ResourceGroupName $resourceGroup `
     -ServerName $drServer -FailoverGroupName $failoverGroup
    ```

    When the failover occurs, you'll notice that the connections may be dropped for a few moments. But since our app keeps retrying, the application doesn't fail entirely. And once the failover has completed, you should notice that the `READ_WRITE` and `READ_ONLY` results resume and they do not swap.

    One of the benefits of auto-failover groups in Azure SQL Database and Azure SQL Managed Instance is that you do not have to update the connection strings after a failover. You continue to connect to the primary (`<failover-group>.database.windows.net`) for write-workloads and the secondary (`<failover-group>.secondary.database.windows.net`) for read-workloads, and Azure takes care of routing you to the appropriate database in the corresponding region/server.

1. Check the status of the secondary server by running the following in Azure Cloud Shell.

    ```powershell
    (Get-AzSqlDatabaseFailoverGroup -FailoverGroupName $failoverGroup `
        -ResourceGroupName $resourceGroup -ServerName $drServer).ReplicationRole
    ```

    It should now be in the `Primary` role.

1. Fail back by running the following in Azure Cloud Shell.

    ```powershell
    Switch-AzSqlDatabaseFailoverGroup -ResourceGroupName $resourceGroup `
     -ServerName $server -FailoverGroupName $failoverGroup
    ```

1. Finally, you can check the status of the secondary server yet again by running the following in Azure Cloud Shell.

    ```powershell
    (Get-AzSqlDatabaseFailoverGroup -FailoverGroupName $failoverGroup `
        -ResourceGroupName $resourceGroup -ServerName $drServer).ReplicationRole
    ```

1. You can now close both command prompts and maximize the Microsoft Learn browser window.

In this exercise, you learned how to deploy and configure auto-failover groups, as well as what that means from an application perspective. Auto-failover groups are just one way you can go further with availability and read-scale in Azure SQL.
