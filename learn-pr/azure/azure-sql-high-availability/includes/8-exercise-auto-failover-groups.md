In the module, you learned about geo-replication and auto-failover groups. In this exercise, you'll configure auto-failover groups for your Azure SQL Database. You'll then initiate a failover and observe the results, leveraging an application.  

## Auto-failover groups in Azure SQL  

To configure auto-failover groups for a database(s) and observe the results in an application, you must complete the following steps:  

0. Confirm environment is properly configured
1. Create an empty Azure SQL Database server in the failover region
1. Create a failover group between the servers  
1. Add database(s) to the failover group  
1. Configure the network
1. Configure your application(s)
1. Run your application(s)
1. Initiate a failover
1. Fail back
1. (Bonus) How many read replicas?  

This notebook will guide you through configuring auto-failover groups for your AdventureWorksID database. You'll then use a simple Java application to understand where reads and writes occur, and the importance of retry logic in your applications. Finally, you'll do a fun exercise to determine how many read-replicas are associated with a Business critical database that also has an auto-failover group.  

>Note: This activity is based off of a [tutorial in the documentation](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-implement-geo-distributed-database?tabs=azure-powershell) that also has information about using the Azure portal and the Azure CLI. In this exercise, you will use the Az PowerShell module.  

**Step 0 - Confirm environment is properly configured**  

If either of the above cells fail, please revisit the prerequisites before continuing.  

In the below cell, add your SQL authentication password. For `$drLocation`, you'll need to supply the region where you want your failover group to be. Ideally, you would select a paired region, which you can see the list of [here](https://docs.microsoft.com/en-us/azure/best-practices-availability-paired-regions). Finally, add the IP address of your local machine. You should already have found this at the beginning of the exercise, but if you need to locate it again, TODO.

> Note: If you're taking this as part of an in-person workshop and were provided an environment to use, defer to instructor guidance on what region to use.   

```powershell
# Add your info
$password = "O365microsoft!"
$drLocation = "eastus"
$ipAddress = "TODO"

# Do not modify
$admin = "cloudadmin"
$resourceGroup = Get-AzResourceGroup | Where ResourceGroupName -like learn*
$location = $resourceGroup.Location
$resourceGroup = $resourceGroup.ResourceGroupName
$database = "AdventureWorks"
$server = Get-AzureRmSqlServer -ResourceGroupName $resourceGroup
$server = $server.ServerName
$drServer = "$($server)-dr"
$failoverGroup = "$($server)-fg"
Write-Host "Variables Received"
```

**Step 1 - Create an empty Azure SQL Database server in the failover region**
```powershell
# create a backup server in the failover region
New-AzSqlServer -ResourceGroupName $resourceGroup `
    -ServerName $drServer `
    -Location $drLocation `
    -SqlAdministratorCredentials $(New-Object -TypeName System.Management.Automation.PSCredential `
    -ArgumentList $admin, $(ConvertTo-SecureString -String $password -AsPlainText -Force))
Write-Host "New Azure SQL Database logical server Created in different region"
```

**Step 2 - Create a failover group between the servers**
```powershell
# create a failover group between the servers
New-AzSqlDatabaseFailoverGroup -ResourceGroupName $resourceGroup `
    -ServerName $server `
    -PartnerServerName $drServer `
    -FailoverGroupName $failoverGroup 
Write-Host "New auto-failover group created between the two Azure SQL Database logical servers"
```

**Step 3 - Add database(s) to the failover group**
```powershell
# add the database to the failover group
Get-AzSqlDatabase -ResourceGroupName $resourceGroup `
    -ServerName $server -DatabaseName $database | `
    Add-AzSqlDatabaseToFailoverGroup -ResourceGroupName $resourceGroup `
    -ServerName $server `
    -FailoverGroupName $failoverGroup
Write-Host "AdventureWorks database added to the auto-failover group"
```

The above step takes some time, because what you're doing is restoring the database in the other region, which involves copying the data from the original region to the DR region. You can work on **Step 5** and then come back here to check if it has completed. If it hasn't, you can work on **Step 6** and then check back here.  

**Step 4 - Configure the network**  
```powershell
# Enter your local IP address
$ipAddress = "Local Ip Here"
# Add a firewall rules that gives your VM access to the new server
New-AzSqlServerFirewallRule -ResourceGroupName $resourceGroup `
    -ServerName $drServer `
    -FirewallRuleName $firewallRule `
    -StartIpAddress $ipAddress `
    -EndIpAddress $ipAddress;
```

What you've just done is deploy and configure and auto-failover group for you AdventureWorks database. Let's review.  

You started with a database and server in one location, with access from a virtual network (containing your VM) in that same location, this is what you did in Modules 2 and 3. In this notebook, you created a failover group from your original server to a new server in a different location, and added your AdventureWorks database to it. Finally, you added a firewall rule so that the new server/database in a different region can still be accessed from your VM.  

For the purposes of this activity (illustrating auto-failover groups) this is sufficient from a networking and VM perspective. However, this is slightly different from what you would do in an enterprise environment. In an enterprise environment, your "VM" will likely be a set of resources that make up some type of application. In the event of a failover of your database, you may want to failover your application/VMs/other resources to that new region as well. Both sets of resources will need access to the resources/servers/databases in the other region. In order to do this, you can use virtual network peering, virtual network to virtual network connections, or potentially something else (like ExpressRoute). It will depend on your scenario. You can learn more about what is needed to [design globally available services using Azure SQL Database here](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-designing-cloud-solutions-for-disaster-recovery).   

**Step 5 - Configure your application(s)**  

For this activity, you'll leverage two ostress workloads to check the *Updateability* (whether a database is in a `ReadWrite` or `ReadOnly` state) of your primary and secondary servers in your failover group.  

Open two separate command prompt windows, and format the windows on your screen so you can see this window (the browser) as well as both command prompts.  

The first command prompt window will be used to check the status of your primary server in the failover group you created. Format and then run the following command with your server name and password:   
```cmd
ostress.exe -S"<server-name>-fg.database.windows.net" -Q"SELECT DATABASEPROPERTYEX(DB_NAME(),'Updateability')" -U"cloudadmin" -d"AdventureWorks" -P"password" -n1 -r50000 -oprimary
```

The second command prompt window will be used to check the status of your secondary server in the failover group you created. Format and then run the following command with your server name and password"  
```cmd
ostress.exe -S"<server-name>-fg.secondary.database.windows.net" -Q"SELECT DATABASEPROPERTYEX(DB_NAME(),'Updateability')" -U"cloudadmin" -d"AdventureWorks" -P"password" -n1 -r50000 -osecondary
```

**Step 6 - Understand the running applications**  

The result from the first command prompt you configured should be `READ_WRITE` because it is the primary failover group server and you have not initiated any failovers.  

The result from the second command prompt you configured should be `READ_ONLY` because it is the disaster recovery or secondary server that you configured. You should only be able to write from one of the servers at any given time.  

In the next steps, you'll examine what happens to both servers when a failover occurs.  

**Step 7 - Initiate a failover**   

Using the Azure Cloud Shell terminal (to your right), check the status of the secondary server.
```powershell
(Get-AzSqlDatabaseFailoverGroup -FailoverGroupName $failoverGroup `
    -ResourceGroupName $resourceGroup -ServerName $drServer).ReplicationRole
```

The result of the previous cell tells you if the secondary server in the auto-failover group is being used as the primary or secondary database.  

We can now see what happens when a failover occurs by starting a manual failover with the Azure PowerShell commands below in the Azure Cloud Shell terminal.  

When the failover occurs, you'll notice that the connections may be dropped for a few moments. But since our app keeps retrying, the application doesn't fail entirely. And once the failover has completed, you should notice that the `READ_WRITE` and `READ_ONLY` results will be swapped.    

```powershell
Switch-AzSqlDatabaseFailoverGroup -ResourceGroupName $resourceGroup `
 -ServerName $drServer -FailoverGroupName $failoverGroup
```

Check the status of the secondary server.  
```powershell
(Get-AzSqlDatabaseFailoverGroup -FailoverGroupName $failoverGroup `
    -ResourceGroupName $resourceGroup -ServerName $drServer).ReplicationRole
```

**Step 8 - Fail back**  

Now we can fail back to our original configuration by using a similar command.  
```powershell
Switch-AzSqlDatabaseFailoverGroup -ResourceGroupName $resourceGroup `
 -ServerName $server -FailoverGroupName $failoverGroup
```

Check the status of the secondary server.  

```powershell
(Get-AzSqlDatabaseFailoverGroup -FailoverGroupName $failoverGroup `
    -ResourceGroupName $resourceGroup -ServerName $drServer).ReplicationRole
```

**(Bonus) Step 9 - How many read replicas?**  

You've seen how you can use the primary/secondary in an auto-failover group to help offload read-heavy workloads from the primary. In the previous activity, you also saw how in certain service tiers, like Business critical, you get a read-replica without setting up auto-failover groups. This begs the question, how many read-replicas do you have with a Business critical Azure SQL Database with an auto-failover group?  

Maybe you guessed it, but the answer is **3**. You can investigate this claim by using SSMS (or ADS) to connect to the following servers (**be sure to specify the database** under connection properties) and running the query to check if it's ReadWrite or ReadOnly below.  

The easiest way to do this is to create a New Database Engine Query by selecting **File** > **New** > **Database Engine Query**.  

![New database engine query](../media/newdbenginequery.png)

Connections:  

* `aw-server`YourID`-fg.database.windows.net`  
* `aw-server`YourID`-fg.database.windows.net` with Additional Connection Parameter `ApplicationIntent=ReadOnly`  
* `aw-server`YourID`-fg.secondary.database.windows.net`  
* `aw-server`YourID`-fg.secondary.database.windows.net` with Additional Connection Parameter `ApplicationIntent=ReadOnly`  

Command to run in each:  
```sql  
SELECT DATABASEPROPERTYEX(DB_NAME(), 'Updateability')
```  