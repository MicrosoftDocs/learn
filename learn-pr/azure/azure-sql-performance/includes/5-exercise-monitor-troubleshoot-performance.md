In this exercise, you will learn how to monitor and troubleshoot a performance problem with Azure SQL by using familiar and new tools and capabilities.

### Set up: Use scripts to deploy Azure SQL Database

In the terminal on the right, you'll see Azure Cloud Shell, which provides a way to interact with Azure by using a browser. Before you start the labs, you will run a script there in order to create your environment, an instance of Azure SQL Database with the `AdventureWorks` database. In the script, you're prompted for a password for the new database and your local IP address to enable your device to connect to the database.  

This script takes 3-5 minutes to complete. Make sure to note your password, unique ID, and region. These won't be shown again.

1. Start by obtaining your local IP address. Ensure that you're disconnected from any VPN service and open a local PowerShell terminal on your device. Run the following command and note the resulting IP address.

    ```powershell
    (Invoke-WebRequest -Uri "https://ipinfo.io/ip").Content
    ```

1. Next, run the following commands in Azure Cloud Shell on the right. Fill in a complex password and, when prompted, enter your local public IP address you retrieved.

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

1. Output and store (for example, in a text file) the information you'll need throughout the module by running the following script in Cloud Shell.  You'll likely need to press `ENTER` after you paste in the code, because the last line won't be run by default.

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

    > [!TIP]
    > Don't forget to note your password, unique ID, and server. You will need these items throughout the module.

1. Run the following script to deploy an instance of Azure SQL Database and a logical server with the `AdventureWorks` sample. This script also adds your IP address as a firewall rule, enables Advanced Data Security, and creates a storage account for use in future units (this is to be consistent with other units).

    ```powershell
    # The logical server name has to be unique in the system
    $serverName = "aw-server$($uniqueID)"
    # The sample database name
    $databaseName = "AdventureWorks"
    # The storage account name has to be unique in the system
    $storageAccountName = $("sql$($uniqueID)")
    # Create a new server with a system wide unique server name
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
    # Create a Storage Account
    $storageAccount = New-AzStorageAccount -ResourceGroupName $resourceGroupName `
        -AccountName $storageAccountName `
        -Location $location `
        -Type "Standard_LRS"
    ```

1. On your local device, open SQL Server Management Studio (SSMS) and create a new connection to your logical server.  

    For server name, input the name of your Azure SQL Database logical server that was shown from Cloud Shell. For example: *aw-server`<unique ID>`.database.windows.net*.

    Change the authentication to **SQL Server Authentication**, and input the corresponding sign-in and password you provided for the script.  

    Select **Remember password** > **Connect**.  

    :::image type="content" source="../media/5-connect-azure-sql.png" alt-text="Screenshot of connecting to Azure SQL Database in SSMS."::: 

    > [!NOTE]
    > Depending on your local configuration (for example, VPN), your client IP address might differ from the IP address the Azure portal used during deployment. If it does, you'll get the following message: "Your client IP address does not have access to the server. Sign in to an Azure account and create a new firewall rule to enable access." If you get this message, sign in by using the account you're using for the sandbox, and add a firewall rule for your client IP address. You can complete all of these steps by using the wizard in SSMS.  

## Prepare the exercise by loading and editing scripts

All scripts for this exercise can be found in the folder *04-Performance\monitor_and_scale* in the GitHub repository or the zip file you downloaded. Let's prepare the exercise by loading and editing scripts.

1. In SSMS, in **Object Explorer**, select the **AdventureWorks** database. Then select **File** > **Open** to load the **dmexecrequests.sql** script. Your query editor window should look like the following text:

    ```sql
    SELECT er.session_id, er.status, er.command, er.wait_type, er.last_wait_type, er.wait_resource, er.wait_time
    FROM sys.dm_exec_requests er
    INNER JOIN sys.dm_exec_sessions es
    ON er.session_id = es.session_id
    AND es.is_user_process = 1;
    ```

1. Use the same method in SSMS to load the **dmdbresourcestats.sql** script. A new query editor window should look like the following text:

    ```sql
    SELECT * FROM sys.dm_db_resource_stats;
    ```

    This dynamic management view (DMV) will track overall resource usage of your workload against Azure SQL Database. For example, it tracks CPU, I/O, and memory.

1. Edit the script **sqlworkload.cmd** (which will use the ostress.exe program).

    - Substitute your `unique_id` that you saved from the deployment script to put in the correct server name.
    - Substitute the password for the sign-in for the Azure SQL Database server for the `-P parameter`.

## Run the workload

Now you will run a workload of a T-SQL query to observe its performance simulating concurrent users.

1. Use SSMS to open the script file **topcustomersales.sql** to observe the query. You won't run the query from SSMS. Your query editor window should look like the following text:

    ```sql
    DECLARE @x int
    DECLARE @y float
    SET @x = 0;
    WHILE (@x < 10000)
    BEGIN
    SELECT @y = sum(cast((soh.SubTotal*soh.TaxAmt*soh.TotalDue) as float))
    FROM SalesLT.Customer c
    INNER JOIN SalesLT.SalesOrderHeader soh
    ON c.CustomerID = soh.CustomerID
    INNER JOIN SalesLT.SalesOrderDetail sod
    ON soh.SalesOrderID = sod.SalesOrderID
    INNER JOIN SalesLT.Product p
    ON p.ProductID = sod.ProductID
    GROUP BY c.CompanyName
    ORDER BY c.CompanyName;
    SET @x = @x + 1;
    END
    GO
    ```

    This database isn't large. The query to retrieve the customer and their associated sales information, ordered by customers with the most sales, shouldn't generate a large result set. It's possible to tune this query by reducing the number of columns from the result set, but these are needed for demonstration purposes of this exercise.

1. From a PowerShell command prompt, change to the directory for this exercise:

    ```powershell
    cd <base directory>\04-Performance\monitor_and_scale
    ```

1. Run the workload with the following command:

    ```powershell
    .\sqlworkload.cmd
    ```

    This script will use 10 concurrent users who are running the workload query two times. Notice that the script itself runs a single batch but loops 10,000 times. It also assigned the result to a variable, therefore eliminating almost all result set traffic to the client. This isn't necessary, but helps to show a "pure" CPU workload run all on the server.

    > [!TIP]
    > If you're not seeing CPU usage behavior with this workload for your environment, you can adjust the `-n parameter` for number of users and the `-r parameter` for iterations.

    Your screen at the command prompt should look similar to the following output:

    ```output
    [datetime] [ostress PID] Max threads setting: 10000
    [datetime] [ostress PID] Arguments:
    [datetime] [ostress PID] -S[server].database.windows.net
    [datetime] [ostress PID] -isqlquery.sql
    [datetime] [ostress PID] -U[user]
    [datetime] [ostress PID] -dAdventureWorks
    [datetime] [ostress PID] -P********
    [datetime] [ostress PID] -n10
    [datetime] [ostress PID] -r2
    [datetime] [ostress PID] -q
    [datetime] [ostress PID] Using language id (LCID): 1024 [English_United States.1252] for character formatting with NLS: 0x0006020F and Defined: 0x0006020F
    [datetime] [ostress PID] Default driver: SQL Server Native Client 11.0
    [datetime] [ostress PID] Attempting DOD5015 removal of [directory]\sqlquery.out]
    [datetime] [ostress PID] Attempting DOD5015 removal of [directory]\sqlquery_1.out]
    [datetime] [ostress PID] Attempting DOD5015 removal of [directory]\sqlquery_2.out]
    [datetime] [ostress PID] Attempting DOD5015 removal of [directory]\sqlquery_3.out]
    [datetime] [ostress PID] Attempting DOD5015 removal of [directory]\sqlquery_4.out]
    [datetime] [ostress PID] Attempting DOD5015 removal of [directory]\sqlquery_5.out]
    [datetime] [ostress PID] Attempting DOD5015 removal of [directory]\sqlquery_6.out]
    [datetime] [ostress PID] Attempting DOD5015 removal of [directory]\sqlquery_7.out]
    [datetime] [ostress PID] Attempting DOD5015 removal of [directory]\sqlquery_8.out]
    [datetime] [ostress PID] Attempting DOD5015 removal of [directory]\sqlquery_9.out]
    [datetime] [ostress PID] Starting query execution...
    [datetime] [ostress PID]  BETA: Custom CLR Expression support enabled.
    [datetime] [ostress PID] Creating 10 thread(s) to process queries
    [datetime] [ostress PID] Worker threads created, beginning execution...
    ```

## Observe performance of the workload

Let's now use the DMV queries you loaded earlier to observe performance.

1. Run the query in SSMS you previously loaded to monitor `dm_exec_requests` (dmexecrequests.sql) to observe active requests. Run this query five or six times and observe some of the results:

    ```sql
    SELECT er.session_id, er.status, er.command, er.wait_type, er.last_wait_type, er.wait_resource, er.wait_time
    FROM sys.dm_exec_requests er
    INNER JOIN sys.dm_exec_sessions es
    ON er.session_id = es.session_id
    AND es.is_user_process = 1;
    ```

    You should see many of the requests have a status of RUNNABLE, and `last_wait_type` is SOS_SCHEDULER_YIELD. One indicator of many RUNNABLE requests and many SOS_SCHEDULER_YIELD waits is a possible lack of CPU resources for active queries.

    > [!NOTE]
    > You might see one or more active requests with a command of SELECT and a `wait_type` of XE_LIVE_TARGET_TVF. These are queries run by services managed by Microsoft. They help with capabilities like performance insights by using extended events. Microsoft doesn't publish the details of these sessions.

    Leave this query editor window open. You'll run it again in the next exercise.

1. Run the query in SSMS you previously loaded to monitor **sys.dm_db_resource_stats** (**dmdbresourcestats.sql**). Run the query to see the results of this DMV three or four times.

    ```sql
    SELECT * FROM sys.dm_db_resource_stats;
    ```

    This DMV records a snapshot of resource usage for the database every 15 seconds (kept for 1 hour). You should see the column **avg_cpu_percent** close to 100 percent for several of the snapshots. This is a symptom of a workload pushing the limits of CPU resources for the database.

    For a SQL Server on-premises environment, you would typically use a tool specific to the operating system to track overall resource usage such a CPU. For example, you might use Windows Performance Monitor for this purpose. If you ran this example on an on-premises SQL Server or SQL Server in a virtual machine with 2 CPUs, you would see near 100 percent CPU utilization on the server.

    > [!NOTE]
    > Another DMV, **sys.resource_stats**, can be run in the context of the master database of the Azure SQL Database server to see resource usage for all Azure SQL Database databases associated with the server. This view is less granular and shows resource usage every 5 minutes (kept for 14 days).

    Leave this query editor window open. You'll run it again in the next exercise.

1. Let the workload complete and take note of its overall duration. When the workload completes, you should see results like the following output and a return to the command prompt:

    ```output
    [datetime] [ostress PID] Total IO waits: 0, Total IO wait time: 0 (ms)
    [datetime] [ostress PID] OSTRESS exiting normally, elapsed time: 00:01:22.637
    ```

    Your duration time might vary but this typically takes at least 1-3 minutes. Make sure to let this run to completion. When the workload is done, you will be returned to the command prompt.

## Use the Query Store for further analysis

Query Store is a capability in SQL Server to track performance execution of queries. Performance data is stored in the user database. Query Store isn't enabled by default for databases created in SQL Server, but is on by default for Azure SQL Database (and Azure SQL Managed Instance).

Query Store comes with a series of system catalog views to view performance data. SSMS provides reports by using these views.

1. Using the **Object Explorer** in SSMS, open the **Query Store** folder to find the report for **Top Resource Consuming Queries**.

    :::image type="content" source="../media/5-ssms-find-top-queries.png" alt-text="Screenshot of the Query Store.":::

1. Select the report to find out what queries have consumed the most average resources and execution details of those queries. Based on the workload run to this point, your report should look something like the following image:

    :::image type="content" source="../media/5-ssms-top-query-report.png" alt-text="Screenshot of the top query report.":::

    The query shown is the SQL query from the workload for customer sales. This report has three components: queries with the high total duration (you can change the metric), the associated query plan and runtime statistics, and the associated query plan in a visual map.

1. Select the bar chart for the query (the `query_id` might be different for your system). Your results should look like the following image:

    :::image type="content" source="../media/5-ssms-query-id.png" alt-text="Screenshot of the query ID." lightbox="../media/5-ssms-query-id.png":::

    You can see the total duration of the query and query text.

1. To the right of this bar chart is a chart for statistics for the query plan associated with the query. Hover over the dot associated with the plan. Your results should look like the following image:

    :::image type="content" source="../media/5-ssms-slow-query-stats.png" alt-text="Screenshot of slow query statistics.":::

    Note the average duration of the query. Your times might vary, but compare this average duration to the average wait time for this query. Later, we'll introduce a performance improvement, and you'll make this comparison again to see the difference.

1. The final component is the visual query plan. The query plan for this query looks like the following image:

    :::image type="content" source="../media/5-ssms-workload-query-plan-inline.png" alt-text="Screenshot of the workload query plan." lightbox="../media/5-ssms-workload-query-plan-expanded.png":::

    Because of the small number of rows in the tables in this database, this query plan isn't inefficient. There might be some tuning opportunities, but you won't gain much performance by tuning the query itself. You might see a warning in the plan about a lack of statistics for one of the columns in the query for the clustered index seek. This doesn't factor into overall performance.

1. Below the **Top Resource Consuming Queries** report in SSMS is a report called **Query Wait Statistics**. You know from earlier diagnostics that a high number of requests constantly were in a RUNNABLE status, along with almost 100 percent CPU. Query Store comes with reports to look at possible performance bottlenecks due to waits on resources. Select this report and hover over the bar chart. Your results should look like the following image:

    :::image type="content" source="../media/5-ssms-top-wait-stats.png" alt-text="Screenshot of the top wait statistics.":::

    You can see the top wait category is CPU (this is equivalent to the `wait_type` SOS_SCHEDULER_YIELD, which can be seen in `sys.dm_os_wait_stats`), and the average wait time.

1. Select the CPU bar chart in the report. The top query waiting for CPU is the query from the workload that you're using.

    :::image type="content" source="../media/5-ssms-top-wait-stats-query.png" alt-text="Screenshot of the top wait statistics query." lightbox="../media/5-ssms-top-wait-stats-query.png":::

    Notice that the average wait time for CPU for this query is a high percentage of the overall average duration for the query.

    Considering the evidence to this point, without any query tuning, our workload requires more CPU capacity than we have deployed for our instance of Azure SQL Database.

1. You can close both Query Store reports for now. You'll use the same reports in the next exercise.

## Observe performance with Azure Monitor

Let's use one other method to view the resource usage of our workload. Azure Monitor provides performance metrics that you can view in various ways, including the Azure portal.

1. Go to the Azure portal for your deployment. Find the instance of Azure SQL Database deployed. On the **Overview** for a database, the default view in the **Monitoring** pane is called **Compute Utilization**:

    :::image type="content" source="../media/5-azure-portal-compute-slow-query.png" alt-text="Screenshot of the Azure portal with a slow query.":::

    Notice in this example, the CPU utilization is near 100 percent for a recent time range. This chart shows resource usage (CPU and I/O are the defaults) over the last hour, and it's refreshed continually. If you select the chart, you can customize it and look at other resource usage.

1. On the **Resource** menu, select **Metrics**. There's another way to see the same compute utilization metrics and other metrics automatically collected by Azure Monitor for Azure SQL Database. In the Azure portal, from the **Resources** pane, under **Monitoring**, use **Metrics Explorer**. (Note that **Compute Utilization** is just a pre-defined view of the **Metrics Explorer**.) If you select **Metrics**, you'll see the following results:

    :::image type="content" source="../media/5-azure-monitor-metrics.png" alt-text="Screenshot of Azure Monitor metrics.":::

    As you can see in the screenshot, there are several metrics you can use to view with Metrics Explorer. The default view of Metrics Explorer is for a 24-hour period, with a 5-minute granularity. The Compute Utilization view is the last hour with a 1-minute granularity (which you can change). To see the same view, select **CPU percentage** and change the capture for 1 hour. The granularity will change to 1 minute and should look like the following image:

    :::image type="content" source="../media/5-azure-monitor-metrics-cpu.png" alt-text="Screenshot of Azure Monitor metrics, including CPU after 1 minute.":::

    The default is a line chart, but the Explorer view allows you to change the chart type. There are various options with Metrics Explorer, including the ability to show multiple metrics on the same chart.

## Azure Monitor logs

In this exercise, you didn't set up an Azure Monitor log, but it's worth looking at what a log might look like for a CPU resource usage scenario. Azure Monitor logs can provide a much longer historical record than Azure Metrics.

If you had configured Azure Monitor logs with a Log Analytics workspace, you could use the following Kusto query to see the same type of results for CPU utilization for the database:

```kusto
AzureMetrics
| where MetricName == 'cpu_percent'
| where Resource == "ADVENTUREWORKS"
| project TimeGenerated, Average
| render columnchart
```

Your results would look like the following image:

:::image type="content" source="../media/5-kusto-query-metric-cpu-percent.png" alt-text="Screenshot of a query measuring CPU.":::

Azure Monitor logs have a delay when you're first configuring log diagnostics for a database, so these results can take some time to appear.

In this exercise, you learned how to observe a common SQL Server performance scenario and dive into details to decide on a possible solution to improve performance. In the next unit, you learn methods to accelerate and tune performance.
