You've learned about the high-availability architecture of Azure SQL. In this exercise, you'll see how the General purpose tier of Azure SQL Database behaves similarly to a failover cluster instance on-premises. This functionality can be time consuming or tricky to set up on-premises, but you get it out of the box with Azure SQL.

In this exercise, you'll use the OStress tool that you might have used in the previous module to create a workload. You'll then initiate a failover by using the Azure PowerShell module in the Azure Cloud Shell and observe the effect it has on the OStress workload.  

## Basic high availability in the Azure SQL General purpose service tier

In this exercise, you'll complete the following steps:

1. Run the OStress workload.  
1. Confirm that the environment is properly configured.
1. Use PowerShell to initiate a failover of Azure SQL Database.  
1. Observe the results in OStress.  
1. Look for signs in the portal that a failover occurred.  

### Run the OStress workload

The first step is to create a long-running workload. This workload will allow you to see how a failover affects the ability to read and write data, and how long a failover takes in the General purpose service tier for Azure SQL Database. You'll use OStress.

1. Open a new Command Prompt window on your local computer. Use `cd` to go to the directory in the repository you cloned or downloaded earlier that contains the availability module. For example, you might use this command:

    ```cmd
    cd C:\Users\username\mslearn-azure-sql-fundamentals\05-Availability
    ```

    The OStress executable file is in this folder. (It's small.) The OStress workload connects and runs a simple query 50,000 times.

1. Use the following OStress script to run the workload. Replace `serverName` with the name of your Azure SQL Database logical server and `password` with your password.

    ```cmd
    .\ostress.exe -S"serverName.database.windows.net" -Q"SELECT COUNT(*) FROM SalesLT.Customer" -U"cloudadmin" -d"AdventureWorks" -P"password" -n1 -r50000
    ```

    If your workload is running properly, you should see the result of the query, `847`, repeatedly appearing in the Command Prompt window.

    If you want to stop running the OStress workload before it's done, you can select **Ctrl+C** in the terminal.  

    If you want to run the workload again, you can run the command again.  

### Use PowerShell in the Azure Cloud Shell to initiate a failover and observe the results

1. In the Azure Cloud Shell terminal (on the right side of this page), run this PowerShell script to configure your environment:  

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
