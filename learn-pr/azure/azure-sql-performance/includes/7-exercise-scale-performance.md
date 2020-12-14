In this exercise, you will take the problem you encountered in the first exercise and improve performance by scaling more CPUs for Azure SQL Database. You will use the database you deployed in the previous exercise.

All scripts for this exercise can be found in the folder *04-Performance\monitor_and_scale* in the GitHub repository or the zip file that you downloaded.

## Scale up Azure SQL performance

To scale performance for a problem that appears to be a CPU capacity problem, you should decide what your options are and then proceed to scale CPUs by using provided interfaces for Azure SQL.

1. Decide how to scale performance. Since the workload is CPU *bound*, one way to improve performance is to increase CPU capacity or speed. A user of SQL Server would have to move to a different machine or reconfigure a VM to get more CPU capacity. In some cases, even an administrator of SQL Server might not have permission to make these scaling changes. The process might take time and even require a database migration.
  
    For Azure, you can use ALTER DATABASE, the Azure CLI, or the Azure portal to increase CPU capacity with no database migration on the part of the user.
  
1. Using the Azure portal, you can see options for how you can scale for more CPU resources. From the **Overview** pane for the database, select the **Pricing** tier current deployment. The **Pricing** tier allows you to change the service tier and the number of vCores.
  
    :::image type="content" source="../media/7-azure-portal-change-tier.png" alt-text="Screenshot of changing service tier in the Azure portal.":::
  
1. Here you can see options for changing or scaling compute resources. For **General Purpose**, you can easily scale up to something like 8 vCores.
  
    :::image type="content" source="../media/7-azure-portal-compute-options.png" alt-text="Screenshot of compute options in the Azure portal.":::
  
    You can also use a different method to scale your workload.

1. For this exercise, so that you can see proper differences in reports, you must first flush the Query Store. In SQL Server Management Studio (SSMS), select the **AdventureWorks** database, and use the **File** > **Open** menu. Open the script in SSMS **flushhquerystore.sql** in the context of the **AdventureWorks** database. Your query editor window should look like the following text:
  
    ```sql
    EXEC sp_query_store_flush_db;
    ```

    Run this T-SQL batch.

1. Open the script  **get_service_objective.sql** in SSMS. Your query editor window should look like the following text:

    ```sql
    SELECT database_name,slo_name,cpu_limit,max_db_memory, max_db_max_size_in_mb, primary_max_log_rate,primary_group_max_io, volume_local_iops,volume_pfs_iops
    FROM sys.dm_user_db_resource_governance;
    GO
    SELECT DATABASEPROPERTYEX('AdventureWorks', 'ServiceObjective');
    GO
    ```

    This is a method to find out your service tier by using T-SQL. The pricing or service tier is also known as a *service objective*. Run the T-SQL batches.
  
    For the current Azure SQL Database deployment, your results should look like the following image:
  
    :::image type="content" source="../media/7-service-objective-results.png" alt-text="Screenshot of service objective results.":::
  
    Notice the term **slo_name** is also used for service objective. **slo** stands for *service level objective*.
  
    The various `slo_name` values aren't documented, but you can see from the string value that this database uses a general purpose service tier with 2 vCores:

    > [!NOTE]
    > `SQLDB_OP_...` is the string used for Business Critical.

    When you view the ALTER DATABASE documentation, notice the ability to select your target SQL Server deployment to get the right syntax options. Select **SQL Database single database/elastic pool** to see the options for Azure SQL Database. To match the compute scale you found in the portal, you need the service objective `'GP_Gen5_8'`.

1. Modify the service objective for the database to scale more CPUs. Open the script **modify_service_objective.sql** in SSMS, and run the T-SQL batch. Your query editor window should look like the following text:
  
    ```sql
    ALTER DATABASE AdventureWorks MODIFY (SERVICE_OBJECTIVE = 'GP_Gen5_8');
    ```
  
    This statement comes back immediately, but the scaling of the compute resources takes place in the background. A scale this small should take less than a minute, and for a short period of time the database is offline to make the change effective. You can monitor the progress of this scaling activity by using the Azure portal.

    :::image type="content" source="../media/7-azure-portal-update-progress.png" alt-text="Screenshot of update in the Azure portal.":::

1. In **Object Explorer**, under the **System Databases** folder, right-click the **master** database and select **New Query**. Run this query in the SSMS query editor window:

    ```sql
    SELECT * FROM sys.dm_operation_status;
    ```

    This is another way to monitor the progress of a change for the service objective for Azure SQL Database. This dynamic management view (DMV) exposes a history of changes to the database with ALTER DATABASE to the service objective. It shows the active progress of the change.

    Here's an example of the output of this DMV in a table format, after you run the preceding ALTER DATABASE statement:

    Item                | Value
    ---                 | ---
    session_activity_id | 97F9474C-0334-4FC5-BFD5-337CDD1F9A21
    resource_type       | 0
    resource_type_desc  | Database
    major_resource_id   | AdventureWorks
    minor_resource_id   | 
    operation           | ALTER DATABASE
    state               | 1
    state_desc          | IN_PROGRESS
    percent_complete    | 0
    error_code          | 0
    error_desc          | 
    error_severity      | 0
    error_state         | 0
    start_time          | [date time]
    last_modify_time    | [date time]

    During a change for the service objective, queries are allowed against the database until the final change is implemented. An application can't connect for a very brief period of time. For Azure SQL Managed Instance, a change of tier allows queries and connections, but prevents all database operations, like the creation of new databases. In these cases, you receive the following error message: "The operation could not be completed because a service tier change is in progress for managed instance '[server]'. Please wait for the operation in progress to complete and try again."

1. When this is done, use the preceding queries listed from **get_service_objective.sql** in SSMS, to verify that the new service objective or service tier of 8 vCores has taken effect.

## Run the workload after scale up

Now that the database has more CPU capacity, let's run the workload we did in the previous exercise to observe whether there is a performance improvement.

1. Now that the scaling has completed, check if the workload duration is faster and whether waits on CPU resources has decreased. Run the workload again by using the command **sqlworkload.cmd** that you ran in the previous exercise.

1. Using SSMS, run the same query from the first exercise of this module to observe results from the script **dmdbresourcestats.sql**:

    ```sql
    SELECT * FROM sys.dm_db_resource_stats;
    ```

    You should see that the average CPU resource usage has decreased from the almost 100 percent usage in the previous exercise.

1. Using SSMS, run the same query from the first exercise of this module to observe results from the script **dmexecrequests.sql**.

    ```sql
    SELECT er.session_id, er.status, er.command, er.wait_type, er.last_wait_type, er.wait_resource, er.wait_time
    FROM sys.dm_exec_requests er
    INNER JOIN sys.dm_exec_sessions es
    ON er.session_id = es.session_id
    AND es.is_user_process = 1;
    ```

    You will see that there are more queries with a status of RUNNING. This means our workers have more CPU capacity to execute.

1. Observe the new workload duration. The workload duration from **sqlworkload.cmd** should now be much less, and should be approximately 25-30 seconds.

## Observe Query Store reports

Let's look at the same Query Store reports as we did in the previous exercise.

1. Using the same techniques as the first exercise in this module, look at the **Top Resource Consuming Queries** report from SSMS:

    :::image type="content" source="../media/7-ssms-top-query-faster.png" alt-text="Screenshot of top query results running faster.":::

    You will now see two queries (`query_id`). These are the same query, but show up as different `query_id` values in the Query Store, because the scale operation required a restart and the query had to be recompiled. You can see in the report the overall and average duration was significantly less.

1. Look also at the **Query Wait Statistics** report as you did in the previous exercise. You can see the overall average wait time for the query is less, and it's a lower percentage of the overall duration. This is a good indication that the CPU isn't as much of a resource bottleneck when the database had a lower number of vCores:

    :::image type="content" source="../media/7-ssms-top-wait-stats-query-faster.png" alt-text="Screenshot of top wait statistics results running faster.":::

1. You can close out all reports and query editor windows. Leave SSMS connected, because you'll need this in the next exercise.

## Observe changes from Azure Metrics

1. Go to the **AdventureWorks** database in the Azure portal, and look at the **Overview** pane again for **Compute Utilization**:

    :::image type="content" source="../media/7-azure-portal-compute-query-comparison.png" alt-text="Screenshot of compute comparison in the Azure portal.":::

    Notice that the duration is shorter for high CPU utilization, which means an overall drop in the CPU resources required to run the workload.

1. This chart can be somewhat misleading. From the **Resource** menu, use **Azure Metrics**. The CPU comparison chart looks more like the following:

    :::image type="content" source="../media/7-azure-metrics-query-comparison.png" alt-text="Screenshot of query comparison in the Azure portal.":::

> [!TIP]
> If you continue to increase vCores for this database, you can improve performance up to a threshold where all queries have plenty of CPU resources. This doesn't mean you must match the number of vCores to the number of concurrent users from your workload. In addition, you can change the Pricing Tier to use **Serverless** *Compute Tier*, instead of **Provisioned**. This helps you achieve a more auto-scaled approach to a workload. For example, for this workload if you chose a minimum vCore value of 2, and maximum vCore value of 8, this workload would immediately scale to 8 vCores.

In the next exercise, you observe a performance problem and resolve it by applying best practices for application performance.
