In the module, you learned about the high availability architecture of Azure SQL. In this exercise, you'll get to see how the General purpose tier of Azure SQL Database behaves similarly to a Failover Cluster Instance on-prem. The difference is that on-prem, this can be time-consuming or tricky to set up, but with Azure SQL, you get it out of the box.  

The exercise will use the ostress tool you used in Module 4 to create a workload. You'll then initiate a failover using the Azure PowerShell module in the Azure Cloud Shell, and observe the effect it has on the ostress workload.  

## Basic high availability (with no configuration!) in Azure SQL - General purpose service tier

In order to complete this activity, you will complete the following steps:

0. Confirm environment is properly configured  
1. Run the ostress workload  
1. Use PowerShell to initiate a failover  
1. Observe the results in ostress  
1. (Bonus) Look for signs in the portal that a failover occurred  

This lab will guide you through getting ostress configured, and then you'll see how to use both ostress and PowerShell together to initiate and analyze a failover of Azure SQL Database.  

>Note: Learn more about the PowerShell commands used and available [in the documentation](https://docs.microsoft.com/azure/sql-database/sql-database-powershell-samples?tabs=single-database).  

**Step 0 - Confirm environment is properly configured** 

Open the Command Prompt (it is pinned to the bottom taskbar).  

Confirm [RMUtils tool (which contains ostress)](https://www.microsoft.com/download/details.aspx?id=4511) is installed and has been added to the Path. 
```cmd
ostress
```

Next, in the Azure Cloud Shell terminal (to your right), run the following PowerShell to configure your environment.  

```powershell
$resourceGroup = Get-AzResourceGroup | Where ResourceGroupName -like learn*
$resourceGroup = $resourceGroup.ResourceGroupName
$database = "AdventureWorks0406"
$server = Get-AzureRmSqlServer -ResourceGroupName $resourceGroup
$server = $server.ServerName

# Specify your default resource group and Azure SQL Database logical server
az configure --defaults group=$resourceGroup sql-server=$server

# Confirm the defaults have been set
az configure --list-defaults
```

**Step 1 - Run the ostress workload**  

The next step is to create a long-running workload so you can see how a failover affects the ability to read/write data, and how long a failover takes in the General purpose service tier for Azure SQL Database.  

The ostress workload below essentially connects and runs a simple query 50,000 times. You will use the Command Prompt (which you should already have open on your virtual machine) to run the workload.  

If, at any time, you want to stop running the ostress workload before it is complete, you can go into the terminal and press `CTRL` + `c`.  

If, at any time, you want to run the workload again in the terminal, you can run the command again from the Command Prompt in your virtual machine.  

Before running the workload using the command below, you need to update it by providing your server name (e.g. `aw-server394059299`) in place of `serverName` and your password in place of `password`.  

```cmd
ostress.exe -S"serverName.database.windows.net" -Q"SELECT COUNT(*) FROM SalesLT.Customer" -U"cloudadmin" -d"AdventureWorks0406" -P"password" -n1 -r50000
```

**Step 2 - Use PowerShell to initiate a failover**  

Run the following code in the Azure Cloud Shell terminal.

```powershell
# create a failover
Invoke-AzSqlDatabaseFailover -ResourceGroupName $resourceGroup `
    -ServerName $server `
    -DatabaseName $database
```

**Step 3 - Observe the results in ostress**  

While this cell is running, you should observe any changes that appear in the terminal. You'll notice that while the failover occurs, for some time you cannot access the database. Once the failover completes, you can see the workload runs successfully again. The importance of retry logic in your application is very important, because if Azure decides to fail you over (for a number of reasons), you don't want your application to crash or become down for any longer than it takes for the failover to occur.  

This tool to create a failover on command can be useful in certain scenarios. It's important to note that the service does throttle you from doing this too often. Press "Play" in the cell below to try to run the failover again.  

```powershell
# create a failover again
Invoke-AzSqlDatabaseFailover -ResourceGroupName $resourceGroup `
    -ServerName $server `
    -DatabaseName $database
```

You can now stop the workload in Command Prompt by clicking on the window and selecting `CTRL` + `c`. You can leave this window open, as you will use this same workload in a future activity.      

**(Bonus) Step 4 - Look for signs in the portal that a failover occurred**   

You might be wondering, if there's a way to check if potentially a failover occurred. There is no clear "Failover occurred" message that exists today, however, checking the Resource Health can be a good indicator.  

In the Azure portal, navigate to your Azure SQL Database, and in the left-hand menu, under "Support + troubleshooting", select **Resource Health**. Some time after a failover (can be 5-15 minutes), you may see a health event similar to below. This can indicate several things, but one is that something has happened and Azure has decided to failover. 

![](../media/healthhistory.png)  
