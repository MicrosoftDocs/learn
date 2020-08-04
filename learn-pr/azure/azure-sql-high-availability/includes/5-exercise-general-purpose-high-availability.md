In the module, you learned about the high availability architecture of Azure SQL. In this exercise, you'll get to see how the General purpose tier of Azure SQL Database behaves similarly to a Failover Cluster Instance on-prem. The difference is that on-prem, this can be time-consuming or tricky to set up, but with Azure SQL, you get it out of the box.

This exercise will use the *ostress* tool you might have used in the previous module to create a workload. You'll then initiate a failover using the Azure PowerShell module in the Azure Cloud Shell, and observe the effect it has on the ostress workload.  

## Basic high availability (with no configuration!) in Azure SQL - General purpose service tier

In order to complete this exercise, you will complete the following steps:

1. Run the ostress workload  
1. Confirm environment is properly configured
1. Use PowerShell to initiate a failover  
1. Observe the results in ostress  
1. (Bonus) Look for signs in the portal that a failover occurred  

This exercise will guide you through getting ostress configured, and then you'll see how to use both ostress and PowerShell together to initiate and analyze a failover of Azure SQL Database.  

### Run the ostress workload

The first step is to create a long-running workload so you can see how a failover affects the ability to read/write data, and how long a failover takes in the General purpose service tier for Azure SQL Database. You will leverage a tool called `ostress`.

1. Open a new Command Prompt window on your local machine. Use `cd` to change directories to where the availability module is in the repository you cloned or downloaded earlier. For example, you might use

    ```cmd
    cd C:\Users\username\mslearn-azure-sql-fundamentals\05-Availability
    ```

    If `C:\Users\username\mslearn-azure-sql-fundamentals\05-Availability` was the filepath to the folder.

    Within the folder, is the ostress executable (very small). The ostress workload will essentially connect and runs a simple query 50,000 times.

1. Before running the workload, you will need to update the below ostress script by replacing `serverName` with the name of your Azure SQL Database logical server, and `password` with your password.

    ```cmd
    .\ostress.exe -S"serverName.database.windows.net" -Q"SELECT COUNT(*) FROM SalesLT.Customer" -U"cloudadmin" -d"AdventureWorks" -P"password" -n1 -r50000
    ```

    If your workload is running properly, you should be seeing the result of the query `847` repeatedly appearing in the Command Prompt.

    If at any time, you want to stop running the ostress workload before it is complete, you can go into the terminal and press `CTRL` + `c`.  

    If at any time, you want to run the workload again, you can run the command again.  

### Use PowerShell in Azure Cloud Shell to initiate a failover and observe the results

1. In the Azure Cloud Shell terminal (to your right on this page), run the following PowerShell to configure your environment.  

    ```powershell
    $resourceGroup = "<rgn>Sandbox resource group name</rgn>"
    $database = "AdventureWorks"
    $server = Get-AzureRmSqlServer -ResourceGroupName $resourceGroup
    $server = $server.ServerName

    # Specify your default resource group and Azure SQL Database logical server
    az configure --defaults group=$resourceGroup sql-server=$server

    # Confirm the defaults have been set
    az configure --list-defaults
    ```

1. Configure your windows so that you can see this browser and the Command Prompt in one view.  

1. Run the following code in the Azure Cloud Shell terminal.

    ```powershell
    # create a failover
    Invoke-AzSqlDatabaseFailover -ResourceGroupName $resourceGroup `
        -ServerName $server `
        -DatabaseName $database
    ```

1. Now observe the results in ostress from Command Prompt. While this command is running, you should observe any changes that appear in the Command Prompt. You'll notice that while the failover occurs, for some time you cannot access the database. After approximately 30 seconds, the failover completes, and you can see the workload runs successfully again. The importance of retry logic in your application is very important, because if Azure decides to fail you over (for a number of reasons), you don't want your application to crash or become down for any longer than it takes for the failover to occur.  

1. This ability to create a failover on command can be useful in certain scenarios. It's important to note that the service does throttle you from doing this too often. Run the following command to attempt another failover.  

    ```powershell
    # create a failover again
    Invoke-AzSqlDatabaseFailover -ResourceGroupName $resourceGroup `
        -ServerName $server `
        -DatabaseName $database
    ```

    You will see an error similar to `Invoke-AzSqlDatabaseFailover: Long running operation failed with status 'Failed'. Additional Info:'There was a recent failover on the database or pool if database belongs in an elastic pool.  At least 30 minutes must pass between database failovers.'`.

1. You can now stop the workload in Command Prompt by clicking on the window and selecting `CTRL+C`. You can leave this window open, as you will use this same workload in the next exercise.

1. You might be wondering if there's a way to check if potentially a failover occurred. There is no clear "Failover occurred" message that exists today, however, checking the Resource Health can be a good indicator.  

    In the Azure portal, navigate to your Azure SQL Database, and in the left-hand menu, under "Support + troubleshooting", select **Resource Health**. Some time after a failover (can be 5-15 minutes), you may see a health event similar to below. This can indicate several things, but one is that something has happened and Azure has decided to failover.

    :::image type="content" source="../media/5-health-history-inline.png" alt-text="Screenshot of the health history details." lightbox="../media/5-health-history-expanded.png":::
