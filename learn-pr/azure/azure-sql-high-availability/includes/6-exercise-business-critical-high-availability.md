In this exercise, you'll upgrade your database to the Business critical tier. You'll see how it provides read replicas and increased performance.

You'll use the OStress tool you used in the previous exercise to create a workload. You'll then initiate a failover by using the Azure PowerShell module in the Azure Cloud Shell. Finally, you'll view the effect the failover has on the OStress workload.  

## Basic high availability in the Azure SQL Business critical service tier

In this exercise, you'll complete the following steps:

1. Deploy the database from the previous exercise in the Business critical tier.
1. Run the OStress workload.  
1. Use PowerShell to initiate a failover.  
1. View the results in OStress.  
1. Connect to a readable secondary.

## Deploy the same database in the Business critical tier

In a previous module of this learning path, you learned how to scale a database by using T-SQL. The goal of this exercise is to upgrade the database that you used in the previous exercise from General purpose to Business critical. You'll use Azure CLI commands in the Azure Cloud Shell to upgrade the database. Because there's a limit on the frequency of failovers, you'll use the same sample database but name it AdventureWorks-bc.  

1. In the Azure Cloud Shell terminal on the right side of this page, run the following PowerShell script to configure your environment:  

    ```powershell
    $resourceGroup = "<rgn>Sandbox resource group name</rgn>"
    $database = "AdventureWorks-bc"
    $server = Get-AzureRmSqlServer -ResourceGroupName $resourceGroup
    $server = $server.ServerName

    # Specify your default resource group and Azure SQL Database logical server
    az configure --defaults group=$resourceGroup sql-server=$server

    # Confirm the defaults are set
    az configure --list-defaults
    ```

1. Run this command to create a database in the Business critical service tier:

    ```powershell
    az sql db create --name $database `
    --edition BusinessCritical `
    --family Gen5 `
    --capacity 2 `
    --sample-name AdventureWorksLT `
    --read-scale Enabled `
    --zone-redundant false
    ```

    It will take some time for this command to finish. While it's running, you can review some of the parameters used:

    * `family`: This parameter specifies the generation of the hardware. To be consistent with the previous exercise, we used `Gen5`.
    * `capacity`: This parameter specifies the number of DTUs or vCores. To be consistent with the previous exercise, we used `2` vCores.
    * `sample-name`: To be consistent with the previous exercise, we used the `AdventureWorksLT` database sample.
    * `edition`: This parameter name is a bit misleading. It really refers to the service tier, which isn't the same the edition that's used in SQL Server.  
    * `read-scale`: This option isn't enabled by default, but there's no additional cost associated with it. By enabling it, you're enabling one of your secondary replicas to be used as a readable secondary.  
    * `zone-redundant`: By default, this parameter is set to false. You can set it to true if you want a "Multi-Az" deployment at no additional cost. You'll learn more about Availability Zones in the next unit.

      > [!NOTE]
      > Availability Zones are available only in [certain regions](https://docs.microsoft.com/azure/availability-zones/az-overview#services-support-by-region?azure-portal=true). They're not currently available in Azure SQL Managed Instance.  

1. After the database is created, you should see detailed information about the updates in the Azure Cloud Shell output. You'll see two main categories (though you'll also see indicators under several other properties):  
    * `currentServiceObjectiveName`: Should be `BC_Gen5_2`. `BC` stands for Business critical.  
    * `currentSku`:  
        * `name`: Should be `BC_Gen5`.
        * `tier`: Should be `BusinessCritical`.  

1. Another way to check the service tier is to go to your database in the Azure portal. On the **Overview** tab, see the **Pricing tier**.  

    > [!TIP]
    > There are many other ways to view these updates. One other way is by using SSMS. If you right-click your database and select **Properties** > **Configure SLO**, you can view the changes.  

## Run the OStress workload

As in the previous exercise, you'll use OStress to repeatedly query your Azure SQL database.

1. Open a new Command Prompt window on your local computer. Use `cd` to change directories to where the availability module is in the repository you cloned or downloaded earlier. For example, you might use

    ```cmd
    cd C:\Users\username\mslearn-azure-sql-fundamentals\05-Availability
    ```

    If `C:\Users\username\mslearn-azure-sql-fundamentals\05-Availability` was the filepath to the folder.

    The ostress workload will essentially connect and runs a simple query 50,000 times.

1. Before running the workload, you will need to update the below ostress script by replacing `serverName` with the name of your Azure SQL Database logical server, and `password` with your password. Note that this command is slightly different because the database name is now `AdventureWorks-bc`.

    ```cmd
    .\ostress.exe -S"serverName.database.windows.net" -Q"SELECT COUNT(*) FROM SalesLT.Customer" -U"cloudadmin" -d"AdventureWorks-bc" -P"password" -n1 -r50000
    ```

    If your workload is running properly, you should be seeing the result of the query `847` repeatedly appearing in the Command Prompt.

    If at any time, you want to stop running the ostress workload before it is complete, you can go into the terminal and press `CTRL` + `c`.  

    If at any time, you want to run the workload again, you can run the command again.  

## Initiate a failover and observe the results

1. Configure your windows so that you can see this browser and the Command Prompt in one view.  

1. Next, run the following code in the Azure Cloud Shell terminal. Note this is the same command you used in the previous exercise.

    ```powershell
    # create a failover
    Invoke-AzSqlDatabaseFailover -ResourceGroupName $resourceGroup `
        -ServerName $server `
        -DatabaseName $database
    ```

1. While this cell is running, you should observe any changes that appear in the terminal. You'll notice that while the failover occurs, for some time you cannot access the database. However, the time where you're unavailable is very short. Once you become disconnected, you should be reconnected after approximately 5 seconds! This failover is 6+ times faster that in the General purpose tier.  

    Recall that databases or managed instances in the Business critical service tier essentially have an Always On Availability Group deployed behind the scenes. This means that when you failover, all that happens is a change in pointers in the backend as we redirect you to one of the secondaries. Because of this, it can be very fast, much faster than General purpose.

## Connect to the read-only replica

Since you enabled the `read-scale` parameter, you have the ability to use one of the secondary replicas for read-only workloads. In order to access the read-only replica in applications, you just have to add the following parameter to your connection string for a database:  

```text
ApplicationIntent=ReadOnly;
```

1. In SSMS, create a new query connection (select **File** > **New** > **Database Engine Query**).  

    :::image type="content" source="../media/6-new-db-engine-query.png" alt-text="Screenshot of a new database engine query.":::  

1. Using the same way you've been connecting to your Azure SQL Database logical server (with SQL Auth), select **Options**.  

    :::image type="content" source="../media/3-connect-azure-sql.png" alt-text="Screenshot of the options in SSMS.":::  

1. Select **Connection Properties**, and select **Reset All**. Then, under "Connect to database" select **Browse server** and select your **AdventureWorks-bc** database.  

1. Then select **Additional Connection Parameters** and copy and paste the following into the text box. Finally, select **Connect**.  

    ```sql
    ApplicationIntent=ReadOnly;
    ```  

    With SSMS, you have to specify the server and database to which you want to connect read-only, because there may be multiple databases in a server with different capabilities as far as readable secondaries goes.

1. To test, try the following query on your new database engine query, and observe the results. Is it what you would expect?  

    ```sql
    SELECT DATABASEPROPERTYEX(DB_NAME(), 'Updateability')
    ```

    :::image type="content" source="../media/6-read-only.png" alt-text="Screenshot of the read only response.":::

1. You can optionally re-connect and update the Additional Connection Parameters (replace `ReadOnly` with `ReadWrite`), and confirm you are accessing the read-write primary replica. `ReadWrite` is the default, so if you don't select anything, that's what you'll be in.

    :::image type="content" source="../media/6-read-write.png" alt-text="Screenshot of the read write response.":::
