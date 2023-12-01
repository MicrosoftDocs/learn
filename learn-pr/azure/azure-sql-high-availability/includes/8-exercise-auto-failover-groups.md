You learned about geo-replication and auto-failover groups in the previous unit. In this exercise, you'll configure auto-failover groups for your Azure SQL database. You'll then initiate a failover and view the results.

## Auto-failover groups in Azure SQL  

To configure auto-failover groups for one or more databases and view the results, you need to complete these steps:  

1. Configure the environment.
1. Create an empty Azure SQL Database server in the failover region.
1. Create a failover group between the servers.
1. Configure the network.
1. Add one or more databases to the failover group.  
1. Configure your command prompt applications.
1. Understand the running applications.
1. Initiate a failover.
1. Fail back.

This exercise guides you through configuring auto-failover groups for your AdventureWorks database. You'll then use a simple command-line application to understand where reads and writes occur and the importance of retry logic in your applications. Finally, you'll do a fun exercise to determine how many read replicas are associated with a Business Critical database that also has an auto-failover group.  

### Configure the environment

1. Copy the following code into Notepad or another text editor. Provide your information. Add your SQL authentication password. For `$drLocation`, supply the region where you want your failover group to be. Ideally, choose a region that's paired to your current server's region. You can check the [list of paired regions](/azure/best-practices-availability-paired-regions?azure-portal=true). At a minimum, it can't be the region where your original database is. Finally, add the IP address of your local computer. If you need to determine the IP address, open PowerShell on the local computer and run `(Invoke-WebRequest -Uri "https://ipinfo.io/ip").Content`.

    ```powershell
    # Add your info
    $password = "password"
    $drLocation = "westus2"
    $ipAddress = "xx.xx.xx.xx"
    ```

1. Run the updated command in Azure Cloud Shell (on the right side of this page).

1. Run this script in Azure Cloud Shell to configure your variables for the steps that follow:

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

1. Create an empty Azure SQL Database server in the failover region by running this script in Azure Cloud Shell:

    ```powershell
    # Create a backup server in the failover region
    New-AzSqlServer -ResourceGroupName $resourceGroup `
        -ServerName $drServer `
        -Location $drLocation `
        -SqlAdministratorCredentials $(New-Object -TypeName System.Management.Automation.PSCredential `
        -ArgumentList $admin, $(ConvertTo-SecureString -String $password -AsPlainText -Force))
    Write-Host "New Azure SQL Database logical server Created in different region"
    ```

1. Create a failover group between the servers by running this script in Azure Cloud Shell:

    ```powershell
    # Create a failover group between the servers
    New-AzSqlDatabaseFailoverGroup -ResourceGroupName $resourceGroup `
        -ServerName $server `
        -PartnerServerName $drServer `
        -FailoverGroupName $failoverGroup 
    Write-Host "New auto-failover group created between the two Azure SQL Database logical servers"
    ```

1. Configure the network by running this script in Azure Cloud Shell:

    ```powershell
    # Add a firewall rule that gives your VM access to the new server
    New-AzSqlServerFirewallRule -ResourceGroupName $resourceGroup `
        -ServerName $drServer `
        -FirewallRuleName $firewallRule `
        -StartIpAddress $ipAddress `
        -EndIpAddress $ipAddress;
    ```

    For purpose of illustrating auto-failover groups, this network setup is sufficient. It's slightly different from what you'd do in an enterprise environment. In an enterprise environment, the machine that needs access would probably be a set of resources that make up some type of application. If your database fails over, you might want to fail over your application, VMs, or other resources to the new region as well. Both sets of resources will need access to the resources, servers, and databases in the other region. To do this, you can use virtual network peering, virtual-network-to-virtual-network connections, or potentially something else (like Azure ExpressRoute). It depends on your scenario.

1. Add one or more databases to the failover group by running this script in Azure Cloud Shell:

    ```powershell
    # Add the database or databases to the failover group
    Get-AzSqlDatabase -ResourceGroupName $resourceGroup `
        -ServerName $server -DatabaseName $database | `
        Add-AzSqlDatabaseToFailoverGroup -ResourceGroupName $resourceGroup `
        -ServerName $server `
        -FailoverGroupName $failoverGroup
    Write-Host "AdventureWorks database added to the auto-failover group"
    ```

    It'll take some time for this script to run. You're restoring the database in the other region, which involves copying the data from the original region to the disaster recovery region. You can work on the steps in the next section and then check back to see if this script has completed.  

You've now deployed and configured an auto-failover group for your AdventureWorks database.

### Configure your command prompt applications

In this section, you'll use two ostress workloads to check the `Updateability` (whether a database is in a `ReadWrite` or `ReadOnly` state) of the primary and secondary servers in your failover group. This scenario is intended to simulate an application for which you have read and write workloads.  

1. Open two separate Command Prompt windows. Set up the windows so you can see this window (the browser) and both Command Prompt windows.  

1. In both Command Prompt windows, go to the Availability folder as you did in the previous exercises. For example, you might use this command:

    ```cmd
    cd C:\Users\username\mslearn-azure-sql-fundamentals\05-Availability
    ```

1. You'll use the first Command Prompt window to check the status of your primary server in the failover group you created. Run this command, using your server name and password:

    ```cmd
    .\ostress.exe -S"<server-name>-fg.database.windows.net" -Q"SELECT DATABASEPROPERTYEX(DB_NAME(),'Updateability')" -U"cloudadmin" -d"AdventureWorks" -P"password" -n1 -r5000 -oprimary
    ```

    > [!NOTE]
    > With auto-failover groups, you connect to the failover group name, which is the abstraction for the database.

1. You'll use the second Command Prompt window to check the status of your secondary server in the failover group you created. Run this command, using your server name and password:  

    ```cmd
    ostress.exe -S"<server-name>-fg.secondary.database.windows.net" -Q"SELECT DATABASEPROPERTYEX(DB_NAME(),'Updateability')" -U"cloudadmin" -d"AdventureWorks" -P"password" -n1 -r5000 -osecondary
    ```

The result of the first command should be `READ_WRITE`, because it checks the primary failover group server and you haven't initiated any failovers.  

The result of the second command should be `READ_ONLY`, because it checks the disaster recovery or secondary server that you configured. You should only be able to write from one of the servers at any given time.  

In the next steps, you'll see what happens to both servers when a failover occurs.  

### Initiate a failover and view the results

1. Use the Azure Cloud Shell terminal on the right side of this page to check the secondary server's status:

    ```powershell
    (Get-AzSqlDatabaseFailoverGroup -FailoverGroupName $failoverGroup `
        -ResourceGroupName $resourceGroup -ServerName $drServer).ReplicationRole
    ```

    The result tells you if the secondary server in the auto-failover group is being used as the primary or secondary database.  

1. You can now see what happens when a failover occurs. Initiate a manual failover by entering these Azure PowerShell commands in the Azure Cloud Shell terminal:  

    ```powershell
    Switch-AzSqlDatabaseFailoverGroup -ResourceGroupName $resourceGroup `
     -ServerName $drServer -FailoverGroupName $failoverGroup
    ```

    When the failover occurs, you might notice that the connections are dropped for a moment, but because the app keeps retrying, the application doesn't fail entirely. After the failover finishes, you should notice that the `READ_WRITE` and `READ_ONLY` results resume and that they don't change.

    One of the benefits of auto-failover groups in Azure SQL Database and Azure SQL Managed Instance is that you don't have to update the connection strings after a failover. You continue to connect to the primary (`<failover-group>.database.windows.net`) for write workloads and the secondary (`<failover-group>.secondary.database.windows.net`) for read workloads. Azure takes care of routing you to the appropriate database in the corresponding region/server.

1. Check the status of the secondary server by running this script in Azure Cloud Shell:

    ```powershell
    (Get-AzSqlDatabaseFailoverGroup -FailoverGroupName $failoverGroup `
        -ResourceGroupName $resourceGroup -ServerName $drServer).ReplicationRole
    ```

    This server should now be in the primary role.

1. Fail back by running this script in Azure Cloud Shell:

    ```powershell
    Switch-AzSqlDatabaseFailoverGroup -ResourceGroupName $resourceGroup `
     -ServerName $server -FailoverGroupName $failoverGroup
    ```

1. Finally, you can check the status of the secondary server yet again. Run this script in Azure Cloud Shell:

    ```powershell
    (Get-AzSqlDatabaseFailoverGroup -FailoverGroupName $failoverGroup `
        -ResourceGroupName $resourceGroup -ServerName $drServer).ReplicationRole
    ```

1. You can now close both Command Prompt windows and maximize the Microsoft Learn browser window.

In this exercise, you learned how to deploy and configure auto-failover groups. You also learned what that means from an application perspective. Auto-failover groups are just one way to go further with availability and read-scale in Azure SQL.
